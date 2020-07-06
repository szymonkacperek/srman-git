%% LABORATORUM SRMan
% ÆWICZENIE 1 - Model manipulatora PM2R. Zadanie proste i odwrotne dynamiki
% ZADANIE 1.3

%---- • MIEJSCE NA NOTATKI
% 

%% ZADANIE 1.3
%---- • Rozwi¹zaæ zadanie odwrotne dynamiki manipulatora PM2R na podstawie modelu
%----   (7) dla sygna³ów zadanych z generatorów G1-G3 (dla ró¿nych wartoœci parametrów
%----   ka¿dego rodzaju sygna³u).
%----   • Przeanalizowaæ uzyskane przebiegi momentów napêdowych w z³¹czach manipulatora.
%----   • Czy sterowaniom sinusoidalnym odpowiadaj¹ sinusoidalne odpowiedzi manipulatora (w stanie ustalonym) jak w przypadku uk³adów liniowych?

function tau = ZAD1_3(u)
global m1 I1 L1 b1 g m2 I2 L2 b2 fC1 fC2

% Definicja sygna³ów wejœciowych
% Sygna³ wejœciowy G3 nie powinien byæ ca³kowany
% % if (u(1) == G3_q1' && u(6) == G3_q2)
% %     q1 = u(1);
% %     q1_dot = 0;
% %     q1_dot_dot = 0;
% %     
% %     q2 = u(6);
% %     q2_dot = 0;
% %     q2_dot_dot = 0;
% %     
% %     q = [q1; q2];
% %     q_dot = [q1_dot; q2_dot];
% %     q_dot_dot = [q1_dot_dot; q2_dot_dot];
% %     
% % % Pozosta³e sygna³y G1 i G2 powinny byæ ca³kowane
% % else
% %     q1 = u(1);
% %     q1_dot = u(2);
% %     q1_dot_dot = u(3);
% %     
% %     q2 = u(6);
% %     q2_dot = u(5);
% %     q2_dot_dot = u(4);
% %     
% %     q = [q1; q2];
% %     q_dot = [q1_dot; q2_dot];
% %     q_dot_dot = [q1_dot_dot; q2_dot_dot];
% % end

q1 = u(1);
q1_dot = u(2);
q1_dot_dot = u(3);

q2 = u(4);
q2_dot = u(5);
q2_dot_dot = u(6);

q = [q1; q2];
q_dot = [q1_dot; q2_dot];
q_dot_dot = [q1_dot_dot; q2_dot_dot];

% Wyznaczenie macierzy bezwladnosci manipulatora
M11 = m1*L1^2+I1+m2*L2^2+I2+4*m2*L1^2+4*m2*L1*L2*cos(q2);
M21 = m2*L2^2+I2+2*m2*L1*L2*cos(q2);
M12 = m2*L2^2+I2+2*m2*L1*L2*cos(q2);
M22 = m2*L2^2+I2;
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
F11 = fC1*sign(q1_dot)+b1*q1_dot;
F21 = fC2*sign(q2_dot)+b2*q2_dot;
F = [F11; F21];

% OdpowiedŸ funkcji (wektor momentow sil)
tau = M*q_dot_dot+C*q_dot+G+F;