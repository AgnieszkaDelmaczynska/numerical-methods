% Zad2
% Wykorzystując generator toru łazika, oraz funkcje do interpolacji wielomianowej
% i trygonometrycznej określ optymalny rozkład punktów pomiarowych (liczbę punktów K) do
% stworzenia dokładnej mapy. W tym celu stwórz dwa wykresy zbieżności Div(K) dla obu
% metod interpolacyjnych w funkcji liczby punktów pomiarowych K, gdzie Div(K) repre-
% zentuje maksymalną wartości różnicy interpolowanych funkcji

% Div(K) = max|F F (K) − F F (K − 1)|

% w badanym obszarze dla kolejnych zestawów próbek (przyjmij K z zakresu od
% 5 do 45).
% Zapisz oba otrzymane wykresy w formacie ∗.png. Skomentuj uzyskane wyniki. Komen-
% tarz umieść w pliku komentarz-zad2.txt.

% wektor przechowujący optymalny rozkład punktów
divpoly = [];
for K = 5:45
    [x,y,f] = lazik(K);
    [p]=polyfit2d(x,y,f);
    [FF_curr]=polyval2d(XX,YY,p); 
    
    [x,y,f] = lazik(K-1);
    [p]=polyfit2d(x,y,f);
    [FF_prev]=polyval2d(XX,YY,p);

    divpoly = [divpoly, max(max(abs(FF_curr-FF_prev)))];
end

figure()
plot(5:45, divpoly)
title("Div(K) dla interpolacji wielomianowej")
xlabel("Liczba punktów pomiarowych K")
ylabel("Maksymalna różnica")
grid();
saveas(gcf,"Zad2_wielomianowa.png")


% wektor przechowujący optymalny rozkład punktów
divtryg = [];
for K = 5:45
    [x,y,f] = lazik(K);
    [p]=trygfit2d(x,y,f);
    [FF_curr]=trygval2d(XX,YY,p);
   
    [x,y,f] = lazik(K-1);
    [p]=trygfit2d(x,y,f);
    [FF_prev]=trygval2d(XX,YY,p);
    
    divtryg = [divtryg, max(max(abs(FF_curr-FF_prev)))];
end
   
figure();
plot(5:45, divtryg)
title("Div(K) dla interpolacji trygonometrycznej")
xlabel("Liczba punktów pomiarowych K")
ylabel("Maksymalna różnica")
grid();
saveas(gcf,"Zad2_trygonometryczna.png")
