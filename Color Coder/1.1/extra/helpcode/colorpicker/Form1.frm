VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   2955
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4455
   LinkTopic       =   "Form1"
   ScaleHeight     =   2955
   ScaleWidth      =   4455
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox Picture1 
      Height          =   1455
      Left            =   240
      ScaleHeight     =   1395
      ScaleWidth      =   1515
      TabIndex        =   0
      Top             =   240
      Width           =   1575
   End
   Begin VB.Image Image1 
      Height          =   480
      Left            =   2640
      Picture         =   "Form1.frx":0000
      Top             =   600
      Width           =   480
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Type POINTAPI
    X As Long
    Y As Long
End Type
Private Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Private Declare Function SetCapture Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function ReleaseCapture Lib "user32" () As Long
Private Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Private Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
Dim Pt As POINTAPI

Dim activate As Boolean

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
  'redirect all mouse input to this form
   ReleaseCapture
   activate = True
   Screen.MousePointer = 99
   Screen.MouseIcon = Image1.Picture
   SetCapture Me.hwnd
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
 If activate Then
    Dim handle1
    Dim hdc1
    
    'Get the current cursor position
    GetCursorPos Pt
    hdc1 = GetDC(handle1)
    Picture1.BackColor = GetPixel(hdc1, Str$(Pt.X), Str$(Pt.Y))
    SetCapture Me.hwnd
 End If
End Sub

Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    ReleaseCapture
    Screen.MousePointer = 0
    activate = False
    Image1.Visible = True
End Sub


Private Sub Image1_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Image1.Visible = False
Call Form_MouseDown(Button, Shift, X, Y)
End Sub
