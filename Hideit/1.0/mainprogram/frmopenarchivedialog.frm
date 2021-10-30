VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form frmopenarchivedialog 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Open Archive dialog"
   ClientHeight    =   3375
   ClientLeft      =   45
   ClientTop       =   120
   ClientWidth     =   5580
   Icon            =   "frmopenarchivedialog.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3375
   ScaleWidth      =   5580
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin MSComDlg.CommonDialog cmdg 
      Left            =   5040
      Top             =   2760
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CheckBox chkInvisibleMode 
      Caption         =   "Invisible Mode"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   1680
      Value           =   1  'Checked
      Width           =   2295
   End
   Begin VB.CommandButton cmdOk 
      Caption         =   "&Ok"
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
      Left            =   1800
      TabIndex        =   2
      Top             =   1080
      Width           =   1215
   End
   Begin VB.Frame frameInvisibleMode 
      Caption         =   "Invisible Mode Options"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1095
      Left            =   120
      TabIndex        =   7
      Top             =   2160
      Width           =   4575
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
         Height          =   285
         IMEMode         =   3  'DISABLE
         Left            =   1920
         PasswordChar    =   "*"
         TabIndex        =   5
         Top             =   480
         Width           =   2415
      End
      Begin VB.Image Image1 
         Height          =   480
         Left            =   240
         Picture         =   "frmopenarchivedialog.frx":000C
         Top             =   360
         Width           =   480
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
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
         Left            =   840
         TabIndex        =   8
         Top             =   480
         Width           =   945
      End
   End
   Begin VB.CommandButton cmdBrowsefolder 
      Caption         =   "&Browse..."
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
      Left            =   4080
      TabIndex        =   1
      Top             =   600
      Width           =   1215
   End
   Begin VB.CommandButton cmdHelp 
      Caption         =   "&Help"
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
      Left            =   4080
      TabIndex        =   3
      Top             =   1080
      Width           =   1215
   End
   Begin VB.TextBox txtopenarchivename 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   840
      TabIndex        =   0
      Top             =   600
      Width           =   3015
   End
   Begin VB.Image Image2 
      Height          =   480
      Left            =   240
      Picture         =   "frmopenarchivedialog.frx":044E
      Top             =   480
      Width           =   450
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Select the File which contians your hidden data"
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
      Left            =   120
      TabIndex        =   6
      Top             =   120
      Width           =   4020
   End
End
Attribute VB_Name = "frmopenarchivedialog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim form_org_height As Integer
Dim Titlebarlength As Integer

Private Sub chkInvisibleMode_Click()
    If chkInvisibleMode.value = 1 Then
        txtpassword = ""
        Me.Height = form_org_height
        gbint_invisiblemodeclicked = 1
    Else
        If Titlebarlength > 23 Then
            Me.Height = frameInvisibleMode.Top + 400
        Else
            Me.Height = frameInvisibleMode.Top + 250
        End If
        gbint_invisiblemodeclicked = 0
    End If
End Sub

Private Sub cmdBrowsefolder_Click()
    cmdg.DialogTitle = "Open a Hidden Archive"
    cmdg.filename = ""
    cmdg.Filter = "All Files (*.*)|*.*"
    cmdg.ShowOpen
    txtopenarchivename.Text = cmdg.filename
End Sub

Private Sub cmdHelp_Click()
    Call create_dynamic_help(Me.hwnd, "show.htm#open_box")
End Sub

Private Sub cmdOk_Click()

If PathFileExists(Trim(txtopenarchivename.Text)) Then

    If Trim(txtopenarchivename.Text) <> "" Then
        
         frmmain.lstfiles.view = lvwReport
        
        'initialise the modules
        Call initialise
        
        With frmmain.lstfiles.ColumnHeaders
            .Clear
            .Add , , "  Name  ", 1500
            .Add , , "  Type  ", 1000
            .Add , , "  Size  ", 800, vbRightJustify
        End With
       
        gbstr_openarchivename = Trim(txtopenarchivename.Text)
     
        gbstr_password = Trim(txtpassword.Text)
        
        If chkInvisibleMode.value = 1 And txtpassword = "" Then
            Exit Sub
        End If
        
        Me.Hide
        
        frmmain.Caption = get_file_title(txtopenarchivename.Text)
        'openarchive is a function
        If openarchive = True And INI_settings.showextractboxonopen = 1 Then
            
            Call frmmain.mnuActionsShow_Click
        
        End If
    Unload Me
    
    End If

End If
End Sub

Private Sub Form_Load()
    form_org_height = Me.Height
    gbint_invisiblemodeclicked = 0
    Titlebarlength = gettitlebarlength(Me.hwnd)
    chkInvisibleMode.value = 0
End Sub

Private Sub txtopenarchivename_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Call cmdOk_Click
    End If
End Sub

Private Sub txtpassword_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Call cmdOk_Click
    End If
End Sub
