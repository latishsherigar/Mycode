Attribute VB_Name = "Module1"
Option Explicit
Public Declare Function PathIsDirectory Lib "shlwapi.dll" Alias "PathIsDirectoryA" (ByVal pszPath As String) As Long
Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public Sub Main()
Dim a As Integer

On Error Resume Next
'MsgBox Command
If Command <> "" Then
        Kill Command & "\*.*"
        RmDir (Command)
End If
errhnd:
End Sub

