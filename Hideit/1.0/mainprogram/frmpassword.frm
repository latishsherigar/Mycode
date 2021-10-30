VERSION 5.00
Begin VB.Form frmpassword 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Password for new archive"
   ClientHeight    =   1665
   ClientLeft      =   45
   ClientTop       =   225
   ClientWidth     =   5040
   BeginProperty Font 
      Name            =   "Verdana"
      Size            =   9
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmpassword.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1665
   ScaleWidth      =   5040
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdcancel 
      Caption         =   "&Cancel"
      Height          =   375
      Left            =   3840
      TabIndex        =   6
      Top             =   1080
      Width           =   1095
   End
   Begin VB.CommandButton cmdRemovepass 
      Caption         =   "&Remove Password"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   5
      Top             =   1080
      Width           =   1935
   End
   Begin VB.CommandButton cmdOK 
      Caption         =   "O&k"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2520
      TabIndex        =   2
      Top             =   1080
      Width           =   1215
   End
   Begin VB.TextBox txtconfirmpassword 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      IMEMode         =   3  'DISABLE
      Left            =   2520
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   600
      Width           =   2415
   End
   Begin VB.TextBox txtpassword 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      IMEMode         =   3  'DISABLE
      Left            =   2520
      PasswordChar    =   "*"
      TabIndex        =   0
      Top             =   120
      Width           =   2415
   End
   Begin VB.Image Image1 
      Height          =   480
      Left            =   120
      Picture         =   "frmpassword.frx":000C
      Top             =   120
      Width           =   480
   End
   Begin VB.Label lblconfirmpass 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Renter Password :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   720
      TabIndex        =   4
      Top             =   600
      Width           =   1575
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Password :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   720
      TabIndex        =   3
      Top             =   120
      Width           =   945
   End
End
Attribute VB_Name = "frmpassword"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdOk_Click()
    Dim pass As String, confirmpass As String
    pass = Trim(txtpassword.Text)
    confirmpass = Trim(txtconfirmpassword.Text)
    
    If pass = "" Or confirmpass = "" Then
     Exit Sub
    End If
    
    If pass <> confirmpass Then
     MsgBox "Please enter the same text in both the password boxes"
     Exit Sub
    End If
    
    gbstr_password = pass
    Unload Me
End Sub

Private Sub cmdRemovepass_Click()
    gbstr_password = ""
    cmdRemovepass.Enabled = False
    txtpassword.Text = ""
    txtconfirmpassword.Text = ""
    MsgBox "Password Removed"
End Sub

Private Sub Form_Load()

    If Trim(gbstr_password) <> "" Then
     cmdRemovepass.Enabled = True
    Else
    cmdRemovepass.Enabled = False
    End If
    
    txtpassword.Text = gbstr_password
    
    txtconfirmpassword.Text = txtpassword.Text

End Sub

Private Sub txtconfirmpassword_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Call cmdOk_Click
    End If
End Sub

Private Sub txtpassword_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        txtconfirmpassword.SetFocus
    End If
End Sub
