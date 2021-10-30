Attribute VB_Name = "globfunctions"
'Program: sheetweavingspecs.exe
'Program Author: Latish Sherigar
'emailid: latishsherigar@ yahoo.co.in
'website:http://www.geocities.com/latishsherigar


Option Explicit

Public trialexpired As Boolean
Public cmdg As New clsCommonDialog
Dim m_fso As New FileSystemObject
Public g_workareapath As String
Public excelfilename As String
Public objexcelapp As Excel.Application
Public objexcelsht As Excel.Worksheet
Public fileprocessingerror As Boolean
Public formheight As Integer
Public stopthejob As Boolean
Public g_productexists As Boolean

Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Const LB_SETHORIZONTALEXTENT = &H194

'Titlebar info
Public Declare Function GetTitleBarInfo Lib "user32.dll" (ByVal hwnd As Long, ByRef pti As TITLEBARINFO) As Long

'Titlebar information
Public Const STATE_SYSTEM_FOCUSABLE = &H100000
Public Const STATE_SYSTEM_INVISIBLE = &H8000
Public Const STATE_SYSTEM_OFFSCREEN = &H10000
Public Const STATE_SYSTEM_UNAVAILABLE = &H1
Public Const STATE_SYSTEM_PRESSED = &H8
Public Const CCHILDREN_TITLEBAR = 5

'titlebarinfo
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

Private Type TITLEBARINFO
    cbSize As Long
    rcTitleBar As RECT
    rgstate(CCHILDREN_TITLEBAR) As Long
End Type

Public TitleInfo As TITLEBARINFO

Public Declare Function InitCommonControls Lib "comctl32.dll" () As Long
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long

Public Const makespecificationsheetname As String = "make specification sheet weaving"
'Public Const Blendingnsheetname As String = "blending"
Public Const pickingandmendingsheetname As String = "picking and mending"
Public Const scouringandmillingdatasheetname As String = "scouring and milling data"
Public Const weavingdatasheetname As String = "weavingdata"


Public g_makespecificationsheetpath As String
'Public g_Blendingnsheetpath As String
Public g_pickingandmendingsheetpath As String
Public g_scouringandmillingdatasheetpath As String
Public g_weavingdatasheetpath As String

Public g_editproduct As Boolean

Public g_qualityname As String
Public g_colored As String
Public g_warp As String
Public g_weft As String
Public g_warpkilos As String
Public g_weftkilos As String
Public g_greasylength As String
Public g_weavinglength As String
Public g_PPI As String
Public g_kilosperpiece As String
Public g_costofquality As String
Public g_pickingandmendinghrs As String
Public g_pickingandmendingmetres As String
Public g_scouringandmillingfinish As String

Public Enum CommandList
 Save = 1
 FindProduct = 2
End Enum

Public PresentCommand As CommandList

Public Function createexcelfiles() As Boolean
createexcelfiles = True
If Not m_fso.FileExists(g_makespecificationsheetpath) Then
 If MsgBox("The excel file '" & g_makespecificationsheetpath & "' doesnot exists!.Do you want to create a new one (The program cannot proceed without one) ?", vbExclamation + vbYesNo, "File not found error") = vbNo Then
  createexcelfiles = False
  Exit Function
 Else
  createtheexcelfile (makespecificationsheetname)
 End If
End If

If Not m_fso.FileExists(g_pickingandmendingsheetpath) Then
 If MsgBox("The excel file '" & g_pickingandmendingsheetpath & "' doesnot exists!.Do you want to create a new one (The program cannot proceed without one) ?", vbExclamation + vbYesNo, "File not found error") = vbNo Then
  createexcelfiles = False
  Exit Function
 Else
  createtheexcelfile (pickingandmendingsheetname)
 End If
End If


If Not m_fso.FileExists(g_scouringandmillingdatasheetpath) Then
 If MsgBox("The excel file '" & g_scouringandmillingdatasheetpath & "' doesnot exists!.Do you want to create a new one (The program cannot proceed without one) ?", vbExclamation + vbYesNo, "File not found error") = vbNo Then
  createexcelfiles = False
  Exit Function
 Else
  createtheexcelfile (scouringandmillingdatasheetname)
 End If
End If

If Not m_fso.FileExists(g_weavingdatasheetpath) Then
 If MsgBox("The excel file '" & g_weavingdatasheetpath & "' doesnot exists!.Do you want to create a new one (The program cannot proceed without one) ?", vbExclamation + vbYesNo, "File not found error") = vbNo Then
  createexcelfiles = False
  Exit Function
 Else
  createtheexcelfile (weavingdatasheetname)
 End If
End If

End Function

Public Function init()
Call readinfofromreg
Call setexcelfilepaths
End Function

Public Function saveinfo2reg()
'On Error Resume Next
Call SaveSetting("xlsdatadistrb", "settings", "workarea", g_workareapath)
End Function

Public Function readinfofromreg()
'On Error Resume Next
g_workareapath = GetSetting("xlsdatadistrb", "settings", "workarea")
End Function



Public Function setexcelfilepaths()
g_makespecificationsheetpath = g_workareapath & makespecificationsheetname & ".xls"
'g_Blendingnsheetpath = g_workareapath & Blendingnsheetname & ".xls"
g_pickingandmendingsheetpath = g_workareapath & pickingandmendingsheetname & ".xls"
g_scouringandmillingdatasheetpath = g_workareapath & scouringandmillingdatasheetname & ".xls"
g_weavingdatasheetpath = g_workareapath & weavingdatasheetname & ".xls"
End Function

Public Function reset()
On Error Resume Next
Call quitexcel
Set objexcelapp = Nothing
Set objexcelsht = Nothing
End Function


Public Function startexcel() As Boolean
 On Error GoTo errhnd:
 Set objexcelapp = New Excel.Application
 DoEvents
 objexcelapp.Visible = False
 startexcel = True
 Exit Function
errhnd:
 startexcel = False
End Function


Public Function quitexcel()
On Error Resume Next
 objexcelapp.Workbooks(1).Close (True)
 objexcelapp.Quit
 Set objexcelsht = Nothing
 Set objexcelapp = Nothing
End Function


Public Function GetFileTitle(strfilepath As String) As String
On Error Resume Next
    
    Dim pointer As Integer
    pointer = InStrRev(strfilepath, "\", , vbBinaryCompare)
    
    GetFileTitle = Right(strfilepath, Len(strfilepath) - pointer)
End Function

Public Function createtheexcelfile(excelfilename) As Boolean
 Call m_fso.CopyFile(App.Path & "\templates\" & excelfilename & ".bak", g_workareapath & excelfilename & ".xls", True)
End Function



Public Function showexcelfile(FileName As String)
On Error Resume Next

Err.Clear

Set objexcelapp = GetObject(, "Excel.Application")
If Err.Number <> 0 Then
   Err.Clear
   Set objexcelapp = CreateObject("Excel.Application")
End If

objexcelapp.Workbooks.Open (excelfilename)
objexcelapp.Visible = True

End Function



Public Function gettitlebarlength(form_hwnd As Long) As Integer
    
    'Initialize structure
    TitleInfo.cbSize = Len(TitleInfo)
    'Retrieve information about the title bar of this window
    GetTitleBarInfo form_hwnd, TitleInfo
    'return the titlebar length
    gettitlebarlength = TitleInfo.rcTitleBar.Bottom - TitleInfo.rcTitleBar.Top

End Function

Public Function savedata() As Boolean
If createexcelfiles Then
 Call savemakespecificationsheetdata
 Call savepickingandmendingsheetdata
 Call savescouringandmillingsheetdata
 Call saveweavingdatasheetdata
End If
End Function

Public Function savemakespecificationsheetdata()
Dim rowno As Long

If Not openexcelsheet(g_makespecificationsheetpath) Then Exit Function
Call findquality(g_qualityname, rowno)
objexcelsht.Cells(rowno, 1) = g_qualityname
objexcelsht.Cells(rowno, 7) = g_warpkilos
objexcelsht.Cells(rowno, 9) = g_weftkilos
objexcelsht.Cells(rowno, 12) = g_greasylength
objexcelsht.Cells(rowno, 14) = g_colored
objexcelsht.Cells(rowno, 15) = g_warp
objexcelsht.Cells(rowno, 16) = g_weft
objexcelsht.Range("A2").Sort objexcelsht.Columns("A"), Header:=xlGuess
objexcelapp.Workbooks(1).Save
objexcelapp.Workbooks(1).Close
End Function

Public Function savepickingandmendingsheetdata()
Dim rowno As Long

If Not openexcelsheet(g_pickingandmendingsheetpath) Then Exit Function
Call findquality(g_qualityname, rowno)
objexcelsht.Cells(rowno, 1) = g_qualityname
objexcelsht.Cells(rowno, 2) = g_pickingandmendinghrs
objexcelsht.Cells(rowno, 4) = g_pickingandmendingmetres
objexcelsht.Range("E" & rowno - 1).Copy objexcelsht.Range("E" & rowno)
objexcelsht.Range("A4").Sort objexcelsht.Columns("A"), Header:=xlGuess
objexcelapp.Workbooks(1).Save
objexcelapp.Workbooks(1).Close
End Function

Public Function savescouringandmillingsheetdata()
Dim rowno As Long

If Not openexcelsheet(g_scouringandmillingdatasheetpath, 1) Then Exit Function
Call findquality(g_qualityname, rowno)
objexcelsht.Cells(rowno, 4) = g_qualityname
objexcelsht.Cells(rowno, 5) = g_scouringandmillingfinish
objexcelsht.Range("D5").Sort objexcelsht.Columns("D"), Header:=xlGuess
objexcelapp.Workbooks(1).Save
objexcelapp.Workbooks(1).Close
End Function

Public Function saveweavingdatasheetdata()
Dim rowno As Long
Dim i As Integer
If Not openexcelsheet(g_weavingdatasheetpath, 1) Then Exit Function
Call findquality(g_qualityname, rowno)
objexcelsht.Cells(rowno, 1) = g_qualityname
objexcelsht.Cells(rowno, 2) = g_kilosperpiece
objexcelsht.Cells(rowno, 3) = g_weavinglength
objexcelsht.Cells(rowno, 4) = g_warpkilos
objexcelsht.Cells(rowno, 5) = g_weftkilos
objexcelsht.Cells(rowno, 8) = g_PPI
objexcelsht.Range("A4").Sort objexcelsht.Columns("A"), Header:=xlGuess
objexcelapp.Workbooks(1).Save
objexcelapp.Workbooks(1).Close


If Not openexcelsheet(g_weavingdatasheetpath, 2) Then Exit Function
Call findquality(g_qualityname, rowno)
objexcelsht.Cells(rowno, 1) = g_qualityname

'put X mark in all the cells of the row
For i = 3 To 27
 objexcelsht.Cells(rowno, i) = "X"
Next

For i = 1 To frmmain.fgloom.Rows - 1
 If Val(frmmain.fgloom.TextMatrix(i, 2)) <> 0 Then
   objexcelsht.Cells(rowno, frmmain.fgloom.TextMatrix(i, 2) + 2) = frmmain.fgloom.TextMatrix(i, 3)
 End If
Next

objexcelsht.Range("A2").Sort objexcelsht.Columns("A"), Header:=xlGuess
objexcelapp.Workbooks(1).Save
objexcelapp.Workbooks(1).Close

If Not openexcelsheet(g_weavingdatasheetpath, 3) Then Exit Function
Call findquality(g_qualityname, rowno)
objexcelsht.Cells(rowno, 1) = g_qualityname
objexcelsht.Cells(rowno, 2) = g_costofquality

objexcelsht.Range("A7").Sort objexcelsht.Columns("A"), Header:=xlGuess
objexcelapp.Workbooks(1).Save
objexcelapp.Workbooks(1).Close
End Function


Public Function closetheopenexcelsheet(excelfilename As String) As Boolean
Dim tempexcelapp As Excel.Application
Dim tempexcelbook As Excel.Workbook
Dim i As Integer

'On Error Resume Next
'Err.Clear
Set tempexcelapp = GetObject(, "excel.application")

If TypeName(tempexcelapp) <> "nothing" Then
 For i = 1 To tempexcelapp.Workbooks.Count
  Set tempexcelbook = tempexcelapp.Workbooks.Item(i)
  If tempexcelbook.FullName = excelfilename Then
'    While Not tempexcelbook.Saved
'     If MsgBox("The workbook " & tempexcelbook.FullName & " will be modified by the program and has to be closed .Please close this workbook and try again !", vbRetryCancel) = vbCancel Then
'        closetheopenexcelsheet = False
'        Exit Function
'     End If
'    Wend
    tempexcelapp.Workbooks.Item(i).Close
   Exit For
  End If
 Next
End If

closetheopenexcelsheet = True
Set tempexcelbook = Nothing
Set tempexcelapp = Nothing
End Function

Public Function openexcelsheet(excelfilename As String, Optional worksheetno As Integer = 1) As Boolean
 If closetheopenexcelsheet(excelfilename) Then
   Set objexcelsht = objexcelapp.Workbooks.Open(excelfilename).Worksheets(worksheetno)
   openexcelsheet = True
 Else
   openexcelsheet = False
 End If
End Function

Public Function findquality(qualityname As String, Optional ByRef itemrowno As Long) As Boolean
Dim i As Long
Dim temp As Long
Dim temprange As Range
Dim qualitycolno As Long
Dim qualityrowno As Long



findquality = False

Set temprange = objexcelsht.Range("A1:z500").Find("quality", , xlValues, xlWhole, xlByRows, xlNext, False)
If temprange Is Nothing Then
 Set temprange = objexcelsht.Range("A1:z500").Find("LOOM GROUP NUMBER", , xlValues, xlWhole, xlByRows, xlNext, False)
End If

If temprange Is Nothing Then
  findquality = False
End If

qualitycolno = temprange.Column
qualityrowno = temprange.Row

For i = qualityrowno To objexcelsht.Rows.Count - 1
 frmprogress.prgbar = (100 * i) / objexcelsht.Rows.Count
 
 If qualityname = "" Then
  findquality = False
  Exit For
 End If
 
 If Trim(objexcelsht.Cells(i, qualitycolno)) = "" Then
  temp = temp + 1
 End If
 
 If temp > 0 And temp < 50 And Trim(objexcelsht.Cells(i, qualitycolno)) <> "" Then
  temp = 0
 End If
 
 If temp = 50 Then
  i = i - temp + 1
  findquality = False
  Exit For
 End If
 
 If (LCase(Trim(objexcelsht.Cells(i, qualitycolno))) = LCase(qualityname)) Then
  findquality = True
  Exit For
 End If
 
 DoEvents
Next
  
itemrowno = i
End Function

Public Function productexists(productname As String) As Boolean
productexists = False
frmprogress.Show (1)
productexists = g_productexists
End Function

