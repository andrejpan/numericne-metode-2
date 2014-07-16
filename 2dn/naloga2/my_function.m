function dy = my_function(y,t)
    dy = zeros(2,1);
    dy(1) = y(2);
    dy(2) = (t .^ 3 .* log(t) .+ 2 .* t .* y(2) .- 2 .* y(1)) ./ t .^ 2;
endfunction
