%% LABORATORUM SRMan
% ÆWICZENIE 1 - Model manipulatora PM2R. Zadanie proste i odwrotne dynamiki
% ZADANIE 2

%---- • MIEJSCE NA NOTATKI
% 27/04 Mo¿na odpaliæ animacjê ruchu robota za pomoc¹ skryptu
%       ~/PM2Ranimation.m
% 
% 27/04 W blokach ca³kuj¹cych nale¿y ustawiæ waruki 'Initial Conditions' na
%       zmienne initConditions, ¿eby model Simulink poprawnie dzia³a³.
% 
%%
close all; clc; clear all

%% Parametry próbkowania
tend = 20;
Tp = 0.01;
t = 0 :Tp: (tend-Tp);
N = size(t,2);

%% ZADANIE 2.1a, 2.1b
%---- • Zamodelowaæ nastêpuj¹ce generatory momentów napêdowych (i = 1, 2) G4, G5:
%---- • G4: generator momentów sinusoidalnych:

global omega
omega = 5.0;
tauM1 = 3.0;
tauM2 = 4.0;

%---- • G5: generator momentów odcinkami sta³ych (rysunek 5): ?i(t) jako sygna³ prostok¹tny
%----   o zmiennej amplitudzie ?mi, zmiennym okresie Ti = Ta + Tb i zmiennym wype³nieniu Wi = Ta/(Ta+Tb):

Ta = 1;
Tb = 2*Ta;
Ti = Ta+Tb;
Wi = Ta / (Ta+Tb);

%% ZADANIE 2.2
%---- • Rozwi¹zaæ zadanie proste dynamiki manipulatora PM2R na podstawie modelu (4) dla
%----   momentów zadanych z generatorów G4-G5 (dla ró¿nych wartoœci parametrów ka¿dego
%----   rodzaju sygna³u).

%----   Realizacja: zobacz plik ~/ZAD2_2.m
global m1 I1 L1 b1 g m2 I2 L2 b2 fC1 fC2
% Parametry ramienia 0 - rysunek zob. plik PDF
L1 = 1.0;           % m
m1 = 5.0;           % kg
I1 = m1*L1^2/12;    % kg*m
b1 = 9.5;           % N*s/rad
fC1 = 0.2;          % N*m

% Parametry ramienia 1
L2 = 0.8;           % m
m2 = 3.0;           % kg
I2 = m2*L2^2/12;    % kg*m
b2 = 4.5;           % N*s/rad
fC2 = 0.1;          % N*m

% Przyspieszenie grawitacyjne
g = 9.81;           % m/s^2

% Wektory warunków pocz¹tkowych
initConditionsAcc = [0 0];
initConditionsVel = [0 0];