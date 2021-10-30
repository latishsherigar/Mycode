VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsencryption"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit
'To fire this event, use RaiseEvent with the following syntax:
'RaiseEvent progress[(arg1, arg2, ... , argn)]
Public Event progress(ByVal progress As Integer)
Dim m_canceloperation As Boolean

Public Property Let cancel_operation(cancel As Boolean)
m_canceloperation = cancel
End Property


Public Function encodearr(arr() As Byte, arrelements As Double, password As String) As Boolean
    Dim i  As Double, j As Double
    Dim progresspercent  As Integer
    Dim temp As Integer
    
'   If Trim(password) = "" Then
'      password = "1A8*"
'   End If
   
If password <> "" Then
encodearr = False
RaiseEvent progress(0)

    For i = 0 To arrelements - 1
        If Not m_canceloperation Then
            For j = 1 To Len(password)
                arr(i) = arr(i) Xor Asc(Mid(password, j, 1))
            Next
            progresspercent = Fix((100 * i) / arrelements) 'integer division
            If temp <> progresspercent Then
                temp = progresspercent
                'raise a event for the progress
                RaiseEvent progress(progresspercent)
            End If
            DoEvents
         Else
            encodearr = True
         End If
    Next
End If
encodearr = True

End Function




















'Private Function encodestr(inputstr As String, password As String)
'    Call encodearr(str2array(inputstr), Len(inputstr), password)
'End Function
'
'
'Private Function str2array(tempstr As String) As Byte()
'    Dim temparr() As Byte
'    Dim strsize As Integer
'    Dim i As Integer
'
'    strsize = Len(tempstr)
'    ReDim temparr(strsize - 1)
'    For i = 0 To strsize - 1
'        temparr(i) = Asc(Mid(tempstr, i + 1, 1))
'    Next
'    str2array = temparr
'End Function

