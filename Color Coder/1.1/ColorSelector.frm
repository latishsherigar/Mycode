VERSION 5.00
Begin VB.Form Color_coder 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Color coder"
   ClientHeight    =   4065
   ClientLeft      =   150
   ClientTop       =   540
   ClientWidth     =   6255
   BeginProperty Font 
      Name            =   "Verdana"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "ColorSelector.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   ScaleHeight     =   4065
   ScaleWidth      =   6255
   StartUpPosition =   2  'CenterScreen
   Begin VB.HScrollBar HScrollRed 
      Height          =   255
      LargeChange     =   50
      Left            =   720
      Max             =   255
      TabIndex        =   16
      TabStop         =   0   'False
      Top             =   2040
      Width           =   1815
   End
   Begin VB.HScrollBar HScrollGreen 
      Height          =   255
      LargeChange     =   50
      Left            =   720
      Max             =   255
      TabIndex        =   15
      TabStop         =   0   'False
      Top             =   2400
      Width           =   1815
   End
   Begin VB.HScrollBar HScrollBlue 
      Height          =   255
      LargeChange     =   50
      Left            =   720
      Max             =   255
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   2760
      Width           =   1815
   End
   Begin VB.PictureBox txtColor 
      BackColor       =   &H00FFFFFF&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1575
      Left            =   120
      ScaleHeight     =   1515
      ScaleWidth      =   1155
      TabIndex        =   13
      Top             =   120
      Width           =   1215
   End
   Begin VB.CommandButton cmdcopylblhex 
      Caption         =   "Copy"
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
      ToolTipText     =   "Click this button  to copy the code in the textbox to the Clipboard. You can paste this code in other applications."
      Top             =   1080
      Width           =   1335
   End
   Begin VB.CommandButton cmdcopylblHtml 
      Caption         =   "Copy"
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
      Left            =   3120
      TabIndex        =   1
      ToolTipText     =   "Click this button  to copy the code in the textbox to the Clipboard. You can paste this code in other applications."
      Top             =   1080
      Width           =   1335
   End
   Begin VB.CommandButton cmdColorselect 
      Caption         =   "Select Color"
      Height          =   1215
      Left            =   4800
      TabIndex        =   0
      ToolTipText     =   "Click This Button to choose the color from the color dialog box"
      Top             =   1920
      Width           =   1215
   End
   Begin VB.Label lblstatus 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Caption         =   "lblstatus"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   120
      TabIndex        =   21
      Top             =   3360
      Width           =   6015
   End
   Begin VB.Label Label9 
      BackStyle       =   0  'Transparent
      Caption         =   "Color Picker"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   3120
      TabIndex        =   20
      Top             =   1920
      Width           =   1215
   End
   Begin VB.Image imgpickercursor 
      Height          =   480
      Left            =   3480
      MouseIcon       =   "ColorSelector.frx":030A
      MousePointer    =   99  'Custom
      Picture         =   "ColorSelector.frx":0614
      Top             =   2280
      Width           =   480
   End
   Begin VB.Image Colorpickerarea 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Left            =   2880
      Top             =   1800
      Width           =   1695
   End
   Begin VB.Image colorselectorarea 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Left            =   4680
      Top             =   1800
      Width           =   1455
   End
   Begin VB.Image scrollbararea 
      BorderStyle     =   1  'Fixed Single
      Height          =   1455
      Left            =   120
      ToolTipText     =   "Slide the scrollbars to  increase or decrease the RGB values"
      Top             =   1800
      Width           =   2655
   End
   Begin VB.Image RGBarea 
      BorderStyle     =   1  'Fixed Single
      Height          =   1575
      Left            =   4800
      ToolTipText     =   "This Shows the RGB values in decimal format"
      Top             =   120
      Width           =   1335
   End
   Begin VB.Image Image2 
      BorderStyle     =   1  'Fixed Single
      Height          =   1575
      Left            =   120
      ToolTipText     =   "This is the color for which the codes are displayed."
      Top             =   120
      Width           =   1215
   End
   Begin VB.Image HTMLAPPcodearea 
      BorderStyle     =   1  'Fixed Single
      Height          =   1575
      Left            =   1440
      ToolTipText     =   "This shows the HTML code and Windows Code  for  the color."
      Top             =   120
      Width           =   3255
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "R"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   360
      TabIndex        =   19
      Top             =   2040
      Width           =   120
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "G"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   360
      TabIndex        =   18
      Top             =   2400
      Width           =   135
   End
   Begin VB.Label Label6 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "B"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   360
      TabIndex        =   17
      Top             =   2760
      Width           =   120
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "B"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   5040
      TabIndex        =   12
      Top             =   1320
      Width           =   120
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "G"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   5040
      TabIndex        =   11
      Top             =   840
      Width           =   135
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "R"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   195
      Left            =   5040
      TabIndex        =   10
      Top             =   360
      Width           =   120
   End
   Begin VB.Label lblRed 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Height          =   375
      Left            =   5280
      TabIndex        =   9
      ToolTipText     =   "erererererer"
      Top             =   240
      Width           =   495
   End
   Begin VB.Label lblgreen 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Height          =   375
      Left            =   5280
      TabIndex        =   8
      Top             =   720
      Width           =   495
   End
   Begin VB.Label lblBlue 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Height          =   375
      Left            =   5280
      TabIndex        =   7
      Top             =   1200
      Width           =   495
   End
   Begin VB.Label Label7 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Windows Apps"
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
      Left            =   1800
      TabIndex        =   6
      Top             =   240
      Width           =   1230
   End
   Begin VB.Label Label8 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "HTML"
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
      Left            =   3480
      TabIndex        =   5
      Top             =   240
      Width           =   450
   End
   Begin VB.Label lblHex 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Height          =   375
      Left            =   1680
      TabIndex        =   4
      ToolTipText     =   "This Textbox shows the Windows Color code"
      Top             =   600
      UseMnemonic     =   0   'False
      Width           =   1335
   End
   Begin VB.Label lblhtml 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Height          =   375
      Left            =   3120
      TabIndex        =   3
      ToolTipText     =   "This textbox shows the HTML code  for the color"
      Top             =   600
      Width           =   1335
   End
   Begin VB.Menu munabout 
      Caption         =   "&About"
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
   End
   Begin VB.Menu mnudisclaim 
      Caption         =   "&Legal Disclaimer"
   End
End
Attribute VB_Name = "Color_coder"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public cdclr As New clsCommonDialog
Dim inputmode As Integer
Dim activate As Boolean

Private Sub Colorpickerarea_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Call Form_MouseDown(Button, Shift, X, Y)
End Sub

Private Sub colorselectorarea_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblstatus = "Click this button if you want to choose the color with the help of the Windows Standard Color Dialog Box."
End Sub



Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
  'redirect all mouse input to this form
   ReleaseCapture
   activate = True
   Screen.MousePointer = 99
   Screen.MouseIcon = imgpickercursor.Picture
   imgpickercursor.Visible = False
   SetCapture Me.hwnd
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 If activate Then
    Dim handle1
    Dim hdc1
    
    'Get the current cursor position
    GetCursorPos Pt
    hdc1 = GetDC(handle1)
    txtColor.BackColor = GetPixel(hdc1, Str$(Pt.X), Str$(Pt.Y))
    inputmode = 2
   ' Call formatvalues
    SetCapture Me.hwnd
    lblstatus = "Drag the Mouse cursor over any area on the screen with the mouse button pressed and release the mouse button when the color is seen in the colorbox."
 Else
    lblstatus = "Move the Mouse Pointer above the boxes for help on using them."
 End If
End Sub

Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    ReleaseCapture
    Call formatvalues
    Screen.MousePointer = 0
    activate = False
    imgpickercursor.Visible = True
End Sub

Private Sub Colorpickerarea_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblstatus = "Click and Drag the Pen to any desired area .Release the Mouse Button when the color is seen in the Color Box."
End Sub

Private Sub HTMLAPPcodearea_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblstatus = "This boxes show the HTML code and the Hex code for the desired color."
End Sub

Private Sub imgpickercursor_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Call Form_MouseDown(Button, Shift, X, Y)
End Sub

Private Sub mnudisclaim_Click()
MsgBox "Color coder is a Freeware utility.The program is provided without any warranties." & vbLf & "The author of this program cannot be held responsible for any Loss(such as Your Dad kicks you out of the house ,Your dog leaves you because of frustration etc) or Damages(Aliens from other planets destroying your computer)  occuring due to the use of this prgramm." & vbLf & vbLf & "If you accept this disclaimer click 'Yes' otherwise click 'No'." & vbLf & "(Clicking the 'No' button will end this program and I suppose you will regret not using one of the 19999999999999999999999999999990 wonders of this world. ;) ) "
End Sub

Private Sub mnuHelp_Click()
MsgBox "The Help is provided of every function in the status bar of this program .Move your Mouse cursor over any area and see the related help in the programs status bar."
End Sub

Private Sub munabout_Click()
'Me.Hide
About.Show (1)
'Me.Show
End Sub

Private Sub cmdcopylblhex_Click()
'On Error GoTo checkerror
Clipboard.Clear
Clipboard.SetText (lblHex)
checkerror:
End Sub

Private Sub cmdcopylblHtml_Click()
'On Error GoTo checkerror
Clipboard.Clear
Clipboard.SetText (lblhtml)
checkerror:
End Sub

Private Sub cmdColorselect_Click()
'On Error GoTo checkerror
Dim temp As Integer
temp = cdclr.ShowColor
If temp >= 1 Then
    inputmode = 0
    txtColor.BackColor = cdclr.Color
    Call formatvalues
End If
checkerror:
End Sub

Private Sub mnuexit_Click()
Call Form_Unload(1)
End Sub

Private Sub Form_Load()
cdclr.OwnerHwnd = Me.hwnd
inputmode = 0
txtColor.BackColor = RGB(255, 255, 255)
Call formatvalues
inputmode = 1
 lblstatus = "Move the Mouse Pointer above the boxes for help on using them."
End Sub

Private Sub Form_Unload(Cancel As Integer)
'On Error Resume Next
'Me.Hide
'About.Show (1)
'Unload About
End Sub

Private Sub HScrollBlue_Change()
'inputmode = 1
'On Error GoTo checkerror
If inputmode <> 0 And inputmode <> 2 Then
    txtColor.BackColor = RGB(HScrollRed.Value, HScrollGreen.Value, HScrollBlue.Value)
    Call formatvalues
End If
checkerror:
End Sub

Private Sub HScrollGreen_Change()
'inputmode = 1
'On Error GoTo checkerror
 If inputmode <> 0 And inputmode <> 2 Then
   txtColor.BackColor = RGB(HScrollRed.Value, HScrollGreen.Value, HScrollBlue.Value)
   Call formatvalues
End If
checkerror:
End Sub

Private Sub HScrollRed_Change()
'On Error GoTo checkerror
If inputmode <> 0 And inputmode <> 2 Then
    txtColor.BackColor = RGB(HScrollRed.Value, HScrollGreen.Value, HScrollBlue.Value)
    Call formatvalues
End If
checkerror:
End Sub

Private Sub formatvalues()
Dim strcolor As String

strcolor = Hex(txtColor.BackColor)

If strcolor = "0" Then
    strcolor = "000000"
End If

If Len(strcolor) = 2 Then
    strcolor = "0000" + strcolor
End If

If Len(strcolor) = 4 Then
    strcolor = "00" + strcolor
End If

lblRed.Caption = CLng("&H" & Right(strcolor, 2))
lblBlue.Caption = CLng("&H" & Left(strcolor, 2))
lblgreen.Caption = CLng("&H" & Mid(strcolor, 3, 2))
lblHex.Caption = "&H" + Hex(Val(txtColor.BackColor)) + "&"
lblhtml.Caption = "#" & Format(Hex(Val(lblRed.Caption)), "0#") & Format(Hex(Val(lblgreen.Caption)), "0#") & Format(Hex(Val(lblBlue.Caption)), "0#")


HScrollRed.Value = lblRed.Caption
HScrollGreen.Value = lblgreen.Caption
HScrollBlue.Value = lblBlue.Caption

If inputmode = 0 Or inputmode = 2 Then
   inputmode = 1
End If

End Sub

Private Sub Form_Initialize()
   InitCommonControls
End Sub

Private Sub RGBarea_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblstatus = "This Boxes show the RGB(Red Green Blue) values for the selected color."
End Sub

Private Sub scrollbararea_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblstatus = "Slide the scrollbars to get the desired color."
End Sub

Private Sub txtColor_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 lblstatus = "Move the Mouse Pointer above the boxes for help on using them."
End Sub
