### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = "C:\Users\geocat\Desktop\geopackage_geobuzz\_source"
    $watcher.Filter = "*.rst"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true  

### DEFINE ACTIONS AFTER AN EVENT IS DETECTED
    #$action = { 
    #            cd "C:\Users\geocat\Desktop\geopackage_geobuzz\_source"
    #            make html
    #          }    
    $action = { $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date), $changeType, $path"
                Add-content "C:\Users\geocat\Desktop\geopackage_geobuzz\log_watcher.txt" -value $logline
                "C:\Users\geocat\Desktop\geopackage_geobuzz\_source"
                .\make html
              }    
### DECIDE WHICH EVENTS SHOULD BE WATCHED 
    Register-ObjectEvent $watcher "Created" -Action $action
    Register-ObjectEvent $watcher "Changed" -Action $action
    Register-ObjectEvent $watcher "Deleted" -Action $action
    Register-ObjectEvent $watcher "Renamed" -Action $action
    while ($true) {sleep 5}