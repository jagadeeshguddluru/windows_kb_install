[void](wusa.exe "C:\Program Files\WindowsPowerShell\Modules\PSWindowsUpdate\<%= @kb %>.msu" /quiet /norestart)

Start-Sleep 5
$update = Get-WUHistory | Where-Object KB -eq "<%= @kb %>" | Sort-Object Date -Descending | Select-Object -First 1
switch -regex ($update.Result) {
    'Succeeded' { Set-Content "C:\ProgramData\InstalledUpdates\<%= @kb %>.flg" "Installed" }

    'Failed' {
        Set-Content "C:\ProgramData\InstalledUpdates\<%= @kb %>.flg" "Failed"
    }
    
}