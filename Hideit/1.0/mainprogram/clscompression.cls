VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clscompression"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'To fire this event, use RaiseEvent with the following syntax:
'RaiseEvent progress[(arg1, arg2, ... , argn)]
Public Event progress(ByVal progress As Integer)

Dim m_compressedfilepath As String
Dim m_compressedfileno As Integer
Dim m_cancel_operation As Boolean
Dim m_fnamearr() As String
Dim m_fno() As Integer
Dim m_files As Integer
Dim m_opstatus As Integer

'exit constants
Private Const OK As Integer = 1
Private Const ERROR As Integer = 0
Private Const cancel As Integer = 2





Public Property Let cancel_operation(cancel As Boolean)
    m_cancel_operation = cancel
End Property

Private Function canceloperation()
Dim i As Integer

    If m_opstatus = 0 Then
       'close and delete the work file
        Close #m_compressedfileno
        kill (m_compressedfilepath)
        For i = 0 To m_files - 1
            Close #m_fno(i)
        Next
    Else
        Close #m_compressedfileno
        For i = 0 To m_files - 1
            Close #m_fno(i)
            kill (m_fnamearr(i))
        Next
    End If
End Function


Public Function compress(filenamearr() As String, ByVal files As Integer, ByVal compressedfilepath As String) As Integer
    Dim sourcefileno As Integer, compfileno As Integer
    Dim i As Integer
    Dim temparr() As Byte
    Dim targetpointer As Double
    Dim sourcepointer As Double
    Dim sourcefilesize As Double
    Dim chunksize As Single
    Dim chunks As Single, j As Single
    Dim residue_chunk_size As Integer
    Dim progresspercent As Integer
    Static oldprogress As Integer
    Dim totalfilessize As Double
    
   ' On Error GoTo errhnd:

    m_opstatus = 0
    compress = ERROR
    totalfilessize = findTotalfilesize(filenamearr, files)
    
    compfileno = FreeFile()
    m_compressedfileno = compfileno
    m_compressedfilepath = compressedfilepath
    
     Open compressedfilepath For Binary Access Write As #compfileno
     targetpointer = 1

    For i = 0 To files - 1
        
        sourcepointer = 1
        m_files = i + 1
        ReDim Preserve m_fnamearr(i)
        ReDim Preserve m_fno(i)
        
        m_fnamearr(i) = filenamearr(i)
        sourcefileno = FreeFile(0)
        m_fno(i) = sourcefileno
        Open filenamearr(i) For Binary Access Read As #sourcefileno
        
        sourcefilesize = LOF(sourcefileno)
        chunksize = 1024
        chunks = Fix(sourcefilesize / chunksize)
        residue_chunk_size = sourcefilesize Mod chunksize
        
        'if any extra residue is present increment chunks
        If residue_chunk_size <> 0 Then
            chunks = chunks + 1
        End If
        
        
        For j = 1 To chunks
           If Not m_cancel_operation Then
               If j = chunks And residue_chunk_size <> 0 Then
                      chunksize = residue_chunk_size
                End If
                
                ReDim temparr(chunksize - 1)
                Get #sourcefileno, sourcepointer, temparr
                sourcepointer = sourcepointer + chunksize
                Put #compfileno, targetpointer, temparr
                targetpointer = targetpointer + chunksize
                            
                progresspercent = (100 * targetpointer) / totalfilessize
                If oldprogress <> progresspercent And progresspercent <= 100 Then
                    oldprogress = progresspercent
                    RaiseEvent progress(progresspercent)
                End If
                
                DoEvents
                
              Else
                'the user has cancelled the operation
                compress = cancel
                Call canceloperation
                Exit Function
              End If
       Next
        Close #sourcefileno
    Next
    
    Close #compfileno
    compress = OK
    Exit Function
    
errhnd:
    compress = ERROR
End Function



Public Function decompress(ByVal compressedfilename As String, outputdir As String, ByVal files As Integer, fnamearr() As String, fsizearr() As Double) As Integer

    Dim i As Integer
    Dim compfileno As Integer
    Dim targetfileno As Integer
    Dim sourcepointer As Double
    Dim temparr() As Byte
    Dim targetfilesize As Double
    Dim targetpointer As Double
    Dim progresspercent As Integer
    Dim compressedfilesize As Double
    Static oldprogress As Integer
    Dim chunks As Single
    Dim chunksize  As Single
    Dim residue_chunk_size As Integer
    Dim j As Single
    
    m_opstatus = 1
    'On Error GoTo errhnd:
    decompress = ERROR
    compfileno = FreeFile()
    m_compressedfileno = compfileno
    Open compressedfilename For Binary Access Read As #compfileno
    compressedfilesize = LOF(compfileno)
    sourcepointer = 1
    
    For i = 0 To files - 1
        
        ReDim Preserve m_fnamearr(i)
        ReDim Preserve m_fno(i)
        
        m_files = i + 1
        
        targetpointer = 1
        
        m_fnamearr(i) = outputdir & "\" & fnamearr(i)
        
        targetfileno = FreeFile()
        
        m_fno(i) = targetfileno
        
        Open m_fnamearr(i) For Binary Access Write As #targetfileno
        
        targetfilesize = fsizearr(i)
        
        chunksize = 1024
        
        chunks = targetfilesize \ chunksize
        
        residue_chunk_size = targetfilesize Mod chunksize
        
        If residue_chunk_size <> 0 Then
            
            chunks = chunks + 1
        
        End If
        
        For j = 1 To chunks
            
            If Not m_cancel_operation Then
                
                If j = chunks And residue_chunk_size <> 0 Then
                   chunksize = residue_chunk_size
                End If

                ReDim temparr(chunksize - 1)
                
                Get #compfileno, sourcepointer, temparr
                
                sourcepointer = sourcepointer + chunksize
                
                Put #targetfileno, targetpointer, temparr
                
                targetpointer = targetpointer + chunksize
                
                
                'raise the progress event
                progresspercent = (100 * sourcepointer) / compressedfilesize
                
                If oldprogress <> progresspercent Then
                    
                    oldprogress = progresspercent
                    
                    RaiseEvent progress(progresspercent)
                
                End If
                
                DoEvents
            
            Else
               'the user has cancelled the operation
                decompress = cancel
                Call canceloperation
                Exit Function
            
            End If
        
        Next
        
        Close #targetfileno
    
    Next
    
    Close #compfileno
    
    decompress = OK
    
    Exit Function
    
errhnd:
    decompress = ERROR
End Function

Private Function findTotalfilesize(fnamearr() As String, ByVal files As Integer) As Double
Dim i As Integer

For i = 0 To files - 1
    findTotalfilesize = findTotalfilesize + FileLen(fnamearr(i))
Next
End Function

