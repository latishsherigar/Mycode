Attribute VB_Name = "CommonFunctions"
Option Explicit

'function to delete the created files in case of cancel operatio
Public Function deletecreatedfiles(progressbar As ctlprogressbar, ByVal outputdir As String, ByVal outputmergefilename As String, ByVal operation As Integer)
Dim filecount As Integer, count As Integer
Dim FileName As String

On Error GoTo errhnd:

If operation = 0 Then
  Close
  Open outputdir & "\list.tmp" For Input As 1
  While Not EOF(1)
    Input #1, FileName
    filecount = filecount + 1
  Wend
 Close
 Open outputdir & "\list.tmp" For Input As 1
 For count = 1 To filecount
   Input #1, FileName
   progressbar.progress = (count / filecount) * 100
   Kill (FileName)
 Next
 Close
 Kill (outputdir & "\list.tmp")
Else
 Close
 Kill (outputmergefilename)
End If
errhnd:
End Function

Public Function cleanup(splitfiletextbox As TextBox, splitfoldertextbox As TextBox, progressbar As ctlprogressbar, mergefiletextbox As TextBox, mergefoldertextbox As TextBox, filesizelabel As Label, sizetextbox As TextBox, sizetypecombo As ComboBox)
splitfiletextbox.Text = ""
splitfoldertextbox.Text = ""
mergefiletextbox.Text = ""
mergefoldertextbox.Text = ""
sizetextbox.Text = ""
filesizelabel.Caption = ""
sizetypecombo.Clear
progressbar.progress = 0
End Function

Public Function closeprog()
Set cmdg = Nothing
End
End Function

Public Function FileExists(ByVal strPath As String) As Boolean
Dim lngRetVal As Long
On Error Resume Next
lngRetVal = Len(Dir$(strPath))
If Err Or lngRetVal = 0 Then
FileExists = False
Else
FileExists = True
End If
End Function


Public Sub updateprogressbar(ByVal actualsize As Double, ByVal totalsize As Double, progressbar As ctlprogressbar)
Dim percent As Double
Static prevprog As Integer
percent = CInt((100 * actualsize) / totalsize)
progressbar.progress = percent
If progressbar.progress <> prevprog Then
DoEvents
End If
prevprog = progressbar.progress
End Sub


'This function takes a full file path in a string and places only the filename in the string.
Public Function GetFileTitle(filepath As String) As String

Dim tempstr As String, temp As String
Dim length As Integer, count As Integer

On Error GoTo errhnd:

'find the length of the string passed i.e the full path.
length = Len(filepath)

'copy the passed string to a temp string till the "/" char is encountered.
For count = length To 1 Step -1
 temp = Mid(filepath, count, 1)
    If (temp = "\") Then
       GetFileTitle = tempstr
       Exit Function
    Else
        tempstr = temp & tempstr
    End If
Next

errhnd:
End Function

'fun to get the file length
Public Function getfilelength(ByVal filepathname As String) As Single
On Error GoTo errorhnd:
getfilelength = FileLen(Trim(filepathname))
errorhnd:
End Function

'fun to get the DOS path to the filepath.
Public Function getDosFilename(sFile As String) As String
    Dim sShortFile As String * 67
    Dim lResult As Long
    'Make a call to the GetShortPathName API
    lResult = GetShortPathName(sFile, sShortFile, _
    Len(sShortFile))
    'Trim out unused characters from the string.
    getDosFilename = Left$(sShortFile, lResult)
End Function


