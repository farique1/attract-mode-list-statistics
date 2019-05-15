;~ Attract Mode List Statistics v1.4
;~ Help you organise the assets on your Attract Mode installation.
;~ It identify the assets you are missing and the ones you have that
;~ are not being used on your Attract Mode setup based on your ROM collection.
;~
;~ Copyright (C) 2018 - Fred Rique (farique) https://github.com/farique1

#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <GUIListBox.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <Color.au3>
#include <File.au3>
#include <Math.au3>

#Region Gui
$_fStatis = GUICreate("Attract Mode List Statistics", 950, 300, -1, -1)
GUICtrlCreateLabel("Systems", 134, 18, 100, 20)
	GUICtrlSetTip( -1, "The available systems")
GUICtrlSetFont(-1, 10, 700, 0, "MS Sans Serif")
$_lsSystems = GUICtrlCreateList("", 134, 40, 122, 212, BitOR($LBS_NOTIFY,$WS_VSCROLL))
GUICtrlSetData(-1, "")
GUICtrlSetFont(-1, 8, 600, 0, "MS Sans Serif")
$_lSysName = GUICtrlCreateLabel("None", 270, 18, 300, 20)
GUICtrlSetFont(-1, 10, 700, 0, "MS Sans Serif")
	GUICtrlSetTip( -1, "The Current system")
GUICtrlCreateGroup("", 270, 34, 660, 219)
GUICtrlCreateLabel("100%", 280, 50, 30, 18)
GUICtrlCreateLabel("50%", 452, 50, 30, 18)
GUICtrlCreateLabel("0%", 626, 50, 30, 18)
GUICtrlCreateLabel("Have", 715, 50, 50, 18,$SS_CENTER)
	GUICtrlSetTip( -1, "The assets you have")
GUICtrlCreateLabel("Missing", 770, 50, 50, 18,$SS_CENTER)
	GUICtrlSetTip( -1, "The assets you do NOT have")
GUICtrlCreateLabel("Percent", 825, 50, 50, 18,$SS_CENTER)
	GUICtrlSetTip( -1, "The percentage of the assets you have in relation to the ones on the romlist")
GUICtrlCreateLabel("Left", 880, 50, 48, 18,$SS_CENTER)
	GUICtrlSetTip( -1, "The assets you have that are NOT on the romlist")
GUICtrlCreateLabel("% Total", 650, 72, 60, 18,$SS_CENTER)
GUICtrlCreateLabel("Roms", 650, 94, 60, 18,$SS_CENTER)
GUICtrlCreateLabel("Snaps", 650, 116, 60, 18,$SS_CENTER)
GUICtrlCreateLabel("Flyers", 650, 138, 60, 18,$SS_CENTER)
GUICtrlCreateLabel("Overviews", 650, 160, 60, 18,$SS_CENTER)
GUICtrlCreateLabel("Publishers", 650, 182, 60, 18,$SS_CENTER)
GUICtrlCreateLabel("Year", 650, 204, 60, 18,$SS_CENTER)
GUICtrlCreateLabel("Category", 650, 226, 60, 18,$SS_CENTER)
$_bPath = GUICtrlCreateButton("Attract Mode Path", 12, 98, 110, 25)
	GUICtrlSetTip( -1, "Point to the Attract Mode folder")
$_cAMv = GUICtrlCreateCheckbox("AM v2.4 Overviews", 13, 156, 110, 25)
	GUICtrlSetTip( -1, "Uses Attract Mode v2.4 style overviews")
$_bSave = GUICtrlCreateButton("Save", 12, 198, 110, 25)
	GUICtrlSetTip( -1, "Save all information")
GUICtrlSetState(-1 ,$GUI_DISABLE)
$_bRescan = GUICtrlCreateButton("Rescan All", 12, 128, 110, 25)
	GUICtrlSetTip( -1, "Rescan all systems again")
$_bHelp = GUICtrlCreateButton("Help", 12, 228, 110, 25)
$_bPrev = GUICtrlCreateButton("<", 269, 260, 40, 25)
	GUICtrlSetTip( -1, "Go to the previous system")
$_bNext = GUICtrlCreateButton(">", 319, 260, 40, 25)
	GUICtrlSetTip( -1, "Go to the next system")
$_bExit = GUICtrlCreateButton("Exit", 820, 260, 110, 25)
$_bSysinfo = GUICtrlCreateButton("Sys config info", 820, 14, 110, 20)
	GUICtrlSetTip( -1, "Show the current system configuration from Attract Mode")
GUICtrlSetDefBkColor(0x1c75bc)
$_ePbar = GUICtrlCreateLabel("",280,70,360,18)
	GUICtrlSetTip( -1, "The general completion percentage for this system")
$_rPbar = GUICtrlCreateLabel("",280,92,360,18)
$_sPbar = GUICtrlCreateLabel("",280,114,360,18)
$_fPbar = GUICtrlCreateLabel("",280,136,360,18)
$_oPbar = GUICtrlCreateLabel("",280,158,360,18)
GUICtrlSetDefBkColor(0x27aae1)
$_pPbar = GUICtrlCreateLabel("",280,180,360,18)
$_yPbar = GUICtrlCreateLabel("",280,202,360,18)
$_cPbar = GUICtrlCreateLabel("",280,224,360,18)
GUICtrlSetDefBkColor(0xf0f0f0)
GUICtrlSetDefColor(0x1c75bc)
$_eHbox = GUICtrlCreateLabel("0", 715, 72, 50, 18,$SS_CENTER)
$_rHbox = GUICtrlCreateLabel("0", 715, 94, 50, 18,$SS_CENTER)
$_sHbox = GUICtrlCreateLabel("0", 715, 116, 50, 18,$SS_CENTER)
$_fHbox = GUICtrlCreateLabel("0", 715, 138, 50, 18,$SS_CENTER)
$_oHbox = GUICtrlCreateLabel("0", 715, 160, 50, 18,$SS_CENTER)
GUICtrlSetDefColor(0x27aae1)
$_pHbox = GUICtrlCreateLabel("0", 715, 182, 50, 18,$SS_CENTER)
$_yHbox = GUICtrlCreateLabel("0", 715, 204, 50, 18,$SS_CENTER)
$_cHbox = GUICtrlCreateLabel("0", 715, 226, 50, 18,$SS_CENTER)
GUICtrlSetDefColor(0x1c75bc)
		  GUICtrlCreateLabel("", -10, 0, 1, 1) ; para manter a grade dos numeros de Id
$_rMbox = GUICtrlCreateLabel("0", 770, 94, 50, 18,$SS_CENTER)
$_sMbox = GUICtrlCreateLabel("0", 770, 116, 50, 18,$SS_CENTER)
$_fMbox = GUICtrlCreateLabel("0", 770, 138, 50, 18,$SS_CENTER)
$_oMbox = GUICtrlCreateLabel("0", 770, 160, 50, 18,$SS_CENTER)
GUICtrlSetDefColor(0x27aae1)
$_pMbox = GUICtrlCreateLabel("0", 770, 182, 50, 18,$SS_CENTER)
$_yMbox = GUICtrlCreateLabel("0", 770, 204, 50, 18,$SS_CENTER)
$_cMbox = GUICtrlCreateLabel("0", 770, 226, 50, 18,$SS_CENTER)
GUICtrlSetDefColor(0x1c75bc)
$_TPbox	= GUICtrlCreateLabel("0", 825, 72, 50, 18,$SS_CENTER)
	GUICtrlSetTip( -1, "The general completion percentage for this system")
$_rPbox = GUICtrlCreateLabel("0", 825, 94, 50, 18,$SS_CENTER)
$_sPbox = GUICtrlCreateLabel("0", 825, 116, 50, 18,$SS_CENTER)
$_fPbox = GUICtrlCreateLabel("0", 825, 138, 50, 18,$SS_CENTER)
$_oPbox = GUICtrlCreateLabel("0", 825, 160, 50, 18,$SS_CENTER)
GUICtrlSetDefColor(0x27aae1)
$_pPbox = GUICtrlCreateLabel("0", 825, 182, 50, 18,$SS_CENTER)
$_yPbox = GUICtrlCreateLabel("0", 825, 204, 50, 18,$SS_CENTER)
$_cPbox = GUICtrlCreateLabel("0", 825, 226, 50, 18,$SS_CENTER)
GUICtrlSetDefColor(0x1c75bc)
		  GUICtrlCreateLabel("", -10, 0, 1, 1) ; para manter a grade dos numeros de Id
$_rLbox = GUICtrlCreateLabel("0", 880, 94, 48, 18,$SS_CENTER)
$_sLbox = GUICtrlCreateLabel("0", 880, 116, 48, 18,$SS_CENTER)
$_fLbox = GUICtrlCreateLabel("0", 880, 138, 48, 18,$SS_CENTER)
$_oLbox = GUICtrlCreateLabel("0", 880, 160, 48, 18,$SS_CENTER)
GUICtrlSetDefColor(0x000000)
$_lDataDate = GUICtrlCreateLabel("No save", 370, 265,220,18,$SS_CENTER)
GUICtrlCreateLabel("Click the numbers to see the lists", 590, 265,220,18,$SS_CENTER)
GUICtrlCreatePic("Data\Logo.gif", 12, 40, 108, 46)
GUICtrlCreateLabel("v1.3", 18, 265,220,18,$SS_left)
GUICtrlSetColor(-1, 0xbbbbbb)
GUISetState(@SW_SHOW)
#EndRegion

#Region Variables
Local $aTempCFG, $aTempList, $aSysCfg[0][6], $aSysData[0][28], $aRomLists
Local $aRomName[0][0], $aRomTitl[0][0], $aRomRoms[0][0], $aRomSnps[0][0], $aRomFlrs[0][0], $aRomOvrv[0][0],$nArraySize = 0
Local $aRomPubl[0][0], $aRomYear[0][0], $aRomCtgr[0][0]
Local $sWDir, $nCurSys = 0, $sCurSys, $sSelSys, $bSeta = False, $sSysRep = "", $prog = 0
Local $_fDisplayList[10], $aArrayListShown[10][5], $nListForm = 0, $_bCopyList[10], $_bCShowTitles[10], $_bExportList[10]
Local $_fSysInfo, $_lbSysConfig, $lSysCfgLabel
Local $aListType[8] = ["List Entries","Roms","Snaps","Flyers","Overviews","Publishers","Year","Category"], $aListHave[4] = ["Have","Missing","Percent","Left"]
Local $aCfgNames[6] = ["Name","Extensions","Roms","Snaps","Flyers","Overviews"], $aLog[0]
Local $bModified = False
Local $sFExt = ".dat"
Local $aDataFilesI[12] = ["SysCfg"&$sFExt, "SysData"&$sFExt, "RomLists"&$sFExt, "RomName"&$sFExt, "RomTitl"&$sFExt, "RomPubl"&$sFExt, _
						  "RomYear"&$sFExt, "RomCtgr"&$sFExt, "RomRoms"&$sFExt, "RomSnps"&$sFExt, "RomFlrs"&$sFExt, "RomOvrv"&$sFExt]
Local $bFail = False
Local $amPath = ""
$amPath = IniRead("Data\AMLS.ini", "Paths", "Attract Mode", $amPath)
local $nAMv = IniRead("Data\AMLS.ini", "Checks", "AM v24 Mode", 1)
#EndRegion

#Region Iniltialize
if $nAMv = 1 then GUICtrlSetState($_cAMv, $GUI_CHECKED)

$aDataFilesF = _FileListToArray("Data\", "*"&$sFExt)
if not @error then
;~ 	_ArrayDisplay($aDataFilesF)
	For $f=1 to UBound($aDataFilesI)-1
		_ArraySearch($aDataFilesF, $aDataFilesI[$f])
		if @error Then
			$bFail = True
			MsgBox(0,"Error", "Data missing"&@CRLF&"Cannot load")
			ExitLoop
		EndIf
	Next
	if not $bFail Then
		_FileReadToArray("Data\SysCfg"&$sFExt, $aSysCfg, 0, "|")
		_FileReadToArray("Data\SysData"&$sFExt, $aSysData, 0, "|")
		_FileReadToArray("Data\RomLists"&$sFExt, $aRomLists, 0)
		_FileReadToArray("Data\RomName"&$sFExt, $aRomName, 0, "|")
		_FileReadToArray("Data\RomTitl"&$sFExt, $aRomTitl, 0, "|")
		_FileReadToArray("Data\RomPubl"&$sFExt, $aRomPubl, 0, "|")
		_FileReadToArray("Data\RomYear"&$sFExt, $aRomYear, 0, "|")
		_FileReadToArray("Data\RomCtgr"&$sFExt, $aRomCtgr, 0, "|")
		_FileReadToArray("Data\RomRoms"&$sFExt, $aRomRoms, 0, "|")
		_FileReadToArray("Data\RomSnps"&$sFExt, $aRomSnps, 0, "|")
		_FileReadToArray("Data\RomFlrs"&$sFExt, $aRomFlrs, 0, "|")
		_FileReadToArray("Data\RomOvrv"&$sFExt, $aRomOvrv, 0, "|")

		;~ _ArrayDisplay($aRomLists)

		for $f=1 to UBound($aRomLists)-1
			GUICtrlSetData($_lsSystems,$aSysCfg[$f-1][0])
		Next

		ShowData()
		ControlCommand($_fStatis, "", $_lsSystems, "SetCurrentSelection", 0)
		$sDataDate = FileGetTime("Data\SysData"&$sFExt)
		if not @error Then
			$sDataDate = _ArrayToString($sDataDate,"/",0,2)&" "&_ArrayToString($sDataDate,":",3,5)
			GUICtrlSetData($_lDataDate, "Last save: "&$sDataDate)
		EndIf
	EndIf
EndIf
#EndRegion

While 1
	$nMsg = GUIGetMsg(1)
	Switch $nMsg[1]
		Case $_fStatis
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					 Quit()
				Case $_bExit
					 Quit()
				Case $_bPath
					BPath()
				Case $_bPrev
					$bSeta = True
					$nCurSys = _Mod($nCurSys - 1,UBound($aRomLists)-1)
					ControlCommand($_fStatis, "", $_lsSystems, "SetCurrentSelection", $nCurSys)
				Case $_bNext
					$bSeta = True
					$nCurSys = _Mod($nCurSys + 1,UBound($aRomLists)-1)
					ControlCommand($_fStatis, "", $_lsSystems, "SetCurrentSelection", $nCurSys)
				Case $_lsSystems
					if $bSeta=false Then ListSelect()
					ShowData()
				Case $_bSave
					Save()
				Case $_bRescan
					$sSearch = FileFindFirstFile($amPath&"\attract.exe")
					if @error or $sSearch = -1 Then
						 MsgBox(0,"Missing Path","Attract Mode not found")
					Else
						RescanAll()
					EndIf
				Case $_cAMv
					$nAMv = (_IsChecked($_cAMv)) ? (1) : (0)
				Case $_bHelp
					If FileExists("Readme.txt") Then
						Run("notepad.exe " & "Readme.txt")
					Else
						MsgBox($MB_SYSTEMMODAL, "File not found", "Readme.txt was not found.")
					EndIf
				Case $_bSysinfo
					SysInfo()
				Case $nMsg[0]>=39 and $nMsg[0]<=67 ; Testa o Control ID do Label * PODE SER QUE QUEBRE SE O LAYOUT DA JANELA MUDAR *
					ShowList()
			EndSwitch
		Case $_fSysInfo
			Switch $nMsg[0]
				Case $GUI_EVENT_CLOSE
					GUIDelete($_fSysInfo)
					GUICtrlSetState($_bSysinfo ,$GUI_ENABLE)
			EndSwitch
		Case Else
            For $i = 0 To 9
                If $nMsg[1] = $_fDisplayList[$i] Then
                    Switch $nMsg[0]
						Case $GUI_EVENT_CLOSE
                            GUIDelete($_fDisplayList[$i])
							_ArrayDelete($_fDisplayList,$i)
							_ArrayAdd($_fDisplayList,"")
							_ArrayDelete($_bCopyList,$i)
							_ArrayAdd($_bCopyList,"")
							_ArrayDelete($_bExportList,$i)
							_ArrayAdd($_bExportList,"")
							_ArrayDelete($aArrayListShown,$i)
							_ArrayAdd($aArrayListShown,"")
							$nListForm -= 1
                            ExitLoop
						Case $_bCopyList[$i]
							_ArrayToClip($aArrayListShown[$i][0],@CRLF)
						Case $_bExportList[$i]
							$sFile = FileSaveDialog("Save "&$aArrayListShown[$i][1]&" "& _
							                                $aArrayListShown[$i][2]&" "& _
															$aArrayListShown[$i][3]&" list", _
															"", "Text (*.txt)", 0, _
															$aArrayListShown[$i][1]&"_"& _
															$aArrayListShown[$i][2]&"_"& _
															$aArrayListShown[$i][3]&".txt")
							_FileWriteFromArray($sFile, $aArrayListShown[$i][0])
						Case $_bCShowTitles[$i]
							ShowTitles()
                    EndSwitch
                EndIf
            Next
	EndSwitch
WEnd

Func BPath()
	$amPathTemp = FileSelectFolder ( "Attract Mode Path",$amPath,2)
	If not @error Then
		$sSearch = FileFindFirstFile($amPathTemp&"\attract.exe")
		if @error  or $sSearch = -1 Then
			 MsgBox(0,"Missing Path","Attract Mode not found")
		Else
			$amPath = $amPathTemp
			RescanAll()
		EndIf
	EndIf
EndFunc

Func RescanAll()

	ProgressOn("Searching","", "", -1, -1, BitOR($DLG_NOTONTOP, $DLG_MOVEABLE))

	Local $hTimer = TimerInit()

	GetConfig()
	GetData()
	GetFiles()

	ConsoleWrite(@CRLF&"Scan Time - "&TimerDiff($hTimer)&@CRLF)
	_ArrayAdd($aLog, "")
	_ArrayAdd($aLog, "Scan Time - "&TimerDiff($hTimer))
	_FileWriteFromArray("Data\AMLS.log", $aLog)

	ProgressOff()

	If $sSysRep <> "" Then
		MsgBox(0, "Repeated Items", "The systems"&@CRLF&@CRLF&$sSysRep&@CRLF&"Appears to have items with repeated names."&@CRLF&"They may cause inconsistencies.")
	EndIf

	ControlCommand($_fStatis, "", $_lsSystems, "SetCurrentSelection", 0)
EndFunc

Func GetConfig() ; *** Fazer romext entender diretorios como roms ***
	Dim $aLog[0]
	Dim $aSysCfg[0][6] ; limpa array dos sistemas
	_GUICtrlListBox_ResetContent($_lsSystems) ; limpa listbox dos sistemas
	$bModified = True ; anota que houve modificacao
	GUICtrlSetState($_bSave ,$GUI_ENABLE) ; habilita botão de save
	$aRomLists = _FileListToArray ($amPath&"\emulators", "*.cfg", 1) ; pega os cfgs dos sistemas
	for $f = 1 to UBound($aRomLists) - 1 ; trata cada um dos os .cfg dos emuladores
		_ArrayAdd($aSysCfg, StringReplace($aRomLists[$f], ".cfg", "")) ; coloca sistema atual na array tirando o .cfg

		ConsoleWrite(@CRLF&"- "&$aSysCfg[$f-1][0]&@CRLF)
		_ArrayAdd($aLog, "- "&$aSysCfg[$f-1][0])

		GUICtrlSetData($_lsSystems, $aSysCfg[$f-1][0]) ; coloca o sistema atual na listbox
		_FileReadToArray($amPath & "\emulators\" & $aRomLists[$f], $aTempCFG) ; le a configuração do sistema atual
		$sWDir = ""
		for $c=0 to UBound($aTempCFG)-1 ; le o .cfg do emulador atual
			if StringLeft($aTempCFG[$c],7) = "workdir" then
				$sWDir = StringTrimLeft($aTempCFG[$c],21)
				$sWDir = StringStripWS($sWDir, 3)
				if $sWDir <> "" Then
					StringReplace($sWDir, "/", "\")
					if StringRight($sWDir,1) <> "\" then $sWDir &= "\"
					$nVolPos = StringInStr($sWDir, ":\")
					if $nVolPos <> 2 Then $sWDir = $amPath & $sWDir
				EndIf

			ConsoleWrite("WorkDir - "&$sWDir&@CRLF)
			_ArrayAdd($aLog, "WorkDir - "&$sWDir)

			EndIf

			if StringLeft($aTempCFG[$c], 6) = "romext" then
				$aTempPath = StringTrimLeft($aTempCFG[$c], 21)
				$aTempPath = StringSplit($aTempPath, ";", 2)
				$aSysCfg[$f-1][1] = ""
				for $d=0 to UBound($aTempPath)-1
					if $aTempPath[$d]<> "<DIR>" then $aSysCfg[$f-1][1] &= $aTempPath[$d] & ";" ; descarta <DIR> *** Fazer romext entender diretorios como roms ***
				Next
				$aSysCfg[$f-1][1] = StringTrimRight($aSysCfg[$f-1][1],1)

			ConsoleWrite(" Romext - "&$aSysCfg[$f-1][1]&@CRLF)
			_ArrayAdd($aLog, " Romext - "&$aSysCfg[$f-1][1])

			EndIf

			GetAssetPath($f, $c, "rompath", 21, 2, $sWDir)
			GetAssetPath($f, $c, "artwork    snap", 27, 3, $sWDir)
			GetAssetPath($f, $c, "artwork    flyer", 27, 4, $sWDir)

		Next
		if _IsChecked($_cAMv) Then
			$aSysCfg[$f-1][5] = $amPath & "\scraper\" & $aSysCfg[$f-1][0] & "\overview"
		Else
			$aSysCfg[$f-1][5] = $amPath & "\romlists\" & $aSysCfg[$f-1][0]
		EndIf

		ConsoleWrite("Overviw - "&$aSysCfg[$f-1][5]&@CRLF)
		_ArrayAdd($aLog, "Overviw - "&$aSysCfg[$f-1][5])
		_ArrayAdd($aLog, "")

	next
EndFunc

Func GetAssetPath($f, $c, $sAsset, $nInfoStart, $nCfgType, $sWDir)	; variaveis dos for, $f e $c
																	; $sAsset - Nome do cabeçalho do asset a procurar na cfg,
																	; $nInfoStart - posição do inicio da informação,
																	; $nCfgType - numero da posição na array do config: 2 rompath, 3 snap, 4 flyer
																	; $sWDir - Working Dir
																	; > comportamento dos paths:
																	; $HOME = C:\Users\Fred = @HomeDrive&@HomePath
																	; $PROGDIR = AM Path = $amPath
																	; %SYSTEMROOT% = C:\WINDOWS = EnvGet("SYSTEMROOT")
																	; %PROGRAMFILES%  = C:\Program Files = EnvGet("PROGRAMFILES") menos " (x86)"
																	; paths relativos sem workingdir ficam no dir do AM (não pode ter "\" no inicio)
																	; workingdir relativo fica no dir do AM (não pode ter "\" no inicio)
	$nAssetLen = StringLen($sAsset)
	if StringLeft($aTempCFG[$c], $nAssetLen) = $sAsset then

		$aTempPath = StringTrimLeft($aTempCFG[$c], $nInfoStart)
		$aTempPath = StringSplit($aTempPath, ";", 2)
		$aSysCfg[$f-1][$nCfgType] = ""

		for $d = 0 to UBound($aTempPath) -1
			$aTempPath[$d] = StringStripWS($aTempPath[$d], 3)
			$aTempPath[$d] = StringReplace($aTempPath[$d], "/", "\")
			$aTempPath[$d] = StringReplace($aTempPath[$d], "$HOME", @HomeDrive&@HomePath)
			$aTempPath[$d] = StringReplace($aTempPath[$d], "$PROGDIR", $amPath)
			$aTempPath[$d] = StringReplace($aTempPath[$d], "%SYSTEMROOT%", EnvGet("SYSTEMROOT"))
			$aTempPath[$d] = StringReplace($aTempPath[$d], "%PROGRAMFILES%", StringReplace(EnvGet("PROGRAMFILES"), " (x86)", ""))

			$nVolPos = StringInStr($aTempPath[$d], ":\") ; pega posição do drive "F:\"
			if $nVolPos <> 2 Then ; se não tiver drive no path = relativo

				if StringLeft($aTempPath[$d], 1) = "\" then ; se começar com "\"
					$aTempPath[$d] = StringTrimLeft($aTempPath[$d], 1) ; tira
				EndIf

				if $sWDir = "" Then ; se não tiver workingdir
					$aTempPath[$d] = $amPath & "\" & $aTempPath[$d] ; faz path ser do AM
				Else
					$aTempPath[$d] = $sWDir & $aTempPath[$d] ; se tiver, faz path ser do workdir
				EndIf
			EndIf

			$aSysCfg[$f-1][$nCfgType] &= $aTempPath[$d] & ";" ; adiciona os paths à string na array da config
		Next

		$aSysCfg[$f-1][$nCfgType] = StringTrimRight($aSysCfg[$f-1][$nCfgType], 1) ; tira o ultimo ";"

		ConsoleWrite(StringRight($sAsset, 7)&" - "&$aSysCfg[$f-1][$nCfgType]&@CRLF)
		_ArrayAdd($aLog, StringRight($sAsset, 7)&" - "&$aSysCfg[$f-1][$nCfgType])
	EndIf
EndFunc

Func GetData()
	Dim $aRomName[0][0], $aRomTitl[0][0], $aRomPubl[0][0], $aRomYear[0][0], $aRomCtgr[0][0] ; Arrays com os itens de todos os sistemas
	Local $nArraySizeN = 0, $nArraySizeP = 0, $nArraySizeY = 0, $nArraySizeC = 0 ; Tamanho das arrays pra redimensionar se necessário

	$sSysRep = ""
	for $f=1 to UBound($aRomLists)-1 ; Faz cada sistema

		$prog = Int($f/(UBound($aRomLists))*100)
		ProgressSet($prog, "Searching Romlists", $aSysCfg[$f-1][0])

		_FileReadToArray($amPath & "\romlists\" & $aSysCfg[$f-1][0] & ".txt", $aTempList,0,";") ; le a lista do sistema atual
		_ArrayDelete($aTempList,"0")
		_ArraySort($aTempList)
		_ArrayAdd($aSysData, UBound($aTempList)) ; coloca o numero de entradas na lista no array de dados, criando o row do sistema

		$aTempFilesN = _ArrayExtract($aTempList, -1, -1, 0, 0) ; Pega apenas a primeira coluna com o name das roms da lista
		$aTempFilesT = _ArrayExtract($aTempList, -1, -1, 1, 1) ; Pega apenas a segunda coluna com o title das roms da lista

		$aTempRepetU = _ArrayUnique($aTempFilesN,0,0,0,0) ; remove duplicatas para avisar de possíveis conflitos
		If UBound($aTempFilesN) > UBound($aTempRepetU) Then ; Avisa se havia nomes repetidos na lista
			$sSysRep &= $aSysCfg[$f-1][0]&@CRLF
		EndIf

		Local $stringP = "", $stringY = "", $stringC = ""

		for $c = 0 to UBound($aTempList)-1 ; faz toda a lista

			if $aTempList[$c][5]<>"" then
				$stringP &= $aTempList[$c][0]&@CRLF
			EndIf

			if StringIsDigit($aTempList[$c][4])=1 then
				$stringY &= $aTempList[$c][0]&@CRLF
			EndIf

			if $aTempList[$c][6]<>"" then
				$stringC &= $aTempList[$c][0]&@CRLF
			EndIf
		Next
		$stringP = StringTrimRight($stringP, 2)
		$stringY = StringTrimRight($stringY, 2)
		$stringC = StringTrimRight($stringC, 2)

		$aTempFilesP = StringSplit($stringP, @CRLF, 3)
		$aTempFilesY = StringSplit($stringY, @CRLF, 3)
		$aTempFilesC = StringSplit($stringC, @CRLF, 3)

		if $nArraySizeN < UBound($aTempFilesN) then $nArraySizeN = UBound($aTempFilesN) ; Se o sistema atual tiver mais itens que o array, aumenta o array...
		ReDim $aRomName[$f-1][$nArraySizeN] ; ...do nome das roms
		ReDim $aRomTitl[$f-1][$nArraySizeN] ; ...do title das roms
		$aSysData[$f-1][0] = UBound($aTempFilesN) ; guarda a quantidade de itens total no inicio da row do sistema na array de dados
		_ArrayAdd($aRomName, _ArrayToString($aTempFilesN)) ; adiciona os items coletados à row do sistema na array de Roms
		_ArrayAdd($aRomTitl, _ArrayToString($aTempFilesT)) ; adiciona os items coletados à row do sistema na array de Titles

		if $nArraySizeP < UBound($aTempFilesP) then $nArraySizeP = UBound($aTempFilesP) ; Se o sistema atual tiver mais itens que o array, aumenta o array
		ReDim $aRomPubl[$f-1][$nArraySizeP]
		_ArrayAdd($aRomPubl, _ArrayToString($aTempFilesP))
		$aSysData[$f-1][17] = UBound($aTempFilesP) ; guarda quantidade de Have na array de dados
		$aSysData[$f-1][18] = $aSysData[$f-1][0] - $aSysData[$f-1][17] ; guarda quantidade de Missing na array de dados
		$aSysData[$f-1][19] = int($aSysData[$f-1][17] * 100 / $aSysData[$f-1][0]) ; guarda Percentual na array de dados

		if $nArraySizeY < UBound($aTempFilesY) then $nArraySizeY = UBound($aTempFilesY) ; Se o sistema atual tiver mais itens que o array, aumenta o array
		ReDim $aRomYear[$f-1][$nArraySizeY]
		_ArrayAdd($aRomYear, _ArrayToString($aTempFilesY))
		$aSysData[$f-1][21] = UBound($aTempFilesY)
		$aSysData[$f-1][22] = $aSysData[$f-1][0] - $aSysData[$f-1][21]
		$aSysData[$f-1][23] = int($aSysData[$f-1][21] * 100 / $aSysData[$f-1][0])

		if $nArraySizeC < UBound($aTempFilesC) then $nArraySizeC = UBound($aTempFilesC) ; Se o sistema atual tiver mais itens que o array, aumenta o array
		ReDim $aRomCtgr[$f-1][$nArraySizeC]
		_ArrayAdd($aRomCtgr, _ArrayToString($aTempFilesC))
		$aSysData[$f-1][25] = UBound($aTempFilesC)
		$aSysData[$f-1][26] = $aSysData[$f-1][0] - $aSysData[$f-1][25]
		$aSysData[$f-1][27] = int($aSysData[$f-1][25] * 100 / $aSysData[$f-1][0])
	Next
EndFunc

Func GetFiles()
	Dim $aRomRoms[0][0], $aRomSnps[0][0], $aRomFlrs[0][0], $aRomOvrv[0][0]
	Local $nArraySizeR = 0, $nArraySizeS = 0, $nArraySizeF = 0, $nArraySizeO = 0

	for $f = 1 to UBound($aRomLists)-1 ; Procura todos os sistemas

		$prog = Int($f/(UBound($aRomLists))*100)

		$sTempWild = StringReplace($aSysCfg[$f-1][1],".","*.")
		_PopulateFiles($aRomRoms, $nArraySizeR, $sTempWild, $f, 2, 1)

		_PopulateFiles($aRomSnps, $nArraySizeS, "*.jpg;*.jpeg;*.png;*.gif;*.bmp;*.tga", $f, 3, 5)

		_PopulateFiles($aRomFlrs, $nArraySizeF, "*.jpg;*.jpeg;*.png;*.gif;*.bmp;*.tga", $f, 4, 9)

		$sOvrvExt = "*.cfg"
		if _IsChecked($_cAMv) Then $sOvrvExt = "*.txt"
		_PopulateFiles($aRomOvrv, $nArraySizeO, $sOvrvExt, $f, 5, 13)

	Next
EndFunc

Func _PopulateFiles(ByRef $aTempFilesC, ByRef $nArraySize, $sWildCard, $nSys, $nType, $nStat) ; Array to fill, Size variable to change, wildcard, system number,
																							  ; Type(0 Name, 1 rom ext, 2 rom path, 3 snap path, 4 flyer path 5 ovrv path),
																							  ; Statistic (1 rom, 5 snap, 9 flyer, 13 overview, 17 publishers, 21 year, 25 category)
		Dim $aTempFilesB[0], $aTempSizeM[0], $aTempSizeL[0] ; Array para todos os arquivos; Array para Missing; Array para Left
		$aTempPath = StringSplit($aSysCfg[$nSys-1][$nType],";",2) ; Cria array com as pastas dos arquivos
		for $c=0 to UBound($aTempPath)-1 ; Procura em todas as pastas
			$aTempFilesA = _FileListToArrayMultiSelect($aTempPath[$c], $sWildCard, ";", 0,1) ; Faz array com os arquivos da pasta
			_ArrayConcatenate($aTempFilesB,$aTempFilesA,1) ; Adiciona a array atual à Array com todos os arquivos
		Next
		_ArraySort($aTempFilesB) ; Coloca os arquivos em ordem

		if $nArraySize < UBound($aTempFilesB) then $nArraySize = UBound($aTempFilesB) ; Se o systema atual tiver mais itens que o array, aumenta o array
		ReDim $aTempFilesC[$nSys-1][$nArraySize]
		_ArrayAdd($aTempFilesC, _ArrayToString($aTempFilesB)) ;  Adiciona array com todos os arquivos do systema atual à array de todos os systemas

		$aSysData[$nSys-1][$nStat] = UBound($aTempFilesB) ; Have - guarda quantidade de arquivos

		$aTempSizeM = CompareLists($aTempFilesB, $nSys-1, 0, int(($nStat+3)/4)) ; Missing - faz array com arquivos que faltam
		$aSysData[$nSys-1][$nStat+1] = UBound($aTempSizeM) ; Missing - guarda quantidade de arquivos


		$aTempSizeL = CompareLists($aTempFilesB, $nSys-1, 1, int(($nStat+3)/4)) ; Left - faz array com arquivos sobrando
		$aSysData[$nSys-1][$nStat+3] = UBound($aTempSizeL) ; Left - guarda quantidade de arquivos

		$aSysData[$nSys-1][$nStat+2] = int(($aSysData[$nSys-1][0]-$aSysData[$nSys-1][$nStat+1]) * 100 / $aSysData[$nSys-1][0]) ; Percent - calcula e grarda

EndFunc

Func ShowData()
	$sCurSys = $aSysCfg[$nCurSys][0]

	$nTotP = 0
	for $f = 3 to 27 Step 4
		$nTotP += $aSysData[$nCurSys][$f]
	Next
	$nTotP = Int($nTotP/7)
	GUICtrlSetData($_TPbox, $nTotP)

	Dim $aColor[3]
	$aColor[0] = _Min(Abs($nTotP-100)*2, 100)*1.8
	$aColor[1] = _Min($nTotP*2, 100)*1.8
	$aColor[2] = 0
	$cColor = _ColorSetRGB($aColor)
	GUICtrlSetBkColor($_ePbar, $cColor)
	GUICtrlSetColor($_TPbox, $cColor)

	GUICtrlSetData($_lSysName, $sCurSys)
	GUICtrlSetPos($_ePbar, 640-($nTotP*3.6),70,$nTotP*3.6,18)
	GUICtrlSetPos($_rPbar, 640-($aSysData[$nCurSys][3]*3.6),92,$aSysData[$nCurSys][3]*3.6,18)
	GUICtrlSetPos($_sPbar, 640-($aSysData[$nCurSys][7]*3.6),114,$aSysData[$nCurSys][7]*3.6,18)
	GUICtrlSetPos($_fPbar, 640-($aSysData[$nCurSys][11]*3.6),136,$aSysData[$nCurSys][11]*3.6,18)
	GUICtrlSetPos($_oPbar, 640-($aSysData[$nCurSys][15]*3.6),158,$aSysData[$nCurSys][15]*3.6,18)
	GUICtrlSetPos($_pPbar, 640-($aSysData[$nCurSys][19]*3.6),180,$aSysData[$nCurSys][19]*3.6,18)
	GUICtrlSetPos($_yPbar, 640-($aSysData[$nCurSys][23]*3.6),202,$aSysData[$nCurSys][23]*3.6,18)
	GUICtrlSetPos($_cPbar, 640-($aSysData[$nCurSys][27]*3.6),224,$aSysData[$nCurSys][27]*3.6,18)
	GUICtrlSetData($_eHbox, $aSysData[$nCurSys][0])
	GUICtrlSetData($_rHbox, $aSysData[$nCurSys][1])
	GUICtrlSetData($_rMbox, $aSysData[$nCurSys][2])
	GUICtrlSetData($_rPbox, $aSysData[$nCurSys][3])
	GUICtrlSetData($_rLbox, $aSysData[$nCurSys][4])
	GUICtrlSetData($_sHbox, $aSysData[$nCurSys][5])
	GUICtrlSetData($_sMbox, $aSysData[$nCurSys][6])
	GUICtrlSetData($_sPbox, $aSysData[$nCurSys][7])
	GUICtrlSetData($_sLbox, $aSysData[$nCurSys][8])
	GUICtrlSetData($_fHbox, $aSysData[$nCurSys][9])
	GUICtrlSetData($_fMbox, $aSysData[$nCurSys][10])
	GUICtrlSetData($_fPbox, $aSysData[$nCurSys][11])
	GUICtrlSetData($_fLbox, $aSysData[$nCurSys][12])
	GUICtrlSetData($_oHbox, $aSysData[$nCurSys][13])
	GUICtrlSetData($_oMbox, $aSysData[$nCurSys][14])
	GUICtrlSetData($_oPbox, $aSysData[$nCurSys][15])
	GUICtrlSetData($_oLbox, $aSysData[$nCurSys][16])
	GUICtrlSetData($_pHbox, $aSysData[$nCurSys][17])
	GUICtrlSetData($_pMbox, $aSysData[$nCurSys][18])
	GUICtrlSetData($_pPbox, $aSysData[$nCurSys][19])
	GUICtrlSetData($_yHbox, $aSysData[$nCurSys][21])
	GUICtrlSetData($_yMbox, $aSysData[$nCurSys][22])
	GUICtrlSetData($_yPbox, $aSysData[$nCurSys][23])
	GUICtrlSetData($_cHbox, $aSysData[$nCurSys][25])
	GUICtrlSetData($_cMbox, $aSysData[$nCurSys][26])
	GUICtrlSetData($_cPbox, $aSysData[$nCurSys][27])

	$bSeta = False
EndFunc

Func ShowList()
	if Int(($nMsg[0]-39)/8) = 2 Then
		ToolTip("Percent has no list")
		Sleep(500)
		ToolTip("")
		Return
	EndIf
	if GUICtrlRead($nMsg[0]) = 0 Then
		ToolTip("No items")
		Sleep(500)
		ToolTip("")
		Return
	EndIf
	if $nListForm > 9 Then
		ToolTip("Too many lists")
		Sleep(500)
		ToolTip("")
		Return
	EndIf

	Dim $aTempShowL[0][0], $aTempShowL1D[0];, $aRomName1D[0]
	if Mod($nMsg[0]-39,8) = 0 Then $aTempShowL = $aRomName
	if Mod($nMsg[0]-39,8) = 1 Then $aTempShowL = $aRomRoms
	if Mod($nMsg[0]-39,8) = 2 Then $aTempShowL = $aRomSnps
	if Mod($nMsg[0]-39,8) = 3 Then $aTempShowL = $aRomFlrs
	if Mod($nMsg[0]-39,8) = 4 Then $aTempShowL = $aRomOvrv
	if Mod($nMsg[0]-39,8) = 5 Then $aTempShowL = $aRomPubl
	if Mod($nMsg[0]-39,8) = 6 Then $aTempShowL = $aRomYear
	if Mod($nMsg[0]-39,8) = 7 Then $aTempShowL = $aRomCtgr

	$nNumItensIdx = _Max(Mod($nMsg[0]-39,8)*4-3,0)
	$nNumItens = $aSysData[$nCurSys][$nNumItensIdx]
	$sString = _ArrayToString($aTempShowL,"|",$nCurSys,$nCurSys,"|",0,$nNumItens-1)
	$aTempShowL1D = StringSplit($sString, "|",2)

	ProgressOn("Searching","", "", -1, -1, BitOR($DLG_NOTONTOP, $DLG_MOVEABLE))
	$prog = 100
	if Int(($nMsg[0]-39)/8) = 1 then
		$aTempShowL1D = CompareLists($aTempShowL1D, $nCurSys, 0, Mod($nMsg[0]-39,8))
	EndIf
	if Int(($nMsg[0]-39)/8) = 3 then
		$aTempShowL1D = CompareLists($aTempShowL1D, $nCurSys, 1, Mod($nMsg[0]-39,8))
	EndIf
	ProgressOff()

	$nNumItens = UBound($aTempShowL1D)

	$_fDisplayList[$nListForm] = GUICreate($aSysCFG[$nCurSys][0], 321, 513,-1,-1, BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_TABSTOP,$WS_EX_MDICHILD))

	GUICtrlCreateLabel($aListHave[Int(($nMsg[0]-39)/8)]&" "&$aListType[Mod($nMsg[0]-39,8)], 8, 16, 230, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKTOP+$GUI_DOCKHCENTER+$GUI_DOCKVCENTER+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
	GUICtrlCreateLabel($nNumItens & " items", 237, 16, 68, 17, $SS_RIGHT)
	GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKTOP+$GUI_DOCKHCENTER+$GUI_DOCKVCENTER+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
	$LSglist = GUICtrlCreateList("", 8, 38, 297, 420, BitOR($LBS_NOTIFY,$WS_VSCROLL))
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKTOP+$GUI_DOCKHCENTER+$GUI_DOCKVCENTER+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
	$_bCShowTitles[$nListForm] = GUICtrlCreateButton("Show Titles", 231, 475, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKHCENTER+$GUI_DOCKVCENTER+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
	$_bExportList[$nListForm] = GUICtrlCreateButton("Export", 88, 475, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKBOTTOM+$GUI_DOCKHCENTER+$GUI_DOCKVCENTER+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
	$_bCopyList[$nListForm] = GUICtrlCreateButton("Copy", 8, 475, 75, 25)
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKBOTTOM+$GUI_DOCKHCENTER+$GUI_DOCKVCENTER+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)

	; Cria array com informação sobre a lista atual - $nListForm
	$aArrayListShown[$nListForm][0] = $aTempShowL1D ; array com itens exibidos
	$aArrayListShown[$nListForm][1] = $aSysCFG[$nCurSys][0] ; nome do sistema
	$aArrayListShown[$nListForm][2] = $aListType[Mod($nMsg[0]-39,8)] ; tipo - List Entries, Roms, Snaps, Flyers, Overviews, Publishers, Year, Category
	$aArrayListShown[$nListForm][3] = $aListHave[Int(($nMsg[0]-39)/8)] ; stat - Have, Missing, Percent, Left
	$aArrayListShown[$nListForm][4] = $nCurSys ; numero do sistema

	if $aArrayListShown[$nListForm][3] = "Left" Then GUICtrlSetState($_bCShowTitles[$nListForm], $GUI_DISABLE) ; se a lista for de Left, disabilita o botão de Show Title

	$sString =  _ArrayToString($aTempShowL1D, "|")
	GuiCtrlSetData($LSglist, $sString)

	$nListForm += 1
	GUISetState(@SW_SHOW)
EndFunc

Func CompareLists($aArrayA, $nCurSys, $nMetod, $nStat) ; Array(1D) Array a ser comparada, systema atual, Metodo (0) acha faltando (1) acha sobrando, qual info (snap, flyer...)

	$nNumItensRom = $aSysData[$nCurSys][0] ; pega o numero de roms do sistema atual

	$sString = _ArrayToString($aRomName,@CRLF, $nCurSys, $nCurSys, @CRLF, 0, $nNumItensRom-1)
	$aRomName1D = StringSplit($sString, @CRLF, 3)

	$sTitle = "Finding Missing "&$aListType[$nStat]
	if $nMetod = 1 Then $sTitle = "Finding Left "&$aListType[$nStat]

	ProgressSet($prog, $sTitle, $aSysCfg[$nCurSys][0])

;~ 	$t = TimerInit()
	_ArraySort($aArrayA)
	_ArraySort($aRomName1D)

	if $nMetod = 0 Then
		$stringN = ""
		Dim $aMontaN[0]
		For $b = 0 To UBound($aRomName1D) - 1
			$nIdx = _ArrayBinarySearch($aArrayA, $aRomName1D[$b])
			if @error Then
				$stringN &= $aRomName1D[$b]&@CRLF
			EndIf
		Next
		if $stringN <> "" Then
			$stringN = StringTrimRight($stringN,2)
			$aMontaN = StringSplit($stringN, @CRLF, 3)
		EndIf
	else
		$stringA = ""
		Dim $aMontaA[0]
		For $b = 0 To UBound($aArrayA) - 1
			$nIdx = _ArrayBinarySearch($aRomName1D, $aArrayA[$b])
			if @error Then
				$stringA &= $aArrayA[$b]&@CRLF
			EndIf
		Next
		if $stringA <> "" Then
			$stringA = StringTrimRight($stringA,2)
			$aMontaA = StringSplit($stringA, @CRLF, 3)
		EndIf
	EndIf
;~ 	ConsoleWrite("Cmp - "&TimerDiff($t)&@CRLF)

	if $nMetod = 0 Then
		Return $aMontaN
	Else
		Return $aMontaA
	EndIf
EndFunc

Func ListSelect()
	$sSelSys = GUICtrlRead($_lsSystems)
	if $sSelSys = $sCurSys Then Return
	$nCurSys = _ArraySearch($aSysCfg, $sSelSys)

	if WinExists("Config information") Then
		ShowSysInfo()
	EndIf
EndFunc

Func SysInfo()
	GUICtrlSetState($_bSysinfo ,$GUI_DISABLE)

	$_fSysInfo = GUICreate("Config information", 450, 300,-1,-1, BitOR($GUI_SS_DEFAULT_GUI,$WS_MAXIMIZEBOX,$WS_SIZEBOX,$WS_THICKFRAME,$WS_TABSTOP,$WS_EX_MDICHILD))
	$lSysCfgLabel = GUICtrlCreateLabel($aSysCFG[$nCurSys][0], 8, 16, 230, 17)
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKTOP+$GUI_DOCKHCENTER+$GUI_DOCKVCENTER+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
	GUICtrlSetFont(-1, 10, 700, 0, "MS Sans Serif")
	$_lbSysConfig = GUICtrlCreateEdit("", 8, 38, 434, 254, BitOR($LBS_NOTIFY,$WS_VSCROLL,$ES_RIGHT,$ES_READONLY, $ES_NOHIDESEL))
	GUICtrlSetBkColor(-1,0xFFFFFF)
	GUICtrlSetResizing(-1, $GUI_DOCKLEFT+$GUI_DOCKRIGHT+$GUI_DOCKBOTTOM+$GUI_DOCKTOP+$GUI_DOCKHCENTER+$GUI_DOCKVCENTER+$GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)

	ShowSysInfo()

	GUISetState(@SW_SHOW)
EndFunc

Func ShowSysInfo()
	GuiCtrlSetData($lSysCfgLabel, $aSysCFG[$nCurSys][0])
	_GUICtrlListBox_ResetContent($_lbSysConfig)
;~ 	$sString = _ArrayToString($aSysCfg,"|",$nCurSys,$nCurSys)

	$sString = ""
	for $f = 1 to 5
		$sString &= $aCfgNames[$f] & @CRLF
		$sString &= StringReplace($aSysCfg[$nCurSys][$f], ";", @CRLF) &  @CRLF
		$sString &= @CRLF
	Next

	$sString = StringTrimRight($sString, 2)
	GuiCtrlSetData($_lbSysConfig, $sString)
	Return

;~ 	$aString = StringSplit($sString,"|")
;~ 	For $f = 2 to 6
;~ 		GuiCtrlSetData($_lbSysConfig, $aCfgNames[$f-1])
;~ 		GuiCtrlSetData($_lbSysConfig, StringReplace($aString[$f],";","|"))
;~ 		GuiCtrlSetData($_lbSysConfig, " |")
;~ 	Next
EndFunc

Func ShowTitles() ; Apagar o que achou pra mostrar corretamente o segundo Title de uma rom repetida na lista

	; Pega informações da array sobre a lista atual - $i do While principal
	$aTempNam = $aArrayListShown[$i][0] ; array com itens exibidos
	$sTempSys = $aArrayListShown[$i][1] ; nome do sistema
	$sTempTyp = $aArrayListShown[$i][2] ; tipo - List Entries, Roms, Snaps, Flyers, Overviews, Publishers, Year, Category
	$sTempSta = $aArrayListShown[$i][3] ; stat - Have, Missing, Percent, Left
	$nTempSys = $aArrayListShown[$i][4] ; número do sistema
	$nNumItensRom = $aSysData[$nTempSys][0] ; pega o numero de roms do sistema atual

	ProgressOn("Searching","", "", -1, -1, BitOR($DLG_NOTONTOP, $DLG_MOVEABLE))
	ProgressSet(100, $sTempSta&" "&$sTempTyp, $aSysCfg[$nCurSys][0])

	$t = TimerInit()
	$tt = TimerInit()
	ConsoleWrite(@CRLF)

	$aRomName2D = _ArrayExtract($aRomName, $nTempSys, $nTempSys, -1, $nNumItensRom-1)
	$aRomTitl1D = _ArrayExtract($aRomTitl, $nTempSys, $nTempSys, -1, $nNumItensRom-1)

	_ArrayAdd($aRomName2D, _ArrayToString($aRomTitl1D))
	_ArrayTranspose($aRomName2D)
	_ArraySort($aRomName2D)

	ConsoleWrite("Prep - "&TimerDiff($t)&@CRLF)

	$t = TimerInit()
	Dim $aTitles[UBound($aTempNam)][2]
	for $f = 0 to UBound($aTempNam)-1
		$nTempInd = _ArrayBinarySearch($aRomName2D, $aTempNam[$f])
		if not @Error Then
			$aTitles[$f][0] = $aRomName2D[$nTempInd][0]
			$aTitles[$f][1] = $aRomName2D[$nTempInd][1]
		EndIf
	next
	ConsoleWrite("Srch - "&TimerDiff($t)&@CRLF)
	ConsoleWrite("totl - "&TimerDiff($tt)&@CRLF)

	ProgressOff()

	_ArrayDisplay($aTitles, $sTempSys&" "&$sTempSta&" "&$sTempTyp, "", 64, Default, "Name|Title")
EndFunc

Func Delete() ; Not using for now
	if UBound($aRomLists)-1 < 1 then return
	$nButton = MsgBox(4,"Delete System", "Do you really wish to delete "&$aSysCfg[$nCurSys][0]&@CRLF&"from AMLS ?")
	if $nButton = 7 Then Return
	_ArrayDelete($aSysCfg, $nCurSys)
	_ArrayDelete($aSysData, $nCurSys)
	_ArrayDelete($aRomLists, $nCurSys+1)
	_ArrayDelete($aRomName, $nCurSys)
	_ArrayDelete($aRomPubl, $nCurSys)
	_ArrayDelete($aRomYear, $nCurSys)
	_ArrayDelete($aRomCtgr, $nCurSys)
	_ArrayDelete($aRomRoms, $nCurSys)
	_ArrayDelete($aRomSnps, $nCurSys)
	_ArrayDelete($aRomFlrs, $nCurSys)
	_ArrayDelete($aRomOvrv, $nCurSys)
	$aRomLists[0] -= 1
	_GUICtrlListBox_ResetContent($_lsSystems)
	for $f=1 to UBound($aRomLists)-1
		GUICtrlSetData($_lsSystems,$aSysCfg[$f-1][0])
	Next
	$bModified = True
	GUICtrlSetState($_bSave ,$GUI_ENABLE)
	ControlCommand($_fStatis, "", $_lsSystems, "SetCurrentSelection", 0)
	If $aRomLists[0] = 0 Then
		 Dim $aSysCfg[1][6] = [["None","","","","",""]], $aSysData[1][28] = [[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]
		 ShowData()
		 Dim $aSysCfg[0][6], $aSysData[0][28]
	EndIf
EndFunc

Func Quit()
	if $bModified Then
		$nButton = MsgBox(3,"Save Data", "There seems to be unsaved data"&@CRLF&"Do you wish to save?")
		if $nButton = 6 then
			Save()
		ElseIf $nButton = 2 then
			Return
		EndIf
	EndIf
	IniWrite("Data\AMLS.ini", "Paths", "Attract Mode", $amPath)
	IniWrite("Data\AMLS.ini", "Checks", "AM v24 Mode", $nAMv)
	Exit
EndFunc

Func Save()
	_FileWriteFromArray("Data\SysCfg"&$sFExt, $aSysCfg)
	_FileWriteFromArray("Data\SysData"&$sFExt, $aSysData)
	_FileWriteFromArray("Data\RomLists"&$sFExt, $aRomLists)
	_FileWriteFromArray("Data\RomName"&$sFExt, $aRomName)
	_FileWriteFromArray("Data\RomTitl"&$sFExt, $aRomTitl)
	_FileWriteFromArray("Data\RomPubl"&$sFExt, $aRomPubl)
	_FileWriteFromArray("Data\RomYear"&$sFExt, $aRomYear)
	_FileWriteFromArray("Data\RomCtgr"&$sFExt, $aRomCtgr)
	_FileWriteFromArray("Data\RomRoms"&$sFExt, $aRomRoms)
	_FileWriteFromArray("Data\RomSnps"&$sFExt, $aRomSnps)
	_FileWriteFromArray("Data\RomFlrs"&$sFExt, $aRomFlrs)
	_FileWriteFromArray("Data\RomOvrv"&$sFExt, $aRomOvrv)
	$bModified = false
	GUICtrlSetState($_bSave ,$GUI_DISABLE)
	$sDataDate = FileGetTime("Data\SysData"&$sFExt)
	if not @error Then
		$sDataDate = _ArrayToString($sDataDate,"/",0,2)&" "&_ArrayToString($sDataDate,":",3,5)
		GUICtrlSetData($_lDataDate, "Last save: "&$sDataDate)
	EndIf
EndFunc

Func _FileListToArrayMultiSelect($dir, $searchlist, $Separator, $iFlag = 0, $iExt = 0)
	Local $FileList[1] = [0], $Filelist1, $iN, $Num, $search

	$search = StringSplit($searchlist, $Separator)
	If $search[0] > 0 Then
		For $iN = 1 To $search[0]
			$Filelist1 = _FileListToArray($dir, $search[$iN], $iFlag)
			If Not @error Then
				$Num = UBound($FileList)
				_ArrayConcatenate($FileList, $Filelist1)
				$FileList[0] = $FileList[0] + $FileList[$Num]
				_ArrayDelete($FileList, $Num)
			EndIf
		Next
		if $iExt = 1 Then
			For $i = 1 to UBound($FileList) - 1
				$iPos = StringInStr($FileList[$i], ".", 0, -1) - 1
				$sNuString = StringMid($FileList[$i], 1, $iPos)
				$FileList[$i] = $sNuString
			Next
		EndIf
	EndIf
	Return $FileList;could be [0]

EndFunc;==>_FileListToArrayMultiSelect

Func _Mod($value1, $value2)
    Return Abs(Mod(Mod($value1,$value2)+$value2,$value2))
EndFunc

Func _ArrayAdd2(ByRef $avArray, $vValue, $x, $y) ; Sem uso (ficou para referencia)
    If $x > UBound($avArray)-1 Then
        ReDim $avArray[$x+1][UBound($avArray, 2)]
    EndIf
    If $y > UBound($avArray, 2)-1 Then
        ReDim $avArray[UBound($avArray)][$y+1]
    EndIf
    $avArray[$x][$y] = $vValue
    Return True
EndFunc

Func _IsChecked($idControlID)
	Return BitAND(GUICtrlRead($idControlID), $GUI_CHECKED) = $GUI_CHECKED
EndFunc   ;==>_IsChecked