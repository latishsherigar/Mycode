VERSION 5.00
Begin VB.Form frmextractarchivedialog 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Extract Dailog box"
   ClientHeight    =   2115
   ClientLeft      =   45
   ClientTop       =   225
   ClientWidth     =   5565
   Icon            =   "frmextractarchivedialog.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2115
   ScaleWidth      =   5565
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.PictureBox framecovercontainer 
      BorderStyle     =   0  'None
      Height          =   2055
      Left            =   0
      ScaleHeight     =   2055
      ScaleWidth      =   5535
      TabIndex        =   0
      Top             =   0
      Width           =   5535
      Begin VB.CommandButton cmdHelpstep1 
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
         TabIndex        =   6
         Top             =   1080
         Width           =   1215
      End
      Begin VB.CheckBox chkdeletehiddenfiles 
         Caption         =   "&Delete the hidden files from the original file. "
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
         Left            =   120
         TabIndex        =   4
         Top             =   1560
         Width           =   4215
      End
      Begin VB.CommandButton cmdok 
         Caption         =   "O&k"
         Height          =   375
         Left            =   1800
         TabIndex        =   3
         Top             =   1080
         Width           =   1215
      End
      Begin VB.TextBox txtoutputfolder 
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
         TabIndex        =   2
         Top             =   600
         Width           =   3015
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
      Begin VB.Image Image1 
         Height          =   570
         Left            =   120
         Picture         =   "frmextractarchivedialog.frx":000C
         Top             =   480
         Width           =   600
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Select the Folder where the hidden files will be extracted ???"
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
         TabIndex        =   5
         Top             =   120
         Width           =   5190
      End
   End
End
Attribute VB_Name = "frmextractarchivedialog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim Titlebarlength As Integer

Private Sub chkdeletehiddenfiles_Click()
    If chkdeletehiddenfiles.value = 1 Then
      gbbool_purifyfile = True
    Else
      gbbool_purifyfile = False
    End If
End Sub

Private Sub cmdBrowsefolder_Click()
    If ShowBrowsefolder(Me.hwnd, "Select a Folder to extract the files .", gbstr_extractoutputdir) Then
        txtoutputfolder.Text = gbstr_extractoutputdir
    End If
End Sub

Private Sub cmdHelpstep1_Click()
    Call create_dynamic_help(Me.hwnd, "show.htm#extract_box")
End Sub

Private Sub cmdOk_Click()
    If PathFileExists(Trim(txtoutputfolder.Text)) Then
        Me.Hide
        frmprogress.Show (1)
        Unload Me
    End If
End Sub


Private Sub Form_Load()
    Titlebarlength = gettitlebarlength(Me.hwnd)
    If Titlebarlength > 23 Then
        Me.Height = framecovercontainer.Height + 500
    Else
        Me.Height = framecovercontainer.Height + 400
    End If
End Sub

Private Sub txtoutputfolder_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 Then
        Call cmdOk_Click
    End If
End Sub
