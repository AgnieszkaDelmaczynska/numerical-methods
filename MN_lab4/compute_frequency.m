function [Z] = compute_frequency(omega)
    % frequency/ częstotliwość
    Zk = 75;
    R = 725;
    C = 8e-5;
    L = 2;
    
    Z = 1/(sqrt(1/R^2 + ( omega* C - 1/(omega*L) )^2 )) - Zk;
    %Z = 1/(sqrt(1/725^2 + ( omega* 0.00008 - 1/(omega*2) )^2 )) - 75;
end