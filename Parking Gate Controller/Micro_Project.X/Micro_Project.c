//Libraries:
#include <p18cxxx.h>
#include <BCDlib.h>
#include <delays.h>

//variables:
char SScodes[] = {0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F};
char timer_digits[3], car_digits[3];
unsigned char car_counter, seconds_counter,
counter_interrupts, Qstates, i, j, m, start_count;

//Setup function:

void Setup(void) {
    //pins: motor, LED, push buttons
    TRISB &= 0xC7;
    ANSELB &= 0xC0;
    WPUB = 0b00000111; //enable pull up resistors for push buttons
    INTCON2bits.RBPU = 0; //enable pull up resistor for push buttons
    //7 segment setup:  
    TRISD = 0x00; //PORTD output
    ANSELD = 0x00; //PORTD digital
    TRISC &= 0xF0; //output
    ANSELC &= 0xF0; //digital
    //buzzer
    TRISAbits.RA0 = 0; //output
    ANSELAbits.ANSA0 = 0; //digital

    //interrupts:
    INTCONbits.GIE = 1; //enable global mask
    INTCONbits.INT0IE = 1; //enable local mask for the gate push button
    INTCON3bits.INT1IE = 1; //enable local mask for the sensor push button(go in)
    INTCON3bits.INT2IE = 1; //enable local mask for the sensor push button(go out)
    INTCONbits.T0IE = 1; //enable local mask for Timer0
    T0CON = 0b11010100; //32microseconds*250cycle=8ms
    TMR0L = 256 - 250;

    //Initialize variables:
    car_counter = 0;
    seconds_counter = 0;
    counter_interrupts = 125;
    Bin2Bcd(car_counter, car_digits);
    Bin2Bcd(seconds_counter, timer_digits);
    Qstates = 0x08;
    i = 1; //index of cars
    j = 1; //index of timer
    m = 0; //index for loop
    start_count = 0; //start count 10 seconds when gate is open
    PORTBbits.RB4 = 0; //initialize motor OFF
    PORTBbits.RB5 = 0; //initialize motor OFF
}

void gate_opening(void); //prototype
void gate_closing(void); //prototype

//main function:

void main(void) {
    Setup(); //executed only once
    while (1); //wait for interrupts
}

//function open the gate and toggle the LED while opening 
//and turn on motor (clockwise):

void gate_opening(void) {
    for (m = 0; m < 100; m++) {
        PORTD = 0xBF;
        PORTC = Qstates;
        Qstates >>= 1;
        if (Qstates == 0b00000000) {
            Qstates = 0b00001000;
        }
        PORTAbits.RA0 = ~PORTAbits.RA0;
        PORTBbits.RB3 = ~PORTBbits.RB3;
        PORTBbits.RB4 = 1;
        PORTBbits.RB5 = 0;
        Delay10KTCYx(3); //wait 0.03s
    }
    //if sensor pressed while opening:
    if (INTCON3bits.INT1IF) INTCON3bits.INT1IF = 0;
    if (INTCON3bits.INT2IF) INTCON3bits.INT2IF = 0;
    //turn off motor:
    PORTBbits.RB4 = 0;
    PORTBbits.RB5 = 0;
}

//function close the gate and toggle the LED while closing 
//and turn on motor (counter-clockwise):

void gate_closing(void) {
    for (m = 0; m < 100; m++) {
        PORTD = 0xBF;
        PORTC = Qstates;
        Qstates >>= 1;
        if (Qstates == 0b00000000) {
            Qstates = 0b00001000;
        }
        PORTAbits.RA0 = ~PORTAbits.RA0;
        PORTBbits.RB3 = ~PORTBbits.RB3;
        PORTBbits.RB4 = 0;
        PORTBbits.RB5 = 1;
        Delay10KTCYx(3); //wait 0.03s
    }
    //if push button pressed while closing:
    if (INTCONbits.INT0IF) INTCONbits.INT0IF = 0;
    //turn off motor:
    PORTBbits.RB4 = 0;
    PORTBbits.RB5 = 0;
}

//function for interrupts:
#pragma code ISR = 0x0008
#pragma interrupt ISR

void ISR(void) {
    if (INTCONbits.T0IF) {
        INTCONbits.T0IF = 0; //clear the flag
        TMR0L = 256 - 250; //elapse 8ms again
        PORTD = 0x00; //Refresh display (OFF all digits/LEDs)
        PORTC = Qstates;
        if (Qstates == 0x08) {
            PORTD = SScodes[timer_digits[j]];
            j++; //increment index of digits of timer
        } else if (Qstates == 0x04) {
            PORTD = SScodes[timer_digits[j]] | 0x80; // to enable dot led
            j++; //increment index of digits of timer
        } else {
            PORTD = SScodes[car_digits[i]];
            i++; //increment index of digits of cars
        }
        Qstates >>= 1; //rotate right transistors

        //when gate open start counting 10s:
        if (start_count) {
            counter_interrupts--; //decrement number of interrupts
            if (counter_interrupts == 0) {
                seconds_counter--; //decrement counter (count down)
                Bin2Bcd(seconds_counter, timer_digits); //new value of counter
                counter_interrupts = 125; //clear the counter interrupts
            }
        }

        //when timer counter reach 10seconds and there a car below the gate 
        //it will count 10s again to avoid crashing the car:  
        if (seconds_counter == -1 && (PORTBbits.RB1 == 0 || PORTBbits.RB2 == 0)) {
            seconds_counter = 10;
            Bin2Bcd(seconds_counter, timer_digits);
        }

        //close the gate after 10s and no cars in the sensors:
        if (seconds_counter == -1) {
            INTCONbits.INT0IF = 0;
            seconds_counter = 0; //clear the timer counter
            Bin2Bcd(seconds_counter, timer_digits); //new value
            gate_closing();
            PORTBbits.RB3 = 0; //Keep LED OFF
            start_count = 0; //clear the flag 
            PORTAbits.RA0 = 0; //buzzer OFF
        }

        if (i == 3) {
            i = 1; //clear the index of digits of cars
        }
        if (j == 3) {
            j = 1; //clear the index of digits of timer 
        }
        if (Qstates == 0b00000000) {
            Qstates = 0b00001000; //initial value again
        }
    } else if (INTCONbits.INT0IF && start_count != 1) {
        INTCONbits.INT0IF = 0; //clear the interrupt
        gate_opening();
        seconds_counter = 10; //set timer 10 seconds to count down
        Bin2Bcd(seconds_counter, timer_digits);
        start_count = 1; //flag to start the counter
        PORTBbits.RB3 = 1; //Keep LED ON
        PORTAbits.RA0 = 0; //buzzer OFF
    } else if (INTCON3bits.INT1IF && PORTBbits.RB3 == 1 && car_counter != 10) {
        INTCON3bits.INT1IF = 0; //clear the interrupt
        car_counter++; //increment car counter
        Bin2Bcd(car_counter, car_digits); //new value of counter
    } else if (INTCON3bits.INT2IF && car_counter > 0 && PORTBbits.RB3 == 1) {
        INTCON3bits.INT2IF = 0; //clear the interrupt
        car_counter--; //decrement car counter
        Bin2Bcd(car_counter, car_digits); //new value of counter
    }
}