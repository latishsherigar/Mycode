VERSION 5.00
Begin VB.Form frmContractGen 
   BorderStyle     =   0  'None
   Caption         =   "Contract Generator"
   ClientHeight    =   16500
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   11880
   BeginProperty Font 
      Name            =   "Verdana"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "ContractGenerator.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   16500
   ScaleWidth      =   11880
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame4 
      Height          =   1095
      Left            =   120
      TabIndex        =   65
      Top             =   4080
      Width           =   10935
      Begin VB.TextBox txtSpecification2 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   2400
         TabIndex        =   67
         Top             =   600
         Width           =   8175
      End
      Begin VB.TextBox txtSpecification1 
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   2400
         TabIndex        =   66
         Top             =   240
         Width           =   8175
      End
      Begin VB.Label Label10 
         AutoSize        =   -1  'True
         Caption         =   "Specification :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   240
         TabIndex        =   68
         Top             =   360
         Width           =   1530
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Footer"
      ForeColor       =   &H00FF0000&
      Height          =   1095
      Left            =   120
      TabIndex        =   64
      Top             =   14280
      Width           =   10935
      Begin VB.TextBox txtFooter3 
         Height          =   375
         Left            =   7560
         TabIndex        =   31
         Top             =   360
         Width           =   3015
      End
      Begin VB.TextBox txtFooter2 
         Height          =   375
         Left            =   3960
         TabIndex        =   30
         Top             =   360
         Width           =   3015
      End
      Begin VB.TextBox txtFooter1 
         Height          =   375
         Left            =   360
         TabIndex        =   29
         Top             =   360
         Width           =   3015
      End
   End
   Begin VB.CommandButton cmdPreview 
      Caption         =   "Prieview"
      Height          =   495
      Left            =   4560
      TabIndex        =   32
      Top             =   15600
      Width           =   3375
   End
   Begin VB.Frame Frame2 
      Caption         =   "Delivery"
      ForeColor       =   &H00FF0000&
      Height          =   1455
      Left            =   120
      TabIndex        =   58
      Top             =   8880
      Width           =   10935
      Begin VB.ComboBox cmbDeliveryTimeStyle 
         Height          =   360
         Left            =   7080
         TabIndex        =   21
         Top             =   240
         Width           =   3615
      End
      Begin VB.TextBox txtDateFrom 
         Height          =   375
         Left            =   3000
         TabIndex        =   22
         Top             =   840
         Width           =   1455
      End
      Begin VB.TextBox txtDateTo 
         Height          =   375
         Left            =   5160
         TabIndex        =   23
         Top             =   840
         Width           =   1575
      End
      Begin VB.TextBox txtDeliveryDate 
         Height          =   375
         Left            =   2280
         TabIndex        =   20
         Top             =   240
         Width           =   2175
      End
      Begin VB.Label Label21 
         AutoSize        =   -1  'True
         Caption         =   "Delivery Date :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   120
         TabIndex        =   62
         Top             =   360
         Width           =   1605
      End
      Begin VB.Label Label22 
         AutoSize        =   -1  'True
         Caption         =   "From"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   2280
         TabIndex        =   61
         Top             =   840
         Width           =   570
      End
      Begin VB.Label Label23 
         AutoSize        =   -1  'True
         Caption         =   "To"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   4800
         TabIndex        =   60
         Top             =   840
         Width           =   255
      End
      Begin VB.Label Label24 
         AutoSize        =   -1  'True
         Caption         =   "Delivery Time Style :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   4680
         TabIndex        =   59
         Top             =   360
         Width           =   2235
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Terms"
      ForeColor       =   &H00FF0000&
      Height          =   1815
      Left            =   120
      TabIndex        =   56
      Top             =   11040
      Width           =   10935
      Begin VB.ComboBox cmbOtherterms 
         Height          =   360
         Left            =   2280
         TabIndex        =   25
         Top             =   240
         Width           =   8295
      End
      Begin VB.ListBox lstFormType 
         Height          =   870
         Left            =   3720
         Style           =   1  'Checkbox
         TabIndex        =   26
         Top             =   720
         Width           =   3735
      End
      Begin VB.Label Label26 
         AutoSize        =   -1  'True
         Caption         =   "Other Terms:"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   120
         TabIndex        =   63
         Top             =   360
         Width           =   1425
      End
      Begin VB.Label Label27 
         AutoSize        =   -1  'True
         Caption         =   "Form Type :"
         BeginProperty Font 
            Name            =   "Verdana"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   2280
         TabIndex        =   57
         Top             =   720
         Width           =   1290
      End
   End
   Begin VB.TextBox txtLastText 
      Height          =   360
      Left            =   2280
      TabIndex        =   28
      Top             =   13680
      Width           =   8415
   End
   Begin VB.ComboBox cmbBrokerage 
      Height          =   360
      Left            =   2280
      TabIndex        =   27
      Top             =   13200
      Width           =   8415
   End
   Begin VB.ComboBox cmbShippingMark 
      Height          =   360
      Left            =   2520
      TabIndex        =   16
      Top             =   7320
      Width           =   1455
   End
   Begin VB.ComboBox cmbPayment 
      Height          =   360
      Left            =   2400
      TabIndex        =   24
      Top             =   10560
      Width           =   8295
   End
   Begin VB.ComboBox cmbBagProvider 
      Height          =   360
      Left            =   2520
      TabIndex        =   19
      Top             =   8280
      Width           =   8295
   End
   Begin VB.ComboBox cmbForNet 
      Height          =   360
      Left            =   7200
      TabIndex        =   18
      Top             =   7800
      Width           =   3615
   End
   Begin VB.ComboBox cmbWeightType 
      Height          =   360
      Left            =   5160
      TabIndex        =   15
      Text            =   "Combo9"
      Top             =   6840
      Width           =   1695
   End
   Begin VB.TextBox txtStartText 
      Height          =   360
      Left            =   2520
      TabIndex        =   2
      Top             =   720
      Width           =   8175
   End
   Begin VB.TextBox txtPacking1 
      Height          =   360
      Left            =   2520
      TabIndex        =   14
      Text            =   "In"
      Top             =   6840
      Width           =   495
   End
   Begin VB.ComboBox cmbBagtype 
      Height          =   360
      Left            =   2520
      TabIndex        =   17
      Top             =   7800
      Width           =   3015
   End
   Begin VB.ComboBox cmbDeliveryType 
      Height          =   360
      Left            =   2520
      TabIndex        =   13
      Top             =   6360
      Width           =   8295
   End
   Begin VB.TextBox txtPrice 
      Height          =   345
      Left            =   2520
      TabIndex        =   12
      Top             =   5880
      Width           =   1935
   End
   Begin VB.ComboBox cmbWeightBasis 
      Height          =   360
      Left            =   8280
      TabIndex        =   11
      Top             =   5400
      Width           =   2535
   End
   Begin VB.ComboBox cmbQtype 
      Height          =   360
      Left            =   4320
      TabIndex        =   10
      Top             =   5400
      Width           =   2175
   End
   Begin VB.TextBox txtQuantity 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2520
      TabIndex        =   9
      Top             =   5400
      Width           =   615
   End
   Begin VB.ComboBox cmbProduct 
      Height          =   360
      Left            =   2520
      Style           =   2  'Dropdown List
      TabIndex        =   8
      Top             =   3600
      Width           =   8175
   End
   Begin VB.TextBox txtStno 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2520
      TabIndex        =   6
      Top             =   2640
      Width           =   3855
   End
   Begin VB.TextBox txtCstno 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2520
      TabIndex        =   5
      Top             =   2160
      Width           =   3855
   End
   Begin VB.ComboBox cmbSellers 
      Height          =   360
      Left            =   2520
      Style           =   2  'Dropdown List
      TabIndex        =   7
      Top             =   3120
      Width           =   3855
   End
   Begin VB.ComboBox cmbWarehouse 
      Height          =   360
      Left            =   2520
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   1680
      Width           =   8175
   End
   Begin VB.ComboBox cmbBuyers 
      Height          =   360
      Left            =   2520
      Style           =   2  'Dropdown List
      TabIndex        =   3
      Top             =   1200
      Width           =   3855
   End
   Begin VB.TextBox txtDate 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   7320
      TabIndex        =   1
      Top             =   240
      Width           =   3375
   End
   Begin VB.TextBox txtContractno 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   2520
      TabIndex        =   0
      Top             =   240
      Width           =   3735
   End
   Begin VB.Label Label30 
      AutoSize        =   -1  'True
      Caption         =   "Last Text :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   240
      TabIndex        =   55
      Top             =   13680
      Width           =   1140
   End
   Begin VB.Label Label29 
      AutoSize        =   -1  'True
      Caption         =   "Brokerage :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   240
      TabIndex        =   54
      Top             =   13200
      Width           =   1260
   End
   Begin VB.Label Label28 
      AutoSize        =   -1  'True
      Caption         =   "Shipping Mark :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   53
      Top             =   7320
      Width           =   1650
   End
   Begin VB.Label Label25 
      AutoSize        =   -1  'True
      Caption         =   "Payment :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   240
      TabIndex        =   52
      Top             =   10560
      Width           =   1110
   End
   Begin VB.Label Label20 
      AutoSize        =   -1  'True
      Caption         =   "Bag Provider :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   51
      Top             =   8280
      Width           =   1530
   End
   Begin VB.Label Label19 
      AutoSize        =   -1  'True
      Caption         =   "For Net :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   5880
      TabIndex        =   50
      Top             =   7800
      Width           =   930
   End
   Begin VB.Label Label18 
      AutoSize        =   -1  'True
      Caption         =   "Bag Type :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   49
      Top             =   7800
      Width           =   1140
   End
   Begin VB.Label Label17 
      AutoSize        =   -1  'True
      Caption         =   "Weight type :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   3360
      TabIndex        =   48
      Top             =   6840
      Width           =   1455
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Start Text :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   47
      Top             =   720
      Width           =   1215
   End
   Begin VB.Label Label16 
      AutoSize        =   -1  'True
      Caption         =   "Packing :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   46
      Top             =   6840
      Width           =   975
   End
   Begin VB.Label Label15 
      AutoSize        =   -1  'True
      Caption         =   "DeliveryType :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   45
      Top             =   6360
      Width           =   1560
   End
   Begin VB.Label Label14 
      AutoSize        =   -1  'True
      Caption         =   "Price(Per mt ton) :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   44
      Top             =   5880
      Width           =   2025
   End
   Begin VB.Label Label13 
      AutoSize        =   -1  'True
      Caption         =   "Weight Basis :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   6720
      TabIndex        =   43
      Top             =   5400
      Width           =   1545
   End
   Begin VB.Label Label12 
      AutoSize        =   -1  'True
      Caption         =   "Qtype :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   3360
      TabIndex        =   42
      Top             =   5400
      Width           =   795
   End
   Begin VB.Label Label11 
      AutoSize        =   -1  'True
      Caption         =   "Quantity :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   41
      Top             =   5400
      Width           =   1080
   End
   Begin VB.Label Label9 
      AutoSize        =   -1  'True
      Caption         =   "Product :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   40
      Top             =   3600
      Width           =   975
   End
   Begin VB.Label Label8 
      AutoSize        =   -1  'True
      Caption         =   "ST no :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   39
      Top             =   2640
      Width           =   720
   End
   Begin VB.Label Label7 
      AutoSize        =   -1  'True
      Caption         =   "CST no :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   38
      Top             =   2160
      Width           =   870
   End
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      Caption         =   "Sellers :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   37
      Top             =   3120
      Width           =   870
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      Caption         =   "Buyers W'house :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   36
      Top             =   1680
      Width           =   1890
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "Buyers :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   35
      Top             =   1200
      Width           =   900
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Date :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   6480
      TabIndex        =   34
      Top             =   240
      Width           =   645
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Contract No :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   360
      TabIndex        =   33
      Top             =   240
      Width           =   1425
   End
End
Attribute VB_Name = "frmContractGen"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmbBuyers_Click()
Call fillwarehousecombo(cmbWarehouse, cmbBuyers.ListIndex)

End Sub

Private Sub Form_Load()
Left = frmMainMDI.Left + 100
Width = frmMainMDI.Width - 500

txtDate.Text = gettodaysdate
Call connect2database
txtStartText.Text = getstarttext
Call fillbuyerscombo(cmbBuyers)
Call fillSellerscombo(cmbSellers)
Call fillProductcombo(cmbProduct)
End Sub


