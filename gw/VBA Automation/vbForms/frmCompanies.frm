VERSION 5.00
Begin VB.Form frmCompanies 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   6675
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   8850
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   6675
   ScaleWidth      =   8850
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtCompanies 
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
      Index           =   7
      Left            =   5760
      TabIndex        =   25
      Top             =   3120
      Width           =   2775
   End
   Begin VB.TextBox txtCompanies 
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
      Index           =   6
      Left            =   1440
      TabIndex        =   24
      Top             =   3120
      Width           =   2775
   End
   Begin VB.TextBox txtCompanies 
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
      Index           =   5
      Left            =   5760
      TabIndex        =   23
      Top             =   2520
      Width           =   2775
   End
   Begin VB.TextBox txtCompanies 
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
      Index           =   4
      Left            =   1440
      TabIndex        =   22
      Top             =   2520
      Width           =   2775
   End
   Begin VB.TextBox txtCompanies 
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
      Index           =   3
      Left            =   5760
      TabIndex        =   21
      Top             =   1920
      Width           =   2775
   End
   Begin VB.TextBox txtCompanies 
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
      Index           =   2
      Left            =   1440
      TabIndex        =   20
      Top             =   1920
      Width           =   2775
   End
   Begin VB.TextBox txtCompanies 
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
      Index           =   1
      Left            =   5760
      TabIndex        =   19
      Top             =   1320
      Width           =   2775
   End
   Begin VB.CommandButton cmdLast 
      Caption         =   "LAST"
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
      Left            =   6135
      TabIndex        =   18
      Top             =   4320
      Width           =   1335
   End
   Begin VB.CommandButton cmdNext 
      Caption         =   "NEXT"
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
      Left            =   4575
      TabIndex        =   17
      Top             =   4320
      Width           =   1335
   End
   Begin VB.CommandButton cmdPrevious 
      Caption         =   "PREVIOUS"
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
      Left            =   3015
      TabIndex        =   16
      Top             =   4320
      Width           =   1335
   End
   Begin VB.CommandButton cmdAdd 
      Caption         =   "ADD"
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
      Left            =   720
      TabIndex        =   15
      Top             =   5040
      Width           =   1335
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "DELETE"
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
      Left            =   2280
      TabIndex        =   14
      Top             =   5040
      Width           =   1335
   End
   Begin VB.CommandButton cmdEdit 
      Caption         =   "EDIT"
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
      Left            =   5415
      TabIndex        =   13
      Top             =   5040
      Width           =   1335
   End
   Begin VB.CommandButton cmdFind 
      Caption         =   "FIND"
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
      Left            =   6975
      TabIndex        =   12
      Top             =   5040
      Width           =   1335
   End
   Begin VB.CommandButton cmdFirst 
      Caption         =   "FIRST"
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
      Left            =   1455
      TabIndex        =   11
      Top             =   4320
      Width           =   1320
   End
   Begin VB.CommandButton cmdSave 
      Caption         =   "SAVE"
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
      Left            =   3855
      TabIndex        =   10
      Top             =   5040
      Width           =   1335
   End
   Begin VB.TextBox txtCompanies 
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
      Index           =   0
      Left            =   1440
      TabIndex        =   0
      Top             =   1320
      Width           =   2775
   End
   Begin VB.Label Label8 
      AutoSize        =   -1  'True
      Caption         =   "Phone :"
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
      TabIndex        =   9
      Top             =   3240
      Width           =   765
   End
   Begin VB.Label Label9 
      Caption         =   "Postal Code :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Left            =   4560
      TabIndex        =   8
      Top             =   2400
      Width           =   975
   End
   Begin VB.Label Label10 
      AutoSize        =   -1  'True
      Caption         =   "City :"
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
      TabIndex        =   7
      Top             =   2640
      Width           =   555
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Fax :"
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
      Left            =   4560
      TabIndex        =   6
      Top             =   3240
      Width           =   510
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "Region :"
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
      Left            =   4560
      TabIndex        =   5
      Top             =   2040
      Width           =   810
   End
   Begin VB.Label Label12 
      AutoSize        =   -1  'True
      Caption         =   "COMPANIES"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   3120
      TabIndex        =   4
      Top             =   240
      Width           =   2445
   End
   Begin VB.Label Label6 
      Caption         =   "Company Name :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Left            =   4560
      TabIndex        =   3
      Top             =   1320
      Width           =   960
   End
   Begin VB.Label Label5 
      Caption         =   "Address :"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   480
      Left            =   240
      TabIndex        =   2
      Top             =   1920
      Width           =   975
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Company ID :"
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
      TabIndex        =   1
      Top             =   1320
      Width           =   1350
   End
End
Attribute VB_Name = "frmCompanies"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim db As Database
Dim rs As Recordset
Dim SQLstr As String
Dim no_of_recs As Integer
Dim modified As Boolean
Dim arr() As String
Dim savetype As Integer


Private Sub cmdAdd_Click()
Dim a As Integer
Dim lastId As Integer

'store the last ID
If rs.RecordCount > 0 Then
  rs.MoveLast
  Call display
  lastId = txtCompanies(0).Text
End If


'All text boxes enabled and cleared.
For a = 0 To txtCompanies.Count - 1
 txtCompanies(a).Text = ""
 txtCompanies(a).Locked = False
 txtCompanies(a).BackColor = vbWhite
Next

'Enable save button and disable delete,find
cmdSave.Enabled = True
cmdDelete.Enabled = False
cmdFind.Enabled = False
cmdAdd.Enabled = False
cmdEdit.Enabled = False
cmdFirst.Enabled = False
cmdPrevious.Enabled = False
cmdNext.Enabled = False
cmdLast.Enabled = False
'display the companies ID
txtCompanies(0).Text = lastId + 1
txtCompanies(1).SetFocus

savetype = 0

End Sub

Private Sub cmdDelete_Click()
Dim retval As Integer

retval = MsgBox("Are you sure you want to delete this Record ???.", vbCritical + vbYesNo + vbDefaultButton2, "Deleting Records")

If retval = vbYes Then
 rs.Delete
 MsgBox "Record sucessfully deleted", vbInformation + vbOKOnly, "Record Deleted"
rs.MoveFirst

  If rs.RecordCount = 0 Then
    Dim a As Integer
   For a = 0 To txtCompanies.Count - 1
     txtCompanies(a).Locked = True
     txtCompanies(a).BackColor = vbCyan
     txtCompanies(a).Text = " "
   Next
    rs.Close
    Set rs = db.OpenRecordset("select * from companies")
    cmdDelete.Enabled = False
    cmdAdd.Enabled = True
    cmdEdit.Enabled = False
    cmdFirst.Enabled = False
    cmdPrevious.Enabled = False
    cmdNext.Enabled = False
    cmdLast.Enabled = False
    cmdSave.Enabled = False
    cmdFind.Enabled = False
   Exit Sub
  End If

 
  no_of_recs = rs.RecordCount
  Call display
End If

End Sub

Private Sub cmdEdit_Click()
Dim a As Integer

For a = 0 To txtCompanies.Count - 1
 txtCompanies(a).Locked = False
 txtCompanies(a).BackColor = vbWhite
Next

cmdAdd.Enabled = False
cmdEdit.Enabled = False
cmdDelete.Enabled = False
cmdFind.Enabled = False
cmdSave.Enabled = True
cmdFirst.Enabled = False
cmdPrevious.Enabled = False
cmdNext.Enabled = False
cmdLast.Enabled = False
savetype = 1
End Sub

Private Sub cmdFind_Click()
Form = "companies"
frmFind.Show (1)
End Sub

Private Sub cmdFirst_Click()
rs.MoveFirst
Call display
End Sub

Private Sub cmdLast_Click()
rs.MoveLast
Call display
End Sub

Private Sub cmdNext_Click()
Dim a As Integer

For a = 0 To txtCompanies.Count - 1
 txtCompanies(a).Locked = True
 txtCompanies(a).BackColor = vbCyan
Next

'check if it is the last record
If rs.AbsolutePosition + 1 = no_of_recs Then
 
Else
 rs.MoveNext
 Call display
End If
End Sub

Private Sub cmdPrevious_Click()
Dim a As Integer

For a = 0 To txtCompanies.Count - 1
 txtCompanies(a).Locked = True
 txtCompanies(a).BackColor = vbCyan
Next

rs.MovePrevious
Call display
End Sub



Private Sub cmdSave_Click()
'call the save method with 0 for addsave.
Call save
MsgBox "The Record is saved."
cmdSave.Enabled = False
cmdAdd.Enabled = True
cmdEdit.Enabled = True
cmdFind.Enabled = True
cmdDelete.Enabled = True
cmdFirst.Enabled = True
cmdPrevious.Enabled = True
cmdNext.Enabled = True
cmdLast.Enabled = True
Call display
End Sub

Private Sub Form_Load()

modified = False
Dim a As Integer

For a = 0 To txtCompanies.Count - 1
 txtCompanies(a).Locked = True
 txtCompanies(a).BackColor = vbCyan
Next

Set db = OpenDatabase(App.Path & "\access database\database.mdb")
Set rs = db.OpenRecordset("companies", dbOpenDynaset)

cmdFirst.Enabled = False
cmdPrevious.Enabled = False
cmdNext.Enabled = False
cmdLast.Enabled = False
cmdDelete.Enabled = False
cmdEdit.Enabled = False
cmdSave.Enabled = False
cmdFind.Enabled = False

If rs.RecordCount > 0 Then
rs.MoveLast
no_of_recs = rs.RecordCount
rs.MoveFirst
Call display
End If

ReDim arr(txtCompanies.Count - 1)
End Sub

Public Function display()
Dim a As Integer
For a = 0 To txtCompanies.Count - 1
 txtCompanies(a).Locked = True
 txtCompanies(a).BackColor = vbCyan
 txtCompanies(a).Text = rs.Fields(a)
Next
cmdNext.Enabled = True
cmdPrevious.Enabled = True

If rs.AbsolutePosition + 1 = 1 Then
 cmdPrevious.Enabled = False
 cmdNext.Enabled = True
End If

If rs.AbsolutePosition + 1 = no_of_recs Then
 cmdPrevious.Enabled = True
 cmdNext.Enabled = False
End If

If rs.AbsolutePosition + 1 = 1 And rs.AbsolutePosition + 1 = no_of_recs Then
  cmdPrevious.Enabled = False
  cmdNext.Enabled = False
End If

If rs.RecordCount > 0 Then
  cmdFirst.Enabled = True
  cmdLast.Enabled = True
  cmdDelete.Enabled = True
  cmdAdd.Enabled = True
  cmdEdit.Enabled = True
  cmdFind.Enabled = True
End If

If rs.RecordCount = 0 Then
 cmdDelete.Enabled = False
End If
End Function

Private Sub Form_Unload(Cancel As Integer)
rs.Close
db.Close
End Sub

Private Sub txtcompanies_KeyPress(Index As Integer, KeyAscii As Integer)
If Index = 0 Then
  If KeyAscii < vbKey0 Or KeyAscii > vbKey9 Then
    If Not KeyAscii = vbKeyBack Or KeyAscii = vbKeyDelete Then
      KeyAscii = 0
     End If
  End If
End If

If Index <> txtCompanies.Count - 1 Then
  If KeyAscii = 13 Then
    txtCompanies(Index + 1).SetFocus
  End If
End If
End Sub


Public Function save()
  Dim a As Integer

If savetype = 1 Then
 rs.Delete
End If

  rs.AddNew

  For a = 0 To txtCompanies.Count - 1
    rs.Fields(a) = Trim(txtCompanies(a).Text)
  Next

  rs.Update
  rs.Bookmark = rs.LastModified
  no_of_recs = rs.RecordCount
  Debug.Print "save ----" & no_of_recs
  rs.Close
Set rs = db.OpenRecordset("Select * from companies")

End Function


