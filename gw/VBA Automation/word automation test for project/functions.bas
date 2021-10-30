Attribute VB_Name = "functions"
Option Explicit

Public objwordapp As Word.Application
Public objworddoc As Word.Document
Public contractno As String
Public titlestring As String
Public companyname As String


Public Function putvalues()
contractno = "MTC/L/0-1/112."
titlestring = "We confirm on behalf and for the account and risk of under-mentioned Buyers & Sellers, the following transactions."
companyname = "M.LAKHAMSHI & CO"
End Function

Public Sub init()
On Error Resume Next

Err.Clear
Set objwordapp = GetObject(, "word.application")
If Err.Number <> 0 Then
   Err.Clear
  Set objwordapp = CreateObject("word.application")
   If Err.Number <> 0 Then
      MsgBox "Error: " & Err.Description
   End If
End If
End Sub

Public Sub printreport()
On Error Resume Next

Set objworddoc = Documents.Add
With objworddoc
    .Content.Font.Name = "Arial"
    .Content.Font.Size = 10
    .SaveAs FileName:=App.Path & "\report.doc"
End With
Call initpagesetup(2.1, 0.7, 0.7, 0.7, 0, wdGutterPosLeft, wdOrientPortrait, wdPaperLetter, 11, 8.5)
Call inserttext
objworddoc.Save
objwordapp.Visible = True
End Sub

Public Function inserttext()
Call putvalues
With Selection
'Insert contractno
    .InsertBefore "Contract No. "
    .InsertAfter contractno
    .Font.Underline = wdUnderlineSingle
    .Collapse Direction:=wdCollapseEnd
    .Font.Underline = wdUnderlineNone
    .InsertAfter (vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & vbTab & "    ")
    .Font.Underline = wdUnderlineNone
    .Collapse Direction:=wdCollapseEnd
    
'Insert Date
    .InsertAfter ("DATE: ")
    .Font.Underline = wdUnderlineSingle
    .Collapse Direction:=wdCollapseEnd
    .Font.Underline = wdUnderlineSingle
    .InsertDateTime ("dd MMMM, yyyy")
    .InsertAfter (".")
    .Collapse Direction:=wdCollapseEnd
    .Font.Underline = wdUnderlineNone
    .Collapse Direction:=wdCollapseEnd
    .InsertAfter (Chr(13) & Chr(13))
    
'Insert Buyers info
Call insertbuyersinfo
    
    
End With
End Function

Public Function insertbuyersinfo()
Dim addressno(1 To 3) As String
Dim a As Integer



With Selection
    .InsertAfter titlestring & Chr(13) & Chr(13)
    .Collapse Direction:=wdCollapseEnd
    .InsertAfter ("BUYERS")
    .Font.Bold = True
    .Collapse Direction:=wdCollapseEnd
    .InsertAfter (vbTab & vbTab)
    .InsertAfter (":" & vbTab)
    .Font.Bold = wdToggle
    .InsertAfter (companyname)
    
    addressno(1) = "C/o. Plot No. 118/121, GIDC,"
    addressno(2) = "Dedhiyasana Modhera Road,"
    addressno(3) = "MAHESANA (GUJ)"
      For a = 1 To 3
       .InsertAfter (Chr(13))
       .InsertAfter (vbTab & vbTab & vbTab & vbTab)
       .Font.Bold = False
       .InsertAfter (addressno(a))
      Next
End With
End Function
Public Sub showpagesetupdlg()
Dim dlgSpell As Dialog

On Error Resume Next
If objworddoc = "nothing" Then
   Set objworddoc = Documents.Add
   objwordapp.Visible = True
End If
Set dlgSpell = Dialogs(wdDialogFilePageSetup)
dlgSpell.Show
End Sub

Public Function insertdate()
Dim dlgSpell As Dialog
Set dlgSpell = Dialogs(wdDialogInsertDateTime)
dlgSpell.Show
End Function

Public Function initpagesetup(topmargin As Single, bottommargin As Single, leftmargin As Single _
, rightmargin As Single, gutter As Single, gutterposition As WdGutterStyle, Orientation As WdOrientation _
, papersize As WdPaperSize, pageheight As Single, pagewidth As Single)
With Selection.PageSetup
 .topmargin = 72 * topmargin
 .bottommargin = 72 * bottommargin
 .leftmargin = 72 * leftmargin
 .rightmargin = 72 * rightmargin
 .gutter = 72 * gutter
 .GutterPos = gutterposition
 .Orientation = Orientation
 .papersize = papersize
 .pageheight = 72 * pageheight
 .pagewidth = 72 * pagewidth
 End With
End Function

