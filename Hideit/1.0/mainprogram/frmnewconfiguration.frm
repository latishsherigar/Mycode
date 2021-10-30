VERSION 5.00
Begin VB.Form frmconfiguration 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Hideit Configuration"
   ClientHeight    =   3630
   ClientLeft      =   45
   ClientTop       =   120
   ClientWidth     =   6375
   Icon            =   "frmnewconfiguration.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3630
   ScaleWidth      =   6375
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdDefault 
      Caption         =   "&Default"
      Height          =   375
      Left            =   4920
      TabIndex        =   9
      Top             =   3120
      Width           =   1215
   End
   Begin VB.CommandButton cmdHelp 
      Caption         =   "&Help"
      Height          =   375
      Left            =   3345
      TabIndex        =   6
      Top             =   3135
      Width           =   1215
   End
   Begin VB.Frame Frame1 
      Caption         =   "Configuration"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2775
      Left            =   120
      TabIndex        =   7
      Top             =   120
      Width           =   6135
      Begin VB.CheckBox chkcloseautomatically 
         Caption         =   "After an operation just finish and close the program automatically."
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   435
         Left            =   240
         TabIndex        =   8
         Top             =   4080
         Width           =   5655
      End
      Begin VB.CheckBox chkshowpasswordboxonhide 
         Caption         =   "Always show the password Dialog box when I choose the Hide it option ."
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   435
         Left            =   240
         TabIndex        =   0
         Top             =   360
         Width           =   5655
      End
      Begin VB.CheckBox chkremindpassword 
         Caption         =   "Remind me for the password if I have not given a password for my archive."
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   435
         Left            =   240
         TabIndex        =   1
         Top             =   920
         Width           =   5535
      End
      Begin VB.CheckBox chkshowtipofday 
         Caption         =   "Show Tip of Day at StartUp."
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   435
         Left            =   240
         TabIndex        =   3
         Top             =   2160
         Width           =   5775
      End
      Begin VB.CheckBox chkshowextractboxonopen 
         Caption         =   "Always show the ' Extract Archive ' dialog box when I chose the Open archive option."
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   555
         Left            =   240
         TabIndex        =   2
         Top             =   1480
         Width           =   5655
      End
   End
   Begin VB.CommandButton cmdCancel 
      Caption         =   "&Cancel"
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
      Left            =   1740
      TabIndex        =   5
      Top             =   3135
      Width           =   1215
   End
   Begin VB.CommandButton cmdOk 
      Caption         =   "&Apply"
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
      Left            =   135
      TabIndex        =   4
      Top             =   3135
      Width           =   1215
   End
End
Attribute VB_Name = "frmconfiguration"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCancel_Click()
    Unload Me
End Sub

Private Sub cmdDefault_Click()
    chkshowpasswordboxonhide.value = 0
    chkshowextractboxonopen.value = 0
    chkremindpassword.value = 1
    chkshowtipofday.value = 1
End Sub

Private Sub cmdHelp_Click()
    Call create_dynamic_help(Me.hwnd, "configure.htm#configure")
End Sub

Private Sub cmdOk_Click()
    INI_settings.showPasswordboxonHide = chkshowpasswordboxonhide.value
    INI_settings.showextractboxonopen = chkshowextractboxonopen.value
    INI_settings.RemindPassword = chkremindpassword.value
    INI_settings.ShowTipofDay = chkshowtipofday.value
    Unload Me
End Sub

Private Sub Form_Load()
    chkshowpasswordboxonhide.value = INI_settings.showPasswordboxonHide
    chkshowextractboxonopen.value = INI_settings.showextractboxonopen
    chkremindpassword.value = INI_settings.RemindPassword
    chkshowtipofday.value = INI_settings.ShowTipofDay
End Sub
