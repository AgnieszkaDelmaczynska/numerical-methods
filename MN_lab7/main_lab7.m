clc
clear all
close all

% Wartość referencyjna całki podana jest w pliku P ref.mat
load P_ref;

% Błąd całkowania dla liczby podprzedziałów N = 5 : 50 : 10^4
N=5:50:10000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ZADANIE1

% Wyznacz prawdopodobieństwo wystąpienia awarii sprzętu elektronicznego
% w pięciu pierwszych latach (n = 5).
% W tym celu zaimplementuj algorytmy całkowania numerycznego


% Metoda prostokątów
pmp=[];
errmp=[];

for i=N
    pmp(end+1) = metoda_prostokatow(@gestosc,0,5,i);
    errmp(end+1) = abs(P_ref - pmp(end));
end


% Metoda trapezów
ptra=[];
errtra=[];

for i=N
    ptra(end+1) = metoda_trapezow(@gestosc,0,5,i);
    errtra(end+1) = abs(P_ref - ptra(end));
end


% Metoda Simpsona
psim=[];
errsim=[];

for i=N
    psim(end+1) = simpson(@gestosc,0,5,i);
    errsim(end+1) = abs(P_ref - psim(end));
end


% Metoda Monte Carlo
pmc=[];
errmc=[];

for i=N
    pmc(end+1) = monte_carlo(@gestosc,0,5,i);
    errmc(end+1) = abs(P_ref - pmc(end));
end


%%%%%%%%%%%%%%
% WYKRESY

figure(1)
loglog(N, errmp)
hold on
loglog(N, errtra)
loglog(N, errsim)
loglog(N, errmc)
title('Wykres błędów')
legend('Metoda prostokątów','Metoda trapezów','Metoda Simpsona','Metoda Monte Carlo','location','southwest');
xlabel('Liczba przedziałów (w Monte Carlo - punktów)')
ylabel('Błąd')
hold off
saveas(gcf,'wykres_bledow.png');

N=10000000;
time=[];

tic
% Czasy wykonywania poszczególnych algorytmów (wykresy typu bar) dla N = 10^7
metoda_prostokatow(@gestosc,0,5,N);
%toc
time(1)=toc;

tic 
metoda_trapezow(@gestosc,0,5,N);
%toc
time(2)=toc;

tic 
simpson(@gestosc,0,5,N);
%toc
time(3)=toc;

tic
monte_carlo(@gestosc,0,5,N);
%toc
time(4)=toc;

figure(2)
x = categorical({'Metoda prostokątów','Metoda trapezów','Metoda Simpsona','Metoda Monte Carlo'});
bar(x, time)
xlabel('Metoda')
ylabel('Czas')
title('Czas wykonania poszczególnych algorytmów')
saveas(gcf,'wykres_czasow.png');

fid = fopen( 'komentarz.txt', 'wt' );
fprintf( fid, ['Możemy zauważyć, że najmniejsze błędy powoduje metoda Simpsona' ...
    'i jest ona wykonywana w najdłuższym czasie, natomiast najkrótszy czas' ...
    'i największe błędy powoduje metoda Monte Carlo.']);
fclose(fid);



