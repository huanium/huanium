nSamples = 5e4;
t0 = 0
t1 = 10
t2 = 10
t3 = 100
t4 = 1
t5 = .01
t6 = 100
t_total = t0 + t1 + t2 + t3 + t4 + t5 + t6;
t = linspace(0, t_total, nSamples);
B0 = 60
B1 = 80.3
B2 = 75
B3 = 90
for i = 1:nSamples
    if t(i)<t0
       B(i) = B0;
    elseif t(i) < t0 + t1
        B(i) = B0 + (B1-B0)/t1 * (t(i) - t0);
    elseif t(i) < t0 + t1 + t2
        B(i) = B1;
    elseif t(i) < t0 + t1 + t2 + t3
        B(i) = B1 + (B2 - B1)/t3 * (t(i) - (t0 + t1 + t2));
    elseif t(i) < t0 + t1 + t2 + t3 + t4
        B(i) = B2;
    elseif t(i) < t0 + t1 + t2 + t3 + t4 + t5
        B(i) = B2 + (B3 - B2)/t5 * (t(i) - (t0 + t1 + t2 + t3 + t4));
    else
        B(i) = B3;
    end
end
B(end) = B0
plot(t,B)