function [indeks, inter_podatki] = nalozi_indeks(vpisna, n)
if nargin == 1
    n = 11;
end
%izberemo 1 zaporednih dni za katere bomo
%aproksimirali indeks, zacnemo s pozicija
load indeks;
rand('seed', vpisna);
pozicija = ceil(345*rand()); 
indeks = indeks(pozicija : (pozicija + n-1) );

%inter_podatki
%spustimo vsak drugi dan
inter_podatki = indeks(1:2:end);