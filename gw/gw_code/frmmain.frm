VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form frmmain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Input Screen for New Quantity"
   ClientHeight    =   6255
   ClientLeft      =   150
   ClientTop       =   435
   ClientWidth     =   6375
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
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   ScaleHeight     =   6255
   ScaleWidth      =   6375
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame framemainbody 
      Height          =   6255
      Left            =   0
      TabIndex        =   16
      Top             =   0
      Width           =   6375
      Begin VB.TextBox txtqualityname 
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   1800
         MaxLength       =   20
         TabIndex        =   0
         Top             =   240
         Width           =   2895
      End
      Begin VB.TextBox txtscouringandmillingfinish 
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   3240
         MaxLength       =   20
         TabIndex        =   14
         Top             =   5160
         Width           =   2895
      End
      Begin VB.CommandButton cmdsave 
         Caption         =   "&Save"
         Height          =   375
         Left            =   3960
         TabIndex        =   15
         Top             =   5760
         Width           =   1440
      End
      Begin VB.ComboBox cmbcolored 
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
         ItemData        =   "frmmain.frx":030A
         Left            =   1800
         List            =   "frmmain.frx":0314
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   720
         Width           =   615
      End
      Begin MSMask.MaskEdBox mskedgridcell 
         Height          =   255
         Left            =   360
         TabIndex        =   17
         Top             =   6240
         Visible         =   0   'False
         Width           =   735
         _ExtentX        =   1296
         _ExtentY        =   450
         _Version        =   393216
         BorderStyle     =   0
         Appearance      =   0
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskwarp 
         Height          =   255
         Left            =   3360
         TabIndex        =   2
         Top             =   720
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         MaxLength       =   5
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Mask            =   "###.#"
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskweft 
         Height          =   255
         Left            =   5280
         TabIndex        =   3
         Top             =   720
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskwarpkilos 
         Height          =   255
         Left            =   1800
         TabIndex        =   4
         Top             =   1200
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskweftkilos 
         Height          =   255
         Left            =   5280
         TabIndex        =   5
         Top             =   1200
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskgreasylength 
         Height          =   255
         Left            =   1800
         TabIndex        =   6
         Top             =   1680
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskweavinglength 
         Height          =   255
         Left            =   5280
         TabIndex        =   7
         Top             =   1680
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskPPI 
         Height          =   255
         Left            =   1800
         TabIndex        =   8
         Top             =   2160
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskkiolsperpiece 
         Height          =   255
         Left            =   5280
         TabIndex        =   9
         Top             =   2160
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskcostofquality 
         Height          =   255
         Left            =   1800
         TabIndex        =   10
         Top             =   2640
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskpickingandmendinghrs 
         Height          =   255
         Left            =   5280
         TabIndex        =   12
         Top             =   3600
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskpickingandmendingmetres 
         Height          =   255
         Left            =   5280
         TabIndex        =   13
         Top             =   4200
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin MSFlexGridLib.MSFlexGrid fgloom 
         Height          =   2535
         Left            =   120
         TabIndex        =   11
         Top             =   3600
         Width           =   2895
         _ExtentX        =   5106
         _ExtentY        =   4471
         _Version        =   393216
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Quality Name :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   0
         Left            =   120
         TabIndex        =   32
         Top             =   240
         Width           =   1395
      End
      Begin VB.Label Label1 
         Caption         =   "White or Colored :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   450
         Index           =   1
         Left            =   120
         TabIndex        =   31
         Top             =   600
         Width           =   1140
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Warp :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   2
         Left            =   2640
         TabIndex        =   30
         Top             =   720
         Width           =   645
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Weft :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   3
         Left            =   4560
         TabIndex        =   29
         Top             =   720
         Width           =   585
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Warp Kilos :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   4
         Left            =   120
         TabIndex        =   28
         Top             =   1200
         Width           =   1140
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Scouring && milling finish :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   7
         Left            =   3240
         TabIndex        =   27
         Top             =   4800
         Width           =   2340
      End
      Begin VB.Label Label1 
         Caption         =   "Picking && Mending metres :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   450
         Index           =   8
         Left            =   3240
         TabIndex        =   26
         Top             =   4200
         Width           =   1815
      End
      Begin VB.Label Label1 
         Caption         =   "Picking && Mending hrs :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   450
         Index           =   9
         Left            =   3240
         TabIndex        =   25
         Top             =   3600
         Width           =   1815
      End
      Begin VB.Label Label1 
         Caption         =   "Cost of Quality per metre :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   450
         Index           =   11
         Left            =   120
         TabIndex        =   24
         Top             =   2640
         Width           =   1680
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Kilos per piece :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   12
         Left            =   3600
         TabIndex        =   23
         Top             =   2160
         Width           =   1500
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "PPI :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   13
         Left            =   120
         TabIndex        =   22
         Top             =   2160
         Width           =   450
      End
      Begin VB.Label Label1 
         Caption         =   "Weaving Length Metres :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   450
         Index           =   14
         Left            =   3600
         TabIndex        =   21
         Top             =   1560
         Width           =   1545
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Greasy Length :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   15
         Left            =   120
         TabIndex        =   20
         Top             =   1680
         Width           =   1515
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Weft Kilos :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   16
         Left            =   3600
         TabIndex        =   19
         Top             =   1200
         Width           =   1080
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Loom Choices:"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Index           =   5
         Left            =   120
         TabIndex        =   18
         Top             =   3240
         Width           =   1380
      End
   End
   Begin VB.Menu mnufile 
      Caption         =   "&File"
      Begin VB.Menu mnufilesetworkarea 
         Caption         =   "&Set Work Area"
         Shortcut        =   ^W
      End
      Begin VB.Menu mnufileexit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuhelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuhelpabout 
         Caption         =   "&About"
         Shortcut        =   {F1}
      End
   End
End
Attribute VB_Name = "frmmain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim c As New cRegistry

Private Sub cmdcancel_Click()

End Sub

Private Sub cmdsave_Click()
If Not trialexpired Then
Call fgloom_LeaveCell
Call getvaluesfromtextboxes
If validate Then
 PresentCommand = Save
 frmprogress.Show (1)
 MsgBox "Data Sucessfully saved ", vbInformation, "Save"
 Call cleartextboxes
 Call setmask
End If
Else
 frmabout.Show (1)
End If
End Sub

Private Sub cleartextboxes()
txtqualityname = ""
mskwarp.Mask = ""
mskwarp.Text = ""
mskweft.Mask = ""
mskweft.Text = ""
mskwarpkilos.Mask = ""
mskwarpkilos.Text = ""
mskweftkilos.Mask = ""
mskweftkilos.Text = ""
mskgreasylength.Mask = ""
mskgreasylength.Text = ""
mskweavinglength.Mask = ""
mskweavinglength.Text = ""
mskPPI.Mask = ""
mskPPI.Text = ""
mskkiolsperpiece.Mask = ""
mskkiolsperpiece.Text = ""
mskcostofquality.Mask = ""
mskcostofquality.Text = ""
mskpickingandmendinghrs.Mask = ""
mskpickingandmendinghrs.Text = ""
mskpickingandmendingmetres.Mask = ""
mskpickingandmendingmetres.Text = ""
txtscouringandmillingfinish.Text = ""
mskedgridcell.Mask = ""
mskedgridcell.Text = ""
cmbcolored.Clear
Call initgrid

End Sub

Private Sub fgloom_Click()
Dim i As Integer

For i = 0 To fgloom.Rows - 1
 fgloom.TextMatrix(i, 0) = ""
Next
 fgloom.TextMatrix(fgloom.Row, 0) = "*"
 
 Call fgloom_EnterCell
End Sub

Private Sub fgloom_EnterCell()
If fgloom.Col = 1 Then Exit Sub
mskedgridcell.Visible = True
mskedgridcell.Left = fgloom.Left + fgloom.CellLeft
mskedgridcell.Top = fgloom.Top + fgloom.CellTop
mskedgridcell.Width = fgloom.CellWidth
mskedgridcell.Height = fgloom.CellHeight
mskedgridcell.Mask = ""
mskedgridcell.Text = fgloom.Text
If mskedgridcell.Enabled Then
 mskedgridcell.SetFocus
End If

Select Case fgloom.Col
 Case 2: mskedgridcell.Mask = "##"
 
 Case 3: mskedgridcell.Mask = "###"

End Select

End Sub

Private Sub fgloom_KeyDown(KeyCode As Integer, Shift As Integer)
mskedgridcell.Visible = False
If fgloom.Row <= 1 And fgloom.Rows <= 2 Then Exit Sub
If KeyCode = 46 Then
 fgloom.RemoveItem (fgloom.Row)
End If
End Sub

Private Sub fgloom_LeaveCell()
fgloom.Text = Val(Replace(mskedgridcell.Text, "_", ""))
If fgloom.Col = 2 And fgloom.Text > 25 Then
 MsgBox "Please enter a value less than 25 for the Loom Group number.", vbInformation, "Validator"
 fgloom.Text = 0
End If
End Sub

Private Sub Form_Load()
Me.Show
Call checkfortrial
If trialexpired Then
    framemainbody.Enabled = False
    frmabout.Show (1)
Else
    Call init
    framemainbody.Enabled = True
    If g_workareapath = "" Then
     MsgBox "It seems to be the first time you have run this application.The application needs the path to the work area where it can find the excel files to work on .Click on 'OK' to select the work area. ", vbInformation, "Data Distrubuter"
     frmpath.Show (1)
    End If
    Call init
    g_editproduct = False
    Call setmask
    Call initgrid
    Call startexcel
    Call createexcelfiles
End If
End Sub

Private Sub checkfortrial()
Dim sd As String
Dim lud As String
Dim sdate As Date
Dim ludate As Date

'this is for the registered version
 trialexpired = False
 Exit Sub

 With c
 .ClassKey = HKEY_LOCAL_MACHINE
 .SectionKey = "Software\lic\001\"
 .ValueKey = "value001"
 .ValueType = REG_SZ
 If .Value = "true" Then
    trialexpired = True
    Exit Sub
 End If
End With

With c
 .ClassKey = HKEY_LOCAL_MACHINE
 .SectionKey = "Software\latdatadistrib\"
 .ValueKey = "sd"
 .ValueType = REG_SZ
  sd = .Value
 .ValueKey = "lud"
 .ValueType = REG_SZ
 lud = .Value
End With

If sd = "" Or lud = "" Then
    sd = "20042709" Xor 953123567
    lud = sd
    
    With c
     .ClassKey = HKEY_LOCAL_MACHINE
     .SectionKey = "Software\latdatadistrib\"
     .ValueKey = "sd"
     .ValueType = REG_SZ
     .Value = sd
     .ValueKey = "lud"
     .ValueType = REG_SZ
     .Value = lud
    End With
End If


sd = sd Xor 953123567
lud = lud Xor 953123567

sdate = CDate(Mid(sd, 7, 2) & "/" & Mid(sd, 5, 2) & "/" & Mid(sd, 1, 4))
ludate = CDate(Mid(lud, 7, 2) & "/" & Mid(lud, 5, 2) & "/" & Mid(lud, 1, 4))

If DateDiff("d", Date, ludate) > 0 Or DateDiff("d", sdate, Date) >= 30 Then
 trialexpired = True
 With c
 .ClassKey = HKEY_LOCAL_MACHINE
 .SectionKey = "Software\lic\001\"
 .ValueKey = "value001"
 .ValueType = REG_SZ
 .Value = "true"
End With
 
Else
lud = (Format(Year(Date), "####") & Format(Day(Date), "0#") & Format(Month(Date), "0#")) Xor 953123567

With c
 .ClassKey = HKEY_LOCAL_MACHINE
 .SectionKey = "Software\latdatadistrib\"
 .ValueKey = "lud"
 .ValueType = REG_SZ
 .Value = lud
End With

End If



End Sub

Private Sub Form_Unload(Cancel As Integer)
Call mnufileexit_Click
End Sub

Private Sub mnufileexit_Click()
  Call reset
  Unload Me
End Sub

Private Sub mnufilesetworkarea_Click()
frmpath.Show (1)
End Sub

Private Sub mnuhelpabout_Click()
frmabout.Show (1)
End Sub

Private Sub mskedgridcell_KeyPress(KeyAscii As Integer)
If fgloom.Row = fgloom.Rows - 1 Then
 fgloom.Rows = fgloom.Rows + 1
End If

End Sub


Private Sub txtqualityname_Validate(Cancel As Boolean)
Dim retval As Integer

PresentCommand = FindProduct
If productexists(txtqualityname) Then
 retval = MsgBox("This product already exists !.Do you want to proceed ?", vbYesNo + vbExclamation, "Product Checker")
 If retval = vbNo Then
  txtqualityname = ""
  Cancel = True
  Exit Sub
 End If
End If

End Sub


Private Function validate() As Boolean
validate = False

If txtqualityname = "" Then
 MsgBox "Please enter a Quality name !", vbExclamation, "Validator"
 Exit Function
End If

If cmbcolored.Text = "" Then
 MsgBox "Please choose a option from the colored combo !", vbExclamation, "Validator"
 Exit Function
End If

If mskwarp.Text = "" Then
 MsgBox "Please enter the Warp quantity !", vbExclamation, "Validator"
 Exit Function
End If

If mskweft.Text = "" Then
 MsgBox "Please enter the Wasp quantity !", vbExclamation, "Validator"
 Exit Function
End If

If mskwarpkilos.Text = "" Then
 MsgBox "Please enter the Warp Kilos Quantity !", vbExclamation, "Validator"
 Exit Function
End If

If mskweftkilos.Text = "" Then
 MsgBox "Please enter the Weft Kilos Quantity !", vbExclamation, "Validator"
 Exit Function
End If

If mskgreasylength.Text = "" Then
 MsgBox "Please enter the Greasy length Quantity !", vbExclamation, "Validator"
 Exit Function
End If

If mskweavinglength.Text = "" Then
 MsgBox "Please enter the Weaving length Quantity !", vbExclamation, "Validator"
 Exit Function
End If

If mskPPI.Text = "" Then
 MsgBox "Please enter the PPI Quantity !", vbExclamation, "Validator"
 Exit Function
End If

If mskkiolsperpiece.Text = "" Then
 MsgBox "Please enter the Kilos per piece Quantity !", vbExclamation, "Validator"
 Exit Function
End If

If mskpickingandmendinghrs.Text = "" Then
 MsgBox "Please enter the Picking and Mending hours Quantity !", vbExclamation, "Validator"
 Exit Function
End If

If mskpickingandmendingmetres.Text = "" Then
 MsgBox "Please enter the Picking and Mending metres Quantity !", vbExclamation, "Validator"
 Exit Function
End If

If txtscouringandmillingfinish.Text = "" Then
 MsgBox "Please enter the Scouring and milling finish text !", vbExclamation, "Validator"
 Exit Function
End If


validate = True

End Function

Private Function setmask()
Dim i As Integer

mskwarp.Mask = "###.#"
mskweft.Mask = "###.#"
mskwarpkilos.Mask = "###.##"
mskweftkilos.Mask = "###.##"
mskgreasylength.Mask = "###.#"
mskweavinglength.Mask = "###.##"
mskPPI.Mask = "###.#"
mskkiolsperpiece.Mask = "###.##"
mskcostofquality.Mask = "###.##"
mskpickingandmendinghrs.Mask = "##.#"
mskpickingandmendingmetres.Mask = "###.##"

End Function

Private Function getvaluesfromtextboxes()

g_qualityname = txtqualityname.Text
g_colored = cmbcolored.Text
g_warp = Val(Replace(mskwarp.Text, "_", ""))
g_weft = Val(Replace(mskweft.Text, "_", ""))
g_warpkilos = Val(Replace(mskwarpkilos.Text, "_", ""))
g_weftkilos = Val(Replace(mskweftkilos.Text, "_", ""))
g_greasylength = Val(Replace(mskgreasylength.Text, "_", ""))
g_weavinglength = Val(Replace(mskweavinglength.Text, "_", ""))
g_PPI = Val(Replace(mskPPI.Text, "_", ""))
g_kilosperpiece = Val(Replace(mskkiolsperpiece.Text, "_", ""))
g_costofquality = Val(Replace(mskcostofquality.Text, "_", ""))
g_pickingandmendinghrs = Val(Replace(mskpickingandmendinghrs.Text, "_", ""))
g_pickingandmendingmetres = Val(Replace(mskpickingandmendingmetres.Text, "_", ""))
g_scouringandmillingfinish = txtscouringandmillingfinish.Text

End Function

Private Function readvaluesfromexcelsheet()

End Function

Private Function initgrid()
'1th column is a hidden column
fgloom.Clear
With fgloom
 .WordWrap = True
 .Cols = 4
 .Rows = 2
 .FixedCols = 1
 .ColWidth(0) = 200
 .ColWidth(1) = 0
 .ColWidth(2) = 1250
 .ColWidth(3) = 1250
 .RowHeight(0) = 500
 .TextMatrix(0, 2) = "Loom group number"
 .TextMatrix(0, 3) = "Loom Speed"
End With
cmbcolored.Clear
cmbcolored.AddItem "w"
cmbcolored.AddItem "c"
End Function
