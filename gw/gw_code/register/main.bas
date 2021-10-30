Attribute VB_Name = "main1"
Option Explicit

Public Sub Main()
Dim c As New cRegistry
Dim sd As String
Dim lud As String

'sd = (Format(Year(Date), "####") & Format(Day(Date), "0#") & Format(Month(Date), "0#")) Xor 953123567
sd = "20042709"
lud = sd

With c
 .ClassKey = HKEY_LOCAL_MACHINE
 .SectionKey = "Software\latdatadistrib\"
 .ValueKey = "sd"
 .ValueType = REG_SZ
 .Value = sd
 .ValueKey = "lud"
 .ValueType = REG_SZ
 .Value = lud
End With
End Sub
