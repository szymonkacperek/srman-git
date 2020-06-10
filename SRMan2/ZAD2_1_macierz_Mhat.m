%% LABORATORUM SRMan
% ÆWICZENIE 2 - Sterowanie z linearyzacj¹ sprzê¿eniem zwrotnym
% ZADANIE 2.1

%---- • MIEJSCE NA NOTATKI
% 
%% ZADANIE 2.1
%---- • Wprowadziæ estymaty p? 6= p parametrów dynamicznych manipulatora PM2R. 
%----   Dla przyjêtych estymat obliczyæ macierze M? i h? wystêpuj¹ce w równaniach modelu (1). 
%----   Zamodelowaæ pêtlê wewnêtrzn¹ (10).

%---- Macierz M

function Mv = ZAD2_1_macierz_Mhat(u)
global m1hat I1hat L1hat m2hat I2hat L2hat
% Definicja wejœæ
q1 = u(1);
q2 = u(2);
q = [q1; q2];

v1 = u(3);
v2 = u(4);
v = [v1; v2];

% Wyznaczenie macierzy bezwladnosci manipulatora
M11 = m1hat*L1hat^2+I1hat+m2hat*L2hat^2+I2hat+4*m2hat*L1hat^2+4*m2hat*L1hat*L2hat*cos(q2);
M21 = m2hat*L2hat^2+I2hat+2*m2hat*L1hat*L2hat*cos(q2);
M12 = m2hat*L2hat^2+I2hat+2*m2hat*L1hat*L2hat*cos(q2);
M22 = m2hat*L2hat^2+I2hat;
M = [M11 M21; M12 M22];

% OdpowiedŸ funkcji
Mv = M*v;