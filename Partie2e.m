%@hugop%

%% e1 voix de robot
clear; close all; clc
disp("e1 effet voix robot")

path = "C:\Users\hugop\OneDrive (1)\Cours esilv\A3\semestre 2\traitement\projet\sons\";
[x, fe] = audioread(path + "bonjour_filtré.wav");
t = (0:length(x)-1) / fe;

f0 = 100; % frequence du robot
robot = x .* sin(2*pi*f0*t') ;

sound(robot, fe); pause(length(robot)/fe + 1)
audiowrite(path + "bonjour_robot.wav", robot, fe);

%% e2 effet echo
disp("e2 effet echo")

delay_sec = 0.4;
delay_samp = round(delay_sec * fe);

echo = zeros(size(x));
echo(1+delay_samp:end) = x(1:end-delay_samp);
y_echo = x + echo;

sound(y_echo, fe); pause(length(y_echo)/fe + 1)
audiowrite(path + "bonjour_echo.wav", y_echo, fe);

%% e3 effet de distance sur mozart
disp("e3 effet de distance mozart")

[mozart, fs] = audioread(path + "Mozart_Bruit.wav");
t2 = (0:length(mozart)-1) / fs;

fade = linspace(0.1, 1, floor(length(mozart)/2));
volume = [fade'; flipud(fade')];
volume = volume(1:length(mozart)); % ajuste la taille

mozart_distance = mozart .* volume;

sound(mozart_distance, fs);
audiowrite(path + "Mozart_distance.wav", mozart_distance, fs);

disp("fin du script effets speciaux")
