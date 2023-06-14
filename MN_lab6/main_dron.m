clc
clear all
close all

warning('off','all')

%%%%%%%%%%%
% ZADANIE 2


%  Wczytaj plik trajektoria1.mat
load trajektoria1

figure(1)
% wykreśl położenie drona
plot3(x,y,z,'o')
title('Trajektoria drona', '"trajektoria1"')
xlabel('x')
ylabel('y')
zlabel('z')
grid on
axis equal


%%%%%%%%%%%
% ZADANIE 3

fid = fopen( '184592_Delmaczynska_zad3.txt', 'wt' );
fprintf( fid, 'Zad 3.\nMyślę, że lepiej byłoby użyć aproksymacji, ponieważ nasze dane obarczone są dużym błędem.');
fclose(fid);


%%%%%%%%%%%
% ZADANIE 4

% Użyj funkcji [wsp, xa] = aproksymacjaWiel(n,x,N) do aproksymacji położenia
% dronu za pomocą wielomianów dla N = 50

N = 50; %  (rząd aproksymacji)

% Uwaga – trzeba aproksymować osobno współrzędne x,y,z
[ wsp_wielomianu, xa ] = aproksymacjaWiel(n,x,N);  % aproksymacja 'x'.
[ wsp_wielomianu, ya ] = aproksymacjaWiel(n,y,N);  % aproksymacja 'y'.
[ wsp_wielomianu, za ] = aproksymacjaWiel(n,z,N);  % aproksymacja 'z'.

figure(2)
% Wykreśl w jednym oknie trajektorię drona:
% - bazującą na lokalizacji (wykres: 'o')
plot3(x,y,z,'o')
hold on
% - aproksymowaną (wykres:’lineWidth’,4)
plot3(xa,ya,za,'lineWidth',4)
title('Trajektoria drona', '"trajektoria1"')
xlabel('x')
ylabel('y')
zlabel('z')
legend('rzeczywiste położenie','aproksymowane położenie (wielomianowe)')
grid on
axis equal
hold off
saveas(gcf,'184592_Delmaczyńska_zad4','png')



%%%%%%%%%%%
% ZADANIE 5

% Wykreśl położenie drona (lokalizacja i aproksymacja)
% dla danych z trajektoria2.mat i N = 60
% Zauważ, że położenie drona jest wyznaczone w większych odstępach czasu

load trajektoria2

N = 60;
[ wsp_wielomianu, xa ] = aproksymacjaWiel(n,x,N);  
[ wsp_wielomianu, ya ] = aproksymacjaWiel(n,y,N); 
[ wsp_wielomianu, za ] = aproksymacjaWiel(n,z,N);

figure(3)
plot3(x,y,z,'o')
hold on
plot3(xa,ya,za,'lineWidth',4)
title('Trajektoria drona, N=60', '"trajektoria2"')
xlabel('x')
ylabel('y')
zlabel('z')
legend('rzeczywiste położenie','aproksymowane położenie (wielomianowe)')
grid on
axis equal
hold off

N = 70;
[ wsp_wielomianu, xa ] = aproksymacjaWiel(n,x,N);  
[ wsp_wielomianu, ya ] = aproksymacjaWiel(n,y,N); 
[ wsp_wielomianu, za ] = aproksymacjaWiel(n,z,N);

figure(4)
plot3(x,y,z,'o')
hold on
plot3(xa,ya,za,'lineWidth',4)
title('Trajektoria drona, N=70', '"trajektoria2"')
xlabel('x')
ylabel('y')
zlabel('z')
legend('rzeczywiste położenie','aproksymowane położenie (wielomianowe)')
grid on
axis equal
hold off

N = 50; % 40 też nie najgorzej
[ wsp_wielomianu, xa ] = aproksymacjaWiel(n,x,N);  
[ wsp_wielomianu, ya ] = aproksymacjaWiel(n,y,N); 
[ wsp_wielomianu, za ] = aproksymacjaWiel(n,z,N);

figure(5)
plot3(x,y,z,'o')
hold on
plot3(xa,ya,za,'lineWidth',4)
title('Trajektoria drona, N=50', '"trajektoria2"')
xlabel('x')
ylabel('y')
zlabel('z')
legend('rzeczywiste położenie','aproksymowane położenie (wielomianowe)')
grid on
axis equal
hold off
saveas(gcf,'184592_Delmaczynska_zad5','png')


fprintf('Powyższy błąd powoduje efekt Rungego.\n')
% err opisuje bliskość trajektorii zmierzonej i aproksymowanej.
err(71) = 0;
M = length(n); % Wektor n o długości M zawiera chwile czas

for N = 1:71
    [ wsp_wielomianu, xa ] = aproksymacjaWiel(n,x,N);  
    [ wsp_wielomianu, ya ] = aproksymacjaWiel(n,y,N);  
    [ wsp_wielomianu, za ] = aproksymacjaWiel(n,z,N);  
    errx = sqrt(sum((x-xa).^2))/M;
    erry = sqrt(sum((y-ya).^2))/M;
    errz = sqrt(sum((z-za).^2))/M;

    % sumowane są trzy skalary, które określają różnicę pomiędzy
    % położeniem zmierzonym a aproksymowanym dla współrzędnych x, y, z

    % z tego względu err opisuje bliskość trajektorii zmierzonej i aproksymowanej.
    err(N)= errx+erry+errz;
end

% Stwórz wykres błędu (err) dla N = 1 ... 71
figure(6)
semilogy(err)
title('Wykres błędu aproksymacji (efekt Rungego) dla trajektoria2', 'aproksymacja wielomianowa')
xlabel('N')
ylabel('Błąd (err)')
saveas(gcf,'184592_Delmaczynska_zad5b','png')

[~,N] = min(err);
fprintf('N=%i zwraca najmniejszy skumulowany błąd dla trajektorii2 (aproksymacja wielomianowa)\n', N)



%%%%%%%%%%%
% ZADANIE 7

% Ostatnie zadanie polega na sprawdzeniu, czy w przypadku aproksymacji
% funkcjami trygonometrycznymi występuje efekt Rungego

load trajektoria2

plot3(x,y,z, 'o');
grid on
axis equal
hold on;

N = 60;
[ xa ] = aprox_tryg(n, x, N);
[ ya ] = aprox_tryg(n, y, N);
[ za ] = aprox_tryg(n, z, N);
plot3(xa, ya, za, 'lineWidth', 4);
title("Aproksymacja trajektorii vs zmierzona trajektoria N=60");
xlabel('x');
ylabel('y');
zlabel('z');
saveas(gcf,'184592_Delmaczynska_zad7a','png')

hold off;
errv = [];
M = size(n, 2);
for N=1:71
    [xa] = aprox_tryg(n, x, N);
    [ya] = aprox_tryg(n, y, N);
    [za] = aprox_tryg(n, z, N);
    
    errx = sqrt(sum((x-xa).^2))/M;
    erry = sqrt(sum((y-ya).^2))/M;
    errz = sqrt(sum((z-za).^2))/M;
    errv = [errv, errx+erry+errz];
end
figure;
semilogy(errv);
title("Wykres błędu aproksymacji (efekt Rungego)");
xlabel("N");
ylabel('Błąd (err)')
grid on
saveas(gcf,'184592_Delmaczynska_zad7b','png')

[~,N] = min(errv);
fprintf('N=%i zwraca najmniejszy skumulowany błąd dla trajektorii2 (aproksymacja trygonometryczna)\n', N)
