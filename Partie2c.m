%@hugop%

%% c1 creation du signal x
clear; close all; clc

disp("c1 creation du signal x")

fe = 512;
t = 0:1/fe:1;
f1 = 5; f2 = 20; f3 = 35;
x = sin(2*pi*f1*t) + sin(2*pi*f2*t) + sin(2*pi*f3*t);

subplot(2,1,1); plot(t, x);
title("x(t) brut"); xlabel("temps"); ylabel("amplitude");

n = length(x);
X = fftshift(fft(x));
f = linspace(-fe/2, fe/2, n);

subplot(2,1,2); plot(f, abs(X));
title("fft de x(t)"); xlabel("frequence"); ylabel("amplitude");

%% c1 suppression de f2 manuelle dans la fft
disp("filtrage de f2 par suppression directe dans le spectre")

tol = 1;
X_filtre = X;
X_filtre(abs(f - 20) < tol | abs(f + 20) < tol) = 0;

x_filtre = real(ifft(ifftshift(X_filtre)));

figure;
subplot(2,1,1); plot(t, x_filtre);
title("x(t) filtre sans f2"); xlabel("temps");

subplot(2,1,2); plot(f, abs(X_filtre));
title("fft de x(t) filtre"); xlabel("frequence");

%% c2 chargement et fft nettoyage audio bonjour et mozart
disp("c2 nettoyage audio bonjour et mozart")

path = "C:\Users\hugop\OneDrive (1)\Cours esilv\A3\semestre 2\traitement\projet\sons\";

[bonjour_bruite, fs1] = audioread(path + "bonjour-bruit.wav");
[mozart_bruite, fs2] = audioread(path + "Mozart_Bruit.wav");

fc = 4000;

n1 = length(bonjour_bruite);
f1 = linspace(-fs1/2, fs1/2, n1);
B1 = fftshift(fft(bonjour_bruite));
B1(abs(f1) > fc) = 0;
bonjour_filtre = real(ifft(ifftshift(B1)));

n2 = length(mozart_bruite);
f2 = linspace(-fs2/2, fs2/2, n2);
M1 = fftshift(fft(mozart_bruite));
M1(abs(f2) > fc) = 0;
mozart_filtre = real(ifft(ifftshift(M1)));

%% c2 lecture audio et sauvegarde
disp("lecture audio bonjour")
sound(bonjour_filtre, fs1); pause(length(bonjour_filtre)/fs1 + 1);

disp("lecture audio mozart")
sound(mozart_filtre, fs2);

audiowrite(path + "bonjour_filtré.wav", bonjour_filtre, fs1);
audiowrite(path + "Mozart_filtré.wav", mozart_filtre, fs2);

%% c2 affichage temporel
t1 = (0:n1-1)/fs1;
t2 = (0:n2-1)/fs2;

figure;
subplot(2,2,1); plot(t1, bonjour_bruite); title("bonjour bruité");
subplot(2,2,2); plot(t1, bonjour_filtre); title("bonjour filtre");
subplot(2,2,3); plot(t2, mozart_bruite); title("mozart bruité");
subplot(2,2,4); plot(t2, mozart_filtre); title("mozart filtre");

disp("fin du script")
