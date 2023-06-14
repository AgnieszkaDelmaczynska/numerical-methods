% Liczba punktów K = 5, 15, 25, 35 wzdłuż jednego z kierunków
% (zakładamy, że obszar, po którym porusza się łazik jest kwadratem 100 × 100 m,
% zatem łazik jest w stanie dokonać pomiaru w K × K równoddalonych punktach)
K=[5,15,25,35];

%***********************************************************************
%   K = 5

% Do wygenerowania siatki punktów XX oraz YY
[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));

% [x,y,f]=lazik(K) - generator toru ruchu łazika oraz wartości pobranych próbek
% K - liczba punktów pomiarowych wzdłuż jednego z kierunków,

% x,y - wektory jednokolumnowe reprezentujące współrzędne położenia łazika
% w kolejnych chwilach pobierania próbek

% f - wektor jednokolumnowy zawierający wartości pobranych próbek.

[x,y,f]=lazik(K(1));

% Droga ruchu łazika
figure();
subplot(2,2,1);
plot(x,y,'-o','linewidth',3);
xlabel('x [m]');
ylabel('y [m]');
title('Tor ruchu łazika');  
grid();
    
% Dla każdego zestawu punktów wyznacz mapę rozkładu promieniowania w punktach
% rozłożonych co 1 m na całym obszarze, wykorzystując:
% • interpolację wielomianową
% (funkcje [p]=polyfit2d(x,y,f) i [FF]=polyval2d(XX,YY,p)),

% polyfit2d - funkcja wyznaczająca wartości współczynników pm,n interpolacji wielomianowej
% Liczba współczynników pm,n jest równa liczbie węzłów interpolacji -1,
% czyli liczbie pobranych próbek (K^2)
% p - wektor jednokolumnowy zawierający wartości współczynników interpolacji wielomianowej
[p]=polyfit2d(x,y,f);
% [FF] = polyval2d(XX,YY,p) - funkcja wyznaczająca interpolowane wartości funkcji
% (interpolacja wielomianowa) w dowolnych punktach badanego obszaru
% XX,YY - macierze zawierające współrzędne punktów, w których wyznaczane
% będą interpolowane wartości funkcji
% FF - macierz zawierająca interpolowane wartości funkcji
[FF]=polyval2d(XX,YY,p);

% Wartości zebranych próbek
% subplot do wyświetlenia kilku wykresów w jednym oknie
subplot(2, 2, 2);
plot3(x,y,f,'o');
title('Zbierane wartości próbek');
xlabel('x [m]');
ylabel('y [m]');
zlabel('f(x,y)');
grid();

% Mapy uzyskane z interpolacji wielomianowej i trygonometrycznej (surf)
subplot(2,2,3);
surf(XX, YY, FF);
title('Interpolacja wielomianowa');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();

% • interpolację trygonometryczną
% (funkcje [p]=trygfit2d(x,y,f) i [FF]=trygval2d(XX,YY,p)).

subplot(2,2,4);
% p - wektor jednokolumnowy zawierający wartości współczynników interpolacji trygonometrycznej
[p]=trygfit2d(x,y,f);
% [FF] = trygval2d(XX,YY,p) - funkcja wyznaczająca interpolowane wartości funkcji
% (interpolacja trygonometryczna) w dowolnych punktach badanego obszaru
% XX,YY - macierze zawierające współrzędne punktów, w których wyznaczane będą
% interpolowane wartości funkcji
% FF - macierz zawierająca interpolowane wartości funkcji
[FF] = trygval2d(XX, YY,p);
surf(XX, YY, FF);
title('Interpolacja trygonometryczna');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();
saveas(gcf, 'Zad1_K=5.png')

%***********************************************************************
%   K = 15
[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));
[x,y,f]=lazik(K(2));
    
figure();
subplot(2,2,1);
plot(x,y,'-o','linewidth',3);
xlabel('x [m]');
ylabel('y [m]');
title('Tor ruchu lazika');  
grid();
    
    
[p]=polyfit2d(x,y,f);
[FF]=polyval2d(XX,YY,p);
    
subplot(2, 2, 2);
plot3(x,y,f,'o');
title('Zbierane wartości próbek');
xlabel('x [m]');
ylabel('y [m]');
zlabel('f(x,y)');
grid();
    
subplot(2,2,3);
surf(XX, YY, FF);
title('Interpolacja wielomianowa');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();

subplot(2,2,4);
[p]=trygfit2d(x,y,f);
[FF] = trygval2d(XX, YY,p);
surf(XX, YY, FF);
title('Interpolacja trygonometryczna');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();
saveas(gcf, 'Zad1_K=15.png')


%***********************************************************************
%   K = 25

[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));
[x,y,f]=lazik(K(3));
    
figure();
subplot(2,2,1);
plot(x,y,'-o','linewidth',3);
xlabel('x [m]');
ylabel('y [m]');
title('Tor ruchu łazika');  
grid();
    
    
[p]=polyfit2d(x,y,f);
[FF]=polyval2d(XX,YY,p);
    
subplot(2, 2, 2);
plot3(x,y,f,'o');
title('Zbierane wartości próbek');
xlabel('x [m]');
ylabel('y [m]');
zlabel('f(x,y)');
grid();
    
subplot(2,2,3);
surf(XX, YY, FF);
title('Interpolacja wielomianowa');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();

subplot(2,2,4);
[p]=trygfit2d(x,y,f);
[FF] = trygval2d(XX, YY,p);
surf(XX, YY, FF);
title('Interpolacja trygonometryczna');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();
saveas(gcf, 'Zad1_K=25.png')


%***********************************************************************
%   K = 35

[XX,YY]=meshgrid(linspace(0,100,101),linspace(0,100,101));
[x,y,f]=lazik(K(4));
    
figure();
subplot(2,2,1);
plot(x,y,'-o','linewidth',3);
xlabel('x [m]');
ylabel('y [m]');
title('Tor ruchu łazika');  
grid();
    
    
[p]=polyfit2d(x,y,f);
[FF]=polyval2d(XX,YY,p);
    
subplot(2, 2, 2);
plot3(x,y,f,'o');
title('Zbierane wartości próbek');
xlabel('x [m]');
ylabel('y [m]');
zlabel('f(x,y)');
grid();
    
subplot(2,2,3);
surf(XX, YY, FF);
title('Interpolacja wielomianowa');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();

subplot(2,2,4);
[p]=trygfit2d(x,y,f);
[FF] = trygval2d(XX, YY,p);
surf(XX, YY, FF);
title('Interpolacja trygonometryczna');
xlabel('x [m]');
ylabel('y [m]');
grid();
zlabel('f(x,y)');
grid();
saveas(gcf, 'Zad1_K=35.png')
