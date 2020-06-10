close all;

q1 = Qsamples(:,1);
q2 = Qsamples(:,2);

N = size(q1,1);

x0 = 0.0;
y0 = 0.0;

LL1 = 2*L1;
LL2 = 2*L2;
hF = figure(100);
grid on;
axis([-2 2 -2 2]);
       
krok = 4;

for i=1:krok:N
    x1 = x0 + LL1*cos(q1(i));
    y1 = y0 + LL1*sin(q1(i));
    x2 = x1 + LL2*cos(q1(i)+q2(i));
    y2 = y1 + LL2*sin(q1(i)+q2(i)); 
    X1 = [x0;x1];
    Y1 = [y0;y1];
    X2 = [x1;x2];
    Y2 = [y1;y2];
    figure(100);
    axis([-2 2 -2 2]);
    hold off;
    plot(X1,Y1,'b','Linewidth',3.5);
    grid on;
    hold on;
    plot(X2,Y2,'b','Linewidth',2.0);
    plot(x0,y0,'ko');
    plot(x1,y1,'ko');
    plot(x2,y2,'rx');
    axis([-4 4 -4 4]);
    pause(0.0001);
end
