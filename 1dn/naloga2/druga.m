clear all
clf 
format long

[indeks, inter_podatki] = nalozi_indeks(63070099);

index_interval = 1:11;
apr_interval = 2:2:11;
inter_podatki_interval = 1:2:11;
polynom_interval = 0:0.1:12;

% calculating divided difference
d_i = inter_podatki;

for i = 1 : length(inter_podatki_interval)
   for j = length(inter_podatki_interval): -1 : i+1
        d_i(j) = ( d_i(j) .- d_i(j .- 1) ) ./ ( inter_podatki_interval(j) .- inter_podatki_interval(i) );
   end
end

% construct base functions 
p_i = {};
p_i(1) = @(x) 1;
p_i(2) = @(x) (x - 1);
p_i(3) = @(x) (x - 1) .* (x - 3) ;
p_i(4) = @(x) (x - 1) .* (x - 3) .* (x - 5) ;
p_i(5) = @(x) (x - 1) .* (x - 3) .* (x - 5) .* (x -7);
p_i(6) = @(x) (x - 1) .* (x - 3) .* (x - 5) .* (x -7) .* (x - 9);

% fitting polynomial with base functions and divided difference
p = @(x) 0;
for i = 1 : length(d_i)
    p = @(x) p(x) .+ d_i(i) .* p_i{i}(x);
end;

% kvazi horner algorithm for calculating approximate values
apr_values = zeros(5,1);
tmp_values = zeros(length(p_i),1);
k=1;
for i = 2:2:11
    for j = 1 : length(p_i)
        tmp_values(j) = d_i(j) .* p_i{j}(i);
    end;
    apr_values(k) = sum(tmp_values);
    k = k+1;
end;

% show indeks points on graph, interpolation polynomial and aproksimation points on grapph
axis([0 12 2810 3060])

hold on 
plot(index_interval, indeks, '*')
plot(polynom_interval, p(polynom_interval))
plot(apr_interval, apr_values, 'ro')
hold off


% calculate errors for some disered points
abs(apr_values - indeks(2:2:11))
