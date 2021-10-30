VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmmain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "sheet weaving specification processor"
   ClientHeight    =   5055
   ClientLeft      =   150
   ClientTop       =   555
   ClientWidth     =   4965
   BeginProperty Font 
      Name            =   "Verdana"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmmain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   5055
   ScaleWidth      =   4965
   StartUpPosition =   1  'CenterOwner
   Begin VB.PictureBox framemain 
      Height          =   2535
      Left            =   120
      ScaleHeight     =   2475
      ScaleWidth      =   4635
      TabIndex        =   1
      Top             =   120
      Width           =   4695
      Begin VB.CommandButton cmdprocess 
         Caption         =   "&Start"
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
         Left            =   360
         TabIndex        =   8
         Top             =   1920
         Width           =   1095
      End
      Begin VB.CommandButton cmdbrowsedocdir 
         Caption         =   "Browse ..."
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
         Left            =   3360
         TabIndex        =   7
         Top             =   480
         Width           =   1095
      End
      Begin VB.TextBox txtdocdir 
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
         Left            =   120
         Locked          =   -1  'True
         TabIndex        =   6
         Top             =   480
         Width           =   3135
      End
      Begin VB.CommandButton cmdbrowseexcelfile 
         Caption         =   "Browse ..."
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
         Left            =   3360
         TabIndex        =   5
         Top             =   1320
         Width           =   1095
      End
      Begin VB.TextBox txtexcelfilename 
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
         Left            =   120
         Locked          =   -1  'True
         TabIndex        =   4
         Top             =   1320
         Width           =   3135
      End
      Begin VB.CommandButton cmddetails 
         Caption         =   "&Details"
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
         Left            =   3360
         TabIndex        =   3
         Top             =   1920
         Width           =   1095
      End
      Begin VB.CommandButton cmdstop 
         Caption         =   "&Stop"
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
         Left            =   1680
         TabIndex        =   2
         Top             =   1920
         Width           =   1095
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Word Documents Directory:"
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
         TabIndex        =   10
         Top             =   120
         Width           =   2400
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Excel file name:"
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
         Top             =   960
         Width           =   1380
      End
   End
   Begin VB.ListBox lstdetails 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2205
      Left            =   120
      TabIndex        =   0
      Top             =   2760
      Width           =   4695
   End
   Begin MSComDlg.CommonDialog cmdgsave 
      Left            =   5520
      Top             =   4800
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.Menu mnufile 
      Caption         =   "&File"
      Begin VB.Menu mnufileexit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuaction 
      Caption         =   "&Action"
      Begin VB.Menu mnuactionstart 
         Caption         =   "&Start"
      End
      Begin VB.Menu mnuactionstop 
         Caption         =   "S&top"
      End
   End
   Begin VB.Menu mnuhelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuhelpabout 
         Caption         =   "&About"
      End
      Begin VB.Menu mnuhelpwebsite 
         Caption         =   "&Website"
      End
      Begin VB.Menu mnuhelpreadmefile 
         Caption         =   "&Read me file"
      End
   End
End
Attribute VB_Name = "frmmain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Program: sheetweavingspecs.exe
'Program Author: Latish Sherigar
'emailid: latishsherigar@ yahoo.co.in
'website:http://www.geocities.com/latishsherigar



Option Explicit

Dim detailsshown As Boolean
Dim startdate As Date


Private Sub cmdbrowsedocdir_Click()
If cmdg.ShowBrowsefolder Then
 txtdocdir.text = Trim(cmdg.Foldername)
 Call saveinfo2reg(txtdocdir, txtexcelfilename)
 Call readinfofromreg
End If
End Sub



Private Sub cmdbrowseexcelfile_Click()

cmdgsave.Dialogtitle = "Save the excel file name as "
cmdgsave.Filter = "Excel file|*.xls"
cmdgsave.ShowSave
If cmdgsave.FileName <> "" Then
  txtexcelfilename = Trim(cmdgsave.FileName)
  Call saveinfo2reg(txtdocdir, txtexcelfilename)
  Call readinfofromreg
End If
End Sub


Private Sub cmddetails_Click()

Dim m_titlebarlength As Integer

    m_titlebarlength = gettitlebarlength(Me.hwnd)
    
 If detailsshown Then
    If m_titlebarlength > 23 Then
        Me.Height = 3530
    Else
        Me.Height = 3400
    End If
  detailsshown = False
  cmddetails.Caption = "Details >>"
 Else
    If m_titlebarlength > 23 Then
        Me.Height = 5845
    Else
        Me.Height = 5745
    End If
  
  detailsshown = True
  cmddetails.Caption = "Details <<"
 End If
End Sub


Private Sub cmdprocess_Click()
On Error GoTo errhnd:

    Dim FileName As String
    
    Call init(Me.hwnd)
    
    lstdetails.Clear
    
    Call add2listbox("Processing started.....")
    
    cmdprocess.Enabled = False
    
    mnuactionstart.Enabled = False
    
    cmdstop.Enabled = True
    
    mnuactionstop.Enabled = True

    If stopthejob Then
      
       Call reset
       
       Call add2listbox("Job Cancelled....")
       
       Exit Sub
    
    End If


    If Dir(worddocdir & "*.doc") = "" Then
      
        Call reset
        
        Call add2listbox("No Documents found !!!.")
        
        MsgBox "The given directory contains none of the word files required by the program.", vbExclamation
    
    Else
    
        If createtheexcelfile(App.Path & "\xlstemplate.bak", excelfilename) Then
        
         Call add2listbox("Excel File Created.")
        
        Else
        
         Call add2listbox("Error creating Excel File!!!.")
        
         Call add2listbox("Terminating program...")
        
         Call reset
         
         Exit Sub
        
        End If
    
        Call add2listbox("Loading MS-Word Environment....")
        
         If stopthejob Then
           Call reset
           Call add2listbox("Job Cancelled....")
           Exit Sub
         End If
        
        Call startword
        
        Call add2listbox("MS-Word Environment Loaded.")
        
        Call add2listbox("Loading MS-Excel Environment....")
        
         If stopthejob Then
           Call reset
           Call add2listbox("Job Cancelled....")
           Exit Sub
         End If
        
        Call startexcel
        
        Call add2listbox("MS-Excel Environment Loaded.")
        
        Call add2listbox("Reading of Word Documents Started....")
                
        Do
         
         If stopthejob Then
           
           Call reset
           
           Call add2listbox("Job Cancelled....")
           
           Exit Sub
         
         End If
        
         If FileName = "" Then
           
           FileName = Dir(worddocdir & "*.doc")
         
         Else
           
           FileName = Dir
         
           If FileName = "" Then
             
             Exit Do
           
           End If
         
         End If
         
         Call readandpaste(worddocdir & "\" & FileName)
        
        Loop
        
        Call add2listbox("Reading of Word Documents Finished....")
        
        Call add2listbox("Unloading MS-Word Environment....")
        
         If stopthejob Then
           
           Call reset
           
           Call add2listbox("Job Cancelled....")
           
           Exit Sub
         
         End If
        
        Call quitword
        
        Call add2listbox("MS-Word Environment Unloaded.")
        
        Call add2listbox("Excel File Saved.")
        
        If fileprocessingerror Then
         
            MsgBox "There were errors in processing one or more files.See the details box for more details about that file."
        
        End If
        
        Call add2listbox("Unloading MS-Excel Environment....")
         
        If stopthejob Then
            
           Call reset
            
           Call add2listbox("Job Cancelled....")
            
           Exit Sub
        
        End If
         
        Call quitexcel
        
        Call add2listbox("MS-Excel Environment Unloaded.")
        
            
        If MsgBox("The required data has been collected in the Excel sheet.Would you like to open the excel sheet now ?", vbYesNo + vbInformation, "Doc Processor") = vbYes Then
            
           If stopthejob Then
               
              Call reset
               
              Call add2listbox("Job Cancelled....")
               
              Exit Sub
             
           End If
              
           Call showexcelfile(excelfilename)
            
        End If
        
    End If
    
    Call add2listbox("Processing Finished.")
    
    Call softreset
    
    Exit Sub
    
errhnd:
    
    Dim errno As Integer
    Dim errstr As String
    
    errno = Err.Number
    
    errstr = Err.Description
    
    MsgBox "Unknown error:" & vbLf & "Error Number:" & errno & vbLf & "Error Description:" & errstr, vbCritical, "ERROR"
    
    Call add2listbox("Processing Terminated because of unknown error.")
    
    Call add2listbox("Error Number:" & errno)
    
    Call add2listbox("Error Description:" & errstr)
    
    Call reset
    
End Sub


Private Sub cmdstop_Click()
 stopthejob = True
End Sub

Private Sub Form_Load()
 Call init(Me.hwnd)
 Call cmddetails_Click
End Sub



Private Sub Form_Initialize()
    InitCommonControls
End Sub

Private Sub Form_Unload(Cancel As Integer)
 Call reset
 End
End Sub

Private Sub mnuactionstart_Click()
 Call cmdprocess_Click
End Sub

Private Sub mnuactionstop_Click()
Call cmdstop_Click
End Sub

Private Sub mnufileexit_Click()
 Call Form_Unload(0)
End Sub



Private Sub mnuhelpabout_Click()
frmabout.Show (1)
End Sub

Private Sub mnuhelpreadmefile_Click()
   Shell "notepad " & App.Path & "\readme.txt", vbNormalFocus
   End Sub

Private Sub mnuhelpwebsite_Click()
   ShellExecute Me.hwnd, vbNullString, "http://www.geocities.com/latishsherigar", vbNullString, "", 0

End Sub
