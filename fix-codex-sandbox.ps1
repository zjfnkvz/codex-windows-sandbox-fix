# Kills the node.exe that holds the Codex cua_node runtime file open.
# Why: the desktop app's Computer Use subsystem starts node.exe from
#   %LOCALAPPDATA%\OpenAI\Codex\runtimes\cua_node\<hash>\bin\node.exe
# That open handle blocks the sandbox setup from updating the file's ACL,
# which makes every command fail with "setup refresh had errors".

$targets = Get-Process node -ErrorAction SilentlyContinue |
    Where-Object { $_.Path -like "*\OpenAI\Codex\runtimes\*" }

if ($targets) {
    $count = @($targets).Count
    foreach ($p in $targets) {
        Write-Host ("  pid " + $p.Id + "  " + $p.Path)
    }
    $targets | Stop-Process -Force
    Write-Host ("OK: killed " + $count + " Codex runtime node process(es).") -ForegroundColor Green
} else {
    Write-Host "No Codex runtime node process found. Nothing to do." -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Now run any command inside Codex - it should work again."
