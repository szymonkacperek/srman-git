%% LABORATORUM SRMan
% ÆWICZENIE 4 - Jakoœæ sterowania z regulatorem ROOS dla dwóch rodzajów ograniczonych
%               podprzestrzeni sterowañ: hiperkuli i hiperprostopad³oœcianu

%---- • Regulator ROOS

function u = SRManL4_ZADANIE1_ROOS(input)

global epsilon umax
r1 = input(1);
r2 = input(2);
r = [r1; r2];

%  Równanie (5)
if norm(r) >= epsilon
    ans = (min(umax)/norm(r)) * r;
else
    ans = (min(umax)/epsilon) * r;
end

u = ans;