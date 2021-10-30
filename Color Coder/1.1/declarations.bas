Attribute VB_Name = "declarations"
Option Explicit

Public Declare Function InitCommonControls Lib "comctl32.dll" () As Long

Private Type POINTAPI
    X As Long
    Y As Long
End Type
Public Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long) As Long
Public Declare Function SetCapture Lib "user32" (ByVal hwnd As Long) As Long
Public Declare Function ReleaseCapture Lib "user32" () As Long
Public Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Public Declare Function GetDC Lib "user32" (ByVal hwnd As Long) As Long
Public Pt As POINTAPI

