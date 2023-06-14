function [xvect, xdif, fx, it_cnt] = sieczne(a,b,eps,fun)
%zad1
% a - wartość brzegowa lewa, x_0
% b - wartość brzegowa prawa, x_1
xvect=zeros(1,1000);    % xvect - wektor kolejnych wartości przybliżonego rozwiązania
xdif=zeros(1,1000);     % xdif - wektor różnic pomiędzy kolejnymi wartościami przybliżonego rozwiązania np. xdif(1) = abs(xvect(2)-xvect(1));
fx=zeros(1,1000);       % fx - wektor wartości funkcji dla kolejnych elementów wektora xvect

fa=feval(fun,a);        % wartość funkcji w x = a, czyli f(a)
fb=feval(fun,b);        % wartość funkcji w x = b, czyli f(b)

for i = 1:1000
    if (abs(fa-fb)<eps||abs(b-a)<eps) % warunek czy wartość bezwzględna różnicy funkcji w a - b  jest < od dokładności
                                      % lub wartość bezwzględna argumentów
                                      % z osi x b-a jest < od dokładności
        xvect(i)=x;                   % wtedy znaleziono miejsce zerowe i wpisujemy je do wektora
        fx(i) = feval(fun, x);        % wpisujemy wartość funkcji w tym miejscu zerowym
        if(i==1)                      % jeśli jest to pierwsza ireracja, to nie ma od czego odejmować i po prostu wpisujemy daną obliczaną wartość
            xdif(i)=x;
        else                          % w przeciwnym wypadku obliczamy różnoce między ostatnio znalezionymi miejscami zerowymi
            xdif(i)=abs(xvect(i-1) - x);
        end
        break;
    end
    x = a-fa*((a-b)/(fa-fb));       % ze wzoru z wykładu Metoda siecznych, slajd 28, wzór 6, x_k ==a, x+k-1 == b
    fX = feval(fun, x);             % wartość w tym x, miejscu zerowym
     
    b = a;                          % zmieniamy przedziały brzegowe, na których będziemy działać w kolejnej iteracji
    fb = fa;                        % zmieniamy również zadeklarowane i przypisane wcześniej wartości funkcji w tych punktach
    a = x;                          % zmiana również dla a
    fa = fX;                        % zmiana wartości również w a
    
    if(i==1)                        % to co wyżej
        xdif(i)=x;
    else
        xdif(i)=abs(xvect(i-1) - x);
    end
    xvect(i)=x;                     % znalezione miejsce zerowe do wektora
    fx(i) = feval(fun, x);          % wpisujemy wartość
end

it_cnt=i;   % liczba iteracji wykonanych przy poszukiwaniu miejsca zerowego.

% żeby wektory miały tę samą długość i nie występował warning na
% niekompatybilny rozmiar
xvect=xvect(1:it_cnt);
xdif=xdif(1:it_cnt);
fx=fx(1:it_cnt);
end