function[p]=metoda_prostokatow(fun,a,b,k)
    % Metoda Newton-Cotes
    delta=(b-a)/k;              %(7)
    x=linspace(a,b,k+1);
    p=0;
    
    for i=1:k
        x(i)=a +(i-1)*delta;    %(8)
        f = (x(i) + x(i+1))/2;
        p = p + delta.*fun(f);  %(9)
    end
end