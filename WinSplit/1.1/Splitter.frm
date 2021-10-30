VERSION 5.00
Begin VB.Form frmSplitter 
   BackColor       =   &H00EB9F6C&
   BorderStyle     =   0  'None
   Caption         =   "Winsplit 1.1  -  Let it do the splitting ......"
   ClientHeight    =   49995
   ClientLeft      =   15
   ClientTop       =   -195
   ClientWidth     =   9195
   Icon            =   "Splitter.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   49995
   ScaleWidth      =   9195
   StartUpPosition =   1  'CenterOwner
   Begin Winsplit.ctlbutton ctlbuttonmenu 
      Height          =   195
      Index           =   0
      Left            =   8760
      TabIndex        =   51
      ToolTipText     =   "Close Button - closes the program"
      Top             =   120
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   344
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      HoverColor      =   9089279
      Text            =   " "
      BackColor       =   4883967
   End
   Begin VB.Frame Frame 
      BackColor       =   &H00EB9F6C&
      BorderStyle     =   0  'None
      Height          =   5415
      Index           =   4
      Left            =   0
      TabIndex        =   4
      Top             =   32760
      Width           =   7335
      Begin VB.Label Label12 
         BackStyle       =   0  'Transparent
         Caption         =   $"Splitter.frx":030A
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   855
         Left            =   360
         TabIndex        =   38
         Top             =   3840
         Width           =   6495
      End
      Begin VB.Label Label11 
         BackStyle       =   0  'Transparent
         Caption         =   $"Splitter.frx":03E6
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   1095
         Left            =   360
         TabIndex        =   37
         Top             =   1800
         Width           =   6735
      End
      Begin VB.Label Label10 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "HELP"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   330
         Left            =   360
         TabIndex        =   36
         Top             =   240
         Width           =   765
      End
      Begin VB.Label Label19 
         AutoSize        =   -1  'True
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "SPLITTER:"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   360
         TabIndex        =   33
         Top             =   840
         Width           =   975
      End
      Begin VB.Label Label35 
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "NOTE : The files can be splitted or merged using either Windows or Dos Versions."
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   360
         TabIndex        =   32
         Top             =   4920
         Width           =   6255
      End
      Begin VB.Label Label22 
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "The merger can merge or join the splitted files and produce a single file."
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   315
         Left            =   360
         TabIndex        =   31
         Top             =   3360
         Width           =   6450
      End
      Begin VB.Label Label21 
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "The splitter can split files of any practical size and split them in whichever size you want."
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   435
         Left            =   360
         TabIndex        =   30
         Top             =   1200
         Width           =   6450
      End
      Begin VB.Label Label20 
         AutoSize        =   -1  'True
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "MERGER :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   360
         TabIndex        =   29
         Top             =   3000
         Width           =   885
      End
   End
   Begin VB.Frame Frame 
      BackColor       =   &H00EB9F6C&
      BorderStyle     =   0  'None
      Height          =   5415
      Index           =   3
      Left            =   0
      TabIndex        =   3
      Top             =   26880
      Width           =   7335
      Begin Winsplit.ctlbutton ctlbuttonmergefiles 
         Height          =   375
         Left            =   2520
         TabIndex        =   49
         Top             =   3840
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         HoverColor      =   15441772
         Text            =   "GO"
      End
      Begin Winsplit.ctlbutton ctlbuttonmergebrowsefolder 
         Height          =   375
         Left            =   5640
         TabIndex        =   48
         Top             =   3120
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         HoverColor      =   15441772
         Text            =   "Browse..."
         BackColor       =   16044731
      End
      Begin Winsplit.ctlbutton ctlbuttonmergebrowsefile 
         Height          =   375
         Left            =   5640
         TabIndex        =   47
         Top             =   2040
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         HoverColor      =   15441772
         Text            =   "Browse..."
         BackColor       =   16044731
      End
      Begin VB.TextBox txtUnsplitOutputDir 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   360
         TabIndex        =   26
         Top             =   3120
         Width           =   5055
      End
      Begin VB.TextBox txtUnsplitFilename 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   360
         Left            =   360
         TabIndex        =   25
         Top             =   2040
         Width           =   5055
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "MERGER"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   330
         Left            =   360
         TabIndex        =   35
         Top             =   240
         Width           =   1305
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "Name of the splitted file that has to be merged :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   360
         TabIndex        =   28
         Top             =   1680
         Width           =   4695
      End
      Begin VB.Label Label6 
         BackColor       =   &H00FFFFFF&
         BackStyle       =   0  'Transparent
         Caption         =   "Name of the Output folder where the merged file will be saved:"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   360
         TabIndex        =   27
         Top             =   2760
         Width           =   6255
      End
   End
   Begin VB.Frame Frame 
      BackColor       =   &H00EB9F6C&
      BorderStyle     =   0  'None
      Height          =   5415
      Index           =   2
      Left            =   120
      TabIndex        =   2
      Top             =   21000
      Width           =   7215
      Begin Winsplit.ctlbutton ctlbuttonbackfromoperation 
         Height          =   375
         Left            =   2880
         TabIndex        =   53
         Top             =   4080
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         HoverColor      =   15441772
         Text            =   "BACK"
         BackColor       =   16044731
      End
      Begin VB.Timer tmrdelaycancel 
         Enabled         =   0   'False
         Interval        =   500
         Left            =   240
         Top             =   1320
      End
      Begin Winsplit.ctlbutton ctlbuttonoperation 
         Height          =   375
         Left            =   2880
         TabIndex        =   46
         Top             =   2160
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         HoverColor      =   15441772
         Text            =   "START"
         BackColor       =   16044731
      End
      Begin Winsplit.ctlprogressbar progressbar 
         Height          =   375
         Left            =   1080
         TabIndex        =   40
         Top             =   2880
         Width           =   5055
         _ExtentX        =   8916
         _ExtentY        =   661
         BackColor       =   16044731
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.CheckBox chkOverwritefiles 
         BackColor       =   &H00EB9F6C&
         Caption         =   "Overwrite Exisiting Files ???"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   2160
         TabIndex        =   39
         Top             =   3480
         Width           =   3495
      End
      Begin VB.Label lbloperationText 
         AutoSize        =   -1  'True
         BackColor       =   &H00EB9F6C&
         Caption         =   "Press 'CANCEL' to stop operation"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   210
         Left            =   1920
         TabIndex        =   24
         Top             =   1560
         Width           =   3270
      End
   End
   Begin VB.Frame Frame 
      BackColor       =   &H00EB9F6C&
      BorderStyle     =   0  'None
      Height          =   5415
      Index           =   1
      Left            =   0
      TabIndex        =   1
      Top             =   15120
      Width           =   7215
      Begin Winsplit.ctlHyperLink ctlHyperLink2 
         Height          =   210
         Left            =   2280
         TabIndex        =   59
         Top             =   2040
         Width           =   4140
         _ExtentX        =   7303
         _ExtentY        =   370
         BackColor       =   15441772
         ForeColor       =   16777215
         HoverColor      =   16777215
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         HoverUnderLine  =   -1  'True
      End
      Begin Winsplit.ctlHyperLink ctlHyperLink1 
         Height          =   210
         Left            =   2280
         TabIndex        =   58
         Top             =   1680
         Width           =   2670
         _ExtentX        =   4710
         _ExtentY        =   370
         BackColor       =   15441772
         ForeColor       =   16777215
         HoverColor      =   16777215
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Text            =   "latishsherigar@yahoo.co.in"
         URL             =   "mailto:latishsherigar@yahoo.co.in"
         HoverUnderLine  =   -1  'True
      End
      Begin Winsplit.ctlbutton ctlbuttonLegalDisclaimer 
         Height          =   375
         Left            =   2520
         TabIndex        =   45
         Top             =   3840
         Width           =   2415
         _ExtentX        =   4260
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         HoverColor      =   15441772
         Text            =   "Legal Disclaimer"
         BackColor       =   16044731
      End
      Begin VB.Label Label13 
         BackStyle       =   0  'Transparent
         Caption         =   $"Splitter.frx":0508
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   615
         Left            =   360
         TabIndex        =   50
         Top             =   4560
         Width           =   6615
      End
      Begin VB.Label Label37 
         BackColor       =   &H00EB9F6C&
         Caption         =   "For more Programms or any queries regarding this program please visit my site or contact me by email."
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   435
         Left            =   360
         TabIndex        =   23
         Top             =   2640
         Width           =   6405
      End
      Begin VB.Label Label45 
         AutoSize        =   -1  'True
         BackColor       =   &H00EB9F6C&
         Caption         =   "Please read this Legal disclaimer before using this utility"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   480
         TabIndex        =   22
         Top             =   3480
         Width           =   5580
      End
      Begin VB.Label Label16 
         AutoSize        =   -1  'True
         BackColor       =   &H00EB9F6C&
         Caption         =   "WINSPLIT 1.1"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   21.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   480
         Left            =   2265
         TabIndex        =   21
         Top             =   240
         Width           =   2745
      End
      Begin VB.Image Image1 
         Height          =   480
         Left            =   1200
         Picture         =   "Splitter.frx":05D1
         Top             =   240
         Width           =   480
      End
      Begin VB.Label Label39 
         AutoSize        =   -1  'True
         BackColor       =   &H00EB9F6C&
         BackStyle       =   0  'Transparent
         Caption         =   "Latish Sherigar"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   210
         Left            =   2280
         TabIndex        =   20
         Top             =   1320
         Width           =   1515
      End
      Begin VB.Label Label40 
         AutoSize        =   -1  'True
         BackColor       =   &H00EB9F6C&
         Caption         =   "Program Author  :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   360
         TabIndex        =   19
         Top             =   1320
         Width           =   1740
      End
      Begin VB.Label Label41 
         AutoSize        =   -1  'True
         BackColor       =   &H00EB9F6C&
         Caption         =   "Version :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   360
         TabIndex        =   18
         Top             =   960
         Width           =   855
      End
      Begin VB.Label Label42 
         AutoSize        =   -1  'True
         BackColor       =   &H00EB9F6C&
         Caption         =   "Windows version 1.1  "
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   2280
         TabIndex        =   17
         Top             =   960
         Width           =   2130
      End
      Begin VB.Label Label43 
         AutoSize        =   -1  'True
         BackColor       =   &H00EB9F6C&
         Caption         =   "Email ID  :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   360
         TabIndex        =   16
         Top             =   1680
         Width           =   1005
      End
      Begin VB.Label Label44 
         AutoSize        =   -1  'True
         BackColor       =   &H00EB9F6C&
         Caption         =   "Web site  :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   360
         TabIndex        =   15
         Top             =   2040
         Width           =   1020
      End
   End
   Begin VB.Frame Frame 
      BackColor       =   &H00EB9F6C&
      BorderStyle     =   0  'None
      Height          =   5415
      Index           =   0
      Left            =   0
      TabIndex        =   0
      Top             =   8760
      Width           =   7215
      Begin Winsplit.ctlbutton ctlbuttonsplit 
         Height          =   375
         Left            =   2520
         TabIndex        =   44
         Top             =   4920
         Width           =   1335
         _ExtentX        =   2355
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         HoverColor      =   15441772
         Text            =   "GO"
         BackColor       =   16044731
      End
      Begin Winsplit.ctlbutton ctlbuttonbrowsesplitfolder 
         Height          =   375
         Left            =   5640
         TabIndex        =   43
         Top             =   2160
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         HoverColor      =   15441772
         Text            =   "Browse..."
         BackColor       =   16044731
      End
      Begin Winsplit.ctlbutton ctlbuttonbrowsesplitfile 
         Height          =   375
         Left            =   5640
         TabIndex        =   42
         Top             =   1155
         Width           =   1095
         _ExtentX        =   1931
         _ExtentY        =   661
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         HoverColor      =   15441772
         Text            =   "Browse..."
         BackColor       =   16044731
      End
      Begin VB.TextBox txtSize 
         Appearance      =   0  'Flat
         BackColor       =   &H00FFFFFF&
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   330
         Left            =   5160
         TabIndex        =   8
         Top             =   4080
         Width           =   1695
      End
      Begin VB.ComboBox cmbType 
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   360
         ItemData        =   "Splitter.frx":08DB
         Left            =   5160
         List            =   "Splitter.frx":08DD
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   3360
         Width           =   1695
      End
      Begin VB.TextBox txtsplitFilename 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Left            =   360
         TabIndex        =   6
         Top             =   1200
         Width           =   5055
      End
      Begin VB.TextBox txtsplitOutputDir 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         Left            =   360
         TabIndex        =   5
         Top             =   2160
         Width           =   5055
      End
      Begin VB.Label Label8 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "SPLITTER"
         BeginProperty Font 
            Name            =   "Times New Roman"
            Size            =   14.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   330
         Left            =   360
         TabIndex        =   34
         Top             =   240
         Width           =   1425
      End
      Begin VB.Label Label4 
         BackColor       =   &H00EB9F6C&
         Caption         =   "Enter the size in which the files will be splitted. (not needed if format is 1.44Mb Floppy) :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   435
         Left            =   360
         TabIndex        =   14
         Top             =   4080
         Width           =   4650
      End
      Begin VB.Label Label5 
         BackColor       =   &H00EB9F6C&
         Caption         =   "Choose the format in which the files has to be splitted :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   435
         Left            =   360
         TabIndex        =   13
         Top             =   3240
         Width           =   4515
      End
      Begin VB.Label lblFilelength 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   300
         Left            =   2040
         TabIndex        =   12
         Top             =   2760
         Width           =   2775
      End
      Begin VB.Label Label2 
         BackColor       =   &H00EB9F6C&
         Caption         =   "Name of the Output folder where the splitted files will be saved :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   360
         TabIndex        =   11
         Top             =   1800
         Width           =   6405
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackColor       =   &H00EB9F6C&
         Caption         =   "Name of the file that has to be splitted :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   360
         TabIndex        =   10
         Top             =   840
         Width           =   3885
      End
      Begin VB.Label Label7 
         AutoSize        =   -1  'True
         BackColor       =   &H00EB9F6C&
         Caption         =   "Size of the file :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   195
         Left            =   360
         TabIndex        =   9
         Top             =   2820
         Width           =   1530
      End
   End
   Begin Winsplit.ctlbutton ctlbuttonmenu 
      Height          =   195
      Index           =   1
      Left            =   8400
      TabIndex        =   52
      Top             =   120
      Width           =   255
      _ExtentX        =   450
      _ExtentY        =   344
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      HoverColor      =   63744
      Text            =   " "
      BackColor       =   38656
   End
   Begin Winsplit.ctlbutton ctlbuttonsidemenu 
      Height          =   1200
      Index           =   0
      Left            =   120
      TabIndex        =   55
      Top             =   720
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   2117
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      HoverColor      =   15441772
      Text            =   "SPLITTER"
      BackColor       =   16044731
   End
   Begin Winsplit.ctlbutton ctlbuttonsidemenu 
      Height          =   1200
      Index           =   1
      Left            =   120
      TabIndex        =   56
      Top             =   2040
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   2117
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      HoverColor      =   15441772
      Text            =   "MERGER"
      BackColor       =   16044731
   End
   Begin Winsplit.ctlbutton ctlbuttonsidemenu 
      Height          =   1200
      Index           =   2
      Left            =   120
      TabIndex        =   57
      Top             =   3360
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   2117
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      HoverColor      =   15441772
      Text            =   "HELP"
      BackColor       =   16044731
   End
   Begin Winsplit.ctlbutton ctlbuttonsidemenu 
      Height          =   1200
      Index           =   3
      Left            =   120
      TabIndex        =   54
      Top             =   4680
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   2117
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      HoverColor      =   15441772
      Text            =   "ABOUT"
      BackColor       =   16044731
   End
   Begin VB.Label lbltitle 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "WINSPLIT 1.1  - Let it do the splitting......"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   195
      Left            =   960
      TabIndex        =   41
      Top             =   120
      Width           =   3975
   End
   Begin VB.Image imgicon 
      Height          =   480
      Left            =   240
      Picture         =   "Splitter.frx":08DF
      Top             =   0
      Width           =   480
   End
   Begin VB.Image imgBottombar 
      Height          =   360
      Left            =   0
      Picture         =   "Splitter.frx":0BE9
      Stretch         =   -1  'True
      Top             =   6195
      Width           =   10155
   End
   Begin VB.Image imgTitlebar 
      Height          =   435
      Left            =   0
      Picture         =   "Splitter.frx":3C8B
      Stretch         =   -1  'True
      Top             =   0
      Width           =   9255
   End
End
Attribute VB_Name = "frmSplitter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim closeit As Integer

Private Sub ctlbutton1_Click()

End Sub

Private Sub ctlbuttonbackfromoperation_Click()
ctlbuttonbackfromoperation.hover = False
If operation = 0 Then
  Call ctlbuttonsidemenu_Click(0)
Else
  Call ctlbuttonsidemenu_Click(1)
End If
End Sub

Private Sub ctlbuttonbackfromoperation_MouseOut()
ctlbuttonbackfromoperation.hover = False
End Sub

Private Sub ctlbuttonbackfromoperation_MouseOver()
ctlbuttonbackfromoperation.hover = True
End Sub

Private Sub ctlbuttonLegalDisclaimer_Click()
If MsgBox("Winsplit is a Freeware Utility .This program can be freely distibuted for any non-commercial use.Usage of this program for any commercial purpose would require the permission of the program author.Any body using this programm should use at his/her own risk.The author of this programm cannot be held responsible for any damages or loss occuring due to this programm or the use of this programm." & Chr(13) & Chr(13) & "Click 'Yes' to accept the disclaimer or 'No' to reject.(Click 'Yes' to continue or 'No' to end this program)", vbYesNo + vbDefaultButton1 + vbInformation) = vbNo Then
 Call Form_Unload(closeit)
End If
End Sub

Private Sub ctlbuttonbrowsesplitfile_MouseOut()
ctlbuttonbrowsesplitfile.hover = False
End Sub

Private Sub ctlbuttonbrowsesplitfile_Mouseover()
ctlbuttonbrowsesplitfile.hover = True
End Sub

Private Sub ctlbuttonbrowsesplitfolder_MouseOut()
ctlbuttonbrowsesplitfolder.hover = False
End Sub

Private Sub ctlbuttonbrowsesplitfolder_Mouseover()
ctlbuttonbrowsesplitfolder.hover = True
End Sub

Private Sub ctlbuttonLegalDisclaimer_MouseOut()
ctlbuttonLegalDisclaimer.hover = False
End Sub

Private Sub ctlbuttonLegalDisclaimer_Mouseover()
ctlbuttonLegalDisclaimer.hover = True
End Sub

Private Sub ctlbuttonmenu_Click(Index As Integer)
ctlbuttonmenu(Index).hover = False
If Index = 0 Then
    Call Form_Unload(closeit)
Else
  Me.BorderStyle = 2
  Me.WindowState = vbMinimized
End If
End Sub

Private Sub ctlbuttonmenu_MouseOut(Index As Integer)
ctlbuttonmenu(Index).hover = False
End Sub

Private Sub ctlbuttonmenu_Mouseover(Index As Integer)
ctlbuttonmenu(Index).hover = True
ctlbuttonmenu(Index).ToolTipText = "DSSSSSSSSSSSS"
End Sub

Private Sub ctlbuttonmergebrowsefile_MouseOut()
ctlbuttonmergebrowsefile.hover = False
End Sub

Private Sub ctlbuttonmergebrowsefile_Mouseover()
ctlbuttonmergebrowsefile.hover = True
End Sub

Private Sub ctlbuttonmergebrowsefolder_MouseOut()
ctlbuttonmergebrowsefolder.hover = False
End Sub

Private Sub ctlbuttonmergebrowsefolder_Mouseover()
ctlbuttonmergebrowsefolder.hover = True
End Sub

Private Sub ctlbuttonmergefiles_MouseOut()
ctlbuttonmergefiles.hover = False
End Sub

Private Sub ctlbuttonmergefiles_Mouseover()
ctlbuttonmergefiles.hover = True
End Sub

Private Sub ctlbuttonoperation_MouseOut()
ctlbuttonoperation.hover = False
End Sub

Private Sub ctlbuttonoperation_Mouseover()
ctlbuttonoperation.hover = True
End Sub

Private Sub ctlbuttonsidemenu_Click(Index As Integer)
Dim count As Integer, a As Integer

For count = 0 To Frame.count - 1
 Frame(count).Height = 5415
 Frame(count).Width = 7335
 Frame(count).Left = 1500
 Frame(count).Top = 480
 Frame(count).Visible = False
Next

Select Case Index
Case 0: a = 0
Case 1: a = 3
Case 2: a = 4
Case 3: a = 1
End Select


 Frame(a).Visible = True
 ctlbuttonbackfromoperation.Visible = True
End Sub

Private Sub ctlbuttonsidemenu_MouseOut(Index As Integer)
'ctlbuttonsidemenu(Index).hover = False
End Sub

Private Sub ctlbuttonsidemenu_MouseOver(Index As Integer)
Dim a As Integer
For a = 0 To ctlbuttonsidemenu.count - 1
  If ctlbuttonsidemenu(a).hover Then
    ctlbuttonsidemenu(a).hover = False
  End If
Next
ctlbuttonsidemenu(Index).hover = True

End Sub

Private Sub ctlbuttonsplit_MouseOut()
ctlbuttonsplit.hover = False
End Sub

Private Sub ctlbuttonsplit_Mouseover()
ctlbuttonsplit.hover = True
End Sub



Private Sub Form_Load()
cmdg.OwnerHwnd = Me.hwnd
Me.Height = 6500
Call ctlbuttonsidemenu_Click(3)
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
   Dim lngReturnValue As Long
   If Button = 1 Then
      Call ReleaseCapture
      lngReturnValue = SendMessage(Me.hwnd, WM_NCLBUTTONDOWN, HTCAPTION, 0&)
  End If
  
  If ctlbuttonbrowsesplitfile.hover Then
    ctlbuttonbrowsesplitfile.hover = False
  End If
  
  If ctlbuttonbrowsesplitfolder.hover Then
      ctlbuttonbrowsesplitfolder.hover = False
  End If
  
  If ctlbuttonsplit.hover Then
      ctlbuttonsplit.hover = False
  End If
  
  If ctlbuttonLegalDisclaimer.hover Then
     ctlbuttonLegalDisclaimer.hover = False
  End If
  
 
  If ctlbuttonoperation.hover Then
     ctlbuttonoperation.hover = False
  End If
  
  If ctlbuttonmergebrowsefile.hover Then
     ctlbuttonmergebrowsefile.hover = False
  End If
  
  If ctlbuttonmergebrowsefolder.hover Then
     ctlbuttonmergebrowsefolder.hover = False
  End If
  
  If ctlbuttonmergefiles.hover Then
     ctlbuttonmergefiles.hover = False
  End If
  
  Screen.MousePointer = 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
Dim temp As Integer
If Cancel <> 1 Then
    temp = MsgBox(" Are You sure You want to Quit????", vbExclamation + vbYesNo + vbDefaultButton2, "Winsplit")
    If temp = vbYes Then
       Call closeprog
    End If
Else
  MsgBox " Press Cancel to stop operation and then click the exit button !!!!", vbExclamation + vbOK, "Winsplit"
End If
End Sub

Private Sub Frame_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
Call Form_MouseMove(Button, Shift, X, Y)
End Sub

Private Sub ctlbuttonMergefiles_Click()
Dim count As Integer

operation = 1 'set the gloval operation varialble to 0
If validatemergefileinfo(txtUnsplitFilename, txtUnsplitOutputDir) Then
    For count = 0 To Frame.count - 1
       Frame(count).Visible = False
    Next
    Call show_progress_screen
End If
End Sub

Private Sub ctlbuttonmergebrowsefile_Click()
cmdg.Dialogtitle = "Select one of the splitted file"
cmdg.ShowOpen
If Trim(cmdg.FileName) <> "" Then
  txtUnsplitFilename = cmdg.FileName
End If
End Sub

Private Sub ctlbuttonMergeBrowseFolder_Click()
cmdg.Dialogtitle = "Select the Folder where the splitted files will be saved."
cmdg.ShowBrowsefolder
If Trim(cmdg.Foldername) <> "" Then
  txtUnsplitOutputDir = cmdg.Foldername
End If
End Sub

Private Sub ctlbuttonsplit_Click()
Dim count As Integer

operation = 0 'set the global operation varialble to 0
If validatesplitfileinfo(txtsplitFilename.Text, txtsplitOutputDir.Text, cmbType.Text, txtSize.Text) Then
    For count = 0 To Frame.count - 1
       Frame(count).Visible = False
    Next
    Call show_progress_screen
End If
End Sub

Private Sub ctlbuttonbrowsesplitfile_Click()
cmdg.OwnerHwnd = frmSplitter.hwnd
cmdg.Dialogtitle = "Select the File Which has to be splitted"
cmdg.ShowOpen
If Trim(cmdg.FileName) <> "" Then
  txtsplitFilename = cmdg.FileName
End If

Call getfilelength(txtsplitFilename)
Call txtsplitFilename_LostFocus
End Sub
'
Private Sub ctlbuttonbrowsesplitfolder_Click()
cmdg.OwnerHwnd = frmSplitter.hwnd
cmdg.Dialogtitle = "Select the Folder where the splitted files will be saved"
cmdg.ShowBrowsefolder
If Trim(cmdg.Foldername) <> "" Then
  txtsplitOutputDir = cmdg.Foldername
End If
End Sub

Private Sub cmbType_Click()
If cmbType.Text = floppy Then
 txtSize.Enabled = False
 txtSize.BackColor = &H8000000F
 txtSize = ""
Else
 txtSize.Enabled = True
 txtSize.BackColor = vbWhite
End If

End Sub

Private Sub lbltitle_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Call Form_MouseMove(Button, Shift, X, Y)
End Sub

Private Sub tmrflash_Timer()

End Sub

Private Sub tmrdelaycancel_Timer()
ctlbuttonoperation.Enabled = True
End Sub

Private Sub txtSize_KeyPress(KeyAscii As Integer)
On Error GoTo errorhnd:
If (KeyAscii >= 48 And KeyAscii <= 57) Then
Exit Sub
ElseIf KeyAscii = 8 Or KeyAscii = 46 Then
Exit Sub
Else
KeyAscii = 0
End If
errorhnd:
End Sub
'
Private Sub txtsplitFilename_LostFocus()
On Error GoTo errorhnd:
Dim filelength As Single

filelength = getfilelength(txtsplitFilename)
If filelength = 0 Then
cmbType.Clear
lblFilelength = ""
End If
If filelength > 0 Then
  Call formatlabelandcombo(filelength, lblFilelength, cmbType) 'for diaplaying the size and filling the combobox with appropiate values
End If
errorhnd:

End Sub


Private Sub imgBottombar_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Call Form_MouseMove(Button, Shift, X, Y)
End Sub

Private Sub imgclose_Click()
Call Form_Unload(closeit)
End Sub

'Private Sub imgmenucontainer_Click(Index As Integer)
'Dim count As Integer, a As Integer
'
'For count = 0 To Frame.count - 1
' Frame(count).Height = 5055
' Frame(count).Width = 7335
' Frame(count).Left = 1800
' Frame(count).Top = 480
' Frame(count).Visible = False
'Next
'
'Select Case Index
'Case 0: a = 0
'Case 1: a = 3
'Case 2: a = 4
'Case 3: a = 1
'End Select
'
'
' Frame(a).Visible = True
'
'End Sub

'Private Sub imgmenucontainer_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
'Dim count As Integer
'Static presenttab As Integer
'Static selected As Boolean
'
'If presenttab <> Index Or selected = False Then
'  For count = 0 To imgSelectionbar.count - 1
'    imgSelectionbar(count).Visible = False
'  Next
'  imgSelectionbar(Index).Visible = True
'End If
'  presenttab = Index
'  selected = True
'End Sub

Private Sub imgminimize_Click()
Me.WindowState = vbMinimized
End Sub

Private Sub imgTitlebar_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Call Form_MouseMove(Button, Shift, X, Y)
End Sub

Private Sub lblOverwritefiles_Click()
 If chkOverwritefiles.Value Then
     chkOverwritefiles.Value = 0
 Else
     chkOverwritefiles.Value = 1
 End If
End Sub

Private Sub chkOverwritefiles_Click()
If chkOverwritefiles.Value = 1 Then
  overwritewithoutprompt = True
Else
  overwritewithoutprompt = False
End If
End Sub

Private Sub ctlbuttonoperation_Click()
Dim success As Boolean
Dim outputdir As String
Dim count As Integer

Select Case ctlbuttonoperation.Text
 Case "START":
                'disable the menuctlbuttonsidemenu
               For count = 0 To ctlbuttonsidemenu.count - 1
                 ctlbuttonsidemenu(count).Enabled = False
               Next
               ctlbuttonbackfromoperation.Visible = False
               Call Sleep(500)
              DoEvents
              closeit = 1 'disable the close
              lbloperationText.Caption = "Press 'CANCEL' to stop ."
              ctlbuttonoperation.Text = "CANCEL"
              If operation = 0 Then
                  success = splitfiles(frmSplitter.txtsplitFilename.Text, frmSplitter.txtsplitOutputDir.Text, frmSplitter.cmbType.Text, frmSplitter.txtSize.Text, frmSplitter.progressbar)
                  If success Then
                      lbloperationText.Caption = "Splitting of files Completed."
                  Else
                      lbloperationText.Caption = "ERROR - File Splitting not completed."
                  End If
              Else
                  success = mergefiles(frmSplitter.txtUnsplitFilename.Text, frmSplitter.txtUnsplitOutputDir.Text, progressbar)
                  If success Then
                     lbloperationText.Caption = "Merging of files Completed."
                  Else
                      lbloperationText.Caption = "ERROR - File Merging not completed."
                  End If
              End If
              
              If success Then
'                 If Me.WindowState = vbMinimized Then
'                     tmrflash.Interval = 200
'                     tmrflash.Enabled = True
'                     flash = True
'                 End If
              
                 ctlbuttonoperation.Text = " DONE "
                 chkOverwritefiles.Visible = False
              Else
                 If canceloperation = True Then
                    lbloperationText.Caption = "Deleting all created files...."
                    chkOverwritefiles.Visible = False
                 End If
                 
                 If operation = 0 Then
                      outputdir = frmSplitter.txtsplitOutputDir.Text
                 Else
                      outputdir = frmSplitter.txtUnsplitOutputDir.Text
                 End If
                 Call deletecreatedfiles(progressbar, outputdir, outputmergefilename, operation)
                 Call cleanup(frmSplitter.txtsplitFilename, frmSplitter.txtsplitOutputDir, progressbar, frmSplitter.txtUnsplitFilename, frmSplitter.txtUnsplitOutputDir, frmSplitter.lblFilelength, frmSplitter.txtSize, frmSplitter.cmbType)
                 lbloperationText.Caption = "Operation Cancelled ...."
                 ctlbuttonoperation.Text = " DONE "
                 chkOverwritefiles.Visible = False
              End If
             closeit = 0 'enable the close button

 Case "CANCEL":
               canceloperation = True
 Case " DONE ":
             closeit = 0
             
'             'enable the menu
             For count = 0 To ctlbuttonsidemenu.count - 1
                 ctlbuttonsidemenu(count).Enabled = True
             Next
             Call ctlbuttonsidemenu_Click(3)
             Call cleanup(frmSplitter.txtsplitFilename, frmSplitter.txtsplitOutputDir, progressbar, frmSplitter.txtUnsplitFilename, frmSplitter.txtUnsplitOutputDir, frmSplitter.lblFilelength, frmSplitter.txtSize, frmSplitter.cmbType)

End Select
lbloperationText.Left = Frame(2).Width / 2 - lbloperationText.Width / 2
End Sub

'fun to disable the menus after the users selects something.
Public Sub show_progress_screen()
 lbloperationText.Caption = "Press 'START' to begin ."
 ctlbuttonoperation.Text = "START"
 closeit = 0
lbloperationText.Left = Frame(2).Width / 2 - lbloperationText.Width / 2
Frame(2).Visible = True
chkOverwritefiles.Value = 0
chkOverwritefiles.Visible = True
End Sub

