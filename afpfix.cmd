SET rscript="C:\Users\cbeegle\OneDrive - Fiserv Corp\Desktop\afpfix.ps1"
SET fname=%1
powershell.exe -ExecutionPolicy ByPass -file %rscript% %fname%
pause
