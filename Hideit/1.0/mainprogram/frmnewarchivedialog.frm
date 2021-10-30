VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Begin VB.Form frmnewarchivedialog 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "New Archive"
   ClientHeight    =   5730
   ClientLeft      =   45
   ClientTop       =   15
   ClientWidth     =   5580
   BeginProperty Font 
      Name            =   "Verdana"
      Size            =   9
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmnewarchivedialog.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5730
   ScaleWidth      =   5580
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.PictureBox frameresultfilecontainer 
      BorderStyle     =   0  'None
      Height          =   1575
      Left            =   0
      ScaleHeight     =   1575
      ScaleWidth      =   5655
      TabIndex        =   5
      Top             =   3960
      Width           =   5655
      Begin VB.CommandButton cmdHelpstep2 
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
         TabIndex        =   11
         Top             =   960
         Width           =   1215
      End
      Begin VB.CommandButton cmdBrowseresultfile 
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
         TabIndex        =   8
         Top             =   480
         Width           =   1215
      End
      Begin VB.TextBox txtresultfile 
         BackColor       =   &H00FFFFFF&
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
         Locked          =   -1  'True
         TabIndex        =   7
         Top             =   480
         Width           =   3015
      End
      Begin VB.CommandButton cmdResultfileOk 
         Caption         =   "O&K"
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
         TabIndex        =   6
         Top             =   960
         Width           =   1215
      End
      Begin VB.Image Image2 
         Height          =   435
         Left            =   120
         Picture         =   "frmnewarchivedialog.frx":000C
         Top             =   480
         Width           =   540
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Save the file under a new name...."
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
         TabIndex        =   9
         Top             =   120
         Width           =   2985
      End
   End
   Begin VB.PictureBox framecovercontainer 
      BorderStyle     =   0  'None
      Height          =   3495
      Left            =   0
      ScaleHeight     =   3495
      ScaleWidth      =   5535
      TabIndex        =   0
      Top             =   0
      Width           =   5535
      Begin VB.Frame frameadvancedoptions 
         Caption         =   "Advanced Options"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1335
         Left            =   120
         TabIndex        =   13
         Top             =   2040
         Width           =   5175
         Begin VB.CheckBox chksaveinsame 
            Caption         =   "&Dont create any new file. Hide all my data in this same file. "
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
            TabIndex        =   15
            Top             =   720
            Width           =   4695
         End
         Begin VB.CheckBox chkInvisibleMode 
            Caption         =   "Invisible Mode ."
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
            Left            =   240
            TabIndex        =   14
            Top             =   360
            Width           =   1695
         End
      End
      Begin VB.CommandButton cmdOptionsstep1 
         Caption         =   "&Options >>"
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
         TabIndex        =   12
         Top             =   1560
         Width           =   1215
      End
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
         TabIndex        =   10
         Top             =   1080
         Width           =   1215
      End
      Begin VB.CommandButton cmdBrowsecoverfile 
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
         TabIndex        =   3
         Top             =   600
         Width           =   1215
      End
      Begin VB.TextBox txtcoverfile 
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
      Begin VB.CommandButton cmdcoverfileOK 
         Caption         =   "O&K"
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
         TabIndex        =   1
         Top             =   1080
         Width           =   1215
      End
      Begin VB.Image Image1 
         Height          =   630
         Left            =   120
         Picture         =   "frmnewarchivedialog.frx":040D
         Top             =   480
         Width           =   615
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Select the file which will hide the other files ."
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
         TabIndex        =   4
         Top             =   120
         Width           =   3825
      End
   End
   Begin MSComDlg.CommonDialog cmdg 
      Left            =   4440
      Top             =   6120
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
End
Attribute VB_Name = "frmnewarchivedialog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim m_newfile As Boolean
Dim m_OptionsLoaded As Boolean
Dim m_Titlebarlength As Integer
Dim org_frame_height As Integer
Dim red_frame_height As Integer

Private Sub chkInvisibleMode_Click()
    gbint_invisiblemodeclicked = chkInvisibleMode.value
End Sub

Private Sub chksaveinsame_Click()
 m_newfile = CBool(chkInvisibleMode.value)
End Sub

Private Sub cmdBrowsecoverfile_Click()
    cmdg.DialogTitle = "Select the cover file"
    cmdg.Filter = "All type of files (*.*)|*.*"
    cmdg.Flags = cdlOFNExplorer Or cdlOFNFileMustExist Or cdlOFNHelpButton Or cdlOFNHideReadOnly Or cdlOFNLongNames
    cmdg.ShowOpen
    
    If cmdg.filename <> "" Then
      txtcoverfile = cmdg.filename
    End If

End Sub

Private Sub cmdBrowseresultfile_Click()
    Dim extension As String
    
    extension = getfileextension(txtcoverfile)
    cmdg.filename = ""
    cmdg.Filter = "*." + extension + "|*." + extension
    cmdg.DialogTitle = "Save the Resultant file as :"
    cmdg.Flags = cdlOFNExplorer Or cdlOFNHelpButton Or cdlOFNHideReadOnly Or cdlOFNLongNames Or cdlOFNOverwritePrompt
    cmdg.ShowSave
    
    If cmdg.filename <> "" Then
      txtresultfile.Text = cmdg.filename
    End If

End Sub


Private Sub cmdHelpstep1_Click()
    Call create_dynamic_help(Me.hwnd, "hide.htm#new_arch_box")
End Sub

Private Sub cmdHelpstep2_Click()
    Call create_dynamic_help(Me.hwnd, "hide.htm#save_box")
End Sub

Private Sub cmdOptionsstep1_Click()

    If m_OptionsLoaded Then
        framecovercontainer.Height = red_frame_height
        m_OptionsLoaded = False
    Else
        framecovercontainer.Height = org_frame_height
        frameadvancedoptions.Enabled = True
        m_OptionsLoaded = True
    End If
    
    If m_Titlebarlength > 23 Then
        Me.Height = framecovercontainer.Height + 500
    Else
        Me.Height = framecovercontainer.Height + 400
    End If

End Sub

Private Sub cmdResultfileOk_Click()
    If validateresultfile Then
        Call initmainform
    End If
End Sub

Private Sub initmainform()
        
    frmmain.Caption = "Hide it"
    frmmain.Caption = frmmain.Caption + " - " + cmdg.FileTitle
    frmmain.mnuActionsAdd.Enabled = True
    
    If frmmain.lstfiles.ColumnHeaders.count <= 3 Then
        frmmain.lstfiles.ColumnHeaders.Add , , "  Path  ", 5000
    End If
    
    frmmain.tlbar.Buttons(3).Enabled = True
    gbbool_new_archive_state = True
    gbstr_coverfilename = txtcoverfile.Text
    
    If chksaveinsame.value = 1 Then
     gbstr_resultfilename = gbstr_coverfilename
    Else
     gbstr_resultfilename = txtresultfile.Text
    End If
    
    Unload Me
End Sub

Private Sub cmdcoverfileOK_Click()


    If validatecoverfile Then
    
        frmmain.lstfiles.view = lvwReport
        
        'initialise the modules
        Call initialise
        
        With frmmain.lstfiles.ColumnHeaders
            
            .Clear
            
            .Add , , "  Name  ", 1500
            
            .Add , , "  Type  ", 1000
          
            .Add , , "  Size  ", 800, vbRightJustify
          
            .Add , , "  Path  ", 3500
        
        End With

        If Not m_newfile Then
            Call initmainform
        Else
            frameresultfilecontainer.Enabled = True
            Me.Caption = "New Archive - Step 2 of 2"
            framecovercontainer.Visible = False
            frameresultfilecontainer.Left = 0
            frameresultfilecontainer.Top = 0
            frameresultfilecontainer.Visible = True
            Me.Height = frameresultfilecontainer.Height + 400
            txtresultfile.SetFocus
        End If
    End If

End Sub

Private Sub Form_Activate()
If txtcoverfile.Text = "" Then
    txtcoverfile.SetFocus
Else
    txtresultfile.SetFocus
End If
End Sub

Private Sub Form_Load()

    gbbool_new_archive_state = False
    gbint_invisiblemodeclicked = 0
    frameresultfilecontainer.Left = 0
    frameresultfilecontainer.Top = 0
    frameresultfilecontainer.Visible = False
    frameresultfilecontainer.Enabled = False
    frameadvancedoptions.Enabled = False
    
    org_frame_height = framecovercontainer.Height
    
    framecovercontainer.Height = frameadvancedoptions.Top
    red_frame_height = framecovercontainer.Height
    
    m_Titlebarlength = gettitlebarlength(Me.hwnd)
    
    If m_Titlebarlength > 23 Then
        Me.Height = framecovercontainer.Height + 500
    Else
        Me.Height = framecovercontainer.Height + 400
    End If
    
    Me.Caption = "New Archive - Step 1 of 2"
    m_newfile = True
    m_OptionsLoaded = False
    
End Sub

Private Function validateresultfile() As Boolean
   On Error GoTo fileerr

    Dim resultfile As String
    Dim filenumber As Integer
    Dim retval As Integer
    Dim i As Integer
    
    validateresultfile = False
    
    resultfile = Trim(txtresultfile)
    If resultfile = "" And chksaveinsame.value = 0 Then
         Exit Function
    End If
    
    If chksaveinsame.value = 0 Then
        
       If resultfile = gbstr_coverfilename Then
          MsgBox "Please save the file under a different name as the source and the result files names cannot be same .", vbCritical, "Archive name error"
          Exit Function
       End If
       
       If PathFileExists(resultfile) Then
        gbstr_backupresultfilename = gettempfilename(gettempfolderpath)
        Call CopyFile(resultfile, gbstr_backupresultfilename, 0)
       End If
       
        filenumber = FreeFile()
        Open resultfile For Binary Access Write As filenumber
        Close filenumber
        Kill (resultfile)
        
        validateresultfile = True
        Exit Function
    
fileerr:
        
        MsgBox "The archive cannot be created" & vbLf & "Error no:" & Err.Number & vbLf & "Error Description:" & Err.Description & vbLf & vbLf & "Possible Causes :" & vbLf & "1.You dont have the required permissions to create the file in this directory." & vbLf & "2.The given Directory path is incorrect.", vbCritical, "File Creation Error"
        validateresultfile = False
        Exit Function
    End If

End Function

Private Function validatecoverfile() As Boolean
    
    validatecoverfile = False
    
    gbstr_coverfilename = Trim(txtcoverfile.Text)
    
    If gbstr_coverfilename = "" Then
        Exit Function
    End If
    
    If PathFileExists(gbstr_coverfilename) Then
        validatecoverfile = True
    Else
        MsgBox "No file exists of such name." & vbLf & "Please enter a correct filename or select a file by clicking the BROWSE button.", vbCritical, "File Path Error"
        txtcoverfile.SetFocus
        Exit Function
    End If
    
End Function

