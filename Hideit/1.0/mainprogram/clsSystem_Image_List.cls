VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsSystem_Image_List"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

'=== API declarations ===========================================================
'==== general =================
Private Const MAX_PATH = 260&
Private Const GWL_STYLE = (-16)
Private Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long) As Long
Private Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Long, ByVal nIndex As Long, ByVal dwNewLong As Long) As Long
Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Long, ByVal wMsg As Long, ByVal wParam As Long, lParam As Any) As Long

'==== ShGetFileInfo ======
Private Type SHFILEINFO
        hIcon As Long 'out: icon
        iIcon As Long 'out: icon index
        dwAttributes As Long 'out: SFGAO_ flags
        szDisplayName As String * MAX_PATH 'out: display name (or path)
        szTypeName As String * 80 'out: type name
End Type


Private Declare Function SHGetFileInfo Lib "shell32.dll" Alias "SHGetFileInfoA" (ByVal pszPath As String, ByVal dwFileAttributes As Long, psfi As SHFILEINFO, ByVal cbFileInfo As Long, ByVal uFlags As Long) As Long

'==== imagelist ============
Private Declare Function ImageList_GetImageCount Lib "comctl32.dll" (ByVal himl As Long) As Long

'==== listview ==============================================
Private Const LVS_SHAREIMAGELISTS = &H40& 'don't destroy assigned ILs
Private Const LVM_FIRST = &H1000&
Private Const LVM_SETIMAGELIST = (LVM_FIRST + 3)
Private Const LVM_SETITEM = (LVM_FIRST + 6)
Private Const LVSIL_NORMAL = 0&
Private Const LVSIL_SMALL = 1&
Private Const LVIF_IMAGE = 2&

Private Type LV_ITEM
    mask As Long
    iItem As Long
    iSubItem As Long
    State As Long
    stateMask As Long
    pszText As String
    cchTextMax As Long
    iImage As Long
    lParam As Long '(~ ItemData)
'#if (_WIN32_IE >= 0x0300)
    iIndent As Long
'#End If
End Type

Private Const SHGFI_ICON = &H100                         '  get icon
Private Const SHGFI_DISPLAYNAME = &H200                  '  get display name
Private Const SHGFI_TYPENAME = &H400                     '  get type name
Private Const SHGFI_ATTRIBUTES = &H800                   '  get attributes
Private Const SHGFI_ICONLOCATION = &H1000                '  get icon location
Private Const SHGFI_EXETYPE = &H2000                     '  return exe type
Private Const SHGFI_LINKOVERLAY = &H8000                 '  put a link overlay on icon
Private Const SHGFI_SELECTED = &H10000                   '  show icon in selected state
Private Const SHGFI_SYSICONINDEX = &H4000 'get system icon index
Private Const SHGFI_LARGEICON = 0& 'get large icon
Private Const SHGFI_SMALLICON = 1& 'get small icon
Private Const SHGFI_OPENICON = &H2                       '  get open icon
Private Const SHGFI_SHELLICONSIZE = &H4                  '  get shell size icon
Private Const SHGFI_PIDL = &H8                           '  pszPath is a pidl
Private Const SHGFI_USEFILEATTRIBUTES = &H10             '  use passed dwFileAttribute

'==== module vars =============================================================
'system imagelist handles...
Dim m_hImgListLarge As Long, m_hImgListSmall As Long

'Assigns the system Imagelist to the Listview
Public Function AssignSysIL(lstview_hwnd As Long)
    
    'Retieve handles to system imagelists and assign them to listview.
    
    Dim SFI As SHFILEINFO
    
    'Get handles to system image lists.
    'They may change, especially if the user changes display settings.
    'Safest to obtain them each time...
    
    m_hImgListLarge = SHGetFileInfo(App.Path, 0&, SFI, Len(SFI), SHGFI_SYSICONINDEX Or SHGFI_LARGEICON)
    
    m_hImgListSmall = SHGetFileInfo(App.Path, 0&, SFI, Len(SFI), SHGFI_SYSICONINDEX Or SHGFI_SMALLICON)
    
    'assign image lists to listview via API...
    
    SendMessage lstview_hwnd, LVM_SETIMAGELIST, LVSIL_NORMAL, ByVal m_hImgListLarge
    
    SendMessage lstview_hwnd, LVM_SETIMAGELIST, LVSIL_SMALL, ByVal m_hImgListSmall

End Function


'displays the icon in the listview
'takes in the actual file path
'the hwnd of the listview
'and the itemno whose icon has to be shown

Public Sub ShowSysIL(strpath As String, lstview_hwnd As Long, view As Integer, itemno As Integer)
    
    'Populate the listview with the contents of
    'large or small system imagelist.
    
    Dim L As Long, lNumImages As Long
    
    Dim LVI As LV_ITEM
    
    Dim SFI As SHFILEINFO
    
    Dim cbSFI As Long 'size of SFI
    
    Dim lFlags As Long 'ShFileInfo uFlags param
    
    Dim lStyle As Long
    
        
    'IMPORTANT - make sure listview can't destroy system imagelists.
    'The VB ocx ListView won't destroy the imagelist when terminating,
    'however the ComCtl32 ListView does by default.
    'Rather than take the chance that future VB versions will behave
    'the same...
    
    lStyle = GetWindowLong(lstview_hwnd, GWL_STYLE)
    
    SetWindowLong lstview_hwnd, GWL_STYLE, lStyle Or LVS_SHAREIMAGELISTS

    AssignSysIL lstview_hwnd
    
    DoEvents
    
    cbSFI = Len(SFI)
    
    'Set ShFileInfo uFlags parameter (determines what info to retrieve)...
    
    lFlags = SHGFI_DISPLAYNAME Or SHGFI_SYSICONINDEX Or SHGFI_TYPENAME
            
    If view = 0 Then
         lFlags = lFlags Or SHGFI_LARGEICON
    Else
         lFlags = lFlags Or SHGFI_SMALLICON
    End If
        
lFlags = lFlags Or SHGFI_LINKOVERLAY
SHGetFileInfo strpath, 0&, SFI, cbSFI, lFlags

'Set the image for the item...

LVI.iItem = itemno - 1 'item index (-1 adjusts to 0-based api index)

LVI.iImage = SFI.iIcon 'index in system imagelist

LVI.mask = LVIF_IMAGE 'just setting image index

'assign item's image index via api...

SendMessage lstview_hwnd, LVM_SETITEM, 0&, LVI
End Sub

