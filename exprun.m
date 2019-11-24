function run = exprun(direction, concentration=-40, current_run_length=0)
  if direction == 1
    shift = 0.5 .* change(concentration);
  else
    shift = 0.5;
  endif
  if expcdf(current_run_length/10-shift, 0.83) <= rand
    run = 1;
  else
    run = 0;
  endif
endfunction
