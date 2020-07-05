%% LABORATORUM SRMan
% ÆWICZENIE 4 - Jakoœæ sterowania z regulatorem ROOS dla dwóch rodzajów ograniczonych
%               podprzestrzeni sterowañ: hiperkuli i hiperprostopad³oœcianu
% 
% Plik inicjalizacyjny

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
initConditionsPos = [0; 0];

%% 1.3 OBLICZENIA
%---- • Dokonujê wymaganych obliczeñ z danych motora dostêpnych w pliku 
%       KartaKatF2260.PDF. 
% Zamieniam na jednostki SI sta³¹ maszyny Km Torque Constant (Motor Data, 883, p. 12)
%       Sta³a ta odpowiada za generowany moment na wale silnika. Zale¿na jest
%       od pr¹du wg wzoru: tauM = Km * i (5).
torqueConstnonSI = 78.2;                    % mNm/A
km = torqueConstnonSI * 0.001;              % Nm/A

% Zamieniam na jednostki SI sta³¹ maszyny Kb Speed Constant (Motor Data, p. 13)
%       Sta³a ta ma swoje odzwierciedlenie w rozliczeniu napiêæ panuj¹cych
%       w silniku wg wzoru: u = R*i + Kb*qmDot (4).
speedConstNonSI = 122;                      % rpm/V
speedConst = speedConstNonSI * (pi/30);     % rad/(V*s)

% Wartoœci Km i Kb s¹ ze sob¹ skorelowane. ¯eby je porównaæ, nale¿y
% odwróciæ sta³¹ speedConst i otrzymamy kb.
kb = speedConst^-1;

%---- • Wyliczam wspó³czynniki potrzebne do równania momentów silnika (3) z
%       notatek.

% No load speed, current 
%       S¹ to wartoœci dla silnika bez obci¹¿enia.
nlSpeedNonSI = 2840;                        % rpm       p. (2), dok.
qdotm = nlSpeedNonSI * (pi/30);             % rad/s     

nlCurrentNonSI = 226;                       % mA        p. (3), dok.
i0 = nlCurrentNonSI * 0.001;                % A

% Wspó³czynnik b_m (wzór (6), notatki)
bm = km*i0/qdotm;      

% Wyliczam sta³¹ czasow¹ inercji Tm
%       Jest to Mechanical time constant (punkt (15), dokumentacja)
rotorInertiaNonSI = 1300;                   % g*cm^2,   p. (16), dok.
Jm = rotorInertiaNonSI * 0.0000001;         % kg*m^2
R = 0.917;                                  % ohm,      p. (10), dok.
Tm = (Jm*R) / (km*kb+R*bm);                 % s

% Wyznaczam wzmocnienie statyczne K
K = km / (km*kb+R*bm);   

% Elementy sta³e macierzy mas M
global Jl1 Jl2
Jl1 = m1*L1^2+I1+m2*L2^2+I2;
Jl2 = m2*L2^2+I2;

%% 1.4 PARAMETRY PRZEK£ADNI
% Prze³o¿enie eta
global  eta1 eta2 eta
eta1 = 1/181;
eta2 = 1/181;
eta = diag([eta1; eta2]);   


%% 1.5 PARAMETRY SILNIKÓW
% Sta³e maszyny km, kb, bm
global km1 km2 kb1 kb2 bm1 bm2 R1 R2 Km R Jm1 Jm2

%----   Dane silnika nr 1 - przymocowanego do œciany
km1 = km;
kb1 = kb;
bm1 = bm;
R1 = R;
Jm1 = Jm;       % Moment bezw³adnoœci rotora
%----   Dane silnika nr 2 - przymocowanego do ogniwa
km2 = km;
kb2 = kb;
bm2 = bm;
R2 = R;
Jm2 = Jm;       % Moment bezw³adnoœci rotora
%----   Macierze
Km = diag([km1; km2]);
R = diag([R1; R2]);
invR = inv(R);

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
%---- • Przyj¹æ jednakowe ograniczenia momentów napêdowych dla obu silników manipulatora
%       PM2R

% Ustalam ograniczenia napiêciowe

global umax u1max u2max
u1max = 24; 
u2max = u1max*0.5;
umax = diag([u1max; u2max]);

%% (b)  ZADANIE 2.2
%---- • Zamodelowaæ równanie regulatora ROOS z (11) i zastosowaæ j¹ do manipulatora (1).
%       Zapewniæ mo¿liwoœæ swobodnej zmiany wartoœci zak³adanego tunelu ?.Wartoœci elementów
%       macierzy  dobraæ doœwiadczalnie tak, aby zapewniæ minimalne przeregulowania w
%       przebiegu b³êdu pozycji e(t).

% zobacz ~\SRManL4_ZADANIE1_ROOS.m

%---- USTALENIE TUNELU
global epsilon
epsilon = 0.9;

%---- STROJENIE REGULATORA
% uchyb e
lambda1 = 2.3;
lambda2 = 2.2;
Lambda = diag([lambda1 lambda2]);

% pochodna uchybu e'
d1 = 0.05;
d2 = 0.05;
D = diag([d1 d2]);
    