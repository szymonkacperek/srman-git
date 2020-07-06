%% LABORATORUM SRMan
% ÆWICZENIE 1 - Model manipulatora PM2R. Zadanie proste i odwrotne dynamiki
% ZADANIE 1

%---- • MIEJSCE NA NOTATKI
% 24/04 Generator G3 (Rect) œmiga na Janusza - patrz model Simulink. Do
%       poprawki, ale nie wiem jak póki co.
% 
%       Generator G3 jest ca³kowany, a nie powinien.
%       Poprawione? ( )TAK      (x) NIE
% 
%%
close all; clc; clear all

%% Parametry próbkowania
tend = 30;
Tp = 0.1;
t = 0 :Tp: (tend-Tp);
N = size(t,2);

%% ZADANIE 1.1a, 1.1b
%---- • Zamodelowaæ nastêpuj¹ce generatory sygna³ów referencyjnych (zadanych)
%       (i = 1, 2) G1, G2, G3: 

global Qd0 Qd1 Qd2 Qd3 omega
Qd0 = 0.1;
Qd1 = 0.2;
Qd2 = 0.3;
Qd3 = 0.4;
omega = 5.0;

%% ZADANIE 1.1c
%---- • G3: generator sygna³ów odcinkami sta³ych: qdi jako sygna³ prostok¹tny o zmiennej
%----   amplitudzie Qdi, zmiennym okresie Ti = Ta + Tb i zmiennym wype³nieniu Wi =
%----   Ta/(Ta+Tb).

Ta = 1;
Tb = 2*Ta;
Ti = Ta+Tb;
Wi = Ta / (Ta+Tb);
% G3 = rectpuls(t, Ti);

%% ZADANIE 1.2
%---- • Przyj¹æ wartoœci parametrów dynamicznych manipulatora PM2R. Przyk³adowy zestaw
%----   wartoœci parametrów podano poni¿ej (8) (przyjêto, ¿e Ii = miL2 i /12).

global m1 I1 L1 b1 g m2 I2 L2 b2 fC1 fC2
L1 = 1.0;           % m
m1 = 5.0;           % kg
I1 = m1*L1^2/12;    % kg*m
b1 = 9.5;           % N*s/rad
fC1 = 0.2;          % N*m

L2 = 0.8;           % m
m2 = 3.0;           % kg
I2 = m2*L2^2/12;    % kg*m
b2 = 4.5;           % N*s/rad
fC2 = 0.1;          % N*m

g = 9.81;           % m/s^2

%% ZADANIE 1.3
%---- • Rozwi¹zaæ zadanie odwrotne dynamiki manipulatora PM2R na podstawie modelu
%----   (7) dla sygna³ów zadanych z generatorów G1-G3 (dla ró¿nych wartoœci parametrów
%----   ka¿dego rodzaju sygna³u).
%----   • Przeanalizowaæ uzyskane przebiegi momentów napêdowych w z³¹czach manipulatora.
%----   • Czy sterowaniom sinusoidalnym odpowiadaj¹ sinusoidalne odpowiedzi manipulatora (w stanie ustalonym) jak w przypadku uk³adów liniowych?

% patrz m-plik ~/ZAD1_3.m