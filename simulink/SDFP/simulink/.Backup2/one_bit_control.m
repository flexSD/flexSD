w=24; % word width
d=16; % decimal width

% parameters for SDFP (Sigma Delta Fixed Point) blocks 
fixpt_adder_in_bitwidth=24;
fixpt_adder_in_position=16;
fixpt_adder_out_bitwidth=24;
fixpt_adder_out_position=16;

fixpt_gain_bitwidth=24;
fixpt_gain_position=16;

% ts_k_gain[1-3] == bits to shift for different stages

Fs1 = 100000; 
Fs_power_2 = (round(log(Fs1)/log(2))) % calculation of the sampling frequency as a power of 2
Fs = 2^Fs_power_2 
ts = 1/Fs;
T = ts; % sampling period

k_bitshift = -13;
k = 2^k_bitshift; % k gain as a power of negative 2
ts_k_gain1 = k_bitshift - Fs_power_2;
ts_k_gain2 = k_bitshift - Fs_power_2;
ts_k_gain3 = k_bitshift - Fs_power_2;

% if Fs = 1024, k ~ 2^-8
% p0 ~ .001-1
% p1 ~ 2-7
% p2 ~ >10
% p3 ~ 8
% q0 ~ 0
% q1 ~ 0.6828 ~ .4-2
% q2 ~ around 1.6356 >1
% only adjust k gain and Fs!

s = tf('s')
P = 3.78/(s*(s+16.88)); %plant (system to control) transfer function

Kp = 8; % proportional gain
Ki = 3; % intigral gain
C = (s^2 + 20.78*s + 109.9)/(s^2 + 26.33*s + 174.8)*(Kp+Ki/s); %designed 2nd order controller with PI prefilter

% calculation of controller coefficients
p0 = (109.9*Ki)*T^3*k^-3
p1 = (20.78*Ki+109.9*Kp)*T^2*k^-2
p2 = (Ki+20.78*Kp)*T*k^-1
p3 = Kp
q0 = 0*T^3*k^-3
q1 = 174.8*T^2*k^-2
q2 = 26.33*T*k^-1

% writing input and output code to text file 
fid=fopen('input_data.txt', 'wt');
fprintf(fid,'%d\n', input);           
fclose(fid);

fid=fopen('output_data.txt', 'wt');
fprintf(fid,'%d\n', output);           
fclose(fid);


% plot of two sided power spectrum for contoller output
F = fft(Y.signals.values);
L = (abs(F)/length(Y.signals.values)).^2;
L = 2*L;
Hmss=dspdata.msspectrum(L,'Fs',Fs,'spectrumtype','twosided'); 
figure; plot(Hmss);

% plot of two sided power spectrum for plant output
F = fft(plant_output.signals.values);
L = (abs(F)/length(plant_output.signals.values)).^2;
L = 2*L;
Hmss=dspdata.msspectrum(L,'Fs',Fs,'spectrumtype','twosided'); 
figure; plot(Hmss);

% plot of two sided power spectrum for input signal with additive white noise
F = fft(input.signals.values);
L = (abs(F)/length(input.signals.values)).^2;
L = 2*L;
Hmss=dspdata.msspectrum(L,'Fs',Fs,'spectrumtype','twosided'); 
figure; plot(Hmss);
