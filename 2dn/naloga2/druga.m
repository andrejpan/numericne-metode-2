format long;
clf;
clear all;

%exact solution
x2 = [1 : 0.01 : 2];
y2 = @(t) (7 ./ 4 .* t) + (1 ./ 2 .* t .^3 .* log(t)) - (3 ./ 4 .* t .^ 3);

% instead of ode45
%x1=linspace(1,2,100);
%y1 = lsode("my_function", [1; 0], x1);

% runge kutta 4-th order
y0 = zeros(1,11);
y0(1) = 1;
h = 0.1;
t = 1;
w = [1; 0];

for i = 1:10
    k1 = h .* my_function1(t, w);
    k2 = h .* my_function1(t .+ h ./ 2, w .+ k1 ./ 2);
    k3 = h .* my_function1(t .+ h ./ 2, w .+ k2 ./ 2);
    k4 = h .* my_function1(t .+ h, w .+ k3);
    w = w .+ (k1 .+ 2 .* k2 .+ 2 .* k3 .+ k4) ./6;
    y0(i+1) = w(1);
    t = t .+ h;
end

% after instaling package octave-odepkg 
[x3, y3] = ode45(@my_function1, [1 2], [1 0]);

%ploting
hold on

plot(x2, y2(x2), 'g')
%plot(x1, y1(1))
plot(1:0.1:2, y0, 'r')
plot(x3, y3(:,1), 'y')

hold off
