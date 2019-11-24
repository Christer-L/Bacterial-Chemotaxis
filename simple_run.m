function run = simple_run(direction, concentration=0, current_run_length=0)
  if direction == 1
    if rand >= 0.8
      run = 0;
    else
      run = 1;
    endif
  else
    if rand >= 0.5
      run = 0;
    else
      run = 1;
    endif
  endif
endfunction
