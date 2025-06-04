%@hugop%
%% Partie B – quantification d un signal audio
clear; close all; clc;
path = "C:\Users\hugop\OneDrive (1)\Cours esilv\A3\semestre 2\traitement\projet\sons\";
file = path + "extrait.wav";

%% 1 on chargee le fichier audio et ses info
[x, fs] = audioread(file);         % c est les donnes audios
info = audioinfo(file);            % et ça métadonnees du fichier
fprintf(" le fichier '%s' chargé.\n", file);

%% a) frrequence d echantillonnage
fe = fs;                           
nb_bits = info.BitsPerSample;      % bits par echnatillon
fprintf(" a)fréquence d'échantillonnage fe : %d Hz\n", fe);
fprintf("Quantification : %d bits\n", nb_bits);
% Fréquence de Nyquist (fréquence critique selon Shannon)-> merci chat
f_critique = fe / 2;
fprintf("frequence critique (Nyquist) : %d Hz\n", f_critique);

%% b) standard CD-Audio & codec
disp("b) Standard CD-audio = 44100 Hz, 16 bits, stéréo");
disp("    CODEC = Coder-Decodeur, algo qui permet la compression/décompression audio.");
disp("   on a choisi cet ordre de grandeur pour la frequence d echantillonnage car c est un standard qui permet un bon compromis entre qualité et taille.");
disp("    Différence avec 'singing.wav' -> cela depend de la source d enregistrement");

%% c) Nombre d’échantillons et durée totale
nb_echantillons = info.TotalSamples;
duree = info.Duration;
fprintf("c) Nb d'échantillons : %d\n", nb_echantillons);
fprintf(" durée totale du signal : %.2f secondes\n", duree);
fprintf("j ai teste sur le lecture d'audio de windows le son affiche 14 secondes")
fprintf("donc cela semble cohérent car c est identique à la valeur trouvée !!")

%% d) Vérification nombre de bits de quantification
fprintf("d) Vérification : %d bits par échantillon.\n", nb_bits);

%% e) Pas de quantification (résolution en amplitude)
pas_theorique = 2 / (2^nb_bits);   % Car l'amplitude est sur [-1 ; 1]
fprintf("e) Pas théorique de quantification : %.6f\n", pas_theorique);

%% f) verif num du quantum
diffs = diff(sort(unique(x(:))));
quantum_approx = min(diffs(diffs > 0));  % Évite 0
fprintf("f) le quantum est estimé à partir des donnees : %.6f\n", quantum_approx);

%% g) taille approximative du fichier
taille_approx_bits = nb_echantillons * nb_bits;
taille_approx_o = taille_approx_bits / 8;
taille_approx_ko = taille_approx_o / 1024;
fprintf("g) Taille approximative du signal audio : %.1f Ko\n", taille_approx_ko);
fprintf("  Taille réelle selon Windows : %.1f Ko\n", info.TotalSamples * info.BitsPerSample * info.NumChannels / 8 / 1024); % ca peut varier
