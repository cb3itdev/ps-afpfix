#reads files from drag and drop file on batch/cmd file

#if (Test-Path  $env:onedrive + "\Desktop\temp\") {
#	$filesPath = $env:onedrive + "\Desktop\temp\"
#}
#Else {
#	$filesPath = $env:userprofile + "\Desktop\temp\"
#}

$filesPath = $args[0]

#string table for replacement
#left side is .Value and needs double blackslashes  \\\\lwpparsdxr01\\data
#right side is .Key and does not need double backslashes   \\10.9.60.71\aus360wp01
$lookupTable = @{
'`r`nAFP NAMEDPAGEGROUPSONLY  DUMP' = '`r`n@AFP NAMEDPAGEGROUPSONLY  DUMP'

}


#get directory listing from $filespath var
$files = (Get-ChildItem -Recurse $filesPath -Filter *.jtb).fullname
#$files = (get-content 'C:\Users\cbeegle\OneDrive - Fiserv Corp\Desktop\temp\jtb.txt')


#parse directory per line item
foreach($file in $files)
{
	#process file
#	$file = $filesPath + $file
	(Get-Content $file) | foreach-object {
		$line = $_
		#process line
		$lookupTable.GetEnumerator() | ForEach-Object {
			#replace strings in line
			if ($line -match $_.Key)
			{
				#actually replace stuff based on lookuptable
				$line = $line -replace $_.Key, $_.Value
			}
		}
		$line
	} | set-content $file
}

pause