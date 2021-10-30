VERSION 5.00
Begin VB.Form frmFind 
   Caption         =   "Find "
   ClientHeight    =   3285
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   5880
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   ScaleHeight     =   3285
   ScaleWidth      =   5880
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdSearch 
      Caption         =   "SEARCH"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4440
      TabIndex        =   8
      Top             =   1680
      Width           =   1215
   End
   Begin VB.TextBox txtFindterm 
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   7
      Top             =   1680
      Width           =   3855
   End
   Begin VB.CommandButton cmdLast 
      Caption         =   "LAST"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4320
      TabIndex        =   5
      Top             =   2520
      Width           =   1215
   End
   Begin VB.CommandButton cmdNext 
      Caption         =   "NEXT"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   3000
      TabIndex        =   4
      Top             =   2520
      Width           =   1215
   End
   Begin VB.CommandButton cmdPrevious 
      Caption         =   "PREVIOUS"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   1560
      TabIndex        =   3
      Top             =   2520
      Width           =   1215
   End
   Begin VB.CommandButton cmdFirst 
      Caption         =   "FIRST"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      TabIndex        =   2
      Top             =   2520
      Width           =   1215
   End
   Begin VB.ComboBox cmbFindcategory 
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
      TabIndex        =   1
      Top             =   720
      Width           =   3855
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Search Term :"
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
      Left            =   240
      TabIndex        =   6
      Top             =   1320
      Width           =   1425
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Find in :"
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
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   810
   End
End
Attribute VB_Name = "frmFind"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim db As Database
Dim rs As Recordset
Dim SQLstr As String
Public searchstring As String
Public formno As Integer


Public Sub cmdFirst_Click()
If Findrec(rs, searchstring, 1) Then
 Call enablenavbuttons
 Call dispfindresults(formno)
'Else
' Call disablenavbuttons
End If
End Sub

Public Sub cmdLast_Click()
If Findrec(rs, searchstring, 2) Then
 Call enablenavbuttons
 Call dispfindresults(formno)
'Else
' Call disablenavbuttons
End If
End Sub

Public Sub cmdNext_Click()
If Findrec(rs, searchstring, 3) Then
 Call enablenavbuttons
 Call dispfindresults(formno)
'Else
' Call disablenavbuttons
End If
End Sub

Public Sub cmdPrevious_Click()
If Findrec(rs, searchstring, 4) Then
 Call enablenavbuttons
 Call dispfindresults(formno)
'Else
' Call disablenavbuttons
End If
End Sub

Public Sub cmdSearch_Click()
Dim a As Integer
searchstring = cmbFindcategory.Text & " = '" & txtFindterm.Text & "'"


cmdFirst.Enabled = True
cmdPrevious.Enabled = True
cmdNext.Enabled = True
cmdLast.Enabled = True

If Findrec(rs, searchstring, 1) Then
 Call enablenavbuttons
 Call dispfindresults(formno)
'Else
' Call disablenavbuttons
End If
End Sub

Public Sub Form_Load()
'Form = LCase(Trim(InputBox("Table name")))

Select Case Form
 Case "buyers": Call findinbuyers
 Case "sellers": Call findinsellers
 Case "products": Call findinProducts
 Case "companies": Call findinCompanies
End Select

cmdFirst.Enabled = False
cmdPrevious.Enabled = False
cmdNext.Enabled = False
cmdLast.Enabled = False
End Sub

Public Function findinbuyers()
Set db = OpenDatabase(App.Path & "\access database\database.mdb")
Set rs = db.OpenRecordset("Buyers", dbOpenSnapshot)

Dim a As Integer
For a = 0 To rs.Fields.Count - 1
cmbFindcategory.AddItem rs.Fields(a).Name
Next
cmbFindcategory.Text = rs.Fields(0).Name
rs.Close
db.Close
Set rs = frmBuyers.rs
formno = 1
End Function

Public Function findinsellers()
Set db = OpenDatabase(App.Path & "\access database\database.mdb")
Set rs = db.OpenRecordset("Sellers", dbOpenSnapshot)

Dim a As Integer
For a = 0 To rs.Fields.Count - 1
cmbFindcategory.AddItem rs.Fields(a).Name
Next
cmbFindcategory.Text = rs.Fields(0).Name

rs.Close
db.Close
Set rs = frmSellers.rs
formno = 2
End Function

Public Function findinProducts()
Set db = OpenDatabase(App.Path & "\access database\database.mdb")
Set rs = db.OpenRecordset("Products", dbOpenSnapshot)

Dim a As Integer
For a = 0 To rs.Fields.Count - 1
cmbFindcategory.AddItem rs.Fields(a).Name
Next
cmbFindcategory.Text = rs.Fields(0).Name
Set rs = frmBuyers.rs
formno = 3
End Function

Public Function findinCompanies()
Set db = OpenDatabase(App.Path & "\access database\database.mdb")
Set rs = db.OpenRecordset("Companies", dbOpenSnapshot)

Dim a As Integer
For a = 0 To rs.Fields.Count - 1
cmbFindcategory.AddItem rs.Fields(a).Name
Next
cmbFindcategory.Text = rs.Fields(0).Name
Set rs = frmBuyers.rs
formno = 4
End Function

Public Function dispfindresults(no As Integer)
Select Case no
 Case 1: frmBuyers.display
 Case 2: frmSellers.display
 Case 3: frmProducts.display
 Case 4: frmCompanies.display
End Select

End Function

Public Function disablenavbuttons()
cmdFirst.Enabled = False
cmdLast.Enabled = False
cmdNext.Enabled = False
cmdPrevious.Enabled = False
End Function

Public Function enablenavbuttons()
cmdFirst.Enabled = True
cmdLast.Enabled = True
cmdNext.Enabled = True
cmdPrevious.Enabled = True
End Function
