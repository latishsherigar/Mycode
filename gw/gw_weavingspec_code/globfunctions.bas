Attribute VB_Name = "globfunctions"
'Program: sheetweavingspecs.exe
'Program Author: Latish Sherigar
'emailid: latishsherigar@ yahoo.co.in
'website:http://www.geocities.com/latishsherigar


Option Explicit

Public cmdg As New clsCommonDialog
Public worddocdir As String
Public excelfilename As String
Public objwordapp As Word.Application
Public objworddoc As Word.Document
Public objexcelapp As Excel.Application
Public objexcelsht As Excel.Worksheet
Public fileprocessingerror As Boolean
Public formheight As Integer
Public stopthejob As Boolean
Public documentsfound As Boolean

Public quality As String
Public reedwidth As String
Public groundends As String
Public totalends As String
Public ppiatfellofcloth As String
Public warp As String
Public warpkilos As String
Public weft As String
Public weftkilos As String
Public cutlength As String
Public weftedlength As String
Public greasylength As String
Public kilospermetre As String

Public sheetrowno As Integer
Public datatable As Word.Table

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

Public Function init(OwnerHwnd As Long)
On Error Resume Next
 cmdg.OwnerHwnd = OwnerHwnd
 sheetrowno = 2
 Call readinfofromreg
 frmmain.txtdocdir = worddocdir
 frmmain.txtexcelfilename = excelfilename
 formheight = frmmain.Height

frmmain.cmdprocess.Enabled = True
frmmain.mnuactionstart.Enabled = True
frmmain.cmdstop.Enabled = False
frmmain.mnuactionstop.Enabled = False
 
End Function


Public Function reset()
On Error Resume Next
Call softreset
Call quitexcel
Set objexcelapp = Nothing
Set objexcelsht = Nothing
End Function

Public Function softreset()
On Error Resume Next
objexcelapp.Workbooks(1).Save
Set cmdg = Nothing
Call quitword
Set objwordapp = Nothing
Set objworddoc = Nothing
stopthejob = False
documentsfound = False
fileprocessingerror = False
frmmain.cmdprocess.Enabled = True
frmmain.mnuactionstart.Enabled = True
frmmain.cmdstop.Enabled = False
frmmain.mnuactionstop.Enabled = False
End Function

Public Function saveinfo2reg(worddocdir As String, excelfilename As String)
On Error Resume Next
 If worddocdir <> "" Then
   Call SaveSetting("docproc", "settings", "worddocdir", worddocdir)
 End If
 If excelfilename <> "" Then
   Call SaveSetting("docproc", "settings", "excelfilename", excelfilename)
 End If
End Function

Public Function readinfofromreg()
On Error Resume Next
worddocdir = GetSetting("docproc", "settings", "worddocdir")
excelfilename = GetSetting("docproc", "settings", "excelfilename")
End Function

Public Function startword() As Boolean
On Error GoTo errhnd:
 Set objwordapp = New Word.Application
 DoEvents
 objwordapp.Visible = False
 startword = True
 Exit Function
errhnd:
 startword = False
End Function

Public Function startexcel() As Boolean
 On Error GoTo errhnd:
 Set objexcelapp = New Excel.Application
 DoEvents
 objexcelapp.Visible = False
 Set objexcelsht = objexcelapp.Workbooks.Open(excelfilename).Worksheets(1)
 startexcel = True
 Exit Function
errhnd:
 startexcel = False
End Function


Public Function quitword()
On Error Resume Next
 objwordapp.Quit
 Set objworddoc = Nothing
 Set objwordapp = Nothing
End Function

Public Function quitexcel()
On Error Resume Next
 objexcelapp.Workbooks(1).Close (True)
 objexcelapp.Quit
 Set objexcelsht = Nothing
 Set objexcelapp = Nothing
End Function


Public Function readandpaste(FileName As String)
 Dim celldata
 Dim rowcount As Integer
 Dim j As Integer
 Dim l As Integer
 Dim m As Integer
 Dim temp
 
 l = sheetrowno
 m = 1
 On Error GoTo errhnd:
 Set objworddoc = objwordapp.Documents.Open(FileName, , True)
 DoEvents
 
On Error Resume Next
 Set datatable = objworddoc.Tables(1)
 
 
quality = purify(2, 3)
reedwidth = purify(5, 3)
groundends = purify(5, 4)
totalends = purify(5, 6)
ppiatfellofcloth = purify(5, 7)

rowcount = 5
While rowcount <= datatable.Rows.Count

celldata = LCase(Trim(purify(rowcount, 1)))

Select Case celldata
 Case "warp": warp = purify(rowcount, 2) & " " & purify(rowcount, 3)
              warpkilos = purify(rowcount, 4)

 Case "weft": weft = purify(rowcount, 2) & " " & purify(rowcount, 3)
              weftkilos = purify(rowcount, 4)

 Case "cut length": cutlength = purify(rowcount, 2)

 Case "wefted length": weftedlength = purify(rowcount, 2)

 Case "greasy length": greasylength = purify(rowcount, 2)

 Case "kilos / metre": kilospermetre = purify(rowcount, 2)

End Select

rowcount = rowcount + 1

DoEvents
Wend


'add to excel cells
objexcelsht.Cells(sheetrowno, 1) = quality
objexcelsht.Cells(sheetrowno, 2) = reedwidth
objexcelsht.Cells(sheetrowno, 3) = groundends
objexcelsht.Cells(sheetrowno, 4) = totalends
objexcelsht.Cells(sheetrowno, 5) = ppiatfellofcloth
objexcelsht.Cells(sheetrowno, 6) = warp
objexcelsht.Cells(sheetrowno, 7) = warpkilos
objexcelsht.Cells(sheetrowno, 8) = weft
objexcelsht.Cells(sheetrowno, 9) = weftkilos
objexcelsht.Cells(sheetrowno, 10) = cutlength
objexcelsht.Cells(sheetrowno, 11) = weftedlength
objexcelsht.Cells(sheetrowno, 12) = greasylength
objexcelsht.Cells(sheetrowno, 13) = kilospermetre

quality = ""
reedwidth = ""
groundends = ""
totalends = ""
ppiatfellofcloth = ""
warp = ""
warpkilos = ""
weft = ""
weftkilos = ""
cutlength = ""
weftedlength = ""
greasylength = ""
kilospermetre = ""

objworddoc.Close
Call add2listbox("File " & GetFileTitle(FileName) & " processed.")
sheetrowno = sheetrowno + 1
Exit Function
errhnd:
 Call add2listbox("Error Processing File " & GetFileTitle(FileName))
 fileprocessingerror = True


End Function
Public Function purify(row As Integer, col As Integer)
Dim i As Integer
Dim temp As String
Dim strtext

On Error Resume Next
strtext = datatable.Cell(row, col)
For i = 1 To Len(strtext)
 If Asc(Mid(strtext, i, 1)) <> 13 And Asc((Mid(strtext, i, 1))) <> 7 Then
 purify = purify & (Mid(strtext, i, 1))
' Else
' Exit Function
 End If
Next
End Function

Public Function GetFileTitle(strfilepath As String) As String
On Error Resume Next
    
    Dim pointer As Integer
    pointer = InStrRev(strfilepath, "\", , vbBinaryCompare)
    
    GetFileTitle = Right(strfilepath, Len(strfilepath) - pointer)
End Function


Public Function add2listbox(text As String)
On Error Resume Next

 frmmain.lstdetails.AddItem text
 Call ListBoxHBar(frmmain.lstdetails, frmmain)
End Function


Public Function ListBoxHBar(LstBox As ListBox, Frm As Form)
On Error Resume Next

Dim lngReturn As Long
Dim lngExtent As Long
Dim i As Integer

With Frm
 .ScaleMode = 3
 .Font = LstBox.Font
 .FontBold = LstBox.FontBold
 .FontItalic = LstBox.FontItalic
 .FontSize = LstBox.FontSize

 For i = 0 To LstBox.ListCount - 1
  If lngExtent < .TextWidth(LstBox.List(i)) Then
    lngExtent = .TextWidth(LstBox.List(i))
  End If
 Next i

End With
lngReturn = SendMessage(LstBox.hwnd, LB_SETHORIZONTALEXTENT, lngExtent, 0&)
End Function

Public Function createtheexcelfile(templatefilepath As String, resultfilepath) As Boolean
Dim tempexcelapp As Excel.Application
Dim tempexcelsht As Excel.Worksheet
Dim i As Integer

On Error Resume Next
createtheexcelfile = False
Err.Clear
Set tempexcelapp = GetObject(, "excel.application")

If TypeName(tempexcelapp) <> "nothing" Then
 For i = 1 To tempexcelapp.Workbooks.Count
  If tempexcelapp.Workbooks.Item(i).FullName = excelfilename Then
   tempexcelapp.Workbooks.Item(i).Close
   Exit For
  End If
 Next
End If

Kill (excelfilename)
On Error GoTo errhnd:
Err.Clear
Call FileCopy(App.Path & "\xlstemplate.bak", excelfilename)
createtheexcelfile = True
Set tempexcelapp = Nothing
Set tempexcelsht = Nothing
Exit Function

errhnd:
createtheexcelfile = False
Set tempexcelapp = Nothing
Set tempexcelsht = Nothing
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

