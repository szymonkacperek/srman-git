%% LABORATORUM SRMan
% ÆWICZENIE 5 - Regulator adaptacyjny. Zbie¿noœæ estymat parametrów modelu manipulatora
% 
% ZADANIE 2 - Plik inicjalizacyjny

close all; clc; clear all
 
%---- • NOTATKI
% 
%% 1   PARAMETRY
%% 1.1 PARAMETRY PRÓBKOWANIA
tend = 30;
Tp = 0.1;
t = 0 :Tp: tend;
N = size(t,2);

%% 1.2 PARAMETRY MANIPULATORA
global m1 I1 L1 b1 g m2 I2 L2 b2 fC1 fC2
% Parametry ramienia 0 - rysunek zob. plik PDF
L1 = 1.0*0.9;           % m
m1 = 5.0;           % kg
I1 = m1*L1^2/12;    % kg*m
b1 = 9.5;           % N*s/rad
fC1 = 0.2;          % N*m

% Parametry ramienia 1
L2 = 0.8*0.9;           % m
m2 = 3.0*1.1;           % kg
I2 = m2*L2^2/12;    % kg*m
b2 = 4.5;           % N*s/rad
fC2 = 0.1;          % N*m

% Przyspieszenie grawitacyjne
g = 9.81;           % m/s^2

% Wektory warunków pocz¹tkowych - po³o¿enie ogniw
initConditionsVel = [0; 0];
initConditionsPos = [0; 0];%[pi/2; pi/2];

%% 1.6 PARAMETRY GENERATORÓW SYGNA£ÓW REFERENCYJNCYCH      
% G1 (Generator sinusoidalny)
Qd0 = 1;
Qd1 = 1;      
Qd2 = 1;      
Qd3 = 1;
omega1 = 0.6;
omega2 = 0.7;

% G2 (Generator wielomianowy)
Qd01 = 0.0025;
Qd11 = 0.0020;
Qd21 = 0.0015;
Qd31 = 0.001;

Qd02 = 0.0025;
Qd12 = 0.002;
Qd22 = 0.0015;
Qd32 = 0.001;

% G3 (Generator odcinkami sta³y)
Qd1const = 1;             % amplituda
Qd2const = 1;             % amplituda
Ta = 5;
Tb = Ta*1.8;

%% 2    ZADANIA
%% (a)  ZADANIE 2.1 
%---- • Korzystaj¹c z parametryzacji modelu manipulatora PM2R z æwiczenia 1, wyprowadziæ
%       postaæ macierzy regresji z równania (14) – elementy q¨r i qÿr wystêpuj¹ce w tej macierzy
%       wynikaj¹ z postaci równania (13).

% zobacz plik ./SRManCw5_ZADANIE1_PRAWO_ESTYMACJI.m

%% (b)  ZADANIE 2.2
%---- • Przyj¹æ pocz¹tkowe wartoœci estymat parametrów manipulatora phat != 0.

% Zmienn¹ wpisujê w bloku ca³kuj¹cym z subsystemu Simulink "PARAMETRY DYN."
phatInitConditions = [0.1 0.1 0.1 0.1 0.1 0.1 0.1];
global p;
p = [I2+m2*L2^2 2*m2*L1*L2 I1+m1*L1^2+4*m2*L1^2 m2*L2*g (m1+2*m2)*g*L1 b1 b2];

%% (c)  ZADANIE 2.3
%---- • Zamodelowaæ pêtlê regulacyjn¹ (13) – rys. 2. Wartoœci macierzy Kv i Lambda dobraæ doœwiadczalnie
%       jako macierze sta³e w czasie.

k = 5.0;
Lambda = diag([k k]);

w = 800.0;
Kv = diag([w w]);

% Macierz wzmocnieñ
global Gamma
r = 100.0;
Gamma = diag([r r r r r r r]);

%% (d)  ZADANIE 2.4
%---- • Zamodelowaæ blok estymacji parametrów (14) – rys. 2.

% zobacz ./SRManCw5_ZADANIE2_PRAWO_ESTYMACJI.m

%% (e)  ZADANIE 2.7
%---- • Przeprowadziæ symulacje dla skokowych, sinusoidalnych i wielomianowych sygna³ów zadanych
%       przyjmuj¹c macierz wzmocnieñ Kv jako zmienn¹ w czasie:

global Delta
delta = 5000.0;
Delta = diag([delta delta]);