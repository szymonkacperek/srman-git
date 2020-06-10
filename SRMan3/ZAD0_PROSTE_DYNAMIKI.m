%% LABORATORUM SRMan
% ÆWICZENIE 3 - Schemat sterowania z niezale¿nymi regulatorami osi i kompensacj¹ oddzia³ywania grawitacyjnego
% ZADANIE 1.1

%---- • NOTATKI
% 
%% ZADANIE 1.1
%---- • Zaimplementowaæ rozszerzony model manipulatora PM2R zgodnie z równaniem (10) i
%----   schematem z rys. 2 (pocz¹tkowo przyj¹æ ?? = 0). Wartoœci parametrów napêdów (w
%----   jednostkach SI) przyj¹æ na podstawie karty katalogowej wybranego silnika DC zinte-
%----   growanego z przek³adni¹ redukcyjn¹. Nale¿y pamiêtaæ, ¿e elementy bezw³adnoœciowe w
%----   macierzy M(q) powinny uwzglêdniaæ teraz masê uk³adu wykonawczego i sposób jego
%----   umieszczenia w manipulatorze.

function qDotDot = ZAD0_PROSTE_DYNAMIKI(u)
global m1 I1 L1 b1 g m2 I2 L2 b2 fC1 fC2

% Definicja sygna³ów wejœciowych
tau1 = u(1);
tau2 = u(2);    
tau = [tau1; tau2];

q1 = u(3);
q2 = u(4);
q = [q1; q2];

q1_dot = u(5);
q2_dot = u(6);
qDot = [q1_dot; q2_dot];

% Wyznaczenie zmodyfikowanej macierzy bezwladnosci manipulatora M
global Jm1 Jm2 eta1 eta2 Jl1 Jl2
M11 = ((1/eta1^2)*Jm1+Jl1)+4*m2*L1^2+4*m2*L1*L2*cos(q2);
M21 = m2*L2^2+I2+2*m2*L1*L2*cos(q2);
M12 = m2*L2^2+I2+2*m2*L1*L2*cos(q2);
M22 = (1/eta2^2)*Jm2+Jl2;
M = [M11 M21; M12 M22];

% Wyznaczenie macierzy wspolczynnikow uogolnionych sil Coriolisa i odsrodkowych
C11 = -2*m2*L1*L2*q2_dot*sin(q2);
C21 = 2*m2*L1*L2*q1_dot*sin(q2);
C12 = -2*m2*L1*L2*(q1_dot+q2_dot)*sin(q2);
C22 = 0;
C = [C11 C21; C12 C22];

% Wyznaczenie wektora uogolnionych sil grawitacji
G11 = (m1*L1+2*m2*L1)*g*cos(q1)+m2*L2*g*cos(q1+q2);
G21 = m2*L2*g*cos(q1+q2);
G = [G11; G21];

% Wyznaczenie wektora uogolnionych sil tarcia
global bm1 bm2 km1 km2 R1 R2 kb1 kb2
F11 = fC1*sign(q1_dot) + (b1 + (1/eta1^2)*bm1 + (km1*kb1)/(eta1^2*R1)) * q1_dot;
F21 = fC2*sign(q2_dot) + (b2 + (1/eta2^2)*bm2 + (km2*kb2)/(eta2^2*R2)) * q2_dot;
F = [F11; F21];

% OdpowiedŸ funkcji (wektor przyspieszeñ w przegubach)
global tauDelta
h = C*qDot + G + F + tauDelta;

qDotDot = inv(M)*(tau-h);