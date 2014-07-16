format long;
%clf;
clear all;

a1=0;
a2=0;
a3=9;
a4=9;
%A =2 .+ a3 ./ 10 .+ a4 ./ 100;

a=0;
b=3;

f = @(x) (1 .+ a3 .+ a4) .* e.^ (- x .* x ./ 4) .* sin(x);

%a, m=1
m=1;
h = (b .- a) ./ (2 .* m);
ff1 = h ./ 3 .* (f(0) .+ 4 .* f(1.5) .+ f(3))

%a, m=5
m=5;
h = (b .- a) ./ (2 .* m);
interval = [h : h : 3-h];

ff5 = f(0) + f(3);
for i= 1 : (2.*m-1);
    if( mod(i, 2) )
        ff5 = ff5 .+ 4 .* f(interval(i));         
    else
        ff5 = ff5 .+ 2 .* f(interval(i));
    end
end
ff5 = ff5 .* h ./ 3

%a, m=20
m=20;
h = (b .- a) ./ (2 .* m);
interval = [h : h : 3-h];

ff20 = f(0) + f(3);
for i= 1 : (2.*m-1);
    if( mod(i, 2) )
        ff20 = ff20 .+ 4 .* f(interval(i));         
    else
        ff20 = ff20 .+ 2 .* f(interval(i));
    end
end
ff20 = ff20 .* h ./ 3

% b
quad = quad( @(x)f(x), a, b, e^ -16)
