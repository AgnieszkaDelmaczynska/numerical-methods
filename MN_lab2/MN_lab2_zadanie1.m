clc   % clear Command Window
clear % clear Workspace

% zadanie A
Edges = sparse([1,1,2,2,2,3,3,3,4,4,5,5,6,6,7;
    4,6,3,4,5,5,6,7,5,6,4,6,4,7,6]);

% zadanie B
N = max(max(Edges));             % N = 7, liczba stron
liczba_polaczen = size(Edges,2); % liczba_polaczen = 15
d = 0.85;                        % d - współczynnik tłumienia
I = speye(N);                    % I - macierz jednostkowa 7x7
disp(I);
b = ones(N,1)*(1-d)/N;           % wektor b o długości N
disp(b);

% B = sparse(N,N);                 % generuje macierz 0 m x n
% for i = 1: liczba_polaczen
%     B(Edges(2, i), Edges(1, i)) = 1; % wpisz 1 tam, gdzie jest połączenie
% end
B = sparse( Edges(2, : ) , Edges(1, :) , 1, N, N);
disp(B);

L = sum(B);                      % wpisz ile łącznie jest połączeń
                                 % dla danej strony, w wektorze
A = sparse(diag(1./L));          % macierz rzadka, na przekątnej elementy = 1/L(i)
disp(A);
M = sparse(I - d*(B*A));         % macierz rzadka
disp(M);

% zadanie C
% M * r = b
r = M\b;
disp(r);

% zadanie D
bar(r)
title('Wykres PageRank od stron w sieci');
xlabel('Numer strony w sieci');
ylabel('Wartość PageRank');
grid on;
saveas(gcf,'PageRank_wykres.png');