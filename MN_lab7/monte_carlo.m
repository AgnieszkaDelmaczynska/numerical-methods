function [p] = monte_carlo(fun,x_p,x_k,n)
   
    hight=max(fun(1:n));    % wysokość figury
    S=hight*(x_k-x_p);      % pole figury
    
    x=rand(1,n);            % generuj losowy x w przedziale 1 do k
    x=x_p+x*(x_k-x_p);      % wybieramy x
    y=rand(1,n)*hight;      % losujemy y
    
    y_x=fun(x);
    N1=0;
    
    for i = 1:n
      if(y(i)<y_x(i))
        N1 = N1 + 1;        % N1 - liczba punktów znajdujących się pod krzywą
      end
    end
    
    p=(N1/n)*S;             % n - wszystkie punkty w obrębie danej figury
end