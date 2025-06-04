%@hugop%

%% exercice 1a
clear; close all; clc
disp("exercice 1a")

n = -10:10;
x = zeros(size(n));
x(n==0)  = 1;
x(n==1)  = -0.5;
x(n==2)  = 0.3;
x(n==-1) = -2;

subplot(2,1,1); stem(n, x, 'filled');
title("x[n] = δ[n] - 0.5δ[n-1] + 0.3δ[n-2] - 2δ[n+1]")
disp("x[n] est un signal fini avec un pic en n=0 et une anti-réponse en n=-1")
disp("il s agit d un signal de type reponse impulsionnelle modifiée")


%% exercice 1b
disp("exercice 1b")

n1 = 0:10;
x1 = ones(size(n1));
x1(n1 >= 5) = 0;

subplot(2,1,2); stem(n1, x1, 'filled');
title("x1[n] = u[n] - u[n-5]")
disp("x1[n] est un échelon de longueur 5 de n=0 à n=4")
disp("ce type de signal peut être utilisé pour tester la réponse d un système à une excitation constante")

%% exercice 2a
disp("exercice 2a")

n = 0:20;
x = [1 zeros(1,20)];
b = [0.3 0.6 0.6];
a = [1 -0.9];
y = filter(b, a, x);

figure;
subplot(2,1,1); stem(n, y, 'filled');
title("reponse impulsionnelle du filtre")

%% exercice 2b c sans freqz (fft à la place)
disp("exercice 2b ")
disp("exercice 2c ")
nfft = 512;
Y = fft(y, nfft);
f = linspace(0, 1, nfft); % fréquence normalisée

subplot(2,1,2); plot(f, abs(Y));
title("module de la reponse en frequence"); xlabel("frequence normalisee")

%% exercice 2d
disp("exercice 2d")

n = 0:20;
x2 = zeros(size(n));
x2(n <= 10) = 1;
y2 = filter(b, a, x2);

figure;
subplot(2,1,1); stem(n, x2, 'filled'); title("signal entree")
subplot(2,1,2); stem(n, y2, 'filled'); title("reponse du filtre")
disp("la reponse impulsionnelle du filtre decroit progressivement ce qui indique une stabilite")
disp("le module de la reponse en frequence est faible au centre et fort sur les bords")
disp("le filtre est donc un passe haut")
disp("la sortie pour un echantillon constant montre une reponse transitoire et un retour a 0")
disp("le filtre est causal car y[n] ne depend que de valeurs passees")
disp("le filtre est stable car la reponse impulsionnelle est absolument sommable")

%% exercice 3a
disp("exercice 3a")

num = [1 -1];
den = [75 20 1];
H = tf(num, den, -1);

figure;
pzmap(H);
title("poles et zeros de H(z)")

%% exercice 3b
disp("exercice 3b")

figure;
impulse(H);
title("reponse impulsionnelle de H(z)")

%% exercice 3c
disp("exercice 3c")

figure;
bodeplot(H);
title("reponse en frequence de H(z)")
disp("le plan des poles montre deux poles reel negatifs dans le cercle unite")
disp("le filtre est donc stable")
disp("la reponse impulsionnelle est breve donc le filtre est d ordre faible")
disp("la reponse en frequence montre une pente ascendante en magnitude donc comportement passe haut")
disp("le filtre est causal car defini par une fonction de transfert rationnelle avec retards positifs")
