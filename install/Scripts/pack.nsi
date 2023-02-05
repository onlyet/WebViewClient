; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; �����÷����£�
; define�����������峣��
; finalize������ڰ�װ�����ɺ�ִ��
; system�������ִ��windows����

; echo�����������verbose�ȼ�Ϊ4�����磺
;!verbose push
;!verbose 4
;!echo ��װ��·����${EchoInstallerPath}"
;!verbose pop

#!define /date CUR_TIME "%Y%m%d-%H%M%S"
;!define CUR_TIME ${VER}
!define CUR_TIME 123

; ��װ�����ʼ���峣��
!define PRODUCT_NAME_CN "���Կͻ���"
!define PRODUCT_NAME "WebViewClient"
!define PRODUCT_PATHNAME "WebViewClient"  #��װж�����õ���KEY
!define PRODUCT_VERSION "1.0.0"
#!define PRODUCT_PUBLISHER ""
#!define PRODUCT_WEB_SITE ""
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

!define PROGRAM_NAME "${PRODUCT_NAME}.exe"

!define PRODUCT_BIN_DIR "..\..\Release"

!define OutFileStr "${PRODUCT_NAME}_Setup_V${PRODUCT_VERSION}_${CUR_TIME}"
!define OutDir ..\Release\${OutFileStr}
!define ExeAbsolutePath "${OutDir}\${OutFileStr}.exe"

; �������Ŀ¼
!system 'mkdir "${OutDir}"'

!define PdbFiles ..\..\Release\*.pdb
; ����pdb�ļ������Ŀ¼
!system 'copy ${PdbFiles} ${OutDir}'

#!define EnableShareDir
!ifdef EnableShareDir
!define MyDrive "E:"
!define MyIP "\\192.168.2.185"
!define MyShareDir "share\��װ��\WebViewClient"
!define ShareDirStr "${MyShareDir}\Setup_V${PRODUCT_VERSION}_${CUR_TIME}"
!define ShareDirPath "${MyDrive}\${ShareDirStr}"

; ��������Ŀ¼
!system 'mkdir "${ShareDirPath}"'


; ������װ��������Ŀ¼
!finalize 'copy ${ExeAbsolutePath} ${ShareDirPath}'

; ��ӡ����Ŀ¼
!define EchoInstallerPath "${MyIP}\${ShareDirStr}"
!finalize 'echo .'
!finalize 'echo ----------------------------------------------------------------------------------------'
!finalize 'echo ��װ��·����${EchoInstallerPath}'
!finalize 'echo ----------------------------------------------------------------------------------------'
!endif

SetCompressor lzma

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
;!define MUI_ICON "..\Icon\demoLogo.ico"
;!define MUI_UNICON "..\Icon\demoLogo.ico"
!define MUI_ICON "..\..\WebViewClient\momo1.ico"
!define MUI_UNICON "..\..\WebViewClient\momo1.ico"

; ��ӭҳ��
#!insertmacro MUI_PAGE_WELCOME
; ���Э��ҳ��
#!insertmacro MUI_PAGE_LICENSE "..\License\license.txt"
; ��װĿ¼ѡ��ҳ��
!insertmacro MUI_PAGE_DIRECTORY
; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES
; ��װ���ҳ��
!insertmacro MUI_PAGE_FINISH

; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_INSTFILES

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
;OutFile "..\Release\${PRODUCT_NAME}_Setup_V${PRODUCT_VERSION}.exe"
OutFile ${ExeAbsolutePath}
InstallDir "$PROGRAMFILES\${PRODUCT_NAME}"
ShowInstDetails show
ShowUnInstDetails show
BrandingText "${PRODUCT_NAME}��װ����"

Section "MainSection" SEC01
  
  SetOverwrite ifnewer
  ;File /r "..\FileToInstall\*.*"

  SetOutPath "$INSTDIR"
  File /r "${PRODUCT_BIN_DIR}\*.exe"
  File /r "${PRODUCT_BIN_DIR}\*.dll"
  File /r "${PRODUCT_BIN_DIR}\*.json"

  SetOutPath "$INSTDIR\bearer"
  File /r "${PRODUCT_BIN_DIR}\bearer\*.dll"

  SetOutPath "$INSTDIR\iconengines"
  File /r "${PRODUCT_BIN_DIR}\iconengines\*.dll"

  SetOutPath "$INSTDIR\imageformats"
  File /r "${PRODUCT_BIN_DIR}\imageformats\*.dll"

  SetOutPath "$INSTDIR\platforms"
  File /r "${PRODUCT_BIN_DIR}\platforms\*.dll"

  SetOutPath "$INSTDIR\styles"
  File /r "${PRODUCT_BIN_DIR}\styles\*.dll"
  
  SetOutPath "$INSTDIR\resources"
  File /r "${PRODUCT_BIN_DIR}\resources\*.pak"
  File /r "${PRODUCT_BIN_DIR}\resources\*.dat"

  CreateShortCut "$DESKTOP\${PRODUCT_NAME_CN}.lnk" "$INSTDIR\${PRODUCT_NAME}.exe" "" "$INSTDIR\${PRODUCT_NAME}.exe"
SectionEnd

Section -AdditionalIcons
  #WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateDirectory "$SMPROGRAMS\${PRODUCT_NAME}"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_NAME}.lnk" "$INSTDIR\${PRODUCT_NAME}.exe"
  #CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\XXX.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\${PRODUCT_NAME}\ж��${PRODUCT_NAME}.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  #WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  #WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\${PROGRAM_NAME}"
SectionEnd

/******************************
 *  �����ǰ�װ�����ж�ز���  *
 ******************************/

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"

  Delete "$DESKTOP\${PRODUCT_NAME}.lnk"
  Delete "$DESKTOP\${PRODUCT_NAME_CN}.lnk"

  RMDir /r "$SMPROGRAMS\${PRODUCT_NAME}"
  RMDir /r "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd

#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#

# �Զ�ж�ؾɰ汾
Var UNINSTALL_PROG
Var OLD_VER
Var OLD_PATH

Function .onInit
  ;�������Ƿ�����
  FindProcDLL::FindProc ${PROGRAM_NAME}
   Pop $R0
   IntCmp $R0 1 0 no_run
   MessageBox MB_ICONSTOP "��װ�����⵽ ${PRODUCT_NAME} �������У���ر�֮���ٰ�װ��"
   Quit
   no_run:

  ClearErrors
  ReadRegStr $UNINSTALL_PROG "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_UNINST_KEY}" "UninstallString"
  IfErrors  done
 
  ReadRegStr $OLD_VER "${PRODUCT_UNINST_ROOT_KEY}" "${PRODUCT_UNINST_KEY}" "DisplayVersion"
  MessageBox MB_YESNOCANCEL|MB_ICONQUESTION \
    "��⵽�����Ѿ���װ�� ${PRODUCT_NAME} $OLD_VER��\
    $\n$\n�Ƿ���ж���Ѱ�װ�İ汾��" \
      /SD IDYES \
      IDYES uninstall1 \
      IDNO done
  Abort
 
uninstall1:
  StrCpy $OLD_PATH $UNINSTALL_PROG -10
  ExecWait '"$UNINSTALL_PROG" _?=$OLD_PATH' $0
  DetailPrint "uninst.exe returned $0"
 
done:
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDYES +2
  Abort
  
  # ����������Ƿ�����
  FindProcDLL::FindProc ${PROGRAM_NAME}
  Pop $R0
  IntCmp $R0 1 0 no_run_monitor
  MessageBox MB_ICONSTOP "ж�س����⵽ ${PRODUCT_NAME} �������У���ر�֮����ж�أ�"
  Quit
  no_run_monitor:
  
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  #MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) �ѳɹ��ش����ļ�����Ƴ���"
FunctionEnd
