clc
clear
close all

%zad2:
% Porównaj metodę siecznych i bisekcji pod względem liczby iteracji.
% Stosuję wzory na wielkości obliczane w funkcjach wyrażających różnicę
% obliczanych wielkości i ich zadanych wartości docelowych a następnie
% nazwy tych funkcji przekazuję jako uchwyty
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   |Z|
a = 0;   % <a,b> przedział izolacji
b = 50;

% 1e-12 - dokładność
% @compute_frequency - badana funkcja z wykorzystaniem uchwytu

figure(1)
[xvect, xdif, fx, it_cnt] = bisekcja(a,b,1e-12,@compute_frequency);
plot(1:it_cnt, xvect, 'm')
hold on
[xvect, xdif, fx, it_cnt] = sieczne(a,b,1e-12,@compute_frequency);
plot(1:it_cnt, xvect, 'b');
title('Wartość kolejnego przybliżenia x_i w zależności od numeru iteracji i','"obwód rezonansowy - impedance"');
ylabel('Wartości x');
xlabel('Iteracje');
legend('Metoda bisekcji','Metoda siecznych')
hold off
saveas(gcf,'zad2_184592_figure1_frequency_wartosci','png')

figure(2)
[xvect, xdif, fx, it_cnt] = bisekcja(a,b,1e-12,@compute_frequency);
semilogy(1:it_cnt, xdif, 'm');
% semilogy(xdif, 'm');
hold on
[xvect, xdif, fx, it_cnt] = sieczne(a,b,1e-12,@compute_frequency);
semilogy(1:it_cnt, xdif, 'b');
title('Różnicy pomiędzy wartościami x w kolejnych iteracjach i','"obwód rezonansowy - impedance"');
ylabel('Różnica w x');
xlabel('Iteracje');
legend('Metoda bisekcji','Metoda siecznych')
hold off
saveas(gcf,'zad2_184592_figure2_frequency_roznice','png')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   v
a = 0;   % <a,b> przedział izolacji
b = 50;

figure(3)
[xvect, xdif, fx, it_cnt] = bisekcja(a, b,1e-12,@compute_time);
plot(1:it_cnt, xvect, 'm');
hold on
[xvect, xdif, fx, it_cnt] = sieczne(a, b,1e-12,@compute_time);
plot(1:it_cnt, xvect, 'b');
title('Wartość kolejnego przybliżenia x_i w zależności od numeru iteracji i','"lot rakiety - velocity"');
ylabel('Wartości x');
xlabel('Iteracje');
legend('Metoda bisekcji','Metoda siecznych')
hold off
saveas(gcf,'zad2_184592_figure3_time_wartosci','png')

figure(4)
[xvect, xdif, fx, it_cnt] = bisekcja(a, b,1e-12,@compute_time);
semilogy(xdif, 'm');
% semilogy(1:it_cnt, xdif, 'm');
hold on 
[xvect, xdif, fx, it_cnt] = sieczne(a, b,1e-12,@compute_time);
semilogy(1:it_cnt, xdif, 'b');
title('Różnicy pomiędzy wartościami x w kolejnych iteracjach i','"lot rakiety - velocity"');
ylabel('Różnica w x');
xlabel('Iteracje');
legend('Metoda bisekcji','Metoda siecznych')
hold off
saveas(gcf,'zad2_184592_figure4_time_roznice','png')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   t
a = 1;   % <a,b> przedział izolacji
b = 60000;

figure(5)
[xvect, xdif, fx, it_cnt] = bisekcja(a,b,1e-3,@compute_impedance);
plot(1:it_cnt, xvect, 'm')
hold on
[xvect, xdif, fx, it_cnt] = sieczne(a,b,1e-3,@compute_impedance);
plot(1:it_cnt, xvect, 'b');
title('Wartość kolejnego przybliżenia x_i w zależności od numeru iteracji i','"algorytm - czas"');
ylabel('Wartości x');
xlabel('Iteracje');
legend('Metoda bisekcji','Metoda siecznych')
hold off
saveas(gcf,'zad2_184592_figure5_impedance_wartosci','png')

figure(6)
[xvect, xdif, fx, it_cnt] = bisekcja(a,b,1e-3,@compute_impedance);
semilogy(xdif, 'm');
%semilogy(1:it_cnt, xdif, 'm');
hold on
[xvect, xdif, fx, it_cnt] = sieczne(a,b,1e-3,@compute_impedance);
semilogy(1:it_cnt, xdif, 'b');
title('Różnicy pomiędzy wartościami x w kolejnych iteracjach i','"algorytm - czas"');
ylabel('Różnica w x');
xlabel('Iteracje');
legend('Metoda bisekcji','Metoda siecznych')
hold off
saveas(gcf,'zad2_184592_figure6_impedance_roznice','png')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%zad3:
% Zastosuj wbudowaną funkcję Matlaba fzero do wyznaczenia miejsc zerowych
% funkcji tg(x), przyjmując przybliżenie początkowe pierwiastka równe 6.0
% oraz 4.5. Ustaw odpowiednie opcje w strukturze OPTIONS aby otrzymać raport
% dla poszczególnych iteracji
options = optimset('Display','iter');
fzero(@tan,6,options)
fzero(@tan,4.5,options)