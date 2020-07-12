%% LABORATORUM SRMan
% ÆWICZENIE 5 - Regulator adaptacyjny. Zbie¿noœæ estymat parametrów modelu manipulatora

% Estymaty macierzy  C, G, F - parametryzacja druga (SRManCw1.pdf, B)

%---- • NOTATKI
% 
function Kv = SRManCw5_ZADANIE2_KV(input)
% global M C G F

% Definicja sygna³ów wejœciowych
s = input(1:2);
m1 = input(3);
m2 = input(4);
m3 = input(5);
m4 = input(6);
Mhat = [m1 m2; m3 m4];
global delta

Kv = Mhat * s;