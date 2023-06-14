function [v] = compute_time(t)
    % time/ czas
    u = 2000;
    m0 = 150000;
    q = 2700;
    g = 9.81;
    vk = 750;

    v = u* log(m0 / (m0 - q*t)) - g*t - vk;
    %v = 2000* log(150000 / (150000-2700*t )) - 9.81*t - 750;
end