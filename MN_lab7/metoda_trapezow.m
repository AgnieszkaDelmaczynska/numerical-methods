function[p]=metoda_trapezow(fun,a,b,k)
    
    delta=(b-a)/k;                          %(7)
    x=linspace(a,b,k+1);
    p=0;
    
    for i=1:k
        x(i)=a +(i-1)*delta;                %(8)
        f = (fun(x(i)) + fun(x(i+1)))/2;
        p = p + delta.*f;                   %(11)
    end
end