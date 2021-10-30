VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox pictest2 
      Appearance      =   0  'Flat
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   480
      Left            =   120
      Picture         =   "Form1.frx":0000
      ScaleHeight     =   480
      ScaleWidth      =   480
      TabIndex        =   2
      Top             =   1200
      Width           =   480
   End
   Begin VB.PictureBox pictest 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      Height          =   975
      Left            =   960
      ScaleHeight     =   915
      ScaleWidth      =   1155
      TabIndex        =   1
      Top             =   240
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   735
      Left            =   480
      TabIndex        =   0
      Top             =   1920
      Width           =   855
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
    pictest.Picture = frmmain.imglstTlBar.ListImages(1).Picture
    Dim pixel As Long
    Dim r As Integer, g As Integer, b As Integer

    pixel = GetPixel(pictest.hdc, X / Screen.TwipsPerPixelX, Y / Screen.TwipsPerPixelY)
    
    
    r = pixel Mod 256
    g = (pixel \ 256) Mod 256
    b = (pixel \ 256 \ 256)
   frmmain.imglstTlBar.MaskColor = RGB(r, g, b)
   frmmain.imglst_disabled_toolbar.MaskColor = RGB(r, g, b)
End Sub

Private Sub pictest_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Dim pixel As Long
Dim r As Integer, g As Integer, b As Integer

    pixel = GetPixel(pictest.hdc, X / Screen.TwipsPerPixelX, Y / Screen.TwipsPerPixelY)
    
    
    r = pixel Mod 256
    g = (pixel \ 256) Mod 256
    b = (pixel \ 256 \ 256)
'   frmmain.imglstTlBar.MaskColor = &HCED7D6
 '  frmmain.imglst_disabled_toolbar.MaskColor = &HCED7D6
 End Sub
