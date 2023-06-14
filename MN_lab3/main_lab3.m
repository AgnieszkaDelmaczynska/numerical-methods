clc         % clear command window
clear all   % clear the workspace
close all   % close figure windows

% odpowiednie fragmenty kodu mo¿na wykonaæ poprzez znazaczenie i wciœniêcie F9
% komentowanie/ odkomentowywanie: ctrl+r / ctrl+t

%diary('log_184592_lab3')

% Zadanie A
%------------------
N = 10;
density = 3;    % parametr decyduj¹cy o gestosci polaczen miedzy stronami
[Edges] = generate_network(N, density);
%------------------

% Zadanie B
%------------------
% generacja macierzy I, A, B i wektora b
d = 0.85;                       % d - wspó³czynnik t³umienia

I = speye(N);                   % I - macierz jednostkowa NxN
B = sparse(Edges(2,:), Edges(1,:), 1, N, N);
L = sparse(sum(B));
A = sparse(diag(1./L));         % macierz rzadka, na przek¹tnej elementy = 1/L(i)
b = zeros(N,1);
b(:,1) = (1 - d)/N;             % wektor b o d³ugoœci N

% macierze A, B i I musz¹ byæ przechowywane w formacie sparse (rzadkim)
A = sparse(A);
B = sparse(B);
I = sparse(I);

save zadB_184592 A B I b
%-----------------



% Zadanie C
%------------------
M = sparse(I - d*B*A);
r = M\b;

save zadC_184592 r
%------------------


% Zadanie D
%------------------
clc
clear all
close all

N = [500, 1000, 3000, 6000, 12000];
density = 10;
d = 0.85;


for i = 1:5

    % 1. Generate table Edges for N corresponding to the loop index
    Edges=generate_network(N(i), density);

    % 2. Generate tables A,B,I,b, and M
    I = speye(N(i));
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    L = sum(B);
    A = sparse(diag(1./L));
    b = zeros(N(i),1);
    b(:,1) = (1 - d)/N(i);
    
    A = sparse(A);
    B = sparse(B);
    I = sparse(I);

    M = sparse(I - d*B*A);

    tic
    % obliczenia
    % 3. Formula for the direct solution to Mr=b 
    r = M\b;
    czas(i) = toc;
end

plot(N, czas)
title("Czas bezpoœredniego rozwi¹zania uk³adu równañ od N");
ylabel("Czas [s]");
xlabel("Rozmiar macierzy N");
saveas(gcf, 'zadD_184592.png');
%--------------------


% Zadanie E
%------------------
clc
clear all
close all

% przyk³ad dzia³ania funkcji tril, triu, diag:
% Z = rand(4,4)
% tril(Z,-1) 
% triu(Z,1) 
% diag(diag(Z))

N = [500, 1000, 3000, 6000, 12000];
density = 10;
d = 0.85;

untill = 10^(-14);

for i = 1:5
    % 1. Generate table Edges for N corresponding to the loop index
    [Edges] = generate_network(N(i), density);

    % 2. Generate tables A,B,I,b, and M
    I = speye(N(i));
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    L = sum(B);
    A = sparse(diag(1./L));
    b = zeros(N(i),1);
    b(:,1) = (1 - d)/N(i);

    A = sparse(A);
    B = sparse(B);
    I = sparse(I);

    M = sparse(I - d*B*A);
    % wszystko powy¿ej tak jak wczeœniej w æwiczeniu D

    % Generate the lower triangular part of matrix M using L=tril(M,-1);
    L = tril(M,-1);
    % Generate the upper triangular part of matrix M using U=triu(M,1);
    U = triu(M,1);
    % Generate the the main diagonal of matrix M using D=diag(diag(M));
    D = diag(diag(M));
    % Set the initial r vector using ones(N(i),1);
    r = ones(N(i), 1);
    
    number_of_iterations(i) = 0;
    tic

    fprintf('Executing Jacobi method for N=%i:\n',N(i));
    % Implement iterative Jacobi method here using 'j' and its index
    % Use parameter 'iterMax' to fix the maximum number of number_of_iterations    
    % Use the forward substitution instead of using explicit matrix inverse
    % Calculate residuum vector 'res' and its norm 'nres'

    while(true)
    number_of_iterations(i) = number_of_iterations(i) + 1;
    r = D\(-(L+U)*r+b);
    res = M*r - b;
    norm_res(i, number_of_iterations(i)) = norm(res);
        if(norm(res) <= untill)
            break
        end
    end
    czas_Jacobi(i) = toc;
end

figure(1)
plot(N, czas_Jacobi)
title("Wykres czasu analizy metody Jacobiego od N");
xlabel("Rozmiar macierzy N");
ylabel("Czas [s]");
saveas(gcf, 'zadE_184592_1','png');

figure(2)
plot(N, number_of_iterations)
title("Wykres liczby iteracji od N");
xlabel("Rozmiar Macierzy N");
ylabel("Liczba iteracji");
saveas(gcf, 'zadE_184592_2','png');

figure(3)
semilogy(norm_res(2, 1:number_of_iterations(2)))
title('Wykres normy z residuum dla kolejnych iteracji');
xlabel('Numer iteracji');
ylabel('Norma z residuum');
% update the command below replacing 'taskE3' with 'taskE3_yourIndexNumber'
saveas(gcf, 'zadE_184592_3','png');
%------------------

%Zadanie F
%------------------
clc
clear all
close all

N = [500, 1000, 3000, 6000, 12000];
density = 10;
d = 0.85;

untill = 10^(-14);

for i = 1:5

    % 1. Generate table Edges for N corresponding to the loop index
    [Edges] = generate_network(N(i), density);

    % 2. Generate tables A,B,I,b, and M
    I = speye(N(i));
    B = sparse(Edges(2,:), Edges(1,:), 1, N(i), N(i));
    L = sum(B);
    A = sparse(diag(1./L));
    b = zeros(N(i),1);
    b(:,1) = (1 - d)/N(i);

    A = sparse(A);
    B = sparse(B);
    I = sparse(I);

    M = sparse(I - d*B*A);
    % wszystko powy¿ej tak jak wczeœniej w æwiczeniu D i E

    % Generate the lower triangular part of matrix M using L=tril(M,-1);
    L = tril(M,-1);
    % Generate the upper triangular part of matrix M using U=triu(M,1);
    U = triu(M,1);
    % Generate the the main diagonal of matrix M using D=diag(diag(M));
    D = diag(diag(M));
    % Set the initial r vector using ones(N(i),1);
    r = ones(N(i), 1);

    number_of_iter(i) = 0;
    
    tic
    while(true)
    number_of_iter(i) = number_of_iter(i) + 1;
    r = (D+L)\(-U*r+b);
    res = M*r - b;
    norm_res(i, number_of_iter(i)) = norm(res);
        if(norm(res) <= untill)
            break
        end
    end
    czas_Gaussa_Seidla(i) = toc;
end

figure(1)
plot(N, czas_Gaussa_Seidla)
title("Wykres czasu analizy metody Gaussa Seidla od N");
xlabel("Rozmiar macierzy N");
ylabel("Czas [s]");
saveas(gcf, 'zadF_184592_1','png');

figure(2)
plot(N, number_of_iter)
title("Wykres liczby iteracji od N");
xlabel("Rozmiar Macierzy");
ylabel("Liczba iteracji");
saveas(gcf, 'zadF_184592_2','png');

figure(3)
semilogy(norm_res(2, 1:number_of_iter(2)))
title("Wykres normy z residuum dla kolejnych iteracji");
xlabel("Numer iteracji");
ylabel("Norma z residuum");
saveas(gcf, 'zadF_184592_3','png');
%---------------


% Zadanie G
% ------------------ metoda bezpoœrednia
clc
clear all
close all

load("Dane_Filtr_Dielektryczny_lab3_MN.mat")
%r = ones(20000, 1);

tic
r_Gauss = M\b;
czas = toc;
disp(czas);
save zadG_Gauss_184592 r_Gauss

%-------------------- Jacobi
untill = 10^(-14);

L = tril(M,-1);
U = triu(M,1);
D = diag(diag(M));
r = ones(20000, 1);

tic
while(true)
r = D\(-(L+U)*r+b);
res = M*r - b;
    if(norm(res) <= untill || isnan(norm(res)))
        break
    end
end
czas_Jacobi = toc;
disp(czas_Jacobi);

%------------------ Gauss-Seidl
L = tril(M,-1);
U = triu(M,1);
D = diag(diag(M));
r = ones(20000, 1);

tic
while(true)
r = (D+L)\(-U*r+b);
res = M*r - b;
    if(norm(res) <= untill || isnan(norm(res)))
        break
    end
end
czas_Gaus_Seidl = toc;
disp(czas_Gaus_Seidl);