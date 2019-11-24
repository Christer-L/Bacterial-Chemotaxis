% Take user input
N = input('Enter number of iterations: ');


% Initiate concentration gradient
M = 400; % Map size determing parameter (2M + 1 x 2M + 1)
[concentration_map, norm_conc_map] = concmap(M, @normgrad);
imshow(norm_conc_map);
hold on

% Initiate agents and its parameters / Modify y_rand and x_rand to change start location.
y_rand = round(0.5*M);
x_rand = round(0.5*M);
concentration_values_m_g = agent(@maxwell_tumble, @gamrun, concentration_map, N, x_rand, y_rand);
concentration_values_b_g = agent(@tumble, @gamrun, concentration_map, N, x_rand, y_rand);

h = legend ('Maxwell & Gamma', 'Beta & Gamma');
set (h, "interpreter", "tex");
hold off;
