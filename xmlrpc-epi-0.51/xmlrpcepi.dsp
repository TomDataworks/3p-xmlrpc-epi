# Microsoft Developer Studio Project File - Name="xmlrpcepi" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=xmlrpcepi - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "xmlrpcepi.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "xmlrpcepi.mak" CFG="xmlrpcepi - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "xmlrpcepi - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "xmlrpcepi - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "xmlrpcepi - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "XMLRPCEPI_EXPORTS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /I "iconv-1.7\include" /I "expat\xmlparse" /D "NDEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "XMLRPCEPI_EXPORTS" /D snprintf=_snprintf /D inline=__inline /D strcasecmp=stricmp /D VERSION="\"0.50\"" /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386

!ELSEIF  "$(CFG)" == "xmlrpcepi - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "XMLRPCEPI_EXPORTS" /YX /FD /GZ  /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /I "iconv-1.7\include" /I "expat\xmlparse" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "XMLRPCEPI_EXPORTS" /D snprintf=_snprintf /D inline=__inline /D strcasecmp=stricmp /D VERSION="\"0.50\"" /YX /FD /GZ  /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /nodefaultlib:"msvcrt" /pdbtype:sept
# SUBTRACT LINK32 /pdb:none

!ENDIF 

# Begin Target

# Name "xmlrpcepi - Win32 Release"
# Name "xmlrpcepi - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\src\base64.c
# End Source File
# Begin Source File

SOURCE=.\src\encodings.c
# End Source File
# Begin Source File

SOURCE=.\src\queue.c
# End Source File
# Begin Source File

SOURCE=.\src\simplestring.c
# End Source File
# Begin Source File

SOURCE=.\src\system_methods.c
# End Source File
# Begin Source File

SOURCE=.\src\xml_element.c
# End Source File
# Begin Source File

SOURCE=.\src\xml_to_dandarpc.c
# End Source File
# Begin Source File

SOURCE=.\src\xml_to_soap.c
# End Source File
# Begin Source File

SOURCE=.\src\xml_to_xmlrpc.c
# End Source File
# Begin Source File

SOURCE=.\src\xmlrpc.c
# End Source File
# Begin Source File

SOURCE=.\src\xmlrpc_introspection.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\src\base64.h
# End Source File
# Begin Source File

SOURCE=.\src\encodings.h
# End Source File
# Begin Source File

SOURCE=.\src\queue.h
# End Source File
# Begin Source File

SOURCE=.\src\simplestring.h
# End Source File
# Begin Source File

SOURCE=.\src\system_methods_private.h
# End Source File
# Begin Source File

SOURCE=.\src\xml_element.h
# End Source File
# Begin Source File

SOURCE=.\src\xml_to_dandarpc.h
# End Source File
# Begin Source File

SOURCE=.\src\xml_to_soap.h
# End Source File
# Begin Source File

SOURCE=.\src\xml_to_xmlrpc.h
# End Source File
# Begin Source File

SOURCE=.\src\xmlrpc.h
# End Source File
# Begin Source File

SOURCE=.\src\xmlrpc_introspection.h
# End Source File
# Begin Source File

SOURCE=.\src\xmlrpc_introspection_private.h
# End Source File
# Begin Source File

SOURCE=.\src\xmlrpc_private.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\src\xmlrpc.def
# End Source File
# End Group
# Begin Group "external-iconv"

# PROP Default_Filter ""
# Begin Source File

SOURCE=".\iconv-1.7\include\iconv.h"
# End Source File
# Begin Source File

SOURCE=".\iconv-1.7\lib\iconv_a.lib"
# End Source File
# End Group
# Begin Group "external-expat"

# PROP Default_Filter ""
# Begin Source File

SOURCE=.\expat\xmlparse\xmlparse.h
# End Source File
# Begin Source File

SOURCE=.\expat\lib\xmlparse.lib
# End Source File
# Begin Source File

SOURCE=.\expat\lib\xmltok.lib
# End Source File
# End Group
# End Target
# End Project
