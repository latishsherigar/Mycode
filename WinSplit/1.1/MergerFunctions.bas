Attribute VB_Name = "MergerFunctions"
Option Explicit
Public outputmergefilename As String
Public Function mergefiles(ByVal splittedfilename As String, ByVal outputdir As String, progressbar As ctlprogressbar) As Boolean

Dim sourcefileno As Integer, targetfileno As String, nooffiles As Integer
Dim count As Integer, retval As Integer, temp As Integer
Dim sourcefilename As String, outputfilename As String
Dim targetpointer As Double, sourcepointer As Double
Dim length As Double, breaksize As Double, a As Double, b As Double
Dim arr() As Byte
Dim totalsize As Double
On Error GoTo errhnd:

'read the file info into the structure stored in the 1st file
sourcefileno = FreeFile()
sourcefilename = getsourcefilename(0, splittedfilename)

Open sourcefilename For Input As sourcefileno
Close sourcefileno

sourcefileno = FreeFile()
Open sourcefilename For Random Access Read Lock Read Write As sourcefileno
Get #sourcefileno, 1, data
Close #sourcefileno

'get the output filename with extra chars removed.
targetfileno = FreeFile()
outputfilename = getoutputfilename(data.FileName, outputdir)
outputmergefilename = outputfilename 'assign the outputfilename value to a global variable for later use.
retval = vbYes
If FileExists(outputfilename) Then
  retval = MsgBox("The file ' " & outputfilename & " ' already exists..." & Chr(13) & "Overwrite It????", vbCritical + vbYesNo + vbDefaultButton2, "Overwrite file")
End If

If retval = vbYes Then
      Open outputfilename For Binary Access Write Lock Read Write As targetfileno

       nooffiles = data.nooffiles
       targetpointer = 1
       
       'check whether all the file exists and exit if any file missing
       For temp = 1 To nooffiles
         sourcefilename = getsourcefilename(temp - 1, splittedfilename)
         If Not FileExists(sourcefilename) Then
           MsgBox "File '" & sourcefilename & " ' is missing or has been deleted." & Chr(13) & "The operation cannot be continued.Please try again with all the files.", vbCritical + vbOKOnly, "File Missing.."
           mergefiles = False
           Exit Function
         End If
       Next
       totalsize = gettotalsize(splittedfilename, nooffiles)

       For count = 1 To nooffiles

         If Not canceloperation Then
            sourcefileno = FreeFile()
            sourcefilename = getsourcefilename(count - 1, splittedfilename)
            Open sourcefilename For Binary Access Read Lock Read Write As sourcefileno
    
            If count = 1 Then
              length = LOF(sourcefileno) - Len(data)
              sourcepointer = Len(data) + 1
            Else
              length = LOF(sourcefileno)
              sourcepointer = 1
            End If
         
            If length > 1024 Then
              breaksize = 1024
              b = length \ 1024
            Else
              breaksize = length
              b = 0
            End If

            For a = 1 To b + 1
              Call updateprogressbar(targetpointer, totalsize, progressbar)

              If (a = b + 1) Then
                If (length > 1024) Then
                  breaksize = length - (b * 1024)
                End If
              End If
              
              ReDim arr(1 To breaksize)
              Get #sourcefileno, sourcepointer, arr
              sourcepointer = sourcepointer + breaksize
              Put #targetfileno, targetpointer, arr
              targetpointer = targetpointer + breaksize
            
            Next a
  
            Close #sourcefileno
         Else
            If MsgBox("Are you sure you want to cancel the operation????", vbCritical + vbYesNo + vbDefaultButton2, "Cancel Operation") = vbYes Then
               mergefiles = False
               Exit Function
            Else
               count = count - 1
               canceloperation = False
            End If
         End If
      Next
End If

Close #targetfileno
Close #sourcefileno
mergefiles = True
Exit Function

errhnd:
'Close #targetfileno
'Close #sourcefileno
Close

Dim strerr As String
strerr = "Error Number: " & Err.Number & Chr(13) & "Error Description :" & Err.Description

Select Case (Err.Number)
  Case 52:  MsgBox "ERROR : Cannot Create the Output File" & Chr(13) & "This could be possibly beacuse of an Incorrect Folder path" & Chr(13) & Chr(13) & Chr(13) & "DETAILS:" & Chr(13) & "Error Number:" & Err.Number & Chr(13) & "Error description :" & Err.Description, vbCritical, "Error: Cannot create output file"
  Case 53:  MsgBox "ERROR : File " & GetFileTitle(sourcefilename) & " missing." & Chr(13) & Chr(13) & "Winsplit will not merge the files.", vbCritical + vbOKOnly, "ERROR : File missing"
  Case Else: MsgBox "ERROR : Cannot merge files due to fatal error." & Chr(13) & "Filename: " & GetFileTitle(sourcefilename) & Chr(13) & strerr, vbCritical + vbOKOnly, "Winsplit - File merging error"
End Select
mergefiles = False
End Function


Private Function getoutputfilename(FileName As String, outputdir As String)

Dim count As Integer
Dim tempchar As String, tempstr As String

For count = 1 To Len(FileName)
  tempchar = Mid(FileName, count, 1)
  If tempchar <> Chr(0) Then
    tempstr = tempstr & tempchar
  End If
Next
getoutputfilename = outputdir & "\" & tempstr

End Function


Public Function validatemergefileinfo(unsplitfilenametextbox As TextBox, unsplitoutputdirtextbox As TextBox) As Boolean
If Trim(unsplitfilenametextbox.Text) = "" Then
  MsgBox "Please enter one of the filename to be merged.", vbCritical + vbOKOnly, "Winsplit"
  validatemergefileinfo = False
  Exit Function
End If
  
If Trim(unsplitoutputdirtextbox.Text) = "" Then
  MsgBox "Please enter the Output Folder where the joined file has to be placed.", vbCritical + vbOKOnly, "Winsplit"
  validatemergefileinfo = False
  Exit Function
End If

validatemergefileinfo = True
End Function

Private Function getsourcefilename(count As Integer, strPath As String)
'this function takes in the full path of any splitted filename
'and returns the appropiate filename with full path.

Dim temp As String, temp1 As String, temp2 As String
Dim length As Integer

temp = GetFileTitle(strPath)
length = Len(temp)
temp = Mid(temp, 4, Len(strPath))
temp1 = Format(count, "000")
temp2 = Left(strPath, Len(strPath) - length)
temp = temp2 & temp1 & temp
getsourcefilename = temp

End Function

Private Function gettotalsize(ByVal splittedfilenamepath As String, ByVal noofiles As Integer) As Double
Dim a As Integer, sourcefilename As String
For a = 1 To noofiles
  sourcefilename = getsourcefilename(a - 1, splittedfilenamepath)
 gettotalsize = gettotalsize + FileLen(sourcefilename)
Next
End Function
