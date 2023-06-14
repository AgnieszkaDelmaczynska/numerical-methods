function [xvect, xdif, fx, it_cnt] = bisekcja(a,b,eps,fun)
%zad1
% a - wartość brzegowa lewa
% b - wartość brzegowa prawa
xvect=zeros(1,1000);    % xvect - wektor kolejnych wartości przybliżonego rozwiązania
xdif=zeros(1,1000);     % xdif - wektor różnic pomiędzy kolejnymi wartościami przybliżonego rozwiązania np. xdif(1) = abs(xvect(2)-xvect(1));
fx=zeros(1,1000);       % fx - wektor wartości funkcji dla kolejnych elementów wektora xvect

% Rozpatrzmy funkcję f (x) i dwie wartości: a and b , takie, że: f(a) i f(b) mają przeciwnne znaki: f(a)*f(b) < 0
for i = 1:1000
    c = (a + b)/2;              % c - korzystając z twierdzenia o wartości pośredniej, między a i b jest miejsce zerowe
    if(abs(feval(fun,c))<eps || abs(b-a)<eps)   %feval(fun,x); % by uzyskać wartość funkcji w 'x' 
        xvect(i) = c;           % znajdujemy x* i przypisujemy mu miejsce zerowe równe c
        fx(i) = feval(fun, c);  % wartość funkcji w miejscu tego miejsca zerowego
        if(i==1)            % gdy i == 1 nie można policzyć różnicy dla jednej liczby, więc dajemy tę liczbę
            xdif(i)=c;          
        else                % w przeciwnym wypadku możemy obliczyc tę różnicę
            xdif(i)=abs(xvect(i-1) - c); 
        end
        break;
    elseif (feval(fun, a)*feval(fun,c)<0) % jeśli te dwie wartości maja przeciwne znaki
        b = c;              % wartości prawej brzegowej przypisz miejsce zerowe c
    else
        a = c;              % wartości prawej brzegowej przypisz miejsce zerowe c
    end

    xvect(i)=c;             % ostatecznie znalezione miejsce zerowe wpisz do wektora
    fx(i) = feval(fun, c);  % wpisz do wektora równieź jego wartość

    if(i==1)                % robimy to samo co wyżej, ale jeszcze raz, ponieważ już nie sprawdzamy tego warunku wyżej, a różnica obliczona jakaś być musi
        xdif(i)=c;
    else
        xdif(i)=abs(xvect(i-1) - c);
    end
end

it_cnt=i;   % liczba iteracji wykonanych przy poszukiwaniu miejsca zerowego.

% żeby wektory miały tę samą długość i nie występował warning na
% niekompatybilny rozmiar
xvect=xvect(1:it_cnt);
xdif=xdif(1:it_cnt);
fx=fx(1:it_cnt);

end