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
L1 = 1.0*0.5;           % m
m1 = 5.0;           % kg
I1 = m1*L1^2/12;    % kg*m
b1 = 9.5;           % N*s/rad
fC1 = 0.2;          % N*m

% Parametry ramienia 1
L2 = 0.8*0.4;           % m
m2 = 3.0*1.6;           % kg
I2 = m2*L2^2/12;    % kg*m
b2 = 4.5;           % N*s/rad
fC2 = 0.1;          % N*m

% Przyspieszenie grawitacyjne
g = 9.81;           % m/s^2

% Wektory warunków pocz¹tkowych - po³o¿enie ogniw
initConditionsVel = [0; 0];
initConditionsPos = [0; 0];

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

%% (c)  ZADANIE 2.3
%---- • Zamodelowaæ pêtlê regulacyjn¹ (13) – rys. 2. Wartoœci macierzy Kv i Lambda dobraæ doœwiadczalnie
%       jako macierze sta³e w czasie.

Lambda = diag([800 800]);
Kv = diag([800 800]);

% Macierz wzmocnieñ
global Gamma
Gamma = diag([100 100 100 100 100 100 100]);

%% (d)  ZADANIE 2.4
%---- • Zamodelowaæ blok estymacji parametrów (14) – rys. 2.

% zobacz ./SRManCw5_ZADANIE2_PRAWO_ESTYMACJI.m

%% (e)  ZADANIE 1.5
%---- • Przeprowadziæ symulacje uk³adu sterowania (7)+(8) z manipulatorem (1) dla nastêpuj¹cych
%       sygna³ów zadanych: G1 i G2. Zapewniæ niezerowe pocz¹tkowe wartoœci b³êdów œledzenia e0 != 0.
%       • Jak zachowuj¹ siê b³êdy œledzenia e(t)? Czy zmierzaj¹ asymptotycznie do zera?
%         Czy s¹ ograniczone w ca³ym horyzoncie sterowania? Jak zachowuj¹ siê b³êdy prêdkoœci eÿ(t)?
%       • Zbadaæ wp³yw wartoœci wspó³czynników wzmocnienia ? bloku estymacji na szybkoœæ
%         zmian wartoœci estymat ?p(t) w ca³ym horyzoncie czasowym sterowania. Czy
%         wartoœci estymat ?p(t) zmierzaj¹ do prawdziwych wartoœci parametrów dynamicznych
%         p manipulatora?