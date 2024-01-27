@ECHO OFF
REM Taken from: https://www.reddit.com/r/openscad/comments/lbq58y/my_approach_to_scripting_parts_and_converting/

REM IF NOT EXIST OBJ mkdir OBJ
IF NOT EXIST STLs mkdir STLs

set Ofile=horn_array

set /p Nparts= Number of parts: 
echo Number of parts: %Nparts%

REM IF NOT EXIST STLs\%Ofile% mkdir STLs\%Ofile%
REM CALL :ProcessPart...... Part number, Input OpenSCAD script, Output filename (without extension). 
FOR /L %%G IN (1,1,%Nparts%) DO (
	echo Exporting Part: %%G
	CALL :ProcessPart %%G, %Ofile%.scad, %Ofile%-%%G
)

ECHO.
ECHO.
ECHO Finished!
ECHO.
ECHO.
PAUSE 
EXIT /B %ERRORLEVEL%
:ProcessPart
"C:\Program Files\OpenSCAD\openscad.exe" -o STLs\%~3.stl -D part=%~1; %~2 -D resolution=1000
REM "C:\Program Files\Assimp\bin\x64\assimp.exe" export Exported_STLs\%~3.stl OBJ\%~3.obj
EXIT /B 0