%% LABORATORUM SRMan
% ÆWICZENIE 5 - Regulator adaptacyjny. Zbie¿noœæ estymat parametrów modelu manipulatora

% Estymaty macierzy  C, G, F - parametryzacja druga (SRManCw1.pdf, B)

%---- • NOTATKI
% 
function CGFhat = SRManCw5_ESTYMACJE_MACIERZY_CGF(input)
% global M C G F

% Definicja sygna³ów wejœciowych
phat = input(1:7);  
q = input(8:9);
qDot = input(9:10);
qdDot = input(11:12);

% Wyznaczam estymatê macierzy Chat wg (SRManCw1.pdf, B)
c11hat = -phat(2)*qDot(2)*sin(q(2));
c12hat = -phat(2)*(qDot(1)+qDot(2))*sin(q(2));
c21hat = phat(2)*qDot(1)*sin(q(2));
c22hat = 0;
Chat = [c11hat c12hat; c21hat c22hat];

% Wyznaczam estymatê macierzy Ghat
g11hat = phat(5)*cos(q(1)) + phat(4)*cos(q(1)+q(2));
g12hat = phat(4)*cos(q(1)+q(2));
Ghat = [g11hat; g12hat];

% Wyznaczam estymatê macierzy Fhat
f11hat = phat(6)*q(1);
f21hat = phat(7)*q(2);
Fhat = [f11hat; f21hat];

CGFhat = Chat*qdDot + Ghat + Fhat;
