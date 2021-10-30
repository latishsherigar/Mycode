VERSION 5.00
Begin VB.Form Form2 
   Caption         =   "Form2"
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form2"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   375
      Left            =   1320
      TabIndex        =   0
      Top             =   360
      Width           =   1335
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim appAccess As Access.Application
Dim objwordapp As Word.Application
Dim objworddoc As Word.Document

Private Sub Command1_Click()
Call DisplayForm
End Sub

Sub DisplayForm()
Call check_if_open
    ' Create new instance of Microsoft Access.
    Set appAccess = CreateObject("Access.Application")
    ' Open database in Microsoft Access window.
    appAccess.OpenCurrentDatabase App.Path & "\db1.mdb"
    appAccess.Visible = False
    appAccess.DoCmd.OutputTo acOutputReport, "report", acFormatRTF, "report.doc", 1
    appAccess.CloseCurrentDatabase
    appAccess.Quit acQuitSaveNone
Call setpagesetup
End Sub


Private Sub setpagesetup()
With Selection
 .PageSetup.TopMargin = 72 * 2.1
 .PageSetup.BottomMargin = 72 * 0.7
 .PageSetup.LeftMargin = 72 * 0.7
 .PageSetup.RightMargin = 72 * 0.7
End With
End Sub
Private Sub check_if_open()
Dim docopen As Boolean
Dim docFound As Boolean

On Error Resume Next
Err.Clear
Set objwordapp = GetObject(, "word.application")
If Err.Number <> 0 Then
 Exit Sub
End If


'find if the document is open
    For Each objworddoc In objwordapp.Documents
        If InStr(1, objworddoc.Name, "report.doc", 1) Then
            docopen = True
            Exit For
        Else
            docopen = False
        End If
    Next objworddoc
    
'Close the document
If docopen = True Then
  objwordapp.Documents("report.doc").Close
  'Quit word
  If objwordapp.Documents.Count = 0 Then
     objwordapp.Quit
  End If
End If



End Sub
