VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Excel Demo Program"
   ClientHeight    =   6720
   ClientLeft      =   1020
   ClientTop       =   1365
   ClientWidth     =   9690
   LinkTopic       =   "Form1"
   ScaleHeight     =   6720
   ScaleWidth      =   9690
   Begin VB.CheckBox Check10 
      Height          =   375
      Left            =   2160
      TabIndex        =   20
      Top             =   5520
      Width           =   255
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Make Excel Visible"
      Height          =   375
      Left            =   120
      TabIndex        =   19
      Top             =   720
      Width           =   1935
   End
   Begin VB.CheckBox Check9 
      Height          =   375
      Left            =   2160
      TabIndex        =   18
      Top             =   4920
      Width           =   255
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Copy Chart"
      Height          =   375
      Left            =   120
      TabIndex        =   17
      Top             =   3720
      Width           =   1935
   End
   Begin VB.CommandButton Command11 
      Caption         =   "Exit Excel Demo"
      Height          =   375
      Left            =   120
      TabIndex        =   16
      Top             =   6120
      Width           =   1935
   End
   Begin VB.CheckBox Check8 
      Height          =   375
      Left            =   2160
      TabIndex        =   15
      Top             =   4320
      Width           =   255
   End
   Begin VB.CheckBox Check7 
      Height          =   375
      Left            =   2160
      TabIndex        =   14
      Top             =   3720
      Width           =   255
   End
   Begin VB.CheckBox Check6 
      Height          =   375
      Left            =   2160
      TabIndex        =   13
      Top             =   3120
      Width           =   255
   End
   Begin VB.CheckBox Check5 
      Height          =   375
      Left            =   2160
      TabIndex        =   12
      Top             =   2520
      Width           =   255
   End
   Begin VB.CheckBox Check4 
      Height          =   375
      Left            =   2160
      TabIndex        =   11
      Top             =   1920
      Width           =   255
   End
   Begin VB.CheckBox Check3 
      Height          =   375
      Left            =   2160
      TabIndex        =   10
      Top             =   1320
      Width           =   255
   End
   Begin VB.CheckBox Check2 
      Height          =   375
      Left            =   2160
      TabIndex        =   9
      Top             =   720
      Width           =   255
   End
   Begin VB.CheckBox Check1 
      Height          =   375
      Left            =   2160
      TabIndex        =   8
      Top             =   120
      Width           =   255
   End
   Begin VB.CommandButton Command10 
      Caption         =   "Quit Excel"
      Height          =   375
      Left            =   120
      TabIndex        =   7
      Top             =   5520
      Width           =   1935
   End
   Begin VB.CommandButton Command9 
      Caption         =   "Close Workbook"
      Height          =   375
      Left            =   120
      TabIndex        =   6
      Top             =   4920
      Width           =   1935
   End
   Begin VB.CommandButton Command8 
      Caption         =   "Save Workbook"
      Height          =   375
      Left            =   120
      TabIndex        =   5
      Top             =   4320
      Width           =   1935
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Create Chart"
      Height          =   375
      Left            =   120
      TabIndex        =   4
      Top             =   3120
      Width           =   1935
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Format the Cells"
      Height          =   375
      Left            =   120
      TabIndex        =   3
      Top             =   2520
      Width           =   1935
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Populate a Sheet"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   1920
      Width           =   1935
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Add a Workbook"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   1320
      Width           =   1935
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Run Excel"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1935
   End
   Begin VB.Image Image1 
      BorderStyle     =   1  'Fixed Single
      Height          =   6375
      Left            =   2640
      Top             =   120
      Width           =   6855
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim ExcelApp As Excel.Application
Dim ExcelCht As Excel.Chart
Dim ExcelSht As Excel.Worksheet
Dim ExcelWkb As Excel.Workbook
Dim MyExcel As Boolean

Private Sub Command1_Click()

On Error Resume Next

Err.Clear

Set ExcelApp = GetObject(, "Excel.Application")
If Err.Number <> 0 Then
   Err.Clear
   Set ExcelApp = CreateObject("Excel.Application")
   If Err.Number <> 0 Then
      MsgBox "Error: " & Err.Description
   Else
      MyExcel = True
      
   End If
   
Else
   MyExcel = False

End If

Check1.Value = vbChecked
Command2.SetFocus

End Sub

Private Sub Command10_Click()

If MyExcel Then
   ExcelApp.Quit
   Set ExcelApp = Nothing
   MyExcel = False
   
End If

Check10.Value = vbChecked
Command11.SetFocus

End Sub

Private Sub Command11_Click()

Unload Me

End Sub

Private Sub Command2_Click()

ExcelApp.Visible = Not ExcelApp.Visible

Check2.Value = vbChecked
Command3.SetFocus

End Sub

Private Sub Command3_Click()

Set ExcelWkb = ExcelApp.Workbooks.Add
Set ExcelSht = ExcelWkb.Worksheets(1)

Check3.Value = vbChecked
Command4.SetFocus

End Sub

Private Sub Command4_Click()

Dim i As Integer
Dim j As Integer

For i = 1 To 4
   For j = 1 To 10
      ExcelSht.Cells(j, i) = Rnd() * 100
   Next j
Next i

Check4.Value = vbChecked
Command5.SetFocus

End Sub

Private Sub Command5_Click()

ExcelSht.Range("A1:D10").NumberFormat = "0.00"

Check5.Value = vbChecked
Command6.SetFocus

End Sub

Private Sub Command6_Click()

Set ExcelCht = ExcelWkb.Charts.Add
ExcelCht.ChartType = xlLineMarkers
ExcelCht.SetSourceData ExcelSht.Range("A1:D10"), xlColumns
ExcelCht.HasTitle = True
ExcelCht.ChartTitle.Characters.Text = "My Data"
ExcelCht.Axes(xlCategory, xlPrimary).HasTitle = True
ExcelCht.Axes(xlCategory, xlPrimary).AxisTitle.Characters.Text = "X-Axis"
ExcelCht.Axes(xlValue, xlPrimary).HasTitle = True
ExcelCht.Axes(xlValue, xlPrimary).AxisTitle.Characters.Text = "Data Series"
ExcelApp.Height = 420
ExcelApp.Width = 350
ExcelCht.SizeWithWindow = True

Check6.Value = vbChecked
Command7.SetFocus

End Sub

Private Sub Command7_Click()

ExcelCht.ChartArea.Select
ExcelCht.ChartArea.Copy

Image1.Picture = Clipboard.GetData(vbCFBitmap)

Check7.Value = vbChecked
Command8.SetFocus

End Sub

Private Sub Command8_Click()

If Len(Dir(App.Path & "\test.xls")) <> 0 Then
   Kill App.Path & "\test.xls"
End If

ExcelWkb.SaveAs App.Path & "\test.xls"

Check8.Value = vbChecked
Command9.SetFocus

End Sub

Private Sub Command9_Click()

ExcelWkb.Close False

Check9.Value = vbChecked
Command10.SetFocus

End Sub

Private Sub Form_Load()

Randomize

End Sub

