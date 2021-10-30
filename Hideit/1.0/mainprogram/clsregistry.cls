VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsregistry"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Const REG_SZ = 1 ' Unicode nul terminated string
Const REG_BINARY = 3 ' Free form binary
Const HKEY_CURRENT_USER = &H80000001

Private Declare Function RegCloseKey Lib "advapi32.dll" (ByVal hKey As Long) As Long
Private Declare Function RegCreateKey Lib "advapi32.dll" Alias "RegCreateKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function RegOpenKey Lib "advapi32.dll" Alias "RegOpenKeyA" (ByVal hKey As Long, ByVal lpSubKey As String, phkResult As Long) As Long
Private Declare Function RegQueryValueEx Lib "advapi32.dll" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, lpType As Long, lpData As Any, lpcbData As Long) As Long
Private Declare Function RegSetValueEx Lib "advapi32.dll" Alias "RegSetValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal Reserved As Long, ByVal dwType As Long, lpData As Any, ByVal cbData As Long) As Long


Public Function writevalue(key As String, value As String)
    Dim Ret As Long
    Dim strpath As String
    Dim hKey  As Long
    
    hKey = HKEY_CURRENT_USER
    strpath = "Software\HideIt"
    
    'Create a new key
    RegCreateKey hKey, strpath, Ret
    
    'Save a string to the key
    RegSetValueEx Ret, key, 0, REG_SZ, ByVal value, Len(value)
    
    'close the key
    RegCloseKey Ret
    
End Function

Public Function readvalue(key As String) As String
    Dim Ret As Long
    Dim strpath As String
    Dim hKey  As Long
    Dim lresult As Long
    Dim value As String
    Dim temp As Long
    
    hKey = HKEY_CURRENT_USER
    strpath = "Software\HideIt"
    
    'Open the key
    RegOpenKey hKey, strpath, Ret
    
    'retrieve nformation about the key
    lresult = RegQueryValueEx(Ret, key, 0, REG_SZ, ByVal 0, 0)
    
   If lresult = 0 Then
       'Create a buffer
        value = String(10, Chr$(0))
        'retrieve the key's content
        temp = Len(value)
        lresult = RegQueryValueEx(Ret, key, 0, REG_SZ, ByVal value, temp)
        If lresult = 0 Then
            'Remove the unnecessary chr$(0)'s
            readvalue = Left$(value, InStr(1, value, Chr$(0)) - 1)
        End If
   End If
    
    'Close the key
    RegCloseKey Ret
End Function
