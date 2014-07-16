format long;
clf;
clear all;

% define a
c1 = 0;
c2 = 2;
c3 = 6;
c4 = 9;
a = 3 + (c1 + c2 + c3 + c4) / 50;
interval = [-a : 0.02 : a];

stand_norm_dist = @(x) exp( -x .^ 2 / 2 ) ./ sqrt( 2 .* pi);

% set up axis in plot standard normal distribution
hold on
axis([-a a -0.2 0.5])
cstring='rgbcmky';

n=0;
plot(interval,stand_norm_dist(interval),cstring(mod(n,7)+1))

for n = 2 : 5
    
    % construct base functions
    base_functions = {};
    for k = 1:n
        base_functions{k} = @(x) cos(((k .- 1) .* pi) ./ (2  .* a) .* x);
    end
    
    % calculate Gram matrix
    A = zeros(n);
    for i = 1 : n
       for j = 1 : n
            A(i, j) = quad( @(x) base_functions{i}(x) * base_functions{j}(x), -a, a);
       end
    end

    % calculate right side of expression
    y = zeros(n,1);
    for i = 1 : n
        y(i) =  quad( @(x) base_functions{i}(x) * stand_norm_dist(x), -a, a);
    end

    % calculate scalars
    z = A \ y ;

    % fitting polynomial with base functions 
    solution = @(x) 0;

    for i = 1:n
        solution = @(x) solution(x) + z(i) * base_functions{i}(x);
    end

    % plot new polynomial
    plot(interval, solution(interval), cstring(mod(n,7)+1))

    % calculate error
    sqrt(quad( @(x) (stand_norm_dist(x) - solution(x))^2, -a, a ))

end

hold off
