%% LABORATORUM SRMan
% ÆWICZENIE 2 - Sterowanie z linearyzacj¹ sprzê¿eniem zwrotnym
% ZADANIE 1, ZADANIE 2 - Plik inicjalizacyjny

%---- • MIEJSCE NA NOTATKI
% 28/04 Nie dzia³a poprawnie model. Uchyby winny d¹¿yæ do zera.
% 02/05 Uchyby d¹¿¹ do zera przy wymuszeniu odcinkami sta³ym. W przypadku
%       wymuszenia sinusoidalnego maj¹ równie¿ przebieg sinusoidalny.
% 07/05 Uchyby naprawione. Problemem by³ generator sinusoidalny - w bloku
%       sine wave nie ustawi³em Phase na pi/2.

close all; clc; clear all
%---- • PARAMETRY PRÓBKOWANIA
tend = 30;
Tp = 0.01;
t = 0 :Tp: (tend-Tp);
N = size(t,2);

%---- • PARAMETRY MANIPULATORA
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

%---- • PARAMETRY GENERATORÓW
%       Sygna³ów referencyjnych qd

% G1 (Generator sinusoidalny)
Qd0 = 0.1;
Qd1 = 1.2;      
Qd2 = 1.3;      
Qd3 = 0.4;
omega1 = 0.1;
omega2 = 0.2;

% G2 (Generator wielomianowy)
Qd01 = 0.1;
Qd11 = 0.2;
Qd21 = 0.3;
Qd31 = 0.4;

Qd02 = 0.15;
Qd12 = 0.25;
Qd22 = 0.35;
Qd32 = 0.45;

% G3 (Generator odcinkami sta³y)
Qd1const = 1.3;      
Qd2const = 0.9;      
Ta = 5;
Tb = 2*Ta;
Ti = Ta+Tb;
Wi = Ta / (Ta+Tb);

% micha³ek
% Qd1 = 1.3;
wd1 = 0.05;
% Qd2 = 0.9;
wd2 = 0.2;

%% ZADANIE 1.1
%---- • Zaimplementowaæ pêtlê wewnêtrzn¹ (3) – por. rysunek 1 – zapewniaj¹c¹ 
%----   dynamiczn¹ linearyzacjê i odsprzêganie równania (1) w ca³ej przestrzeni 
%----   roboczej manipulatora PM2R.

% zobacz pliki ~/ZAD1_1_(...)

%% ZADANIE 1.2
%---- • Zaimplementowaæ zewnêtrzn¹ pêtlê sprzê¿enia (5) – rysunek 2.
% Dobieram omega_n
%        • Dobór tego parametru ma wp³yw na t³umienie. Dobór wspó³czynników Kp i Kv
%           zale¿y g³ównie od wartoœci tego parametru. Przyjê³o siê, ¿e powinny
%           wynosiæ oko³o omegaN/2.
omegaN1 = 2.0*5;
omegaN2 = 4.0*5;

% Dobieram wspó³czynniki kp i kv
kp1 = omegaN1^2;
kp2 = omegaN2^2;

kv1 = 2*omegaN1;
kv2 = 2*omegaN2;

% Tworzê macierz diagonaln¹ Kp i Kv
Kp = diag([kp1, kp2]);
Kv = diag([kv1, kv2]);

% Czas ustalania dla tunelu 1% Ts
%        • Jest to czas, po którym uchyb przejdzie do niemal¿e stanu
%           ustalonego - w naszym przypadku tunelu 1%. Jest to
%           aproksymacja. Wartoœci a i zeta (wspó³czynnik t³umienia) 
%           zosta³y zadane przez prowadz¹cego.
zeta = 1;                        
a = 2*pi;                                   
Ts1p1 = a / (zeta*omegaN1);
Ts1p2 = a / (zeta*omegaN2);

%% ZADANIE 2.1
%---- • Wprowadziæ estymaty p? 6= p parametrów dynamicznych manipulatora PM2R. 
%----   Dla przyjêtych estymat obliczyæ macierze M? i h? wystêpuj¹ce w równaniach modelu (1). 
%----   Zamodelowaæ pêtlê wewnêtrzn¹ (10).

global m1hat I1hat L1hat b1hat m2hat I2hat L2hat b2hat fC1hat fC2hat
% Parametry ramienia 0 
L1hat = L1;                 % m
m1hat = m1*0.9;             % kg
I1hat = m1hat*L1hat^2/12;   % kg*m
b1hat = b1*1.05;            % N*s/rad
fC1hat = fC1;               % N*m

% Parametry ramienia 1
L2hat = L2;                 % m
m2hat = m2*1.1;             % kg
I2hat = m2hat*L2hat^2/12;   % kg*m
b2hat = b2*0.95;            % N*s/rad
fC2hat = fC2;               % N*m

%% ZADANIE 2.2
%---- • Za³o¿yæ niepewnoœæ strukturaln¹ wynikaj¹c¹ tylko z zaniedbania si³ tarcia F (qÿ) poprzez
%----   przyjêcie: fCi = 0 oraz bi = 0, i = 1, 2. Zatem wektor h? w równaniu (14) powinien mieæ
%----   postaæ: h(q, qÿ) = C(q, qÿ)qÿ + G(q)

% zobacz pliki ~/ZAD2_2