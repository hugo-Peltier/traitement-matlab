%@hugop%
%% Partie II-A Enregistrement live
clear; close all; clc;

%% 1) on charge les fichiers audio
path = "C:\Users\hugop\OneDrive (1)\Cours esilv\A3\semestre 2\traitement\projet\sons\";
[x, fs_x]     = audioread(path + "singing.wav");
[h_ch, fs_ch] = audioread(path + "ChurchImpulse.wav");
[h_dg, fs_dg] = audioread(path + "DungeonImpulse.wav");
disp("les fichiers audio ont été chargés avec succès. Bravo à vous notamment daphné & candice ;)");

%% 2) on verifie les frequences d echantillonnage
fprintf("fs 'singing.wav'        : %d Hz\n", fs_x);
fprintf(" fs 'ChurchImpulse.wav' : %d Hz\n", fs_ch);
fprintf(" fs 'DungeonImpulse.wav': %d Hz\n", fs_dg);
if fs_x == fs_ch && fs_x == fs_dg
    disp("on a des frequences d echantillonnage qui sont identiques donc on a pas besoin d un sample");
else
    error("frequences d’échantillonnage incompatibles. Utilisee resample.");
end

%% 3) convulotion des signaux ( on veut donner l'impression d etre dans une salle)
y_church  = conv(x, h_ch);
y_dungeon = conv(x, h_dg);
disp("convolution effectuée avec succèsssssssssssss");

%% 4) on ecoute les sons
disp("Lecture des sons en cours ...");
sound(x, fs_x);        pause(length(x)/fs_x + 1);
sound(h_ch, fs_x);     pause(length(h_ch)/fs_x + 1);
sound(y_church, fs_x); pause(length(y_church)/fs_x + 1);
sound(h_dg, fs_x);     pause(length(h_dg)/fs_x + 1);
sound(y_dungeon, fs_x);

%% 5) on normalise
y_church = y_church / max(abs(y_church));
y_dungeon = y_dungeon / max(abs(y_dungeon));
% juste un patch pour écraser les fichiers de meme noms
if isfile(path + "singingChurch.wav")
    delete(path + "singingChurch.wav");
end
if isfile(path + "singingDungeon.wav")
    delete(path + "singingDungeon.wav");
end
audiowrite(path + "singingChurch.wav", y_church, fs_x);
audiowrite(path + "singingDungeon.wav", y_dungeon, fs_x);
disp("fichiers sauvegardes sans clipping ");

%% 6) plot affichage temporel
t_x = (0:length(x)-1)/fs_x;
t_ch = (0:length(y_church)-1)/fs_x;
t_dg = (0:length(y_dungeon)-1)/fs_x;
figure;
subplot(3,1,1); plot(t_x, x); title("Signal original"); xlabel("Temps (s)"); ylabel("Amplitude");
subplot(3,1,2); plot(t_ch, y_church); title("SingingChurch"); xlabel("Temps (s)"); ylabel("Amplitude");
subplot(3,1,3); plot(t_dg, y_dungeon); title("SingingDungeon"); xlabel("Temps (s)"); ylabel("Amplitude");

%% 7) calcul des FFT
N = 2^nextpow2(max([length(x), length(y_church), length(y_dungeon)]));
X  = fftshift(fft(x, N));
Yc = fftshift(fft(y_church, N));
Yd = fftshift(fft(y_dungeon, N));
f = linspace(-fs_x/2, fs_x/2, N);

%% 8)  spectres en amplitude & affichage 
figure;
subplot(3,1,1); plot(f, abs(X)); title("|FFT| Signal original"); xlabel("Fréquence (Hz)"); ylabel("Amplitude");
subplot(3,1,2); plot(f, abs(Yc)); title("|FFT| SingingChurch"); xlabel("Fréquence (Hz)"); ylabel("Amplitude");
subplot(3,1,3); plot(f, abs(Yd)); title("|FFT| SingingDungeon"); xlabel("Fréquence (Hz)"); ylabel("Amplitude");
