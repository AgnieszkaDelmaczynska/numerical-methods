function [d]=gestosc(t)
    sigma=3;
    mi=10;
    mianownik=sigma*sqrt(2*pi);
    potega=(-(t-mi).^2)/(2*sigma.^2);
    d=exp(potega)/mianownik;
end