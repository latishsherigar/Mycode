Attribute VB_Name = "Module2"
Option Explicit

' The use of a mail merge is necessary when a report is too large to be created in Access.
' In this example, I created the report documents in Word.

' I've just recently completed this code. I posted this code (incomplete) at PSC ages ago &
' have finally got round to sorting it out.
' This code may well be of use to someone in a similar situation to which I was in when I
' set out to do this (at the time) pretty complicated task.
' It's all pretty straight forward, but if my reasoning behind certain sections of code etc.
' is not too clear, then just email me @

'                           richard.millen@talk21.com

' Also... if you have any (constructive) criticism to be made (as I'm sure some will) then
' please let me know at the above address. You'll be helping me if you do!
' I've commented all the way through the code to try to aid in understanding
' what I am trying to do.
' Enjoy!!

' p.s. Be sure to create the necessary documents to be printed etc.

' *****************************************************************
'            Source Code written in the Parent Form.
' *****************************************************************

Private Sub cmdCallProc_Click()
    ChildForm.SetFocus  ' Necessary due to the fact that the "DoCmd.GoToRecord , , acNext" procedure calls,
                        ' affect this form aswell as the SubForm, unless it is given focus within this form.
    Forms![4_CONTRACT & ACKMT]![ChildForm].Form.PrintMergeReport
End Sub

' *****************************************************************
'         Source Code written in the SubForm being evaluated.
' *****************************************************************

Dim FirstRecord As Boolean
Dim WordApp As Word.Application



Sub PrintMergeReport()
    ' ********************************************************************************
    Dim strFruit(1 To 3) As String
    Dim vFileToPrint As String
    Static RecordCount As Integer
    
    RecordCount = 0                             ' Variable intended to prevent endless loop.
    strFruit(1) = "Bananas"                     ' This variable array will define which
    strFruit(2) = "Apples"                      ' document is to printed.
    strFruit(3) = "Pears"
    Set WordApp = CreateObject("Word.Application")  ' Create an object instance of Word.
    FirstRecord = True                          ' Used to determine if cycle has been performed
                                                ' before.
    chkRequired.SetFocus                        ' Give CheckBox focus, to evaluate it. (Necessary with Access '97)
    DoCmd.GoToRecord , , acFirst                ' Make sure you're at the beginning of
                                                ' the recordset.
    ' MAIN LOOP.
    Do While RecordCount < 15
        chkRequired.SetFocus
        If chkRequired.Value = "-1" Then    ' If chkRequired is checked then...
            txtFruit.SetFocus
            Select Case txtFruit.Text
                Case strFruit(1)                            ' Bananas
                    vFileToPrint = "Bananas_Report.doc"
                    PrintDocument vFileToPrint      ' Make proc call passing params.
                Case strFruit(2)                            ' Apples
                    vFileToPrint = "Apples_Report.doc"
                    PrintDocument vFileToPrint      ' Make proc call passing params.
                Case strFruit(3)                            ' Pears
                    vFileToPrint = "Pears_Report.doc"
                    PrintDocument vFileToPrint      ' Make proc call passing params.
                Case Else                           ' If the contents of txtFruit is other than
                    vFileToPrint = Empty            ' that which is needed then...
                    GoTo No_PrintOut_Required
            End Select
        Else                                ' If chkRequired isn't checked then...
            vFileToPrint = Empty
            GoTo No_PrintOut_Required
        End If
No_PrintOut_Required:
        On Error GoTo No_More_Records       ' When there are no more records...
        RecordCount = RecordCount + 1       ' Increment counter by 1
        DoCmd.GoToRecord , , acNext
    Loop                                    ' END OF MAIN LOOP

No_More_Records:
        Set WordApp = Nothing               ' Destroy Object Reference
End Sub

Private Sub PrintDocument(sFileToPrint As String)   ' Pass the name of the file to print.
    If FirstRecord Then                     ' If this is the first time this Proc has been
        FirstRecord = False                 ' entered then do nothing except change value of
    Else                                    ' FirstRecord, so that next time it will indicate
                                            ' that its not the first time.
        Set WordApp = Nothing               ' Destroy previous WordApp object variable.
        Set WordApp = New Word.Application  ' Create a new reference to Word if the original
    End If                                  ' has been destroyed.

    WordApp.Visible = False                     ' Don't show Word
    WordApp.ChangeFileOpenDirectory "C:\Reports"   ' Directory of files.
    '                    OPEN DOCUMENT!!
    WordApp.Documents.Open FileName:=sFileToPrint, ConfirmConversions:=False, _
    ReadOnly:=False, AddToRecentFiles:=False, PasswordDocument:="", _
    PasswordTemplate:="", Revert:=False, WritePasswordDocument:="", _
    WritePasswordTemplate:="", Format:=wdOpenFormatAuto
    '                Print the open document.
    WordApp.PrintOut FileName:="", Range:=wdPrintAllDocument, _
    Item:=wdPrintDocumentContent, Copies:=1, Pages:="", _
    PageType:=wdPrintAllPages, Collate:=True, Background:=True, PrintToFile:=False
    DoEvents                                ' Do all tasks in message queue before closing instance.
                                            ' Close down the instance of Word.
    WordApp.Quit wdDoNotSaveChanges
    DoEvents                                ' Make sure all processes have been completed before
                                            ' you destroy the reference to Word.
End Sub



