% Parameters
Fs = 100e3;               % Sampling rate = 100 kHz
T  = 1.0;                 % Signal duration = 1 second
t  = 0:1/Fs:(T - 1/Fs);   % Time vector (0 to 1 s, step 1/Fs)
f1 = 5;                   % Intermediate frequency (Hz)
fc = 10000;               % Carrier frequency (Hz)
f2 = fc + f1;             % Second LO frequency = fc + f1 (10005 Hz)

% Baseband message signal f(t)
message = cos(2*pi*10 * t);   % 10 Hz cosine

% Weaver Modulation – Stage 1 (mix with f1)
LO1_cos = cos(2*pi*f1 * t);   % cos(2πf1t) for I branch
LO1_sin = sin(2*pi*f1 * t);   % sin(2πf1t) for Q branch
I1 = message .* LO1_cos;      % I branch mixer output
Q1 = message .* LO1_sin;      % Q branch mixer output

% Ideal Low-pass filter (cutoff = 5 Hz) on each branch via FFT
N = length(t);
cutoff = 5;  % cutoff frequency in Hz (B/2)
I1_fft = fft(I1); % fft stands for fast fourier transform
I1_fft(cutoff+2 : end-cutoff) = 0;   % zero out frequency components outside ±5 Hz
I1_filt = real(ifft(I1_fft));       % filtered I branch (0.5*cos(2π*5t))
Q1_fft = fft(Q1);
Q1_fft(cutoff+2 : end-cutoff) = 0;
Q1_filt = real(ifft(Q1_fft));       % filtered Q branch (-0.5*sin(2π*5t))

% Weaver Modulation – Stage 2 (mix with f2 and combine for USB)
LO2_cos = cos(2*pi*f2 * t); 
LO2_sin = sin(2*pi*f2 * t);
% Upconvert each branch to around fc (10 kHz)
I2 = I1_filt .* LO2_cos;    % I branch upconversion
Q2 = Q1_filt .* LO2_sin;    % Q branch upconversion
% Combine branches (USB): φ(t) = I2 + Q2 
phi = I2 + Q2;   % resulting SSB-modulated signal at ~10010 Hz (USB)

% Plot φ(t) in time domain (zoomed in to show high-frequency carrier)
figure;
t_zoom = t(1:100);              % first 0.001 s (1 ms) for zoomed view
plot(t_zoom, phi(1:100));
xlabel('Time (s)'); ylabel('\phi(t) amplitude');
title('SSB-SC Modulated Signal \phi(t) - Time Domain (Zoomed 1 ms)');
grid on;

% Compute and plot |Phi(f)| (magnitude spectrum of φ)
Phi = fft(phi);
N2 = floor(N/2);               % one-sided spectrum length (N even)
freq = (0:N2) * (Fs/N);        % frequency axis from 0 to Fs/2
Phi_mag = abs(Phi(1:N2+1));    % one-sided magnitude spectrum
figure;
plot(freq, Phi_mag);
xlim([0 12000]);  % focus x-axis to 0–12 kHz range for clarity
xlabel('Frequency (Hz)'); ylabel('|Phi(f)|');
title('Spectrum of SSB Signal \phi(t)');
grid on;
% Note: The spectrum shows a single peak at ~10010 Hz (fc + 10 Hz), 
% with no significant component at 9990 Hz (fc - 10 Hz). This confirms USB only.

% Weaver Demodulation – Stage 1 (mix φ with f2 and low-pass filter)
I3 = phi .* LO2_cos;   % mix with cos(2πf2t)
Q3 = phi .* LO2_sin;   % mix with sin(2πf2t)
% Low-pass filter to remove high-frequency (around 2*f2)
I3_fft = fft(I3);
I3_fft(cutoff+2 : end-cutoff) = 0;
I3_filt = real(ifft(I3_fft));   % recovered I at 5 Hz
Q3_fft = fft(Q3);
Q3_fft(cutoff+2 : end-cutoff) = 0;
Q3_filt = real(ifft(Q3_fft));   % recovered Q at 5 Hz

% Weaver Demodulation – Stage 2 (mix with f1 to recover baseband)
recovered_base = I3_filt .* LO1_cos + Q3_filt .* LO1_sin;
recovered = 4 * recovered_base;   % scale by 4 to restore original amplitude
% (Each mixing stage introduced a 1/2 factor; total gain ~0.25, so multiply by 4.)

% Plot and compare original and recovered signals
figure;
plot(t, message, 'b-', t, recovered, 'r--');
xlabel('Time (s)'); ylabel('Signal amplitude');
title('Recovered Signal vs. Original Message');
legend('Original f(t) = cos(2π·10t)', 'Recovered signal');
xlim([0 0.5]); grid on;
% The recovered 10 Hz signal (dashed red) overlaps the original (solid blue), 
% demonstrating successful SSB modulation and demodulation.