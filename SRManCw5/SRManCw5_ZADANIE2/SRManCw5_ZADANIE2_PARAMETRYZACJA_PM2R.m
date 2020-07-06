%% LABORATORUM SRMan
% ÆWICZENIE 5 - Regulator adaptacyjny. Zbie¿noœæ estymat parametrów modelu manipulatora

% Estymaty macierzy  C, G, F - parametryzacja druga (SRManCw1.pdf, B)

%---- • NOTATKI
% 
function qDotDot = SRManCw5_ZADANIE2_PARAMETRYZACJA_PM2R(input)
global m1 I1 L1 b1 g m2 I2 L2 b2
% Definicja sygna³ów wejœciowych
tau = input(1:2);
q = input(3:4);
qDot = input(5:6);

% % Wyznaczam macierz regresji Y
% y11 = qDotDot(1) + qDotDot(2);
% y12 = (2*qDotDot(1) + qDotDot(2))*cos(q(2)) - (qDot(2)*qDot(1) + qDot(1)*qDot(2) + qDot(2)*qDot(2))*sin(q(2));
% y13 = qDotDot(1);
% y14 = cos(q(1)+q(2));
% y15 = cos(q(1));
% y16 = qDot(1);
% y17 = 0;
% 
% y21 = qDotDot(1) + qDotDot(2);
% y22 = qDotDot(1)*cos(q(2)) + qDot(1)*qDot(1)*sin(q(2));
% y23 = 0;
% y24 = cos(q(1)+q(2));
% y25 = 0;
% y26 = 0;
% y27 = qDot(2);
% 
% Y = [y11 y12 y13 y14 y15 y16 y17; y21 y22 y23 y24 y25 y26 y27];

% Wyznaczam wektor parametrów rzeczywistych p
% p = [I2+m2*L2^2 2*m2*L1*L2 I1+m1*L1^2+4*m2*L1^2 m2*L2*g (m1+2*m2)*g*L1 b1 b2];
global p

% Wyznaczam macierz rzeczywsit¹ M wg (SRManCw1.pdf, B)
m11 = p(1)+p(3)+2*p(2)*cos(q(2));
m12 = p(1)+p(2)*cos(q(2));
m21 = p(1)+p(2)*cos(q(2));
m22 = p(1);
M = [m11 m12; m21 m22];

% Wyznaczam macierz rzeczywist¹ C 
c11 = -p(2)*qDot(2)*sin(q(2));
c12 = -p(2)*(qDot(1)+qDot(2))*sin(q(2));
c21 = p(2)*qDot(1)*sin(q(2));
c22 = 0;
C = [c11 c12; c21 c22];

% Wyznaczam macierz rzeczywist¹ G
g11 = p(5)*cos(q(1)) + p(4)*cos(q(1)+q(2));
g12 = p(4)*cos(q(1)+q(2));
G = [g11; g12];

% Wyznaczam macierz rzeczywist¹ F
f11 = p(6)*qDot(1);
f21 = p(7)*qDot(2);
F = [f11; f21];

% OdpowiedŸ funkcji (wektor przyspieszeñ w przegubach)
h = C*qDot+G+F;
qDotDot = inv(M)*(tau-h);
