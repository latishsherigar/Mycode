Attribute VB_Name = "declarations"
Option Explicit

Public Form As String


Public Function Findrec(rstemp As Recordset, strsearch As String, intcommand As Integer) As Boolean

    Dim varBookmark As Variant
      Findrec = True
        With rstemp
            ' Populate recordset.
            .MoveLast
            ' Find first record satisfying search string. Exit
            ' loop if no such record exists.
            .FindFirst strsearch
            If .NoMatch Then
                MsgBox "No records found ."
                Findrec = False
                Exit Function
                
            End If

                ' Store bookmark of current record.
                varBookmark = .Bookmark
                ' Get user choice of which method to use.
                
                ' Use selected Find method. If the Find fails,
                ' return to the last current record.
                If FindAny(intcommand, rstemp, _
                        strsearch) = False Then
                    .Bookmark = varBookmark
                    Findrec = False
                End If


        End With



End Function


Public Function FindAny(intChoice As Integer, _
    rstTemp As Recordset, _
    strFind As String) As Boolean

    ' Use Find method based on user input.
    Select Case intChoice
        Case 1
            rstTemp.FindFirst strFind
        Case 2
            rstTemp.FindLast strFind
        Case 3
            rstTemp.FindNext strFind
        Case 4
            rstTemp.FindPrevious strFind
    End Select

    ' Set return value based on NoMatch property.
    FindAny = IIf(rstTemp.NoMatch, False, True)

End Function


Public Function findsql(rstemp As Recordset, strsearch As String, intcommand As Integer)
Select Case intcommand:
End Select
End Function
