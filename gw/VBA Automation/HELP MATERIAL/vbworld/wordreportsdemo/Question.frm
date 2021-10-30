VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Report Generator"
   ClientHeight    =   3540
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3720
   LinkTopic       =   "Form1"
   ScaleHeight     =   3540
   ScaleWidth      =   3720
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdReport 
      Caption         =   "Report"
      Height          =   375
      Left            =   2280
      TabIndex        =   15
      Top             =   2880
      Width           =   1095
   End
   Begin VB.HScrollBar HScroll1 
      Height          =   255
      Left            =   120
      Max             =   10
      TabIndex        =   13
      Top             =   2880
      Width           =   1455
   End
   Begin VB.CheckBox chkG 
      Caption         =   "G"
      Height          =   255
      Left            =   2280
      TabIndex        =   12
      Top             =   2520
      Width           =   1095
   End
   Begin VB.CheckBox ChkF 
      Caption         =   "F"
      Height          =   255
      Left            =   2280
      TabIndex        =   11
      Top             =   2160
      Width           =   975
   End
   Begin VB.CheckBox chkD 
      Caption         =   "D"
      Height          =   255
      Left            =   2280
      TabIndex        =   10
      Top             =   1440
      Width           =   975
   End
   Begin VB.CheckBox ChkE 
      Caption         =   "E"
      Height          =   255
      Left            =   2280
      TabIndex        =   9
      Top             =   1800
      Width           =   975
   End
   Begin VB.CheckBox chkC 
      Caption         =   "C"
      Height          =   255
      Left            =   2280
      TabIndex        =   8
      Top             =   1080
      Width           =   975
   End
   Begin VB.TextBox txtDept 
      Height          =   285
      Left            =   840
      TabIndex        =   5
      Top             =   600
      Width           =   2655
   End
   Begin VB.TextBox txtName 
      Height          =   285
      Left            =   840
      TabIndex        =   4
      Top             =   120
      Width           =   2655
   End
   Begin VB.Frame FrmA 
      Caption         =   "Frame1"
      Height          =   1815
      Left            =   120
      TabIndex        =   0
      Top             =   960
      Width           =   2055
      Begin VB.OptionButton OptNone 
         Caption         =   "Neither A or B"
         Height          =   375
         Left            =   120
         TabIndex        =   3
         Top             =   1320
         Width           =   1815
      End
      Begin VB.OptionButton OptB 
         Caption         =   "Option B"
         Height          =   375
         Left            =   120
         TabIndex        =   2
         Top             =   840
         Width           =   1575
      End
      Begin VB.OptionButton OptA 
         Caption         =   "Option A"
         Height          =   375
         Left            =   120
         TabIndex        =   1
         Top             =   360
         Width           =   1455
      End
   End
   Begin VB.Label lblScroll 
      Caption         =   "10"
      Height          =   255
      Left            =   1680
      TabIndex        =   14
      Top             =   2880
      Width           =   375
   End
   Begin VB.Label Label2 
      Caption         =   "Dept:"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   600
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "Name:"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   120
      Width           =   615
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim ObjWord As Word.Application
Private Sub cmdReport_Click()
    Dim temp As String
    Set ObjWord = New Word.Application
'   Disable command button to prevent object being recreated
    cmdReport.Enabled = False
'   Name of report file, change path to whatever is applicable
    ObjWord.Documents.Open ("c:\Report.doc")
    
'   Calling subroutines with header and data
    Call RepPara("userid01", txtName)
    Call RepPara("userid02", txtDept)
    Call DelPara("Q11", OptA.Value)
    Call DelPara("Q12", OptB.Value)
    Call DelPara("Q13", OptNone.Value)
    Call DelPara("Q20", chkC.Value)
    Call DelPara("Q21", chkD.Value)
    Call DelPara("Q22", ChkE.Value)
    Call DelPara("Q23", ChkF.Value)
    Call DelPara("Q24", chkG.Value)
    
    temp = "You selected " & Str$(HScroll1.Value) & " on the scroll bar"
    Call RepPara("Q31", temp)
    Call RepPara("Q32", temp)
'   Saves report with a new filename
    ObjWord.ActiveDocument.SaveAs ("c:\NewReport.doc")
'   Quit Word
    ObjWord.Quit
'   Inform user that report is created
    MsgBox "Report Created"
'   Clear our pointer to word
    Set ObjWord = Nothing
End Sub

Private Sub Form_Load()
    HScroll1_Change
End Sub
Private Sub HScroll1_Change()
    lblScroll = HScroll1.Value
End Sub
Private Sub HScroll1_Scroll()
    HScroll1_Change
End Sub
Private Sub DelPara(Header As String, Keep As Boolean)
    With ObjWord.Selection.Find
        .ClearFormatting
        .Text = Header
        .Execute Forward:=True
    End With
    If Keep = False Then
        Call ObjWord.Selection.MoveDown(wdParagraph, 1, wdExtend)
    End If
    ObjWord.Selection.Delete
End Sub
Private Sub RepPara(Header As String, Data As String)
    With ObjWord.Selection.Find
        .ClearFormatting
        .Text = Header
        .Execute Forward:=True
    End With
    Clipboard.Clear
    Clipboard.SetText (Data)
    ObjWord.Selection.Paste
    Clipboard.Clear
End Sub

