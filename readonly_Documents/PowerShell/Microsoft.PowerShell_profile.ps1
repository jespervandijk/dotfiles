(@(& 'C:/Users/Jesper/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init pwsh --config='C:\Users\Jesper\AppData\Local\Programs\oh-my-posh\themes\tokyonight_storm.omp.json' --print) -join "`n") | Invoke-Expression
# Add the tools folder to your PATH
$env:PATH += ";C:\Tools"

# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\tokyonight_storm.omp.json" | Invoke-Expression
# function goto-haas-be { Set-Location C:\repos\Hypotheek\services\Hypotheekdossier\src\Abn.Hypotheekdossiers.Api }
# function goto-haas-fe { Set-Location C:\repos\Hypotheek\apps\haas-ui }
# function goto-haas-tools { Set-Location C:\repos\Hypotheek\.tools }