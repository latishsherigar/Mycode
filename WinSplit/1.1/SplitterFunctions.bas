Attribute VB_Name = "SplitterFunctions"
Option Explicit

Public Function splitfiles(ByVal FileName As String, ByVal outputdir As String, ByVal splittype As String, ByVal splitsizestr As String, progressbarctl As ctlprogressbar) As Boolean
Dim FileTitle As String, splitfilename As String
Dim filelength As Double, splitsize As Double, lastpartsize As Double
Dim sourcepointer As Double, targetpointer As Double
Dim arrlength As Double, breaksize As Double, a As Double, b As Double
Dim nooffiles As Integer, sourcefileno As Integer, targetfileno As Integer, listfileno As Integer
Dim count As Integer
Dim arr() As Byte
Dim overwrite As Integer

'On Error GoTo errorhnd:
sourcepointer = 1
targetpointer = 1

Dim temp As Integer

'find the main file name.
FileTitle = GetFileTitle(getDosFilename(FileName))

'Get fileLength
filelength = FileLen(FileName)

'Get the splitsize  and lastpartsize in bytes.
splitsize = getsplitfilesize(splittype, Val(splitsizestr), filelength)
If splitsize = 0 Then ' on invalid splitsize
 splitfiles = False
 Exit Function
End If

'find the no of files to be splitted.
nooffiles = getnooffiles(filelength, splitsize)

'find the last part size
lastpartsize = filelength - (splitsize * (nooffiles - 1))

'write the filename and the no of files in the structure data.
data.FileName = convertspaces(FileTitle, Len(data.FileName))
data.nooffiles = nooffiles

'open the source file for reading data.
sourcefileno = FreeFile()
Open FileName For Binary Access Read Lock Read Write As sourcefileno

'open the file list file.
listfileno = FreeFile()
Open outputdir & "\" & "list.tmp" For Output Access Write Lock Read Write As listfileno

For count = 0 To nooffiles - 1
If canceloperation = False Then
   'get the name of the 1st file .
    splitfilename = getsplitfilename(count, FileName, outputdir)
       
    If overwritewithoutprompt = False Then
      'check whether the fileexists
       If FileExists(splitfilename) Then
        overwrite = MsgBox("The File '" & splitfilename & "' already exists." & Chr(13) & "Overwrite it?????", vbCritical + vbYesNo + vbDefaultButton2, "Overwrite File ????")
       Else
        overwrite = vbYes
       End If
    Else
      overwrite = vbYes
    End If
    
    'find the length of the array to be declared.
     arrlength = findarrlength(count, nooffiles, splitsize, lastpartsize)
    
    If overwrite = vbYes Then
            
      'open the target file for putting the structure info.
       targetfileno = FreeFile()
       Open splitfilename For Binary Access Write Lock Read Write As targetfileno
     
      'write the filename in the filelist.
       Print #listfileno, splitfilename
     
      'put the file info in the first file.
       If (count = 0) Then
        Put #targetfileno, 1, data
       targetpointer = Len(data) + 1
       End If
       
   
        If arrlength > 1024 Then
            breaksize = 1024
            b = arrlength \ 1024
        Else
            breaksize = arrlength
            b = 0
        End If


        For a = 1 To b + 1

          Call updateprogressbar(sourcepointer, filelength, progressbarctl)

          If (a = b + 1) Then
            If (arrlength > 1024) Then
               breaksize = arrlength - (b * 1024)
            End If
          End If

          'redeclare the array as the size of the splitted file.
           ReDim arr(1 To breaksize)

          'read the data from the source file and increment the source pointer.
           Get #sourcefileno, sourcepointer, arr
          sourcepointer = sourcepointer + breaksize

          'put the read contents to the target file after the file info.
           Put #targetfileno, targetpointer, arr
           targetpointer = targetpointer + breaksize
        Next a
        
   'if the file is not to be overwritten
    Else
     sourcepointer = sourcepointer + arrlength
     Call updateprogressbar(sourcepointer, filelength, progressbarctl)
    End If
   
    targetpointer = 1
    Close #targetfileno
 Else
    If MsgBox("Are you sure you want to cancel the operation????", vbCritical + vbYesNo + vbDefaultButton2, "Cancel Operation") = vbYes Then
      splitfiles = False
      Exit Function 'exit the function with error code
    Else
      count = count - 1 'decrease the count to reverse this step
      canceloperation = False 'continue the operation
    End If
 End If
  
Next count
Call updateprogressbar(1, 1, progressbarctl)
Close #targetfileno
Close #sourcefileno
Close #listfileno
Kill (outputdir & "\" & "list.tmp")
splitfiles = True
Exit Function

errorhnd:
Close #targetfileno
Close #sourcefileno
Close #listfileno

Dim strerr As String
strerr = "Error Number: " & Err.Number & Chr(13) & "Error Description :" & Err.Description

Select Case Err.Number
  Case 53: MsgBox "ERROR : Incorrect filepath " & Chr(13) & "File '" & GetFileTitle(splitfilename) & "' not found.", vbCritical + vbOKOnly, "Winsplit - File splitting error"
  Case 76: MsgBox "ERROR : Incorrect Folder Path" & Chr(13) & "The Folder or directory path you have entered is Invalid.Please enter a vaild path", vbCritical + vbOKOnly, "Error : Incorrect Output Folder"
  Case Else: MsgBox "Winsplit cannot split the files due to fatal error." & Chr(13) & "Filename: " & GetFileTitle(splitfilename) & Chr(13) & strerr, vbCritical + vbOKOnly, "Winsplit - File splitting error"
End Select

splitfiles = False
End Function

'Function used for converting vb strings to dos type strings to maintain compability with DOS version.
Private Function convertspaces(FileTitle As String, length As Integer)
Dim temp As String, temp1 As String, count As Integer
 
 For count = 1 To length - Len(FileTitle)
   temp = Chr(0)
   temp1 = temp1 & temp
 Next
convertspaces = FileTitle & temp1
End Function

'Function used for returing the length of the byte array to be declared.
Private Function findarrlength(ByVal no As Integer, ByVal files As Integer, ByVal splitsize As Double, ByVal lastpartsize As Double) As Double
If no = files - 1 Then ' for the last file
  findarrlength = lastpartsize
Else
  findarrlength = splitsize
End If
End Function

'Function used for getting the names of the splitted files.
Private Function getsplitfilename(ByVal no As Integer, ByVal filepath As String, ByVal splitoutputdir As String) As String
Dim temp As String, dosname As String, extension As String
dosname = GetFileTitle(getDosFilename(filepath))
temp = getfnamewoutext(dosname)
If Len(temp) > 5 Then
  temp = Mid(temp, 1, 5)
End If
 temp = Format(no, "000") & temp
 
extension = getfileextension(dosname)
getsplitfilename = splitoutputdir & "\" & temp & "." & extension
End Function

'function to get the extension of the file
'get the extension of the file if any.
 'Start from backwards if there are 2 dots in a filename
 'take only the last extension as it will be the real extension
Public Function getfileextension(ByVal FileName As String) As String
Dim tempchar As String, extension As String, count As Integer, dotpos As Integer
Dim arr(10) As String

dotpos = InStrRev(FileName, ".", , vbBinaryCompare)
  
  If dotpos = 0 Then
    getfileextension = ""
    Exit Function
  End If
  
extension = Mid(FileName, dotpos + 1, Len(FileName) - dotpos)
getfileextension = extension
Exit Function

End Function



'function to seperate the filename without its extension
Private Function getfnamewoutext(str As String)
Dim temp As String, temp1 As String
Dim count As Integer
count = 1
temp = Mid(str, 1, 1)
While (temp <> ".")
  If (temp <> " ") Then
    temp1 = temp1 & temp
  End If
    count = count + 1
    temp = Mid(str, count, 1)
Wend
getfnamewoutext = temp1
End Function


Public Function formatlabelandcombo(ByVal filelength As Double, filesizelabel As Label, splitformatcombo As ComboBox)
'Format the length label according to the size.
On Error GoTo errorhnd:

splitformatcombo.Clear

Select Case Len(CStr(filelength))
  Case 1 To 3: filesizelabel.Caption = filelength & " Bytes"
                splitformatcombo.AddItem (bytes)
                
  Case 4 To 6:  filesizelabel.Caption = Format((filelength * (1 / 1000)), "##################.###") & " KB ."
                splitformatcombo.AddItem (kilobytes)
                splitformatcombo.AddItem (bytes)
                
  Case 7 To 9: filesizelabel.Caption = Format((filelength * (1 / 1000000)), "##################.###") & " MB ."
                splitformatcombo.AddItem (floppy)
                splitformatcombo.AddItem (megabytes)
                splitformatcombo.AddItem (kilobytes)
                splitformatcombo.AddItem (bytes)
                     
  Case Else: filesizelabel.Caption = Format((filelength * (1 / 1000000000)), "##################.###") & " GB ."
                splitformatcombo.AddItem (gigabytes)
                splitformatcombo.AddItem (megabytes)
                
                
End Select
            
errorhnd:
End Function



Private Function getnooffiles(filelength As Double, splitsize As Double) As Double
Dim lastfile As Double
Dim nooffiles As Double


'do integer division and add 1 to the answer for the total files.
If (filelength / splitsize) <> 0 Then
 lastfile = filelength Mod splitsize
End If

'add extra file to the total no of files only if last file is 0.
If (lastfile <> 0) Then
   nooffiles = (filelength \ splitsize) + 1
Else
   nooffiles = filelength \ splitsize
End If

'return the no of files to the calling function.
getnooffiles = nooffiles
End Function

Private Function getsplitfilesize(splittype As String, splitsize As Double, filelength As Double) As Double
On Error GoTo errhnd:
Dim temp As Double

'multilpy the user selected size by the multiplication factor.
Select Case splittype
 Case floppy: temp = 1.38 * 10 ^ 6 ' floppy size-1.38MB
 Case megabytes: temp = Format((splitsize * 10 ^ 6), "##################################") ' for  MB
 Case kilobytes: temp = Format((splitsize * 10 ^ 3), "##################################") 'for KB
 Case bytes: temp = Format((splitsize), "##################################") ' for Bytes
End Select

'Check if splitsize is valid i.e less then the filelength.
If (temp > filelength) Then
  MsgBox "Invalid part size.Please enter a split size less then the filelength.", vbOKOnly + vbCritical, "Winsplit"
  getsplitfilesize = 0 'return 0 on error conditon
  Exit Function
End If

getsplitfilesize = temp

errhnd:
End Function


'This function reurns False on error to the calling function.
Public Function validatesplitfileinfo(ByVal splitfilename As String, ByVal splitoutputdir As String, ByVal splittype As String, ByVal splitsize As String) As Boolean
Dim temp As Integer

If splitfilename = "" Then
  MsgBox "Please enter a vaild filename to be splitted.", vbCritical + vbOKOnly, "Winsplitter"
  validatesplitfileinfo = False
  Exit Function
End If
If splitoutputdir = "" Then
  MsgBox "Please select a valid Output directory ,where the splitted files will be placed.", vbCritical + vbOKOnly, "Winsplit"
  Exit Function
End If

If splittype = "" Then
  MsgBox "Please select the size format in which you want your files to be splitted.", vbCritical + vbOKOnly, "Winsplit"
  validatesplitfileinfo = False
  Exit Function
End If

If Val(splitsize) <= 0 And splittype <> floppy Then 'floppy yis a constant for the 1.44MB floppy
  MsgBox "Please enter a valid  size in which you want your files to be splitted.", vbCritical + vbOKOnly, "Winsplit"
  validatesplitfileinfo = False
  Exit Function
End If

Dim splitsize1 As Double
Dim filelength As Double
Dim nooffiles As Double
''find the main file name.
'FileTitle = GetFileTitle(getDosFilename(splitfilename))

'Get fileLength
filelength = FileLen(splitfilename)

'Get the splitsize  and lastpartsize in bytes.
splitsize1 = getsplitfilesize(splittype, Val(splitsize), filelength)

'find the no of files to be splitted.
If splitsize1 <> 0 Then
    nooffiles = getnooffiles(filelength, splitsize1)

    'check if no of files is not greater than 1000.
    If (nooffiles > 1000) Then
       MsgBox "Please increase the splitsize.Parts greater than 1000.", vbCritical, "Winsplit"
       validatesplitfileinfo = False
       Exit Function
    End If

    'Validate the no of files.
    If (nooffiles <= 0) Then
      MsgBox "Invalid Part size.", vbCritical + vbOKOnly, "Winsplit"
      validatesplitfileinfo = False
      Exit Function
    End If
Else
      validatesplitfileinfo = False
      Exit Function
End If

'if all's well return true
validatesplitfileinfo = True
End Function




