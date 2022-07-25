# Copyright (c) Microsoft Corporation. All rights reserved.
# SPDX-License-Identifier: MIT
param(
  [string] $LogFileLocation = "$($env:BUILD_SOURCESDIRECTORY)/WebSocketServer/WebSocketServer.log",
  [string] $ErrorLogFileLocation = "$($env:BUILD_SOURCESDIRECTORY)/WebSocketServer/WebSocketServer.err.log"
)

function ensureParentPath($filePath) {
  $parentPath = Split-Path $filePath -Parent
  if (!$parentPath) {
    # If the $parentPath is '' then the path is the current working directory
    # and no directory needs to be created.
    return
  }

  if (!(Test-Path $parentPath)) {
    New-Item -ItemType Directory -Path $parentPath | Out-Null
  }
}

ensureParentPath $LogFileLocation
ensureParentPath $ErrorLogFileLocation

if ($IsWindows) {
  $process = Start-Process 'python.exe' `
    -ArgumentList 'long_service.py' `
    -NoNewWindow `
    -PassThru `
    -RedirectStandardOutput $LogFileLocation `
    -RedirectStandardError $ErrorLogFileLocation
} else {
  $process = Start-Process `
    -FilePath (Get-Command nohup) `
    -ArgumentList @('python3', 'long_service.py') `
    -PassThru `
    -RedirectStandardOutput $LogFileLocation `
    -RedirectStandardError $ErrorLogFileLocation
}

Write-Host "##vso[task.setvariable variable=ServerProcessId]$($process.Id)"
