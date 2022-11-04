function li = approx_polylog(n,z,N)
    % approximate polylog function
    % good for small z
    li = 0;
    for k=1:N
        li = li + z.^k/k^n;
    end
end