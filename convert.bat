@echo off
chcp 65001
setlocal enabledelayedexpansion

set "input=%~1"

set "output=!input:ä=^&auml;!"
set "output=!output:Ä=^&Auml;!"
set "output=!output:ö=^&ouml;!"
set "output=!output:Ö=^&Ouml;!"
set "output=!output:ü=^&uuml;!"
set "output=!output:Ü=^&Uuml;!"
set "output=!output:õ=^&otilde;!"
set "output=!output:Õ=^&Otilde;!"
set "output=!output:š=^&scaron;!"
set "output=!output:Š=^&Scaron;!"
set "output=!output:ž=^&zcaron;!"
set "output=!output:Ž=^&Zcaron;!"

echo %output%

set "changes=0"
set "äCount=0"
set "ÄCount=0"
set "öCount=0"
set "ÖCount=0"
set "üCount=0"
set "ÜCount=0"
set "õCount=0"
set "ÕCount=0"
set "šCount=0"
set "ŠCount=0"
set "žCount=0"
set "ŽCount=0"

for %%a in (ä Ä ö Ö ü Ü õ Õ š Š ž Ž) do (
    call :countChar %%a
)

if %changes% equ 0 (
    echo Ei leidnud ühtegi täpitähte.
) else (
    echo Vahetatud:
    for %%a in (ä Ä ö Ö ü Ü õ Õ š Š ž Ž) do (
        set "char=%%a"
        set "charCount=!%%aCount!"
        if !%%aCount! gtr 0 (
            echo %%a: !%%aCount!
        )
    )
    echo Kokku: %changes%
)

endlocal
goto :eof

:countChar
set "char=%~1"
set "temp=!input:%char%=!"

set /a Length1=0
set /a Length2=0

:Length1Loop
if not "!input:~%Length1%!"=="" (
    set /a Length1+=1
    goto Length1Loop
)

:Length2Loop
if not "!temp:~%Length2%!"=="" (
    set /a Length2+=1
    goto Length2Loop
)

set /a "diff=Length1-Length2"

if !diff! gtr 0 (
    set /a "%char%Count+=diff"
    set /a "changes+=diff"
)
goto :eof
