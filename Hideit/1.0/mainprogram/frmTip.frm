VERSION 5.00
Begin VB.Form frmTip 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Hide It !  Tip of the Day"
   ClientHeight    =   3120
   ClientLeft      =   2355
   ClientTop       =   2385
   ClientWidth     =   5175
   Icon            =   "frmTip.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3120
   ScaleWidth      =   5175
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   WhatsThisHelp   =   -1  'True
   Begin VB.CheckBox chkLoadTipsAtStartup 
      Caption         =   "&Show Tips at Startup"
      Height          =   315
      Left            =   120
      TabIndex        =   3
      Top             =   2640
      Width           =   2055
   End
   Begin VB.CommandButton cmdNextTip 
      Caption         =   "&Next Tip"
      Height          =   375
      Left            =   3840
      TabIndex        =   2
      Top             =   2640
      Width           =   1215
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00FFFFFF&
      Height          =   2355
      Left            =   120
      Picture         =   "frmTip.frx":000C
      ScaleHeight     =   2295
      ScaleWidth      =   4875
      TabIndex        =   1
      Top             =   120
      Width           =   4935
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackColor       =   &H00FFFFFF&
         Caption         =   "Did you know..."
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   600
         TabIndex        =   5
         Top             =   120
         Width           =   1755
      End
      Begin VB.Label lblTipText 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1155
         Left            =   120
         TabIndex        =   4
         Top             =   840
         Width           =   4695
      End
   End
   Begin VB.CommandButton cmdOK 
      Cancel          =   -1  'True
      Caption         =   "&Close"
      Default         =   -1  'True
      Height          =   375
      Left            =   2520
      TabIndex        =   0
      Top             =   2640
      Width           =   1215
   End
End
Attribute VB_Name = "frmTip"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim tipfileno As Integer

Private Sub chkLoadTipsAtStartup_Click()
    INI_settings.ShowTipofDay = chkLoadTipsAtStartup.value
End Sub

Private Sub cmdNextTip_Click()
    On Error GoTo errhnd:
    lblTipText.Caption = LoadResString(INI_settings.Tipno)
    INI_settings.Tipno = INI_settings.Tipno + 1
    Exit Sub
errhnd:
    INI_settings.Tipno = 1
    Call cmdNextTip_Click
End Sub

Private Sub cmdOk_Click()
    Unload Me
End Sub

Private Sub Form_Load()
    chkLoadTipsAtStartup.value = INI_settings.ShowTipofDay
    Call cmdNextTip_Click
End Sub
