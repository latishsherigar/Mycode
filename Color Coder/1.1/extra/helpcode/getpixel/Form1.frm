VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3090
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   615
      Left            =   840
      TabIndex        =   2
      Top             =   2040
      Width           =   1935
   End
   Begin VB.PictureBox Picture2 
      Height          =   495
      Left            =   2880
      ScaleHeight     =   435
      ScaleWidth      =   1515
      TabIndex        =   1
      Top             =   240
      Width           =   1575
   End
   Begin VB.PictureBox Picture1 
      Height          =   615
      Left            =   3120
      ScaleHeight     =   555
      ScaleWidth      =   1275
      TabIndex        =   0
      Top             =   1920
      Width           =   1335
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'This project needs:
'- two picture boxes
'- a button
Private Type POINTAPI
    X As Long
    Y As Long
End Type

Private Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Private Declare Function SetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long) As Long
Private Declare Function PaintDesktop Lib "user32" (ByVal hdc As Long) As Long
Private Declare Function StretchBlt Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nSrcWidth As Long, ByVal nSrcHeight As Long, ByVal dwRop As Long) As Long
Private Declare Function GetBkColor Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function MoveToEx Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, lpPoint As POINTAPI) As Long
Private Declare Function LineTo Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long

Const ScrCopy = &HCC0020
Const Yellow = &HFFFF&
Private Sub Form_Load()
    'KPD-Team 1998
    'URL: http://www.allapi.net/
    'E-Mail: KPDTeam@Allapi.net
    Dim Cnt1 As Byte, Cnt2 As Byte, Point As POINTAPI
    'Set the graphic mode to persistent
    Me.AutoRedraw = True
    'API uses pixels
    Me.ScaleMode = vbPixels
    Picture1.ScaleMode = vbPixels
    Picture2.ScaleMode = vbPixels
    'No borders
    Picture1.BorderStyle = 0: Picture2.BorderStyle = 0
    'Set the button's caption
    Command1.Caption = "Paint && Stretch"
    'Set the graphic mode to 'non persistent'
    Picture1.AutoRedraw = False: Picture2.AutoRedraw = False
    For Cnt1 = 0 To 100 Step 3
        For Cnt2 = 0 To 100 Step 3
            'Set the start-point's coördinates
            Point.X = Cnt1: Point.Y = Cnt2
            'Move the active point
            MoveToEx Me.hdc, Cnt1, Cnt2, Point
            'Draw a line from the active point to the given point
            LineTo Me.hdc, 200, 200
        Next Cnt2
    Next Cnt1
    For Cnt1 = 0 To 100 Step 5
        For Cnt2 = 0 To 100 Step 5
            'Draw a pixel
            SetPixel Me.hdc, Cnt1, Cnt2, Yellow
        Next Cnt2
    Next Cnt1
End Sub
Private Sub Picture1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim XX As Long, YY As Long, A As Long
    XX = X: YY = Y
    'Set the picturebox' backcolor
    Picture2.BackColor = GetPixel(Picture1.hdc, XX, YY)
End Sub
Private Sub Picture1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = 1 Then
        Dim XX As Long, YY As Long, A As Long
        XX = X: YY = Y
        'Set the picturebox' backcolor
        Picture2.BackColor = GetPixel(Picture1.hdc, XX, YY)
    End If
End Sub
Private Sub Picture1_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim XX As Long, YY As Long, A As Long
    XX = X: YY = Y
    'Set the picturebox' backcolor
    Picture2.BackColor = GetPixel(Picture1.hdc, XX, YY)
End Sub
Private Sub Command1_Click()
    'Set the width and height
    Picture2.Width = 100: Picture2.Height = 100
    Picture1.Width = 50: Picture1.Height = 50
    'No pictures
    Picture1.Picture = LoadPicture("")
    DoEvents
    'Copy the desktop to our picturebox
    PaintDesktop Picture1.hdc
    'Stretch the picture
    StretchBlt Picture2.hdc, 0, 0, 100, 100, Picture1.hdc, 0, 0, 50, 50, ScrCopy
End Sub

