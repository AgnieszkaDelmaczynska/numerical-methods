clc;          % clear Command Window
clear;        % clear Workspace

a = 1;        % kwadrat o boku 5
r_max = a/5;  % maksymalny promień pęcherzyków, r_max < a/2
n = 0;        % początkowa liczba pęcherzyków
n_max = 100;  % maksymalna liczba pęcherzyków, (100...10 000 lub więcej)

% zapamiętać parametry okręgu w wektorach x(n), y(n), r(n) (indeks n)
v_x = [];
v_y = [];
v_r = [];

% zapamiętać aktualną wartość powierzchni okręgu
areas = [];
area = 0;

% wektor przechowuje ile razy wykonane zostało losowanie, by uzyskać dany pęcherzyk
v_how_many_draws = [];
% liczba losowań
number_of_draws = 0;

% dopóki aktualna liczba pęcherzyków nie przekracza wart. max. == n_max
while(n<n_max)
    space_for_the_bubble_was_found = false;
    while(space_for_the_bubble_was_found == false)
        % do losowania parametru x, y, r bieżącego okręgu, użyć funkcji rand
        % i skalowania do wart. maksymalnej a, r_max
        x = a*rand(1);
        y = a*rand(1);
        r = r_max * rand(1);
        % sprawdzać czy wylosowany okrąg mieści się w kwadracie
        if(x+r < a && x-r > 0 && y-r>0 && y+r<a)
            % jeśli się mieści, wyjdź z pętli
            space_for_the_bubble_was_found = true;
        end
        % inkrementuj liczbę losowań
        number_of_draws = number_of_draws + 1;
    end
    
    % sprawdzać, czy nie przecina się z żadnym z wcześniej narysowanych
    % i zapamiętanych okręgów
    if_crossed = false;
    % pętla po wszystkich narysowanych i zapamiętanych pęcherzykach    
    for i = 1:n                 
            dist_x = x-v_x(i);
            dist_y = y-v_y(i);
            dist = sqrt(dist_x*dist_x + dist_y*dist_y);
            % sprawdza, czy okręgi się na siebie nie nachodzą,
            % nie będą rysowane jeden w drugim
            if(dist <= v_r(i) + r)  
                % po odnotowaniu przecięcia bieżącego okręgu z którymkolwiek
                % narysowanym ustawić zmienną logiczną zapamiętująca ten fakt
                if_crossed = true;                                   
            end        
    end

    % jeśli nie było przecięcia z innym wcześniejszym okręgiem              
    if (if_crossed == false)        
        % to inkrementować liczbę wszystkich okręgów (pęcherzyków)
        n  = n + 1;             
        
        % wyrównać skalę osi x i y
        axis equal;             
        plot_circ(x, y, r);
        hold on;

        % zapamiętać liczbę losowań dla obecnego pęcherzyka
        v_how_many_draws(n) = number_of_draws;
        % liczba losowań nowa dla kolejnego pęcherzyka
        number_of_draws = 0;    
        
        % dopisać jego parametry do wektorów x, y, r
        v_x(n) = x;             
        v_y(n) = y;
        v_r(n) = r;

        % dodać jego powierzchnię do poprzedniej powierzchni wszystkich okręgów
        area = area + pi*r*r;   
        % przechować historię wzrostu powierzchni
        areas(n) = area;        
       
        % wypisać na konsolę bieżąca wartość n i powierzchni całkowitej
        fprintf(1, ' %s%5d%s%.3g\r ', 'n =', n, ' S = ', area) 
        % wstrzymać program na ułamek sekundy, aby zaktualizować wykres
        % z narysowanym nowym okręgiem
        pause(0.01);           
    end
end
hold off;
saveas(gcf,'pecherzyki.png');

% wykres Powierzchni całkowitej
figure('Name', 'Powierzchnia całkowita');   
semilogx(1:n, areas);
title('Powierzchnia całkowita');
xlabel('n');
ylabel('Zajęta powierzchnia');
grid on;
saveas(gcf,'wykres1.png');

% wykres Średniej liczby losowań
figure('Name', 'Średnia liczba losowań');   
loglog(cumsum (v_how_many_draws)./(linspace(1,n,n)));
title('Średnia liczba losowań');
xlabel('n');
ylabel('Średnia liczba losowań');
grid on;
saveas(gcf,'wykres2.png');

% funkcja do rysowania okręgu o zadanym środku (X,Y) i promieniu R
function plot_circ(X, Y, R)
    theta = linspace(0,2*pi);
    x = R*cos(theta) + X;
    y = R*sin(theta) + Y;
    plot(x,y)
end