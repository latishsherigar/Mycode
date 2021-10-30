Attribute VB_Name = "declarations"
Option Explicit

'---------------------------------------------------------------------------------------------------------------------------------------------------------
Public Declare Function GetFileTitle Lib "comdlg32.dll" Alias "GetFileTitleA" (ByVal lpszFile As String, ByVal lpszTitle As String, ByVal cbBuf As Integer) As Integer
Public Declare Function SHGetFileInfo Lib "shell32.dll" Alias "SHGetFileInfoA" (ByVal pszPath As String, ByVal dwFileAttributes As Long, psfi As SHFILEINFO, ByVal cbFileInfo As Long, ByVal uFlags As Long) As Long
Public Declare Function GetFileType Lib "kernel32" (ByVal hFile As Long) As Long
Public Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Public Declare Function ShellExecuteEx Lib "shell32.dll" (SEI As SHELLEXECUTEINFO) As Long
Public Declare Function InitCommonControls Lib "comctl32.dll" () As Long
Public Declare Function PathFileExists Lib "shlwapi.dll" Alias "PathFileExistsA" (ByVal pszPath As String) As Long
Public Declare Function PathIsDirectory Lib "shlwapi.dll" Alias "PathIsDirectoryA" (ByVal pszPath As String) As Long
Public Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
Public Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long
Public Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Long, ByVal hWnd2 As Long, ByVal lpsz1 As String, ByVal lpsz2 As String) As Long
Public Declare Function CopyFile Lib "kernel32" Alias "CopyFileA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String, ByVal bFailIfExists As Long) As Long
Public Declare Function GetAllUsersProfileDirectory Lib "userenv.dll" Alias "GetAllUsersProfileDirectoryA" (ByVal lpProfileDir As String, lpcchSize As Long) As Boolean
Public Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal y As Long) As Long

'Browse folder dialogbox
Public Declare Function SHBrowseForFolder Lib "shell32.dll" Alias "SHBrowseForFolderA" (lpBrowseInfo As BROWSEINFO) As Long
Public Declare Function SHGetPathFromIDList Lib "shell32" (ByVal pidList As Long, ByVal lpBuffer As String) As Long

'INI files
Public Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Long, ByVal lpFileName As String) As Long
Public Declare Function WritePrivateProfileString Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As Any, ByVal lpString As Any, ByVal lpFileName As String) As Long

'Titlebar info
Public Declare Function GetTitleBarInfo Lib "user32.dll" (ByVal hwnd As Long, ByRef pti As TITLEBARINFO) As Long



'-----------------------------------------------------------------------------------------------------------------------
'Constants

'Listview constants
Public Const SHGFI_DISPLAYNAME = &H200
Public Const SHGFI_TYPENAME = &H400
Public Const SW_SHOWNORMAL = 1
Public Const MAX_PATH = 260&
Public Const BIF_RETURNONLYFSDIRS = &H1
Public Const BIF_NEWDIALOGSTYLE = &H40


'Toolbar constants
Public Const WM_USER = &H400
Public Const TBSTYLE_FLAT As Long = &H800
Public Const TB_SETSTYLE = WM_USER + 56
Public Const TB_GETSTYLE = WM_USER + 57
Public Const TB_SETIMAGELIST = WM_USER + 48
Public Const TB_SETHOTIMAGELIST = WM_USER + 52
Public Const TB_SETDISABLEDIMAGELIST = WM_USER + 54


'Showfileproperties function
Public Const SEE_MASK_INVOKEIDLIST = &HC
Public Const SEE_MASK_NOCLOSEPROCESS = &H40
Public Const SEE_MASK_FLAG_NO_UI = &H400


'Titlebar information
Public Const STATE_SYSTEM_FOCUSABLE = &H100000
Public Const STATE_SYSTEM_INVISIBLE = &H8000
Public Const STATE_SYSTEM_OFFSCREEN = &H10000
Public Const STATE_SYSTEM_UNAVAILABLE = &H1
Public Const STATE_SYSTEM_PRESSED = &H8
Public Const CCHILDREN_TITLEBAR = 5




'----------------------------------------------------------
'Structures

'File properties
Public Type SHFILEINFO
    hIcon As Long                      '  out: icon
    iIcon As Long          '  out: icon index
    dwAttributes As Long               '  out: SFGAO_ flags
    szDisplayName As String * MAX_PATH '  out: display name (or path)
    szTypeName As String * 80         '  out: type name
End Type

'Browse folder
Public Type BROWSEINFO
  hOwner As Long
  pidlRoot As Long
  pszDisplayName As String
  lpszTitle As String
  ulFlags As Long
  lpfn As Long
  lParam As Long
  iImage As Long
End Type


Public Type SHELLEXECUTEINFO
    cbSize As Long
    fMask As Long
    hwnd As Long
    lpVerb As String
    lpFile As String
    lpParameters As String
    lpDirectory As String
    nShow As Long
    hInstApp As Long
    lpIDList As Long
    lpClass As String
    hkeyClass As Long
    dwHotKey As Long
    hIcon As Long
    hProcess As Long
End Type

'titlebarinfo
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type

Private Type TITLEBARINFO
    cbSize As Long
    rcTitleBar As RECT
    rgstate(CCHILDREN_TITLEBAR) As Long
End Type

Public TitleInfo As TITLEBARINFO




'------------------------------------------------------------------------------------------

'this structure is only used during the program execution for the
'listview and is not used any where

Type fileinfostruct
    filename As String
    filetype As String
    filesize As String
    filepath As String
End Type

'program info structure
Type proginfostruct
    progname As String * 7
    minversion_required As Integer
    Encrypted As Boolean
    invisiblemode As String * 1
    no_of_archivefiles As Integer
    compressedfilesize As Double
    pointer As Double
End Type


'INI file structure.
Public Type INI_settings_struct
    Height As Integer
    Width As Integer
    X As Integer
    y As Integer
    RemindPassword As Integer
    ShowTipofDay As Integer
    Tipno As Integer
    showPasswordboxonHide As Integer
    showextractboxonopen As Integer
    'closeautomatically As Integer
End Type


Public INI_settings As INI_settings_struct
Public proginfo As proginfostruct
Public fileinfo As fileinfostruct
Public objSystemImageList As New clsSystem_Image_List

'Global variables which store the names of coverfilename
'and resultant filename
Public gbstr_coverfilename As String
Public gbstr_resultfilename As String
Public gbstr_backupresultfilename As String
Public gbstr_openarchivename As String
Public gbstr_extractoutputdir As String
Public gbstr_password As String
Public gbstr_helppath As String

Public gbbool_purifyfile As Boolean
Public gbbool_new_archive_state As Boolean
Public gbbool_open_archive_state As Boolean
Public gbbool_encrypted As Boolean
Public gbbool_data_verification_flag As Boolean
Public gbbool_again As Boolean

Public gbdbl_compressedfilesize As Double
Public gbdbl_compressedpointer As Double
Public gbdbl_coverfilesize As Double

Public gbint_invisiblemodeclicked As Integer
Public gbint_errorno As Integer
Public gbint_errormessage As String
Public gbint_password_status As Integer
Public gbint_operation_status As Integer

Public gbarrstr_filename() As String
Public gbarrdbl_filesize() As Double

