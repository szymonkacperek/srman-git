%% LABORATORUM SRMan
% ÆWICZENIE 5 - Regulator adaptacyjny. Zbie¿noœæ estymat parametrów modelu manipulatora

% Zadanie proste dynamiki - parametryzacja druga (SRManCw1.pdf, B)

%---- • NOTATKI
% 
function phatPrim = SRManCw5_ZADANIE2_PRAWO_ESTYMACJI(input)

% Definicja sygna³ów wejœciowych
qrDotDot = input(1:2);
qrDot = input(3:4);
qDot = input(5:6);
q = input(7:8);
s = input(9:10);

% Wyznaczam macierz regresji Y
y11 = qrDotDot(1) + qrDotDot(2);
y12 = (2*qrDotDot(1) + qrDotDot(2))*cos(q(2)) - (qDot(2)*qrDot(1) + qDot(1)*qrDot(2) + qDot(2)*qrDot(2))*sin(q(2));
y13 = qrDotDot(1);
y14 = cos(q(1)+q(2));
y15 = cos(q(1));
y16 = qrDot(1);
y17 = 0;

y21 = qrDotDot(1) + qrDotDot(2);
y22 = qrDotDot(1)*cos(q(2)) + qDot(1)*qrDot(1)*sin(q(2));
y23 = 0;
y24 = cos(q(1)+q(2));
y25 = 0;
y26 = 0;
y27 = qrDot(2);

Y = [y11 y12 y13 y14 y15 y16 y17; y21 y22 y23 y24 y25 y26 y27];

% Wektor estymat parametrów
global Gamma
phatPrim =  inv(Gamma) * Y' * s;
