%@hugop%

%% d1 chargement du signal bonjour filtré
clear; close all; clc
disp("chargement du signal bonjour filtre")

path = "C:\Users\hugop\OneDrive (1)\Cours esilv\A3\semestre 2\traitement\projet\sons\";
[signal, fe] = audioread(path + "bonjour_filtré.wav");
t = (0:length(signal)-1) / fe;

%% d1 modulation dsb sc avec fc = 20khz
% question à repondre avant
disp("modulation du signal par une porteuse cos(2pi fct)")

fc = 20000;
porteuse = cos(2*pi*fc*t)';
mod = signal .* porteuse;

%% d1 fft du signal modulé
n = length(mod);
f = linspace(-fe/2, fe/2, n);
MOD = fftshift(fft(mod));

figure;
subplot(2,1,1); plot(t, mod);
title("signal module dsb sc"); xlabel("temps");

subplot(2,1,2); plot(f, abs(MOD));
title("spectre du signal module"); xlabel("frequence");

sound(mod, fe); % attention au volume

%% d2 demodulation par multiplication par la meme porteuse
disp("demodulation par multiplication avec la meme porteuse")

dmod = mod .* porteuse;

%% d2 filtrage passe bas via fft (on conserve < 4khz)
dm = fftshift(fft(dmod));
dm(abs(f) > 4000) = 0;
dmod_filtre = real(ifft(ifftshift(dm)));

%% d2 affichage
figure;
subplot(2,1,1); plot(t, dmod_filtre);
title("signal demodule filtre"); xlabel("temps");

subplot(2,1,2); plot(f, abs(fftshift(fft(dmod_filtre))));
title("spectre du signal demodule filtre"); xlabel("frequence");

sound(dmod_filtre, fe);

disp("fin du script modulation demodulation")
