Attribute VB_Name = "loadermodule"
Option Explicit

Private Declare Function PathIsDirectory Lib "shlwapi.dll" Alias "PathIsDirectoryA" (ByVal pszPath As String) As Long
Private Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
Private Declare Function GetShortPathName Lib "kernel32" Alias "GetShortPathNameA" (ByVal lpszLongPath As String, ByVal lpszShortPath As String, ByVal lBuffer As Long) As Long
Private Declare Function InitCommonControls Lib "comctl32.dll" () As Long

Private Const SW_SHOWNORMAL = 1

Public Sub main()
    Dim tempfileno As Integer
    Dim tempresdataarr() As Byte
    Dim tempstr As String
    Dim temppath As String
    Dim filename As String
    Dim counter As Integer
    
    temppath = gettempfolderpath & "hideittempfolder"
    
    While CBool(PathIsDirectory(temppath & counter))
        counter = counter + 1
    Wend
    
    temppath = temppath & counter & "\"
    MkDir (temppath)
    filename = gettempfolderpath & "cleaner.exe"
    
    tempresdataarr = LoadResData(135, "CUSTOM")
    tempfileno = FreeFile()
    Open filename For Binary As tempfileno
    Put #tempfileno, 1, tempresdataarr
    Close tempfileno
    
    filename = temppath & "mainhideit.exe.manifest"
    tempstr = LoadResString(101)
    tempfileno = FreeFile()
    Open filename For Output As tempfileno
    Print #tempfileno, tempstr
    Close tempfileno
    
    filename = temppath & "mainhideit.exe"
    tempresdataarr = LoadResData(136, "CUSTOM")
    tempfileno = FreeFile()
    Open filename For Binary As tempfileno
    Put #tempfileno, 1, tempresdataarr
    Close tempfileno
    
   Call loadhelpfiles(temppath)
   
   filename = GetShortPath(temppath & "mainhideit.exe")
   tempstr = GetShortPath(gettempfolderpath & "cleaner.exe")
   Call Shell(filename & " " & tempstr, vbNormalFocus)
   
End Sub


Public Function loadhelpfiles(ByVal temp_progpath As String)
Dim tempresdataarr() As Byte
Dim tempfileno As Integer, fileno As Integer
Dim filename As String
Dim strtemp As String
Dim resno As Integer
Dim helppath As String
Dim imagespath As String

        helppath = temp_progpath & "help\"
        imagespath = helppath & "images\"
        

        'create the help directory if not exists
        If Not CBool(PathIsDirectory(helppath)) Then
            MkDir (helppath)
        End If
        
        'create the images directory if not exists
        If Not CBool(PathIsDirectory(imagespath)) Then
            MkDir (imagespath)
        End If
        
        'create the list file
        tempresdataarr = LoadResData(101, "CUSTOM")
        tempfileno = FreeFile()
        filename = helppath & "filelist.txt"
        Open filename For Binary As tempfileno
        Put #tempfileno, 1, tempresdataarr
        Close tempfileno
        
      'open the same file for reading
        tempfileno = FreeFile()
        Open filename For Input As #tempfileno
        
        'resource starts from 102
        resno = 102
                 
        'read the list file and create the files
        While Not EOF(tempfileno)
            Line Input #tempfileno, strtemp
            tempresdataarr = LoadResData(resno, "CUSTOM")
            resno = resno + 1
            fileno = FreeFile()
            Open helppath & strtemp For Binary As #fileno
            Put #fileno, 1, tempresdataarr
            Close fileno
        Wend
        
        Close #tempfileno
        
End Function


Public Function GetShortPath(strFileName As String) As String
    Dim lngRes As Long, strPath As String
    'Create a buffer
    strPath = String$(165, 0)
    'retrieve the short pathname
    lngRes = GetShortPathName(strFileName, strPath, 164)
    'remove all unnecessary chr$(0)'s
    GetShortPath = Left$(strPath, lngRes)
End Function


Private Function gettempfolderpath() As String
    Dim strtemp As String

    'Create a buffer
    strtemp = String(100, Chr$(0))
    'Get the temporary path
    GetTempPath 100, strtemp
    'strip the rest of the buffer
    strtemp = Left$(strtemp, InStr(strtemp, Chr$(0)) - 1)
    gettempfolderpath = strtemp

End Function
