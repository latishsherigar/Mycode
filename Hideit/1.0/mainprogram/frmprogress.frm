VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "ComCtl32.ocx"
Begin VB.Form frmprogress 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   1320
   ClientLeft      =   45
   ClientTop       =   540
   ClientWidth     =   4425
   Icon            =   "frmprogress.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1320
   ScaleWidth      =   4425
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.Frame frameerrdetails 
      Caption         =   "Error Details"
      Height          =   1335
      Left            =   120
      TabIndex        =   4
      Top             =   1320
      Width           =   4095
      Begin VB.Label lbldescription 
         Caption         =   "error description"
         Height          =   495
         Left            =   1080
         TabIndex        =   8
         Top             =   600
         Width           =   2655
      End
      Begin VB.Label lblerrno 
         AutoSize        =   -1  'True
         Caption         =   "error no"
         Height          =   195
         Left            =   480
         TabIndex        =   7
         Top             =   360
         Width           =   540
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Description :"
         Height          =   195
         Left            =   120
         TabIndex        =   6
         Top             =   600
         Width           =   885
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "No :"
         Height          =   195
         Left            =   120
         TabIndex        =   5
         Top             =   360
         Width           =   300
      End
   End
   Begin VB.CommandButton cmderrdetails 
      Caption         =   "Details..."
      Height          =   375
      Left            =   3120
      TabIndex        =   3
      Top             =   840
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.CommandButton cmdbutton 
      Caption         =   "Command1"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   1605
      TabIndex        =   1
      Top             =   840
      Width           =   1215
   End
   Begin VB.Timer tmrautoload 
      Interval        =   10
      Left            =   1200
      Top             =   0
   End
   Begin ComctlLib.ProgressBar pgbar 
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   4215
      _ExtentX        =   7435
      _ExtentY        =   450
      _Version        =   327682
      Appearance      =   1
   End
   Begin VB.Label lblinfo 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   555
   End
End
Attribute VB_Name = "frmprogress"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private WithEvents objtransform As clsencryption
Attribute objtransform.VB_VarHelpID = -1
Private WithEvents objcompress As clscompression
Attribute objcompress.VB_VarHelpID = -1

Private Enum enum_operation
    COMPRESSION = 1
    DECOMPRESSION = 1
    PROCESSING = 2
End Enum
 
Private m_operation As enum_operation
Dim m_cancel As Boolean

Private Sub cmdbutton_Click()
On Error Resume Next
If cmdbutton.Caption = "Cancel" Then
   m_cancel = True
    Select Case m_operation
        Case 1: objcompress.cancel_operation = True
        Case 2: m_cancel = True
    End Select
    
    'restore the backed up file if user has clicked cancel
    Call restore_backuped_file

Else
    Unload Me
End If
End Sub

Private Sub cmderrdetails_Click()
    
    Static detailsseen As Boolean
    Static actualheight As Integer
    
    If Not detailsseen Then
        detailsseen = True
        actualheight = Me.Height
        Me.Height = Me.Height + frameerrdetails.Height + 200
    Else
        detailsseen = False
        Me.Height = actualheight
    End If

End Sub

Private Sub Form_Load()
On Error Resume Next
    Set objtransform = New clsencryption
    Set objcompress = New clscompression
    Me.Left = frmmain.Width / 2 - Me.Width / 2
    Me.Top = frmmain.Height / 2 - Me.Height / 2
    tmrautoload.Interval = 10
    tmrautoload.Enabled = True
    lblinfo.Caption = "Press 'Cancel' to stop."
    cmdbutton.Caption = "Cancel"
    cmderrdetails.Visible = False
End Sub

Private Sub Form_Unload(cancel As Integer)
On Error Resume Next
    Set objcompress = Nothing
    Set objtransform = Nothing
End Sub

Private Sub objcompress_progress(ByVal progress As Integer)
    On Error Resume Next
    pgbar.value = progress
    
    If gbint_operation_status = 0 Then
        Me.Caption = "Compressing files -- " & progress & " % completed"
    Else
        Me.Caption = "Decompressing files -- " & progress & " % completed"
    End If
    
    Me.Refresh
    DoEvents
End Sub


Private Sub tmrautoload_Timer()
On Error GoTo errhnd:
Dim retval As Integer

tmrautoload.Enabled = False

'0 --- hide
'1 --- show

If gbint_operation_status = 0 Then

    retval = hidearchive
    

    Select Case retval
        
        Case 0:
        pgbar.value = 0
        Me.Caption = "Operation Unsuccessful"
        lblinfo.Caption = "Sorry!!! an error occured."
        cmdbutton.Caption = "Close"

        
        Case 1:
        pgbar.value = 100
        Me.Caption = "Operation Successful"
        lblinfo.Caption = "Congrats!!! the archive was saved successfully"
        cmdbutton.Caption = "Close"
        
        Case Else:
        Unload Me
        
    
    End Select
    
Else
        retval = extractarchive
    
    Select Case retval
        Case 0:
            pgbar.value = 0
            Me.Caption = "Operation Unsuccessful"
            lblinfo.Caption = "Sorry!!! an error occured."
            cmdbutton.Caption = "Close"

        
        Case 1:
            pgbar.value = 100
            Me.Caption = "Operation Successful"
            lblinfo.Caption = "Congrats!!! All files were extracted successfully"
            cmdbutton.Caption = "Close"
    
        Case Else:
            
            Unload Me
    
    End Select

End If


'cleanup the mess
Call cleanup
Call initialise
    
Exit Sub
errhnd:
        pgbar.value = 0
        Me.Caption = "Operation Unsuccessful"
        lblinfo.Caption = "Sorry!!! an error occured."
        cmdbutton.Caption = "Close"
        cmderrdetails.Visible = True
        lblerrno.Caption = Err.Number
        lbldescription.Caption = Err.Description

End Sub




'Function to hide the archive

Public Function hidearchive() As Integer

    Dim compressed_filename As String
    Dim items As Integer
    Dim retval As Integer
    Dim resultfileno As Integer
    Dim coverfileno As Integer
    Dim tempcompressedfileno As Integer
    Dim bytepointer As Double
    Dim startlocation As Double
    Dim temparr() As Byte
    Dim fnamearr() As String
  
    

    hidearchive = 0
    
    'function to check if password box needs to be shown
   If check_whether_to_show_password_box = False Then
        Exit Function
   End If
    
    'get the compressed filename
    compressed_filename = get_compressed_filename()

    'add the files in the listview and store it in the fnamearr array
    items = store_files_2_array(fnamearr, frmmain.lstfiles)

    'compress the files
    m_operation = COMPRESSION
    hidearchive = objcompress.compress(fnamearr(), items, compressed_filename)
    
    If hidearchive <> 1 Then
        Exit Function
    End If
    
    'the function is passed a '1' value to overwrite the exisitng file
    retval = CopyFile(gbstr_coverfilename, gbstr_resultfilename, 1)
   
    resultfileno = FreeFile()
    Open gbstr_resultfilename For Binary Access Read Write As #resultfileno
   
    bytepointer = FileLen(gbstr_resultfilename) + 1
   
   'store the start location in the variable
    startlocation = bytepointer
    
    'Encode the data validity flag
    'it changes bytepointer
    Call encode_data_validity_flag(resultfileno, bytepointer)

    'write the filedetails(name,size) into the file
    'it changes bytepointer
    Call write_filedetails_in_resultfile(resultfileno, frmmain.lstfiles, bytepointer)
    
    m_operation = PROCESSING
    'read the compressed file ,encrypt the file and write contents
    'it changes bytepointer
   hidearchive = write_comp_file_contents_in_resultfile(compressed_filename, resultfileno, bytepointer)
    
    If hidearchive <> 1 Then
        Exit Function
    End If
    
    'store data in the proginfo structure
    'it changes bytepointer
    Call write_proginfo_details(startlocation, resultfileno, frmmain.lstfiles, bytepointer, compressed_filename)
    
    Close #resultfileno
    
    'cleanup the mess
    Call cleanup
    
    'initialse all the cleanuped mess
    Call initialise
    
End Function


Public Function extractarchive() As Integer
    
    Dim temparr() As Byte
    Dim sourcefileno As Integer
    Dim compressedfilename As String
    Dim compressedfileno As Integer
    
    
    extractarchive = 0
    'validate theoutput dir
    If Not validate_Outputdir(gbstr_extractoutputdir) Then
        MsgBox "Cannot extract the archive in the Output Folder You have specified.Please try another folder", vbCritical, "Folder write Error"
        Exit Function
    End If

    
    'if it is encrypted form show the password dialog
    If gbbool_encrypted And gbstr_password = "" Then
         frmpasswordopen.Show (1)
    End If
   

    'if encrypted and password is blank
    If gbbool_encrypted And gbstr_password = "" Then
        Exit Function
    Else
        ReDim temparr(3)
        'open the source file for reading
        sourcefileno = FreeFile(0)
        Open gbstr_openarchivename For Binary Access Read As #sourcefileno

        Get #sourcefileno, proginfo.pointer, temparr
        If Not check_data_validity(temparr) Then
            Exit Function
        End If
    End If
        
    'get compressed filename
    compressedfilename = get_compressed_filename()
    
    'process the decrypted file
    m_operation = PROCESSING
    extractarchive = read_and_decryptfile(compressedfilename)
      
    If extractarchive <> 1 Then
        Exit Function
    End If
    
    'expand the file
    m_operation = DECOMPRESSION
    extractarchive = objcompress.decompress(compressedfilename, gbstr_extractoutputdir, proginfo.no_of_archivefiles, gbarrstr_filename(), gbarrdbl_filesize())
                
    If extractarchive <> 1 Then
        Exit Function
    End If
    
    Close
    Call dopurifyfile
    Call cleanup
    Call initialise
End Function

Public Function read_and_decryptfile(compressedfilename As String) As Integer
    
    Dim sourcefileno As Integer
    Dim chunks As Single
    Dim chunksize As Double
    Dim residue_chunk_size As Integer
    Dim sourcefilesize As Double
    Dim temparr() As Byte
    Dim compressedfileno As Integer
    Dim targetpointer As Double
    Dim progresspercent As Integer
    Dim oldprogress As Integer
    Dim j As Single
    Dim retval As Integer
    

    targetpointer = 1
    read_and_decryptfile = 0
    
    'open the source file for reading
    sourcefileno = FreeFile(0)
    Open gbstr_openarchivename For Binary Access Read As #sourcefileno
      
    'creates a new compressedfile in the users temp directory
    compressedfileno = FreeFile
    Open compressedfilename For Binary Access Write As compressedfileno
    
    'gbdbl_compressedfilesize  is the global variable which has the
    'size of the compressed file,the value is stored in the open Archive routine
        sourcefilesize = gbdbl_compressedfilesize
        chunksize = 1024
        chunks = sourcefilesize \ chunksize
        residue_chunk_size = sourcefilesize Mod chunksize
        
        If residue_chunk_size <> 0 Then
            chunks = chunks + 1
        End If
        
        For j = 1 To chunks
            
            If Not m_cancel Then
                
                If j = chunks And residue_chunk_size <> 0 Then
                    chunksize = residue_chunk_size
                End If
 
               ReDim temparr(chunksize - 1)
            
               'read the compressed file from the sourcefile
               'the memory pointer was stored in the gbdbl_compressedpointer global variable
               'which was stored in the open archive function
                
                'Debug.Print gbdbl_compressedpointer
                Get #sourcefileno, gbdbl_compressedpointer, temparr
                
                gbdbl_compressedpointer = gbdbl_compressedpointer + chunksize
                
                'decrypt the data
                retval = objtransform.encodearr(temparr, chunksize, gbstr_password)
                
                Put #compressedfileno, targetpointer, temparr
                
                targetpointer = targetpointer + chunksize
                
               
                progresspercent = (100 * targetpointer) / sourcefilesize
                If oldprogress <> progresspercent Then
                    oldprogress = progresspercent
                    pgbar.value = progresspercent
                    Me.Caption = "Processing Compressed file -- " & progresspercent & " % completed"
                End If
                    
                'pass the control to windows
                DoEvents
            
             Else
                read_and_decryptfile = 2
                Close #sourcefileno
                Close #compressedfileno
                Exit Function
                
             End If
    
        Next
    
    read_and_decryptfile = 1
    Close #sourcefileno
    Close #compressedfileno
End Function

Public Function write_comp_file_contents_in_resultfile(ByVal compressed_filename As String, ByVal resultfileno As Integer, ByRef bytepointer As Double) As Integer
    
    Dim chunks As Single
    Dim chunksize As Double
    Dim totalchunksize As Double
    Dim compfilesize As Double
    Dim residue_chunk_size As Integer
    Dim j As Single
    Dim progresspercent As Integer
    Dim compressedfileno As Integer
    Dim oldprogress As Integer
    Dim temparr() As Byte
    Dim retval As Integer
    Dim sourcepointer As Double
   
  
    sourcepointer = 1
    write_comp_file_contents_in_resultfile = 0
    'read the compressed file and write the contents into the new file
    compressedfileno = FreeFile(0)

    Open compressed_filename For Binary Access Read As #compressedfileno
    compfilesize = LOF(compressedfileno)
    chunksize = 1024
    chunks = Fix(compfilesize / chunksize)
    residue_chunk_size = compfilesize Mod chunksize
    
    If residue_chunk_size <> 0 Then
         chunks = chunks + 1
    End If
    
    For j = 1 To chunks
    
        If Not m_cancel Then
            If j = chunks And residue_chunk_size <> 0 Then
                  chunksize = residue_chunk_size
            End If
            
            ReDim temparr(chunksize - 1)
            
            Get #compressedfileno, sourcepointer, temparr
              
            sourcepointer = sourcepointer + chunksize
            
            'encrypt the file contents
            retval = objtransform.encodearr(temparr, chunksize, gbstr_password)
            
            Put #resultfileno, bytepointer, temparr
            
            bytepointer = bytepointer + chunksize
                    
            totalchunksize = totalchunksize + chunksize
            
            'raise the progress event
            progresspercent = (100 * totalchunksize) / compfilesize
            If oldprogress <> progresspercent Then
                oldprogress = progresspercent
                frmprogress.pgbar.value = progresspercent
                frmprogress.Caption = "Processing Compressed file --" & progresspercent & " % Completed"
            End If
            
            DoEvents
        Else
            write_comp_file_contents_in_resultfile = 2
            Close #compressedfileno
            Exit Function
        End If
    Next
    
write_comp_file_contents_in_resultfile = 1
Close #compressedfileno

End Function
