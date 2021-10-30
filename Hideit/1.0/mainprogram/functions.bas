Attribute VB_Name = "functions"
Option Explicit


'function to get the extension of the file
Public Function getfileextension(ByVal filename As String) As String
'get the extension of the file if any.
 'Start from backwards if there are 2 dots in a filename
 'take only the last extension as it will be the real extension
    
    Dim tempchar As String, extension As String, count As Integer, dotpos As Integer
    Dim arr(10) As String

    getfileextension = ""

    dotpos = InStrRev(filename, ".", , vbBinaryCompare)
  
    If dotpos = 0 Then
        Exit Function
     End If
  
    extension = Mid(filename, dotpos + 1, Len(filename) - dotpos)

    getfileextension = extension

End Function


'Function to get the filename of any filepath
Public Function get_file_title(strfilepath As String) As String
    
    Dim pointer As Integer
    pointer = InStrRev(strfilepath, "\", , vbBinaryCompare)
    
    get_file_title = Right(strfilepath, Len(strfilepath) - pointer)
End Function


'function to get the file information
Public Function getfileinfo(strpath As String)
'function puts the fileinformation on a structure called fileinfo
    
    Dim FI As SHFILEINFO
    
    'Get file info
    
    SHGetFileInfo strpath, 0, FI, Len(FI), SHGFI_DISPLAYNAME Or SHGFI_TYPENAME
    
    fileinfo.filename = get_file_title(strpath)
    
    fileinfo.filetype = StripTerminator(FI.szTypeName)
    
    If fileinfo.filetype = "File Folder" Then
      fileinfo.filesize = ""
    Else
      fileinfo.filesize = FileLen(strpath)
    End If
    
    fileinfo.filepath = strpath

End Function



'This fucntion is used to strip al the unnecessary chr$(0)'s
Public Function StripTerminator(sInput As String) As String
    
    Dim ZeroPos As Integer
    
    'Search the position of the first chr$(0)
    ZeroPos = InStr(1, sInput, vbNullChar)
    
    If ZeroPos > 0 Then
        StripTerminator = Left$(sInput, ZeroPos - 1)
    Else
        StripTerminator = sInput
    End If
End Function



'Function returns programs tempfolderpath if sysfolder is false
'returns sys tempfolder path if true
Public Function gettempfolderpath(Optional SYSFOLDER As Boolean) As String
    
    Dim strtemp As String
      
   If SYSFOLDER Then
        'Create a buffer
        strtemp = String(100, Chr$(0))
        'Get the temporary path
        GetTempPath 100, strtemp
   
       'strip the rest of the buffer
        gettempfolderpath = Left$(strtemp, InStr(strtemp, Chr$(0)) - 1)
    Else
        gettempfolderpath = get_prog_tempfolderpath("Hideittemp")
   End If

End Function

'function to get a temp file for the directory given.
Public Function gettempfilename(outputdir As String, Optional ByVal extension As String) As String
    Dim counter As Integer
    Dim tempfilename As String
    
    If Trim(extension) <> "" Then
        tempfilename = "temp." & extension
    Else
        tempfilename = "temp.tmp"
    End If

    While CBool(PathFileExists(outputdir & counter & tempfilename))
        counter = counter + 1
    Wend
    
    gettempfilename = outputdir & counter & tempfilename

End Function

'for getting a name of the compressed file which has to created in the
'temp directory
Public Function get_compressed_filename() As String
    Dim temp_compressed_filename As String
    
    Dim i As Integer
    
    Dim loopagain As Boolean
    
    temp_compressed_filename = gettempfolderpath
    
    i = 0
    
    loopagain = True
    
    While loopagain
     
        If Not CBool(PathFileExists(temp_compressed_filename & CStr(i) & "temp.tmp")) Then
            
            loopagain = False
     
        End If
     
        i = i + 1
    
    Wend
    
    get_compressed_filename = temp_compressed_filename & CStr(i - 1) & "temp.tmp"
End Function


'store the files which are in the listview's list to an array
Public Function store_files_2_array(ByRef fnamearr() As String, lstfiles As ListView)
Dim i As Integer

Dim items As Integer


items = lstfiles.ListItems.count

ReDim fnamearr(items - 1)

For i = 0 To items - 1

  fnamearr(i) = lstfiles.ListItems(i + 1).SubItems(3)
  
Next

store_files_2_array = items

End Function


Public Function file_not_inthelist(strfilepath As String, lstfiles As ListView) As Boolean
    Dim i As Integer

    For i = 1 To lstfiles.ListItems.count
        
        If lstfiles.ListItems.item(i).SubItems(3) = strfilepath Then
        
            file_not_inthelist = False
        
            Exit Function
        
        End If
    Next
    
    file_not_inthelist = True

End Function



Public Sub add_file_2_list(strfilepath As String)

    Dim strfiletitle As String
    
    Dim Litem As ListItem 'vb object
    
With frmmain
    Call getfileinfo(strfilepath)
    
    If file_not_inthelist(strfilepath, .lstfiles) Then
        
        'changes the filename if a file with same name exists
        fileinfo.filename = change_filename_if_same_name_exists(.lstfiles, fileinfo.filename)
        
        'add the item to the listview
        Set Litem = .lstfiles.ListItems.Add(, , fileinfo.filename)
        
        Litem.SubItems(1) = fileinfo.filetype
        
        Litem.SubItems(2) = fileinfo.filesize
        
        Litem.SubItems(3) = fileinfo.filepath
    
        'assign the system imagelist
        objSystemImageList.ShowSysIL strfilepath, .lstfiles.hwnd, .lstfiles.view, .lstfiles.ListItems.count
        
        'again assign the system imagelist since during first
        'time the 1st icon doesnt appear
        objSystemImageList.AssignSysIL (.lstfiles.hwnd)
        
        
        .mnuActionsRemove.Enabled = True
        
        .tlbar.Buttons("remove").Enabled = True
      
        .mnuActionsHide.Enabled = True
        
        .tlbar.Buttons("hide").Enabled = True
      
        .mnuOptionsPassword.Enabled = True
        
        .tlbar.Buttons("password").Enabled = True
      
        .mnuFileProperties.Enabled = True
        
        .mnuActionselectall.Enabled = True
        
        .mnuActionInvSel.Enabled = True
      
        .lstfiles.SelectedItem.Selected = False
        
        .lstfiles.ListItems(.lstfiles.ListItems.count).Selected = True
        
        .lstfiles.SetFocus
    
    End If
End With

End Sub

Public Function samename_exits(lstfiles As ListView, ByVal filename As String) As Boolean

    Dim i As Integer
    samename_exits = False
    For i = 1 To lstfiles.ListItems.count
        If filename = lstfiles.ListItems.item(i) Then
            samename_exits = True
            Exit Function
        End If
    Next

End Function

Public Function change_filename_if_same_name_exists(lstfiles As ListView, ByVal filename As String) As String

      
    Dim i As Integer
    Dim tempstr As String
    
    change_filename_if_same_name_exists = filename
    i = 0
    tempstr = filename
    
    While samename_exits(lstfiles, tempstr)
        i = i + 1
        tempstr = "(" & i & ")" & filename
    Wend
    change_filename_if_same_name_exists = tempstr

End Function

Public Sub viewtype(index As Integer)

With frmmain
    Select Case index
     
        Case 1: .lstfiles.view = lvwIcon
                .mnuViewlargeicons.Checked = True
                .mnuViewlist.Checked = False
                .mnuViewReport.Checked = False

        
        Case 2: .lstfiles.view = lvwList
                .mnuViewlargeicons.Checked = False
                .mnuViewlist.Checked = True
                .mnuViewReport.Checked = False

        Case 3: .lstfiles.view = lvwReport
                .mnuViewlargeicons.Checked = False
                .mnuViewlist.Checked = False
                .mnuViewReport.Checked = True

    End Select
    
    objSystemImageList.AssignSysIL (.lstfiles.hwnd)
    
    .lstfiles.Refresh

End With

End Sub


Public Sub AddFile()

Dim pos As Integer
Dim temp As String
Dim tempdirpath As String
Dim filename As String
Dim oldpos As Integer
Dim length As Integer
  
    With frmmain
        
        .cmdg.DialogTitle = "Open"
        
        .cmdg.Flags = cdlOFNAllowMultiselect Or cdlOFNExplorer Or cdlOFNFileMustExist Or cdlOFNLongNames
        
        .cmdg.MaxFileSize = 32000
        
        .cmdg.filename = ""
        
        .cmdg.Filter = "All Files (*.*)|*.*"
        
        .cmdg.ShowOpen
    
    If .cmdg.filename <> "" Then
        
        temp = .cmdg.filename
        
        pos = InStr(1, temp, Chr(0), vbBinaryCompare)

        If pos > 0 Then
            
            tempdirpath = Left(temp, pos - 1)
            
            While pos > 0
                
                oldpos = pos
                
                pos = InStr(oldpos + 1, temp, Chr(0), vbBinaryCompare)
                
                If pos > 0 Then
                    length = (pos - 1) - oldpos
                Else
                    length = Len(temp) - oldpos
                End If
                
                filename = Mid(temp, oldpos + 1, length)
                
                Call add_file_2_list(tempdirpath & "\" & filename)
         
            Wend
        Else
            
        Call add_file_2_list(.cmdg.filename)
        
        End If
        
    
    End If
    
    End With
End Sub




Public Sub ShowProps(filename As String, OwnerhWnd As Long)
    
    Dim SEI As SHELLEXECUTEINFO
    Dim r As Long
    With SEI
        'Set the structure's size
        .cbSize = Len(SEI)
        'Seet the mask
        .fMask = SEE_MASK_NOCLOSEPROCESS Or _
         SEE_MASK_INVOKEIDLIST Or SEE_MASK_FLAG_NO_UI
        'Set the owner window
        .hwnd = OwnerhWnd
        'Show the properties
        .lpVerb = "properties"
        'Set the filename
        .lpFile = filename
        .lpParameters = vbNullChar
        .lpDirectory = vbNullChar
        .nShow = 0
        .hInstApp = 0
        .lpIDList = 0
    End With
    r = ShellExecuteEx(SEI)
    Exit Sub

End Sub


Public Function viewfile()

Dim strfile As String
With frmmain
    If Not .lstfiles.SelectedItem Is Nothing Then
      strfile = .lstfiles.SelectedItem.SubItems(3)
      ShellExecute .hwnd, "open", strfile, vbNullString, "C:\", SW_SHOWNORMAL
    End If
End With

End Function

Public Sub remove_file_from_list()

    Dim i As Integer, item As Integer
        
    If gbbool_open_archive_state Then
        Exit Sub
    End If
    
    With frmmain
    
        If .lstfiles.ListItems.count > 0 Then
        
           'i = MsgBox("Are you sure you want to remove the selected files from the list????", vbCritical + vbDefaultButton2 + vbYesNo, "File Removal Warning")
        
           If Not .lstfiles.SelectedItem Is Nothing Then
            
                item = .lstfiles.ListItems.count
            
                i = 1
            
                While i <= item
                
                    If .lstfiles.ListItems.item(i).Selected Then
                    
                        .lstfiles.ListItems.Remove (i)
                    
                        item = item - 1
                    
                        i = i - 1
                
                    End If
            
                    i = i + 1
    
                Wend
    
                item = .lstfiles.ListItems.count
    
                If item <= 0 Then
      
                    .mnuActionsRemove.Enabled = False
      
                    .tlbar.Buttons.item("remove").Enabled = False
        
                    .mnuActionsHide.Enabled = False
      
                    .tlbar.Buttons("hide").Enabled = False
    
                    .mnuOptionsPassword.Enabled = False
      
                    .tlbar.Buttons("password").Enabled = False
                    
                    .mnuFileProperties.Enabled = False
                      
                    .mnuActionselectall.Enabled = False
                      
                    .mnuActionInvSel.Enabled = False
    
                End If
    
           End If
    
        End If
    
        .lstfiles.SetFocus
    
    End With

End Sub


Public Sub initialise()

    
    With frmmain
    
        .mnuActionsAdd.Enabled = False
        
        .tlbar.Buttons.item("add").Enabled = False
        
        
        .mnuActionsRemove.Enabled = False
        
        .tlbar.Buttons.item("remove").Enabled = False
        
        
        .mnuOptionsPassword.Enabled = False
        
        .tlbar.Buttons.item("password").Enabled = False
        
        
        .mnuActionsHide.Enabled = False
        
        .tlbar.Buttons.item("hide").Enabled = False
        
        
        .mnuActionsShow.Enabled = False
        
        .tlbar.Buttons.item("show").Enabled = False
        
        
        .mnuFileProperties.Enabled = False
        
        .mnuActionsView.Enabled = False
        
        
        .mnuActionselectall.Enabled = False
        
        .mnuActionInvSel.Enabled = False
        
        .lstfiles.ListItems.Clear
        
        
    End With
    
  frmmain.Caption = "HideIt"
  gbstr_coverfilename = ""
  gbstr_resultfilename = ""
  gbstr_backupresultfilename = ""
  gbstr_openarchivename = ""
  gbstr_extractoutputdir = ""
  gbstr_password = ""
  gbint_errormessage = ""
  
  gbdbl_compressedfilesize = 0
  gbdbl_compressedpointer = 0
  gbdbl_coverfilesize = 0
  
  gbint_errorno = 0
  gbint_password_status = 0
  gbint_operation_status = 0
  
  gbbool_purifyfile = False
  gbbool_new_archive_state = False
  gbbool_open_archive_state = False
  gbbool_encrypted = False
  gbbool_data_verification_flag = False
  gbbool_again = False
  
  ReDim gbarrstr_filename(0)
  ReDim gbarrdbl_filesize(0)
  
  Set objSystemImageList = Nothing

End Sub


Public Function show_password_warning_dialog() As Integer
    
    frmpasswordwarning.Show (1)
    show_password_warning_dialog = gbint_password_status

End Function

Public Function check_whether_to_show_password_box() As Boolean
    
Dim retval As Integer

check_whether_to_show_password_box = True

    If gbstr_password <> "" Then
        check_whether_to_show_password_box = True
        Exit Function
    End If
    
    If gbint_invisiblemodeclicked = 1 Then
        frmpassword.Show (1)
        If gbstr_password = "" Then
            check_whether_to_show_password_box = False
            Exit Function
        Else
            check_whether_to_show_password_box = True
            Exit Function
        End If
    End If
    
    
    If INI_settings.RemindPassword = 1 Then
        retval = show_password_warning_dialog
        
        Select Case retval
        
            Case vbYes:  frmpassword.Show (1)
                        If gbstr_password <> "" Then
                            check_whether_to_show_password_box = True
                        End If
            
            Case vbNo: check_whether_to_show_password_box = True
            
            Case Else:  check_whether_to_show_password_box = False
            
        End Select
        Exit Function
     Else
        check_whether_to_show_password_box = True
     End If

    If INI_settings.showPasswordboxonHide = 1 Then
        check_whether_to_show_password_box = True
        frmpassword.Show (1)
        Exit Function
    End If
    

End Function

Public Function write_proginfo_details(ByVal startlocation As Double, resultfileno As Integer, lstfiles As ListView, bytepointer As Double, ByVal tempcompressedfile As String)

    'store data in the proginfo structure
    proginfo.progname = "Hide It"
    
    proginfo.minversion_required = 1
    
    If gbstr_password <> "" Then
        proginfo.Encrypted = True
    Else
       proginfo.Encrypted = False
    End If
    
    proginfo.invisiblemode = CStr(gbint_invisiblemodeclicked)
    
    proginfo.compressedfilesize = FileLen(tempcompressedfile)
    
    proginfo.no_of_archivefiles = lstfiles.ListItems.count
    
    proginfo.pointer = startlocation
    
    
    'write the proginfo data into the resultfile
    Put #resultfileno, bytepointer, proginfo
    
    bytepointer = bytepointer + Len(proginfo)
        
End Function

Public Function write_filedetails_in_resultfile(ByVal resultfileno As Integer, lstfiles As ListView, bytepointer As Double)
    
Dim strfilename As String
Dim strfilenamelength  As String * 3

Dim strfilesize As String
Dim strfilesizelength As String * 2

Dim i As Integer
Dim startpointer As Double
Dim elements  As Double
Dim objenc As New clsencryption
Dim temparr() As Byte
Dim retval As Integer

'Structure of the data stored
'strfilenamelength - 3byte string
'strfilename -variable  string
'strfilesizelength- 2 byte string
'strfilesize - variable length string
    
    startpointer = bytepointer
    
    'write the filedetails(name,size) into the file
     For i = 1 To lstfiles.ListItems.count
    
        strfilename = Trim(lstfiles.ListItems(i).Text)
        
        strfilesize = lstfiles.ListItems(i).SubItems(2)
        
        'write the length of the strfilename string
        strfilenamelength = CStr(Len(strfilename))
        Put #resultfileno, bytepointer, strfilenamelength
        bytepointer = bytepointer + Len(strfilenamelength)
        
        'write the strfilename
        Put #resultfileno, bytepointer, strfilename 'variablestring
        bytepointer = bytepointer + strfilenamelength
        
        'write the length of the strfilesize string
        strfilesizelength = CStr(Len(strfilesize))
        Put #resultfileno, bytepointer, strfilesizelength
        bytepointer = bytepointer + Len(strfilesizelength)
        
        'write the filesize
        Put #resultfileno, bytepointer, strfilesize 'double
        bytepointer = bytepointer + Len(strfilesize)
        
    Next
    
If gbint_invisiblemodeclicked = 1 Then
    elements = bytepointer - startpointer
    ReDim temparr(elements - 1)
    Get #resultfileno, startpointer, temparr
    retval = objenc.encodearr(temparr, elements, gbstr_password)
    Put #resultfileno, startpointer, temparr
End If

End Function


Public Function encode_data_validity_flag(ByVal resultfileno, ByRef bytepointer)
    
    Dim objenc As New clsencryption
    Dim temparr() As Byte
    
    'write data in the verification flag
    ReDim temparr(3)
    
    temparr(0) = Asc("T")
    temparr(1) = Asc("R")
    temparr(2) = Asc("U")
    temparr(3) = Asc("E")
    
    Call objenc.encodearr(temparr(), 4, gbstr_password)
    
    Put #resultfileno, bytepointer, temparr
    
    bytepointer = bytepointer + 4
    
End Function



Public Function openarchive() As Boolean
On Error GoTo errhnd:

    Dim temparr() As Byte
    Dim sourcefileno As Integer
    Dim compressedfileno As Integer
    Dim bytepointer As Double
    Dim compressedfilename As String
    Dim i As Integer, j As Integer
    Dim temp_compressed_filename As String
    Dim filenamelength  As Double
    Dim filename As String
    Dim filesizelength As Double
    Dim filesize As Double
    Dim startlocation As Double
    Dim objenc As New clsencryption
    Dim retval As Integer
    Dim elements As Double
    

    openarchive = False
    
    'read the lastbyte of the file
    sourcefileno = FreeFile(0)
    
    Open gbstr_openarchivename For Binary Access Read Write As sourcefileno
    
    bytepointer = (LOF(sourcefileno) - Len(proginfo)) + 1
    
    Get #sourcefileno, bytepointer, proginfo
    
    'validate the file
    If proginfo.progname <> "Hide It" Then
      Exit Function
    End If
    
    If proginfo.minversion_required > 1 Then
      MsgBox "Incorrect Version.This file can only be opened by versions greater than " & proginfo.minversion_required & " :("
      Exit Function
    End If
    
    'see whether the archive is encrypted or not
    gbbool_encrypted = proginfo.Encrypted
    
    'if invisible mode
    If Val(proginfo.invisiblemode) <> gbint_invisiblemodeclicked Then
        Exit Function
    End If
    
    If proginfo.invisiblemode = "1" Then
        ReDim temparr(3)
        Get #sourcefileno, proginfo.pointer, temparr
        If Not check_data_validity(temparr()) Then
            Exit Function
        End If
    End If
    
    
    'store the address in the bytepointer
    bytepointer = proginfo.pointer + 4

    'get the size of the compressed file
    gbdbl_compressedfilesize = proginfo.compressedfilesize
    
    
    
    'store the size of the coverfile in the global var
    gbdbl_coverfilesize = proginfo.pointer - 1
    
    ReDim gbarrstr_filename(proginfo.no_of_archivefiles - 1)
    ReDim gbarrdbl_filesize(proginfo.no_of_archivefiles - 1)
   
   
    
    For i = 1 To proginfo.no_of_archivefiles
        
        elements = 3
        ReDim temparr(elements - 1) 'read the 3 byte filenamelength string
        Get #sourcefileno, bytepointer, temparr
        retval = objenc.encodearr(temparr, elements, gbstr_password)
        filenamelength = Val(arr2str(temparr, elements))
        bytepointer = bytepointer + elements
        
        'get the filename
        ReDim temparr(filenamelength - 1)
        Get #sourcefileno, bytepointer, temparr
        retval = objenc.encodearr(temparr, filenamelength, gbstr_password)
        filename = arr2str(temparr, filenamelength)
        bytepointer = bytepointer + filenamelength
        
        
        'get the filesizelength string
        elements = 2
        ReDim temparr(elements - 1) 'read the 2 byte filesizelength string
        Get #sourcefileno, bytepointer, temparr
        retval = objenc.encodearr(temparr, elements, gbstr_password)
        filesizelength = Val(arr2str(temparr, elements))
        bytepointer = bytepointer + elements
    
       'get the filesize
        ReDim temparr(filesizelength - 1)
        Get #sourcefileno, bytepointer, temparr
        retval = objenc.encodearr(temparr, filesizelength, gbstr_password)
        filesize = CDbl(arr2str(temparr, filesizelength))
        bytepointer = bytepointer + filesizelength

        'store the filename and filesize in the globalarrays
        gbarrstr_filename(i - 1) = filename
        gbarrdbl_filesize(i - 1) = filesize
        
        'display the files in the listview
        Call display_files_in_archive(filename, filesize, frmmain.lstfiles)
    
    Next
        


'store the memory location in the global varible 'gbdbl_compressedpointer'
'where the compressed data begins
gbdbl_compressedpointer = bytepointer

'initialise the gbbool_open_archive_state variable
gbbool_open_archive_state = True

Close sourcefileno

frmmain.tlbar.Buttons("show").Enabled = True
frmmain.mnuActionsShow.Enabled = True
openarchive = True
Exit Function

errhnd:
openarchive = False
End Function

Public Function arr2str(arr() As Byte, ByVal arrelements As Integer) As String

Dim i As Integer

For i = 0 To arrelements - 1
    arr2str = arr2str & Chr(arr(i))
Next


End Function

Public Function check_data_validity(temparr() As Byte) As Boolean
    
    Dim objdec As New clsencryption
    
    Call objdec.encodearr(temparr(), 4, gbstr_password)
    
    If Chr(temparr(0)) = "T" And Chr(temparr(1)) = "R" And Chr(temparr(2)) = "U" And Chr(temparr(3)) = "E" Then
        check_data_validity = True
    Else
        check_data_validity = False
    End If
    
End Function

Public Function decrypt_filedetails(ByVal elements As Double, ByVal pointer As Double, ByVal sourcefileno As Integer)

    Dim temparr() As Byte
    Dim objenc As New clsencryption
    Dim retval As Integer
    
    ReDim temparr(elements - 1)
        
    Get #sourcefileno, pointer, temparr
      
    retval = objenc.encodearr(temparr, elements, gbstr_password)
        
    Put #sourcefileno, pointer, temparr
        
End Function

Public Function validate_Outputdir(outputfolder As String) As Boolean
On Error GoTo errhnd:

    Dim tempfilename As String
    Dim tempfileno As Integer

   validate_Outputdir = True
    tempfilename = gettempfilename(outputfolder)
    tempfileno = FreeFile()
    Open tempfilename For Output As tempfileno
    Close
On Error Resume Next
    Kill (tempfilename)
    Exit Function
errhnd:
validate_Outputdir = False
End Function

Public Function dopurifyfile() As Boolean
    
On Error GoTo errhnd:
    
    Dim tempfileno As Integer
    Dim arrsize As Double
    Dim temparr() As Byte
    
    dopurifyfile = True
    
    If gbbool_purifyfile Then
        tempfileno = FreeFile(0)
        Open gbstr_openarchivename For Binary Access Read As tempfileno
        arrsize = gbdbl_coverfilesize
        ReDim temparr(arrsize - 1)
        Get #tempfileno, 1, temparr
        Close tempfileno
        Kill (gbstr_openarchivename)
        tempfileno = FreeFile(0)
        Open gbstr_openarchivename For Binary Access Write As tempfileno
        Put #tempfileno, 1, temparr
        Close tempfileno
    End If
    Exit Function
errhnd:
    dopurifyfile = False
End Function




Public Function display_files_in_archive(filename As String, filesize As Double, lstfiles As ListView)
    

    Dim strtempfile As String
    Dim fileno As Integer
    
    'add the filename in the listview
    filename = Trim(filename)
    
    lstfiles.ListItems.Add , , filename
    
    'create a tempfile for getting the fileinfo
    strtempfile = gettempfolderpath & filename
    
    fileno = FreeFile()
    
    Open strtempfile For Output As fileno
    
    Close fileno
    
    'show and assign the system imagelist
    objSystemImageList.ShowSysIL strtempfile, lstfiles.hwnd, lstfiles.view, lstfiles.ListItems.count
    
    objSystemImageList.AssignSysIL (lstfiles.hwnd)
    
    'get the fileinformation
    Call getfileinfo(strtempfile)
    
    'display the type of the file
    lstfiles.ListItems(lstfiles.ListItems.count).SubItems(1) = fileinfo.filetype
    
    'display the size of the file in the listview
    lstfiles.ListItems(lstfiles.ListItems.count).SubItems(2) = filesize

End Function


Public Function cleanup()
    'delete the compressed file
    
    On Error Resume Next
    
    Dim tempfolder As String
    Dim temp As String
    
    tempfolder = gettempfolderpath
    
    Close
    
    Kill (tempfolder & "*.*")
    
    RmDir (gettempfolderpath)
    
    If Command = "" Then
        Kill (tempfolder & "*.*")
        RmDir (gettempfolderpath)
    Else
        Kill (gbstr_helppath & "images\*.*")
        RmDir (gbstr_helppath & "images\")
        Kill (gbstr_helppath & "*.*")
        RmDir (gbstr_helppath)
        temp = Command
        temp = temp & " " & App.Path
        Call Shell(temp, vbHide)
    End If
    
End Function



Public Function ShowBrowsefolder(ByVal owner_hwnd As Long, ByVal titlestring As String, ByRef outputfolder As String) As Boolean
  

  Dim X As Long, bi As BROWSEINFO, dwIList As Long
  Dim szPath As String, wPos As Integer

    With bi
        .hOwner = owner_hwnd
        .lpszTitle = titlestring
        .ulFlags = BIF_RETURNONLYFSDIRS + BIF_NEWDIALOGSTYLE

    End With

    dwIList = SHBrowseForFolder(bi)
    szPath = Space$(512)
    X = SHGetPathFromIDList(ByVal dwIList, ByVal szPath)

    If X Then
        wPos = InStr(szPath, Chr(0))
        outputfolder = Left$(szPath, wPos - 1)
        ShowBrowsefolder = True
    Else
        outputfolder = ""
        ShowBrowsefolder = False
    End If
    
End Function

Public Function readsettings()

    Dim temp As Integer
    Dim tempstr As String
    
    Dim objreg As clsregistry
    Set objreg = New clsregistry
    
    INI_settings.Height = Val(objreg.readvalue("Height"))
    If INI_settings.Height <= 0 Then
     INI_settings.Height = 5430
    End If
    
    INI_settings.Width = Val(objreg.readvalue("Width"))
    If INI_settings.Width <= 0 Then
     INI_settings.Width = 9000
    End If
    
    INI_settings.X = Val(objreg.readvalue("X"))
    If INI_settings.X <= 0 Then
     INI_settings.X = Screen.Width / 2 - frmmain.Width / 2
    End If
    
    INI_settings.y = Val(objreg.readvalue("Y"))
    If INI_settings.y <= 0 Then
     INI_settings.y = Screen.Height / 2 - frmmain.Height / 2
    End If
    
    If objreg.readvalue("RemindPassword") = "0" Then
     INI_settings.RemindPassword = 0
    Else
     INI_settings.RemindPassword = 1
    End If
    
    If objreg.readvalue("ShowTipofDay") = "0" Then
        INI_settings.ShowTipofDay = 0
    Else
        INI_settings.ShowTipofDay = 1
    End If
    
    INI_settings.Tipno = Val(objreg.readvalue("Tipno"))
    If INI_settings.Tipno = 0 Then
         INI_settings.Tipno = 1
    End If
    
    If Val(objreg.readvalue("ShowPasswordboxonHide")) = 1 Then
        INI_settings.showPasswordboxonHide = 1
    Else
         INI_settings.showPasswordboxonHide = 0
    End If
    
    If Val(objreg.readvalue("showextractboxonopen")) = 1 Then
        INI_settings.showextractboxonopen = 1
    Else
        INI_settings.showextractboxonopen = 0
    End If
    
    Set objreg = Nothing

End Function


Public Function writeinisettings()

'write the info into the registry
Dim objreg As clsregistry
Set objreg = New clsregistry

Call objreg.writevalue("Height", CStr(INI_settings.Height))
Call objreg.writevalue("Width", CStr(INI_settings.Width))
Call objreg.writevalue("X", CStr(INI_settings.X))
Call objreg.writevalue("Y", CStr(INI_settings.y))
Call objreg.writevalue("RemindPassword", CStr(INI_settings.RemindPassword))
Call objreg.writevalue("ShowTipofDay", CStr(INI_settings.ShowTipofDay))
Call objreg.writevalue("Tipno", CStr(INI_settings.Tipno))
Call objreg.writevalue("ShowPasswordboxonHide", CStr(INI_settings.showPasswordboxonHide))
Call objreg.writevalue("Showextractboxonopen", CStr(INI_settings.showextractboxonopen))

Set objreg = Nothing

End Function


Public Function gettitlebarlength(form_hwnd As Long) As Integer
    
    'Initialize structure
    TitleInfo.cbSize = Len(TitleInfo)
    'Retrieve information about the title bar of this window
    GetTitleBarInfo form_hwnd, TitleInfo
    'return the titlebar length
    gettitlebarlength = TitleInfo.rcTitleBar.Bottom - TitleInfo.rcTitleBar.Top

End Function

Public Function restore_backuped_file()
On Error GoTo errhnd:
    
    Dim backupfileno As Integer
    Close
    If gbstr_backupresultfilename = "" Then
        If gbstr_resultfilename <> "" Then
            Kill (gbstr_resultfilename)
        End If
    Else
        Call CopyFile(gbstr_backupresultfilename, gbstr_resultfilename, 0)
    End If
errhnd:
End Function

Public Function openurl(hwnd As Long, url As String)
On Error GoTo errhnd:
   ShellExecute hwnd, "open", url, vbNullString, "vbNullString", SW_SHOWNORMAL
errhnd:
End Function

Public Function create_dynamic_help(hwnd As Long, pagelink As String)
On Error GoTo errhnd:
    
    Dim tempfileno As Integer
    Dim strtemp As String
    Dim strhtml As String
    Dim position As Integer
    Dim temparr() As Byte
    Dim temp As String
    Dim temphtmlfilename As String
    
    tempfileno = FreeFile()
    Open gbstr_helppath & "indextemplate.htm" For Binary Access Read As #tempfileno
    ReDim temparr(LOF(tempfileno) - 1)
    Get #tempfileno, 1, temparr
    strhtml = arr2str(temparr, LOF(tempfileno) - 1)
    Close tempfileno
    
    temphtmlfilename = gettempfilename(gettempfolderpath, "htm")
    tempfileno = FreeFile()
    Open temphtmlfilename For Output As #tempfileno
    
    position = InStr(1, strhtml, "<%USERDEFINED%>", vbBinaryCompare)
    temp = gbstr_helppath & "contents.htm"
    strtemp = Left(strhtml, position - 1) & temp & Mid(strhtml, (position + Len("<%USERDEFINED%>")))
   
    position = InStr(1, strtemp, "<%USERDEFINED%>", vbBinaryCompare)
    temp = gbstr_helppath & pagelink
    strtemp = Left(strtemp, position - 1) & temp & Mid(strtemp, (position + Len("<%USERDEFINED%>")))
    
    Print #tempfileno, strtemp
    
    Close tempfileno
    
    Call openurl(hwnd, temphtmlfilename)
    Exit Function
    
errhnd:
    
    
End Function


Public Function get_prog_tempfolderpath(ByVal startname As String) As String

Dim temp As String
Dim counter As Integer
Static again As Boolean
Static prog_tempfolderpath As String

 If Not again Or Not gbbool_again Then
 
    If Command = "" Then
        temp = gettempfolderpath(True) & startname
    Else
        temp = App.Path & "\" & startname
    End If
    
    While CBool(PathIsDirectory(temp & counter))
        counter = counter + 1
    Wend
    
    MkDir (temp & counter)
    
    again = True
    gbbool_again = True
        
    prog_tempfolderpath = temp & counter & "\"
   
   End If
   
   get_prog_tempfolderpath = prog_tempfolderpath

End Function



