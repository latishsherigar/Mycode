VERSION 5.00
Begin VB.Form frmContracts 
   Caption         =   "Contract Document Generator"
   ClientHeight    =   8040
   ClientLeft      =   60
   ClientTop       =   555
   ClientWidth     =   11535
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   ScaleHeight     =   8040
   ScaleWidth      =   11535
   StartUpPosition =   1  'CenterOwner
   WindowState     =   2  'Maximized
   Begin VB.ComboBox cmbBrokerageID 
      Height          =   315
      Left            =   840
      TabIndex        =   54
      Text            =   "Combo4"
      Top             =   7560
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.ComboBox cmbPaymentTypeID 
      Height          =   315
      Left            =   480
      TabIndex        =   53
      Text            =   "Combo2"
      Top             =   7560
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.ComboBox cmbDeliveryTimeStyleID 
      Height          =   315
      Left            =   120
      TabIndex        =   52
      Text            =   "Combo1"
      Top             =   7560
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.ComboBox cmbBagProviderID 
      Height          =   315
      Left            =   2640
      TabIndex        =   51
      Text            =   "Combo4"
      Top             =   7200
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.ComboBox cmbPackingExtraID 
      Height          =   315
      Left            =   2280
      TabIndex        =   50
      Text            =   "Combo3"
      Top             =   7200
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.ComboBox cmbBagTypeID 
      Height          =   315
      Left            =   1920
      TabIndex        =   49
      Text            =   "Combo2"
      Top             =   7200
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.ComboBox cmbDeliveryTypeID 
      Height          =   315
      Left            =   1560
      TabIndex        =   48
      Text            =   "Combo1"
      Top             =   7200
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.ComboBox cmbWeightBasisID 
      Height          =   315
      Left            =   1200
      TabIndex        =   47
      Top             =   7200
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.ComboBox cmbProductsId 
      Height          =   315
      Left            =   840
      TabIndex        =   46
      Text            =   "Combo1"
      Top             =   7200
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.ComboBox cmbSellersID 
      Height          =   315
      Left            =   480
      TabIndex        =   45
      Text            =   "Combo1"
      Top             =   7200
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.ComboBox cmbBuyersID 
      Height          =   315
      Left            =   120
      TabIndex        =   44
      Top             =   7200
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.CommandButton cmdProducewordDoc 
      Caption         =   "Produce Word  Document"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   3990
      TabIndex        =   42
      Top             =   7200
      Width           =   3375
   End
   Begin VB.TextBox txtBrokerage 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   6930
      TabIndex        =   40
      Top             =   6600
      Width           =   4215
   End
   Begin VB.ComboBox cmbBrokerage 
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
      Left            =   1560
      TabIndex        =   39
      Top             =   6600
      Width           =   3495
   End
   Begin VB.ListBox lstTerms 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   600
      Left            =   1560
      Style           =   1  'Checkbox
      TabIndex        =   37
      Top             =   5760
      Width           =   9735
   End
   Begin VB.ComboBox cmbPaymentType 
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
      Left            =   1560
      TabIndex        =   35
      Top             =   5280
      Width           =   9735
   End
   Begin VB.TextBox txtDeliveryTo 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   9600
      TabIndex        =   31
      Top             =   4800
      Width           =   1575
   End
   Begin VB.TextBox txtDeliveryFrom 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   7200
      TabIndex        =   30
      Top             =   4800
      Width           =   1455
   End
   Begin VB.ComboBox cmbDeliveryTimeStyle 
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
      Left            =   1560
      TabIndex        =   29
      Top             =   4800
      Width           =   4215
   End
   Begin VB.ComboBox cmbBagProvider 
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
      Left            =   7200
      TabIndex        =   27
      Top             =   4200
      Width           =   3975
   End
   Begin VB.ComboBox cmbPackingextra 
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
      Left            =   1560
      TabIndex        =   25
      Top             =   4200
      Width           =   3855
   End
   Begin VB.ComboBox cmbBagType 
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
      Left            =   7200
      TabIndex        =   23
      Top             =   3720
      Width           =   3975
   End
   Begin VB.TextBox txtWeight 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1560
      TabIndex        =   21
      Top             =   3720
      Width           =   3855
   End
   Begin VB.ComboBox cmbDeliveryType 
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
      Left            =   7200
      TabIndex        =   19
      Top             =   3240
      Width           =   3975
   End
   Begin VB.TextBox txtPrice 
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
      Left            =   1560
      TabIndex        =   17
      Top             =   3250
      Width           =   3855
   End
   Begin VB.TextBox txtSpecification 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   7200
      TabIndex        =   15
      Top             =   2400
      Width           =   3975
   End
   Begin VB.ComboBox cmbWeightBasis 
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
      Left            =   7200
      TabIndex        =   10
      Top             =   2760
      Width           =   3975
   End
   Begin VB.TextBox txtQuantity 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1560
      TabIndex        =   8
      Top             =   2880
      Width           =   3855
   End
   Begin VB.ComboBox cmbProduct 
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
      Left            =   1560
      TabIndex        =   7
      Top             =   2400
      Width           =   3855
   End
   Begin VB.ComboBox cmbSeller 
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
      Left            =   1560
      TabIndex        =   6
      Top             =   1920
      Width           =   9615
   End
   Begin VB.ComboBox cmbBuyerWarehouse 
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
      Left            =   1560
      TabIndex        =   4
      Top             =   1440
      Width           =   9615
   End
   Begin VB.ComboBox cmbBuyer 
      DataSource      =   "AdodcContracts"
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
      Left            =   1560
      TabIndex        =   2
      Top             =   960
      Width           =   9615
   End
   Begin VB.TextBox txtContractID 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1560
      TabIndex        =   0
      Top             =   600
      Width           =   1935
   End
   Begin VB.Label Label22 
      AutoSize        =   -1  'True
      Caption         =   "Contract Document Generator"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   270
      Left            =   4320
      TabIndex        =   43
      Top             =   240
      Width           =   3690
   End
   Begin VB.Label Label21 
      AutoSize        =   -1  'True
      Caption         =   "Brokerage Text :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   5160
      TabIndex        =   41
      Top             =   6600
      Width           =   1665
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      Caption         =   "Brokerage :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   38
      Top             =   6600
      Width           =   1140
   End
   Begin VB.Label Label20 
      Caption         =   "Other Terms :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   360
      TabIndex        =   36
      Top             =   5880
      Width           =   705
   End
   Begin VB.Label Label19 
      AutoSize        =   -1  'True
      Caption         =   "Payment :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   34
      Top             =   5400
      Width           =   1020
   End
   Begin VB.Label Label18 
      AutoSize        =   -1  'True
      Caption         =   "To :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   9000
      TabIndex        =   33
      Top             =   4800
      Width           =   420
   End
   Begin VB.Label Label17 
      AutoSize        =   -1  'True
      Caption         =   "From :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   6450
      TabIndex        =   32
      Top             =   4800
      Width           =   645
   End
   Begin VB.Label Label16 
      AutoSize        =   -1  'True
      Caption         =   "Delivery :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   28
      Top             =   4800
      Width           =   945
   End
   Begin VB.Label Label15 
      AutoSize        =   -1  'True
      Caption         =   "Bag Provider :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   5640
      TabIndex        =   26
      Top             =   4200
      Width           =   1395
   End
   Begin VB.Label Label14 
      AutoSize        =   -1  'True
      Caption         =   "Type :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   24
      Top             =   4200
      Width           =   660
   End
   Begin VB.Label Label13 
      AutoSize        =   -1  'True
      Caption         =   "Bag Type :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   5640
      TabIndex        =   22
      Top             =   3720
      Width           =   1095
   End
   Begin VB.Label Label12 
      AutoSize        =   -1  'True
      Caption         =   "Packing :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   20
      Top             =   3720
      Width           =   915
   End
   Begin VB.Label Label11 
      AutoSize        =   -1  'True
      Caption         =   "Delivery Type :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   5640
      TabIndex        =   18
      Top             =   3240
      Width           =   1515
   End
   Begin VB.Label Label10 
      Caption         =   "Price"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   480
      TabIndex        =   16
      Top             =   3240
      Width           =   570
   End
   Begin VB.Label Label9 
      AutoSize        =   -1  'True
      Caption         =   "Specification :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   5640
      TabIndex        =   14
      Top             =   2400
      Width           =   1440
   End
   Begin VB.Label Label8 
      AutoSize        =   -1  'True
      Caption         =   "Product :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   13
      Top             =   2520
      Width           =   930
   End
   Begin VB.Label Label7 
      AutoSize        =   -1  'True
      Caption         =   "Sellers :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   330
      TabIndex        =   12
      Top             =   2040
      Width           =   810
   End
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      Caption         =   "Weight Basis : "
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   5640
      TabIndex        =   11
      Top             =   2880
      Width           =   1500
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "Quantity :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   9
      Top             =   2880
      Width           =   1020
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "WareHouse"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   330
      TabIndex        =   5
      Top             =   1560
      Width           =   1110
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Buyer"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   330
      TabIndex        =   3
      Top             =   1080
      Width           =   555
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Contract ID"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   330
      TabIndex        =   1
      Top             =   600
      Width           =   1155
   End
End
Attribute VB_Name = "frmContracts"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim db As Database
Dim rs As Recordset
Dim var As String

Private Sub cmbBuyer_Click()
Dim id As String, strSQl As String
id = cmbBuyersID.List(cmbBuyer.ListIndex)
strSQl = "Select warehousedetails from Buyerwarehousedetails where BuyerId = '" & id & "'"
Set rs = db.OpenRecordset(strSQl)
cmbBuyerWarehouse.Clear
Do While Not rs.EOF
cmbBuyerWarehouse.AddItem rs.Fields(0)
 rs.MoveNext
Loop
End Sub



Private Sub cmbProduct_Click()
Dim strSQl As String, id As String

id = cmbProductsId.List(cmbProduct.ListIndex)
strSQl = "Select Products.Specification from Products where Product_Id = '" & id & "'"
Set rs = db.OpenRecordset(strSQl)
txtSpecification.Text = rs.Fields(0)
End Sub

Private Sub cmdProducewordDoc_Click()
'If Not (objaccdoc Is Nothing) Then
' MsgBox "application launched"
' Exit Sub
'End If
'
'
'objwordapp.Height = 200
'objwordapp.Left = 0
'objwordapp.Top = 0
'objwordapp.Visible = True

'Set objworddoc = Documents.Open(App.Path & "\finaltemp.doc")
''Dim rngRange As Word.Range
''Set rngRange = ActiveDocument.Bookmarks("BuyersDetails").Range
''rngRange.InsertBefore Str
'Dim strbuyer As String
'strbuyer = frmContracts.cmbBuyer.Text
''ActiveDocument.FormFields.Item (0)
''ActiveDocument.FormFields(0).Result = "adsdsa"

End Sub


Private Sub Form_Load()
'Dim id As String, strSQL As String
'
'Set db = OpenDatabase(App.Path & "/access database/database.mdb")
'
''populate the buyers combobox.
'strSQL = "SELECT * FROM Buyers"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' cmbBuyer.AddItem rs.Fields("BuyersDetails")
' cmbBuyersID.AddItem rs.Fields(0)
' rs.MoveNext
'Wend
'
''Populate the Sellers combobox
'strSQL = "SELECT * FROM Sellers"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' cmbSeller.AddItem rs.Fields("Details")
' cmbSellersID.AddItem rs.Fields(0)
' rs.MoveNext
'Wend
'
''Populate the Products combobox
'strSQL = "SELECT * FROM Products"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' cmbProduct.AddItem rs.Fields("Details")
' cmbProductsId.AddItem rs.Fields(0)
' rs.MoveNext
'Wend
'
'
''Populate the Weight Basis combobox
'strSQL = "SELECT * FROM weightbasisdetails"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' cmbWeightBasis.AddItem rs.Fields("Details")
' cmbWeightBasisID.AddItem rs.Fields(0)
' rs.MoveNext
'Wend
'
''Populate the Delivery combobox
'strSQL = "SELECT * FROM Deliverytypedetails"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' cmbDeliveryType.AddItem rs.Fields("Details")
' cmbDeliveryTypeID.AddItem rs.Fields(0)
' rs.MoveNext
'Wend
'
''Populate the Bagtype combobox
'strSQL = "SELECT * FROM Bagtypedetails"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' cmbBagType.AddItem rs.Fields("Details")
' cmbBagTypeID.AddItem rs.Fields(0)
' rs.MoveNext
'Wend
'
''Populate the BagProvidertype combobox
'strSQL = "SELECT * FROM BagProviderdetails"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' cmbBagProvider.AddItem rs.Fields("Details")
' cmbBagProviderID.AddItem rs.Fields(0)
' rs.MoveNext
'Wend
'
''Populate the PAckingExtraDetails combobox
'strSQL = "SELECT * FROM Packingextradetails"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' cmbPackingextra.AddItem rs.Fields("Details")
' cmbPackingExtraID.AddItem rs.Fields(0)
' rs.MoveNext
'Wend
'
''Populate the cmbdeliverytimestyle combobox
'strSQL = "SELECT * FROM deliverytimestyledetails"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' cmbDeliveryTimeStyle.AddItem rs.Fields("Details")
' cmbDeliveryTimeStyleID.AddItem rs.Fields(0)
' rs.MoveNext
'Wend
'
''Populate the cmbcmbpaymenttype combobox
'strSQL = "SELECT * FROM Paymenttypedetails"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' cmbPaymentType.AddItem rs.Fields("Details")
' cmbPaymentTypeID.AddItem rs.Fields(0)
' rs.MoveNext
'Wend
'
''Populate the lstterms list box
'strSQL = "SELECT * FROM termscontents"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' lstTerms.AddItem rs.Fields("contents")
' rs.MoveNext
'Wend
'
''Populate the cmbBrokerage combobox
'strSQL = "SELECT * FROM Brokeragedetails"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' cmbBrokerage.AddItem rs.Fields("Details")
' cmbBrokerageID.AddItem rs.Fields(0)
' rs.MoveNext
'Wend
'
''write in the txtbrokerage textbox
'strSQL = "SELECT * FROM Brokeragetextdetails"
'Set rs = db.OpenRecordset(strSQL)
'
'While Not rs.EOF
' txtBrokerage.Text = rs.Fields("Details")
' rs.MoveNext
'Wend


End Sub
