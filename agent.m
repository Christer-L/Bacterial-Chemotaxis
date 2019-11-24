% Input parameters:
% --> tumble_f - function that gives tumble according to some distribution
% --> run_f - function that takes concentration, time and boolean describing
% gradient direction as an input and says if run should be stopped or continued.
% --> gradient_f - gives current Ser concentration at certain location.
% --> time - length of simulated time.
% --> x_start, y_start – starting location.
% Returns concentration data on trajectory.
function data = agent(tumble_f, run_f, concentration_map, time, x_start, y_start)

  % --- Initiate parameters ---
  angle = 0;
  run_l = 0;
  x = [];
  y = [];
  x(1) = x_start;
  y(1) = y_start;
  gradient_values = [];
  gradient_direction = 0; % 1 states up the concentration gradient and 0 down.
  % ---------------------------

  % Start simulation
  for i=1:time

    % Check if agent is moving up or down the gradient.
    p_c = concentration_map(round(x(i)), round(y(i)));
    p_c_next = concentration_map(round(x(i) + cosd(angle)), round(y(i) + sind(angle)));
    d_p_c = p_c_next - p_c;
    gradient_values(i) = p_c;

    if d_p_c < 0
      gradient_direction = 1;
    else
      gradient_direction = 0;
    endif

    if run_f(gradient_direction, p_c, run_l)
      run_l = run_l + 1;
      % Update location of moving bacterium
      x(i + 1) = x(i) + cosd(angle);
      y(i + 1) = y(i) + sind(angle);
    else
      angle = angle - tumble_f();
      run_l = 0;
      % Update location of tumbling bacterium
      x(i + 1) = x(i);
      y(i + 1) = y(i);
    endif
  endfor

  data = gradient_values;
  plot(x,y)
  disp('Completed.')
endfunction
