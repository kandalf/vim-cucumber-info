
function! s:CreateBuffer()
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap nonumber
endfunction

function! s:SetupBuffer()
  setlocal nomodifiable
  setlocal nofoldenable
endfunction

function! ListScenarios()
  if &ft == "cucumber"
    let s:feature_filename = expand('%')
    call s:CreateBuffer()
    set filetype=cucumber
    execute '$read !grep Scenario ' . s:feature_filename . ' | sed -e "s/^*\s$//g" | sed -e "s/^\s//g"'
    call s:SetupBuffer()
  end
endfunction

function! ListSteps()
  if &ft == "cucumber"
    call s:CreateBuffer()
    set filetype=ruby
    let s:file_path = expand('%:p:h')
    let s:steps_defs_dir = split(s:file_path, "features")[0] . '/features/step_definitions/'
    execute '$read !grep -RhE "^(Given|When|Then)" ' . s:steps_defs_dir . ' |  sed -e "s/^*\s$//g" | sed -e "s/^\s//g"'
    call s:SetupBuffer()
  end
endfunction

command! ListScenarios :call ListScenarios()
command! ListSteps :call ListSteps()
