function run = gamrun(direction, concentration=-40, current_run_length=0)
  if direction == 1
    k = change(concentration);
  else
    k = 1;
  endif
  if gamcdf(current_run_length/10-0.5, k,0.83) <= rand
    run = 1;
  else
    run = 0;
  endif
endfunction
