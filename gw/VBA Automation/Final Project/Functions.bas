Attribute VB_Name = "Functions"
Option Explicit
 Public db As Database
 Public rs As Recordset

Public Function gettodaysdate() As String
Dim presentday As Integer
Dim presentmonth As Integer
Dim strmonth As String
Dim presentyear As Integer
Dim finaldate As String

presentday = Day(Now)
presentmonth = Month(Now)
presentyear = Year(Now)

Select Case presentmonth
 Case 1: strmonth = "January"
 Case 2: strmonth = "February"
 Case 3: strmonth = "March"
 Case 4: strmonth = "April"
 Case 5: strmonth = "May"
 Case 6: strmonth = "June"
 Case 7: strmonth = "July"
 Case 8: strmonth = "August"
 Case 9: strmonth = "September"
 Case 10: strmonth = "October"
 Case 11: strmonth = "November"
 Case 12: strmonth = "December"
End Select

finaldate = presentday & " " & strmonth & ", " & presentyear & "."
gettodaysdate = finaldate
End Function


Public Function connect2database()
  Set db = OpenDatabase(App.Path & "\database.mdb")
End Function

Public Function getstarttext()
  Set rs = db.OpenRecordset("select * from starttext")
  getstarttext = rs(0)
End Function

Public Function fillbuyerscombo(combo As ComboBox)
 Set rs = db.OpenRecordset("select * from buyers")
 combo.Clear
 While Not rs.EOF
  combo.AddItem rs("BuyerName")
  rs.MoveNext
 Wend
End Function
 
Public Function fillwarehousecombo(combo As ComboBox, buyercombono As Integer)
 Set rs = db.OpenRecordset("select * from Warehouses where BuyerID=" & buyercombono + 1)
 combo.Clear
 While Not rs.EOF
  combo.AddItem rs("Name")
  rs.MoveNext
 Wend
End Function

Public Function fillSellerscombo(combo As ComboBox)
 Set rs = db.OpenRecordset("select * from Sellers")
 combo.Clear
 While Not rs.EOF
  combo.AddItem rs("SellerName")
  rs.MoveNext
 Wend
End Function


Public Function fillProductcombo(combo As ComboBox)
 Set rs = db.OpenRecordset("select * from Products")
 combo.Clear
 While Not rs.EOF
   combo.AddItem rs("Description")
    rs.MoveNext
 Wend
End Function
