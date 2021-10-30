VERSION 5.00
Object = "{BDC217C8-ED16-11CD-956C-0000C04E4C0A}#1.1#0"; "TABCTL32.OCX"
Begin VB.Form Form2 
   Caption         =   "Form2"
   ClientHeight    =   6990
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   11520
   BeginProperty Font 
      Name            =   "Verdana"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   LinkTopic       =   "Form2"
   ScaleHeight     =   6990
   ScaleWidth      =   11520
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdCancel 
      Caption         =   "CANCEL"
      Height          =   375
      Left            =   6713
      TabIndex        =   3
      Top             =   6120
      Width           =   1215
   End
   Begin VB.CommandButton cmdBack 
      Caption         =   "BACK"
      Height          =   375
      Left            =   3593
      TabIndex        =   2
      Top             =   6120
      Width           =   1215
   End
   Begin VB.CommandButton cmdNext 
      Caption         =   "NEXT"
      Height          =   375
      Left            =   5153
      TabIndex        =   1
      Top             =   6120
      Width           =   1335
   End
   Begin TabDlg.SSTab contractTab 
      Height          =   5895
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   11535
      _ExtentX        =   20346
      _ExtentY        =   10398
      _Version        =   393216
      Tabs            =   8
      TabsPerRow      =   4
      TabHeight       =   520
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      TabCaption(0)   =   "BUYERS"
      TabPicture(0)   =   "contractnew.frx":0000
      Tab(0).ControlEnabled=   -1  'True
      Tab(0).Control(0)=   "lblBuyersDetails"
      Tab(0).Control(0).Enabled=   0   'False
      Tab(0).Control(1)=   "lblWarehousedetails"
      Tab(0).Control(1).Enabled=   0   'False
      Tab(0).Control(2)=   "cmbBuyersCompanyName"
      Tab(0).Control(2).Enabled=   0   'False
      Tab(0).Control(3)=   "cmbWareHouseDetails"
      Tab(0).Control(3).Enabled=   0   'False
      Tab(0).ControlCount=   4
      TabCaption(1)   =   "SELLERS"
      TabPicture(1)   =   "contractnew.frx":001C
      Tab(1).ControlEnabled=   0   'False
      Tab(1).Control(0)=   "Combo1"
      Tab(1).Control(1)=   "Label1"
      Tab(1).ControlCount=   2
      TabCaption(2)   =   "PRODUCT DETAILS"
      TabPicture(2)   =   "contractnew.frx":0038
      Tab(2).ControlEnabled=   0   'False
      Tab(2).ControlCount=   0
      TabCaption(3)   =   "PACKING && DELIVERY"
      TabPicture(3)   =   "contractnew.frx":0054
      Tab(3).ControlEnabled=   0   'False
      Tab(3).ControlCount=   0
      TabCaption(4)   =   "PAYMENT"
      TabPicture(4)   =   "contractnew.frx":0070
      Tab(4).ControlEnabled=   0   'False
      Tab(4).ControlCount=   0
      TabCaption(5)   =   "TERMS"
      TabPicture(5)   =   "contractnew.frx":008C
      Tab(5).ControlEnabled=   0   'False
      Tab(5).ControlCount=   0
      TabCaption(6)   =   "BROKERAGE"
      TabPicture(6)   =   "contractnew.frx":00A8
      Tab(6).ControlEnabled=   0   'False
      Tab(6).ControlCount=   0
      TabCaption(7)   =   "FINISH"
      TabPicture(7)   =   "contractnew.frx":00C4
      Tab(7).ControlEnabled=   0   'False
      Tab(7).ControlCount=   0
      Begin VB.ComboBox cmbWareHouseDetails 
         Height          =   360
         Left            =   3360
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Top             =   3120
         Width           =   4095
      End
      Begin VB.ComboBox Combo1 
         Height          =   360
         Left            =   -72120
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   1320
         Width           =   4095
      End
      Begin VB.ComboBox cmbBuyersCompanyName 
         Height          =   360
         Left            =   3360
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   1320
         Width           =   4095
      End
      Begin VB.Label lblWarehousedetails 
         Caption         =   "dsdsd"
         Height          =   375
         Left            =   3480
         TabIndex        =   9
         Top             =   3720
         Width           =   1815
      End
      Begin VB.Label Label1 
         Caption         =   "Label1dfasafdss"
         Height          =   1695
         Left            =   -72000
         TabIndex        =   7
         Top             =   2040
         Width           =   3975
      End
      Begin VB.Label lblBuyersDetails 
         AutoSize        =   -1  'True
         Caption         =   "dsdsdsddsd"
         Height          =   240
         Left            =   3360
         TabIndex        =   5
         Top             =   1920
         Width           =   1140
      End
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim db As Database
Dim rs As Recordset
Dim strSQl As String

Private Sub cmbBuyersCompanyName_Click()
Dim str As String
rs.MoveFirst
rs.AbsolutePosition = cmbBuyersCompanyName.ListIndex
str = rs.Fields("company name") & Chr(13) & rs.Fields("Address") & Chr(13) & rs.Fields("state")
lblBuyersDetails.Caption = str

End Sub

Private Sub cmdNext_Click()
If contractTab.Tab >= contractTab.Tabs - 1 Then
 contractTab.Tab = 0
Else
 contractTab.Tab = contractTab.Tab + 1
End If

End Sub

Private Sub Form_Load()
Set db = OpenDatabase(App.Path & "\access database\database.mdb")
strSQl = "select * from buyers"
Set rs = db.OpenRecordset(strSQl)
While Not rs.EOF
 cmbBuyersCompanyName.AddItem rs.Fields("Company name")
 rs.MoveNext
Wend
End Sub

