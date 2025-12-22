// PIC18F45K22 timer project
// 2-digit CA 7-segment on PORTD + RC0/RC1
// RA0 : pot -> pick a value 00..99
// RA1 : push button -> start after press + release
// RA2 : LED on while counting
// RA3 : servo (simple PWM, around 50 Hz)
// RA4 : buzzer beeps at 3, 2, 1 sec

//Libraries:
#include <p18cxxx.h>
#include <BCDlib.h>
#include <delays.h>

// I/O shortcuts
#define BTN         PORTAbits.RA1   // push button (active high)
#define LED         PORTAbits.RA2   // LED
#define ServoPWM    PORTAbits.RA3   // servo signal
#define Buzzer      PORTAbits.RA4   // buzzer

// 7-segment (common anode)
// segments on PORTD, digit select on RC0/RC1
#define DIGIT1      PORTCbits.RC0   // ones (right digit)
#define DIGIT2      PORTCbits.RC1   // tens  (left digit)


#pragma config FOSC = INTIO67 //OSCILLATOR setup

// ---------------- global variables ----------------
unsigned char qstates = 0x01;       // which digit is enabled now
unsigned char mux_idx = 0;          // 0 = ones, 1 = tens

unsigned char bcd[3] = {0};         // Bin2Bcd buffer [hundreds, tens, ones]

unsigned char adc_raw   = 0;        // raw ADC from ADRESH (0..255)
unsigned char set_val   = 0;        // selected value from pot (0..99)
unsigned char counting  = 0;        // 0 = idle, 1 = countdown started
unsigned char seconds   = 0;        // remaining time

unsigned char t0_ticks  = 250;      // 250 * 4ms ? 1 second
unsigned char buzz_flag = 0;        // set by ISR when we need a beep

// 7-segment table for common anode (0 = LED ON)
const unsigned char SS_CA[10] = {
    0xC0, // 0
    0xF9, // 1
    0xA4, // 2
    0xB0, // 3
    0x99, // 4
    0x92, // 5
    0x82, // 6
    0xF8, // 7
    0x80, // 8
    0x90  // 9
};

// prototypes
static void Setup(void);
static void ReadPot(void);
static void CheckButton(void);
static void ServoTask(void);
static void Beep(unsigned int LoopCount);

// ===================== main =====================
void main(void)
{
    Setup();

    while(1)
    {
        if (!counting)
        {
            // still choosing the value
            ReadPot();
            CheckButton();      // only reacts when not counting
        }
        else
        {
            // countdown running
            ServoTask();

            if (buzz_flag)
            {
                Beep(200);      // small beep
                buzz_flag = 0;
            }
        }
    }
}

// ===================== setup =====================
static void Setup(void)
{
    // RC0 / RC1 -> digit select
    TRISCbits.RC0 = 0;
    TRISCbits.RC1 = 0;
    ANSELC &= 0xF8;         // RC0,1,2 digital

    // PORTD -> segments
    TRISD  = 0x00;
    ANSELD = 0x00;

    // PORTA pins
    TRISAbits.RA0 = 1;  ANSELAbits.ANSA0 = 1;  // RA0 = AN0 (pot)
    TRISAbits.RA1 = 1;  ANSELAbits.ANSA1 = 0;  // RA1 = button
    TRISAbits.RA2 = 0;  ANSELAbits.ANSA2 = 0;  // RA2 = LED
    TRISAbits.RA3 = 0;  ANSELAbits.ANSA3 = 0;  // RA3 = servo
    TRISAbits.RA4 = 0;                          // RA4 = buzzer

    // default outputs
    LED      = 0;
    ServoPWM = 0;
    Buzzer   = 0;
    PORTD    = 0xFF;      // all segments off (CA)
    DIGIT1   = 0;
    DIGIT2   = 0;

    // ADC on AN0, Vref = Vdd/Vss, left-justified
    ADCON0 = 0b00000001;  // AN0, ADC on
    ADCON1 = 0x00;
    ADCON2 = 0b00001001;  // ADFM=0, ACQT=2Tad, ADCS=Fosc/8
    Delay10KTCYx(1);

    // Timer0: ~4 ms interrupt
    T0CON = 0b11010100;   // 8-bit, prescale 1:32, ON
    TMR0L = 256 - 125;
    INTCONbits.T0IF = 0;
    INTCONbits.T0IE = 1;
    INTCONbits.GIE  = 1;

    // initial state
    counting = 0;
    set_val  = 0;
    seconds  = 0;
    Bin2Bcd(0, (char*)bcd);
    
    OSCCON = 0b01010000; //OSCILLATOR setup
}

// ===================== read pot and scale 0..99 =====================
static void ReadPot(void)
{
    ADCON0bits.GO = 1;
    while (ADCON0bits.NOT_DONE);   // wait for conversion
    adc_raw = ADRESH;              // left justification

    // scale 0..255 to 0..99 (UL: unsigned long)
    set_val = (unsigned char)((adc_raw * 100UL) / 256UL);
    if (set_val > 99) set_val = 99;
}

// ===================== button logic =====================
static void CheckButton(void)
{
    // if countdown is already running, ignore any presses
    if (counting)
        return;

    // simple press + release with small debounce
    if (BTN && (set_val != 0))
    {
        while (BTN);           // wait until user releases
        Delay10KTCYx(5);       // debounce delay

        // now we really start the countdown
        counting = 1;
        seconds  = set_val;
        LED      = 1;          // show that it is running
    }
}

// ===================== servo pulse =====================
static void ServoTask(void)
{
    if (counting && seconds > 0)
    {
        // full-speed in one direction (approx)
        ServoPWM = 1;      // high time ~2 ms
        Delay1KTCYx(2);    // 2 ms
        ServoPWM = 0;      // low time ~18 ms
        Delay1KTCYx(18);   // 18 ms  -> total ~20 ms frame
    }
    else
    {
        // neutral / stop (close to 1.5 ms)
        ServoPWM = 1;
        Delay1KTCYx(1);    // 1 ms (you can try 1 or 2 to find stop point)
        ServoPWM = 0;
        Delay1KTCYx(19);   // 19 ms -> ~20 ms
    }
}

// ===================== buzzer =====================
static void Beep(unsigned int LoopCount)
{
    unsigned int i;

    for (i = 0; i < 2 * LoopCount; i++)
    {
        Buzzer = ~Buzzer;
        Delay100TCYx(10);
    }
    Buzzer = 0;
}

// ===================== Timer0 ISR =====================
#pragma code ISR = 0x0008
#pragma interrupt ISR
void ISR(void)
{
    if (INTCONbits.T0IF)
    {
        INTCONbits.T0IF = 0;
        TMR0L = 256 - 125;          // reload for next 4 ms (approx)

        // choose which value to display
        if (!counting)
            Bin2Bcd(set_val, (char*)bcd);
        else
            Bin2Bcd(seconds, (char*)bcd);

        // turn both digits off before changing
        DIGIT1 = 0;
        DIGIT2 = 0;
        PORTD  = 0xFF;

        // enable one digit only
        if (qstates & 0x01) DIGIT1 = 1;    // ones digit
        if (qstates & 0x02) DIGIT2 = 1;    // tens digit

        // send pattern for the selected digit
        if (mux_idx == 0)
            PORTD = SS_CA[(unsigned char)bcd[2]];   // ones
        else
            PORTD = SS_CA[(unsigned char)bcd[1]];   // tens

        // next interrupt: other digit (flip mux_idx between 0 and 1)
        mux_idx ^= 0x01;
        qstates <<= 1;
        if (qstates & 0x04) qstates = 0x01;

        // build 1-second tick from 4-ms interrupts
        if (--t0_ticks == 0)
        {
            t0_ticks = 250;

            if (counting)
            {
                if (seconds > 0)
                {
                    seconds--;

                    // make noise at 3, 2, 1
                    if (seconds > 0 && seconds <= 3)
                        buzz_flag = 1;
                }
                else
                {
                    // finished (0 reached)
                    counting = 0;
                    LED      = 0;
                    set_val  = 0;      // next run starts from 0 again
                }
            }
        }
    }
}
