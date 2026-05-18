clc
clear all
close all

wn   = 10;
zeta = 0.2;

s = tf('s');

G = wn^2/(s^2 + 2*zeta*wn*s + wn^2);

Ts = 0.01;

t = 0:Ts:10;

y = step(G,t);

response_fft(y,Ts);

function [f1,mag_dB] = response_fft(y,Ts)
%RESPONSE_FFT Computes and plots FFT magnitude of a sampled response
%
% Inputs:
%   y  - sampled response vector
%   Ts - sampling time [sec]
%
% Outputs:
%   f1      - single-sided frequency vector [samples/sec]
%   mag_dB  - single-sided FFT magnitude [dB]
%
% Example:
%   response_fft(y,0.01);

    % Ensure column vector
    y = y(:);

    % FFT
    N = length(y);

    Y = fft(y);

    % Sampling frequency
    Fs = 1/Ts;

    % Frequency vector
    f = (0:N-1)*(Fs/N);

    % Single-sided spectrum
    P2 = abs(Y/N);

    P1 = P2(1:floor(N/2)+1);

    if length(P1) > 2
        P1(2:end-1) = 2*P1(2:end-1);
    end

    % Convert to dB
    mag_dB = 20*log10(P1 + eps);

    % Single-sided frequency vector
    f1 = f(1:floor(N/2)+1);

    % Plot
    figure;

    plot(f1,mag_dB,'LineWidth',1.5);

    grid on;

    xlabel('Frequency [samples/sec]');
    ylabel('Magnitude [dB]');

    title('FFT Magnitude Spectrum');

end