(@(& 'C:/Users/Jesper/AppData/Local/Programs/oh-my-posh/bin/oh-my-posh.exe' init pwsh --config='C:\Users\Jesper\AppData\Local\Programs\oh-my-posh\themes\tokyonight_storm.omp.json' --print) -join "`n") | Invoke-Expression
# Add the tools folder to your PATH
$env:PATH += ";C:\Tools"
