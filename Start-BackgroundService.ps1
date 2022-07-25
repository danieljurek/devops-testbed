# Copyright (c) Microsoft Corporation. All rights reserved.
# SPDX-License-Identifier: MIT
param(
  [string] $LogFileLocation = "$($env:BUILD_SOURCESDIRECTORY)/WebSocketServer.log",
  [string] $ErrorLogFileLocation = "$($env:BUILD_SOURCESDIRECTORY)/WebSocketServer.err.log"
)

if ($IsWindows) {
  $process = Start-Process 'python.exe' `
    -ArgumentList 'long_service.py' `
    -NoNewWindow `
    -PassThru `
    -RedirectStandardOutput $LogFileLocation `
    -RedirectStandardError $ErrorLogFileLocation
} else {
  $process = Start-Process `
    -FilePath (Get-Command pwsh) `
    -ArgumentList @( '-c', "python3 long_service.py") `
    -PassThru `
    -RedirectStandardOutput $LogFileLocation `
    -RedirectStandardError $ErrorLogFileLocation
}

Write-Host "##vso[task.setvariable variable=ServerProcessId]$($process.Id)"
