Attribute VB_Name = "Declarations"
Option Explicit
Public overwritewithoutprompt As Boolean
Public canceloperation As Boolean
Public operation As Integer


Public Const floppy As String = "1.44MB"
Public Const megabytes As String = "MB"
Public Const gigabytes As String = "GB"
Public Const kilobytes  As String = "KB"
Public Const bytes As String = "Bytes"

Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public Declare Function GetShortPathName Lib "kernel32" _
    Alias "GetShortPathNameA" _
    (ByVal lpszLongPath As String, _
    ByVal lpszShortPath As String, _
    ByVal cchBuffer As Long) As Long
    
Declare Function ShellExecute _
   Lib "shell32.dll" Alias "ShellExecuteA" _
   (ByVal hwnd As Long, _
   ByVal lpOperation As String, _
   ByVal lpFile As String, _
   ByVal lpParameters As String, _
   ByVal lpDirectory As String, _
   ByVal nShowCmd As Long) As Long

Public Const SW_SHOWNORMAL = 1

'for moving the form without title bar
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Sub ReleaseCapture Lib "user32" ()
Public Const WM_NCLBUTTONDOWN = &HA1
Public Const HTCAPTION = 2

'main file info structure
 Type filedata
   FileName As String * 15
   nooffiles As Integer
End Type

Public data As filedata

'create a new instance of the Borwse folder dialog box class
Public cmdg As New clsCommonDialog
'create a new instance of the window class
'Public window As New clsWindow
