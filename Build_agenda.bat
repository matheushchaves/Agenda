@ECHO OFF
REM Gerado pela xDev Studio v0.72 as 01/07/2014 @ 14:09:48
REM Compilador .: HB build 3.2. (Simplex) & BCC 5.82 & FW 13.12
REM Destino ....: C:\Des\fivewin\agendafivedbf\agenda.EXE
REM Perfil .....: Batch file (Relative Paths)

REM **************************************************************************
REM * Setamos abaixo os PATHs necessarios para o correto funcionamento deste *
REM * script. Se voce for executa-lo em  outra CPU, analise as proximas tres *
REM * linhas abaixo para refletirem as corretas configuracoes de sua maquina *
REM **************************************************************************
 SET PATH=C:\bcc582\Bin;C:\fwh1307;C:\xhb121\bin;C:\Program Files\Common Files\Microsoft Shared\Windows Live;C:\Program Files (x86)\Common Files\Microsoft Shared\Windows Live;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files (x86)\Windows Live\Shared;C:\Program Files\TortoiseSVN\bin;C:\Program Files\MySQL\MySQL Server 5.6\bin;C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\;C:\Program Files\Microsoft SQL Server\110\Tools\Binn\;C:\Program Files\Microsoft SQL Server\110\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\110\DTS\Binn\
 SET INCLUDE=C:\fwh1307\include;C:\bcc582\include;C:\xhb121\include;;
 SET LIB=C:\fwh1307\lib;C:\bcc582\lib;C:\bcc582\lib\psdk;C:\xhb121\lib;;
 SET PATH=C:\bcc582\Bin;C:\fwh1312;C:\hbfw\bin;C:\Program Files\Common Files\Microsoft Shared\Windows Live;C:\Program Files (x86)\Common Files\Microsoft Shared\Windows Live;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files (x86)\Windows Live\Shared;C:\Program Files\TortoiseSVN\bin;C:\Program Files\MySQL\MySQL Server 5.6\bin;C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\;C:\Program Files\Microsoft SQL Server\110\Tools\Binn\;C:\Program Files\Microsoft SQL Server\110\DTS\Binn\;C:\Program Files (x86)\Microsoft SQL Server\110\Tools\Binn\ManagementStudio\;C:\Program Files (x86)\Microsoft SQL Server\110\DTS\Binn\
 SET INCLUDE=C:\bcc582\include;C:\fwh1312\include;C:\hbfw\include;;
 SET LIB=C:\bcc582\lib;C:\bcc582\lib\psdk;C:\fwh1312\lib;C:\hbfw\lib;;

REM - FiveWin.xCompiler.prg(80) @ 14:09:48:235
ECHO .ÿ
ECHO * (1/3) Compilando agenda.prg
 harbour.exe ".\agenda.prg" /o".\agenda.c"   /M  /N  -A 
 IF ERRORLEVEL 1 GOTO FIM

REM - FiveWin.xCompiler.prg(115) @ 14:09:48:674
 echo -I"C:\bcc582\include;C:\fwh1312\include;C:\hbfw\include;;" > "b32.bc"
 echo -L"C:\bcc582\lib;C:\bcc582\lib\psdk;C:\fwh1312\lib;C:\hbfw\lib;;;;;" >> "b32.bc"
 echo -o".\agenda.obj" >> "b32.bc"
 echo ".\agenda.c" >> "b32.bc"

REM - FiveWin.xCompiler.prg(116) @ 14:09:48:677
ECHO .ÿ
ECHO * (2/3) Compilando agenda.c
 BCC32 -M -c @B32.BC
 IF ERRORLEVEL 1 GOTO FIM

REM - FiveWin.xCompiler.prg(248) @ 14:09:48:812
 echo -I"C:\bcc582\include;C:\fwh1312\include;C:\hbfw\include;;" + > "b32.bc"
 echo -L"C:\bcc582\lib;C:\bcc582\lib\psdk;C:\fwh1312\lib;C:\hbfw\lib;;;;;" + >> "b32.bc"
 echo -aa + >> "b32.bc"
 echo -Gn -Tpe -s + >> "b32.bc"
 echo c0w32.obj +     >> "b32.bc"
 echo ".\agenda.obj", +  >> "b32.bc"
 echo ".\agenda.EXE", +    >> "b32.bc"
 echo ".\agenda.map", +    >> "b32.bc"
 echo FiveH.lib FiveHC.lib + >> "b32.bc"
 echo xhb.lib       +  >> "b32.bc"
 echo hbrtl.lib     +  >> "b32.bc"
 echo hbvm.lib      +  >> "b32.bc"
 echo gtgui.lib  +  >> "b32.bc"
 echo hblang.lib     +  >> "b32.bc"
 echo hbmacro.lib    +  >> "b32.bc"
 echo hbrdd.lib      +  >> "b32.bc"
 echo hbcpage.lib +  >> "b32.bc"
 echo rddntx.lib   +  >> "b32.bc"
 echo rddcdx.lib  +  >> "b32.bc"
 echo rddsql.lib  +  >> "b32.bc"
 echo rddfpt.lib   +  >> "b32.bc"
 echo hbsix.lib    +  >> "b32.bc"
 echo hbcommon.lib   +  >> "b32.bc"
 echo hbpp.lib       +  >> "b32.bc"
 echo hbct.lib       +  >> "b32.bc"
 echo hbwin.lib      +  >> "b32.bc"
 echo hbcplr.lib     +  >> "b32.bc"
 echo hbpcre.lib     +  >> "b32.bc"
 echo hbmzip.lib     +  >> "b32.bc"
 echo minizip.lib    +  >> "b32.bc"
 echo hbzlib.lib     +  >> "b32.bc"
 echo hbziparc.lib   +  >> "b32.bc"
 echo png.lib        +  >> "b32.bc"
 echo hbtip.lib        +  >> "b32.bc"
 echo "C:\bcc582\Lib\PSDK\psapi.lib" +   >> "b32.bc"
 echo "C:\Bcc582\Lib\ws2_32.lib" +   >> "b32.bc"
 echo cw32.lib +      >> "b32.bc"
 echo import32.lib +  >> "b32.bc"
 echo nddeapi.lib + >> "b32.bc"
 echo iphlpapi.lib + >> "b32.bc"
 echo rasapi32.lib + >> "b32.bc"
 echo , >> "b32.bc"
 echo ".\agend1.res"  >> "b32.bc"

REM - FiveWin.xCompiler.prg(249) @ 14:09:48:813
ECHO .ÿ
ECHO * (3/3) Linkando agenda.EXE
 ILINK32 @B32.BC
 IF ERRORLEVEL 1 GOTO FIM

:FIM
 ECHO Fim do script de compilacao!
