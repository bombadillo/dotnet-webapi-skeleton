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

function ReplaceInFile($file) {
    try {
        $content = Get-Content $file.PSPath

        foreach ($stringToReplace in $textToFind) {            
            $content = $content -Replace $stringToReplace, $projectName
            Write-Host "Replaced $stringToReplace with $projectName"
        }
        
        Set-Content -Path $file.PSPath -Value $content
    }
    catch [System.Exception] {
        Write-Host "Unable to replace in file"
    }    
}

function ProcessFiles($files) {    
    foreach ($file in $files) {
        ReplaceInFile $file
        Write-Host "Processed file $file"
    }
}

function RenameItems() {
    Write-Host 'Start renaming'
    Rename-Item "$projectSolutionName.sln" "$projectName.sln"
    Rename-Item "$projectSolutionName\$defaultProjectName.csproj" "$projectName.csproj"
    Rename-Item "$projectSolutionName" "$projectName"
}

ProcessFiles $projectFiles
RenameItems
