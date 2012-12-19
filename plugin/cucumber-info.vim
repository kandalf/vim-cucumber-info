if &ft == "cucumber"
  let s:feature_filename = expand('%')

  function! s:CreateBuffer()
    botright new
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap nonumber
  endfunction

  function! ListScenarios()
    call s:CreateBuffer()
    set filetype=cucumber 
    execute '$read !grep Scenario ' . s:feature_filename . ' | sed -e "s/^*\s$//g" | sed -e "s/^\s//g"'
    setlocal nomodifiable
  endfunction

  function! ListSteps()
    call s:CreateBuffer()
    set filetype=ruby
    let s:file_path = expand('%:p:h')
    let s:steps_defs_dir = split(s:file_path, "features")[0] . '/features/step_definitions/'
    execute '$read !grep -RhE "^(Given|When|Then)" ' . s:steps_defs_dir . ' |  sed -e "s/^*\s$//g" | sed -e "s/^\s//g"'
    setlocal nomodifiable
    setlocal nofoldenable
  endfunction

  command! ListScenarios :call ListScenarios()
  command! ListSteps :call ListSteps()
end
