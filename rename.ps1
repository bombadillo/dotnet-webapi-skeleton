param(
    [string]$projectName
)

if (!$projectName) {
    Write-Host "parameter -projectName is missing"
    exit
}

$textToFind = @("DotnetApiSkeleton", "DotnetWebApiSkeleton", "dotnet-webapi-skeleton")
$projectSolutionName = "dotnet-webapi-skeleton"
$defaultProjectName = "DotnetWebApiSkeleton"
$include = @("*.cs", "*.config", "*.csproj", "*.asax", "*.md", "*.sln")
$projectFiles = Get-ChildItem '.\*' -Recurse -Include $include -Exclude $exclude | ?{ $_.fullname -notmatch "\\obj\\|\\bin\\?" }

function ReplaceInFile($file, $replace) {
    try {
        $content = Get-Content $file.PSPath

        foreach ($stringToReplace in $textToFind) {            
            $content = $content -Replace $stringToReplace, $replace
            Write-Host "Replaced $stringToReplace with $replace" -foregroundcolor "darkgray"
        }
        
        Set-Content -Path $file.PSPath -Value $content
    }
    catch [PSInvalidOperationException]{
        Write-Host "Unable to replace in file" -foregroundcolor "red"
    }    
}

function ProcessFiles($files) {    
    foreach ($file in $files) {
        ReplaceInFile $file "$projectName.Api"
        Write-Host "Processed file $file" -foregroundcolor "green"
    }
}

function RenameItems() {
    Write-Host 'Start renaming'

    try {
        Rename-Item "$projectSolutionName.sln" "$projectName.sln"
        Rename-Item "$projectSolutionName\$defaultProjectName.csproj" "$projectName.Api.csproj"
        Rename-Item "$projectSolutionName" "$projectName.Api"        
    }
    catch [System.Exception] {
        Write-Host "Unable to rename items. Have you already run this script?" -foregroundcolor "red"
    }    
}

function ReplaceOccurrencesInSln() {
    $solutionFile = Get-Item "$projectSolutionName.sln"
    
    $content = Get-Content $solutionFile.PSPath
    $content = $content -Replace 'dotnet-webapi-skeleton', "$projectName.Api"
    $content = $content -Replace 'DotnetWebApiSkeleton.csproj', "$projectName.Api.csproj"
    $content = $content -Replace 'DotnetWebApiSkeleton', "$projectName"                   
    Set-Content -Path $solutionFile.PSPath -Value $content       
}

ReplaceOccurrencesInSln
ProcessFiles $projectFiles
RenameItems
