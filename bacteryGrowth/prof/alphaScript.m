%% Script for alpha function %%
clear;
global tau t_limit selector

% Parameters
tau = 2;         % alpha sloap
t_limit = tau;  % t limit after which alpha' = 1
tfinal = 10;

% Initial Conditions
y01 = 0;

% Solving for both models
selector = 1;
[t1,y1] = ode45('alphaFunction', [0 tfinal], [y01]); % Solving ODE
selector = 2;
[t2,y2] = ode45('alphaFunction', [0 tfinal], [y01]); % Solving ODE

%Plot
plot(t1, y1, 'Linewidth', 2, 'Color', 'r');
hold on
plot(t2, y2, 'Linewidth', 2);
hold off


xlabel('Time [s]');
ylabel('alpha');
title('Alpha function');
legend('Constant', 'Exp');

fprintf 'Simulation done \n'
