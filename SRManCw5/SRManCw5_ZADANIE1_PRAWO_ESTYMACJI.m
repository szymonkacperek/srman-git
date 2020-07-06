%% LABORATORUM SRMan
% ÆWICZENIE 5 - Regulator adaptacyjny. Zbie¿noœæ estymat parametrów modelu manipulatora

% Zadanie proste dynamiki - parametryzacja druga (SRManCw1.pdf, B)

%---- • NOTATKI
% 
function phatPrim = SRManCw5_ZADANIE1_PRAWO_ESTYMACJI(input)

% Definicja sygna³ów wejœciowych
qdDotDot = input(1:2);
qdDot = input(3:4);
qDot = input(5:6);
q = input(7:8);
eDot = input(9:10);

% Wyznaczam macierz regresji Y
y11 = qdDotDot(1) + qdDotDot(2);
y12 = (2*qdDotDot(1) + qdDotDot(2))*cos(q(2)) - (qDot(2)*qdDot(1) + qDot(1)*qdDot(2) + qDot(2)*qdDot(2))*sin(q(2));
y13 = qdDotDot(1);
y14 = cos(q(1)+q(2));
y15 = cos(q(1));
y16 = qdDot(1);
y17 = 0;

y21 = qdDotDot(1) + qdDotDot(2);
y22 = qdDotDot(1)*cos(q(2)) + qDot(1)*qdDot(1)*sin(q(2));
y23 = 0;
y24 = cos(q(1)+q(2));
y25 = 0;
y26 = 0;
y27 = qdDot(2);

Y = [y11 y12 y13 y14 y15 y16 y17; y21 y22 y23 y24 y25 y26 y27];

% Wektor estymat parametrów
global Gamma
% stage1 = Gamma * Y;
phatPrim =  inv(Gamma) * Y' * eDot;
