function[p]=simpson(fun,a,b,k)
    
    delta=(b-a)/k;                                   %(7)
    x=linspace(a,b,k+1);
    p=0;
    
    for i=1:k
        x(i)=a +(i-1)*delta;                         %(8)
        f=(x(i+1)+x(i))/2;
        p = p + fun(x(i)) + 4.*fun(f) + fun(x(i+1)); %(12)
    end
    p=p*delta/6;
end