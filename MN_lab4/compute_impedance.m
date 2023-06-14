function [t] = compute_impedance(N)

    tk = 5000;
    t = (N^1.43 + N^1.14)-1000*tk;
end