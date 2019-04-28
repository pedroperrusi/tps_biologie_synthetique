clear all; close all;
%% Definition d'un modele simple pour la croissance de bateria

% derivative de la population (n)
d_population = @(n, u, alpha) (n .* u .* alpha);

% modele simple pour u
u1 = @(n, umax, So, Sk) umax.*(So-n)./(Sk+So-n);
u2 = @(n, umax, Sk) umax.*(Sk./(Sk+n));

% modele simple aplha
alpha1 = @(t, tau) (1-exp(-t./tau));

% population
% ?

%% Example data
nmax = 1e+6;
n = 1 : 1e+6;
% resolution temporel
t_step = 1/nmax; 
t = 0 : t_step : 1-t_step;
% constant d'amortissement
tau = 10*t_step;

% estimee 1
So = nmax;
Sk = 1 * So;
umax1 = Sk/So + 1;
u_first = u1(n, umax1, So, Sk);

%estimee 2
umax2 = umax1/2;
Skp = nmax/100;
u_second = u2(n, umax2, Skp);

% on sature les valeurs negatifs de u
u_first(u_first < 0) = 0;
u_second(u_second < 0) = 0;

alpha = alpha1(t, tau);

d_n1 = d_population(n, u_first, alpha);
d_n2 = d_population(n, u_second, alpha);

%% On resoudre les equations differentiels


%% Plot curbes
lgdSize = 30;
tickSize = 25;
axisSize = 30;
TitleSize = 40;
lineW = 8;

rows = 2; cols = 2;
subplot(rows,cols,1)
semilogx(t, alpha, 'LineWidth', lineW);
hold on; grid on;
ax = gca; ax.FontSize = tickSize; 
title('Apha', 'FontSize', TitleSize);
xlabel('Temps (log(ms))', 'FontSize', axisSize)
ylabel('Alpha(t)', 'FontSize', axisSize)
subplot(rows,cols,2)
semilogx(n, u_first, 'LineWidth', lineW);
hold on; grid on;
ax = gca; ax.FontSize = tickSize; 
semilogx(n, u_second, 'LineWidth', lineW);
lgd = legend('estime1', 'estime2'); lgd.FontSize = lgdSize;
title('Mi', 'FontSize', TitleSize)
xlabel('Population (log(n))', 'FontSize', axisSize)
ylabel('u(n)', 'FontSize', axisSize)
subplot(rows,cols,3);
loglog(t, d_n1, 'LineWidth', lineW);
hold on; grid on;
ax = gca; ax.FontSize = tickSize; 
loglog(t, d_n2, 'LineWidth', lineW);
title('Derive population', 'FontSize', TitleSize)
xlabel('Temps (log(ms))', 'FontSize', axisSize)
ylabel('log(d(n))', 'FontSize', axisSize)
lgd = legend('estime1', 'estime2'); lgd.FontSize = lgdSize;