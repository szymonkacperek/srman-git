%% LABORATORUM SRMan
% ÆWICZENIE 3 - Schemat sterowania z niezale¿nymi regulatorami osi i
%               kompensacj¹ oddzia³ywania grawitacyjnego
% 
% Funkcja obliczaj¹ca tau

%---- • NOTATKI
% 
function tau = ZAD1_1_tau(input)

u = input(1:2);

global eta1 eta2 km1 km2 R1 R2 eta Km R

tau = inv(eta) * Km * inv(R) * u;
