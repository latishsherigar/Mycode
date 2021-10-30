VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsCommonDialog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'const variables
Const m_defopendialogtitle = "Open"
Const m_defsavedialogtitle = "Save as"
Const m_defdialogfilter = "*.*"

'propertyvariables
Dim m_dialogtitle As String
Dim m_dialogfilter As String
Dim m_dialoginitdir As String
Dim m_dialogfiletitle As String
Dim m_dialogfilename As String
Dim m_dialoghwnd As Variant
Dim m_dialogflags As Variant
Dim m_dialogfoldername As String
Dim m_dialogcolor As Single

Const FW_NORMAL = 400
Const DEFAULT_CHARSET = 1
Const OUT_DEFAULT_PRECIS = 0
Const CLIP_DEFAULT_PRECIS = 0
Const DEFAULT_QUALITY = 0
Const DEFAULT_PITCH = 0
Const FF_ROMAN = 16
Const CF_PRINTERFONTS = &H2
Const CF_SCREENFONTS = &H1
Const CF_BOTH = (CF_SCREENFONTS Or CF_PRINTERFONTS)
Const CF_EFFECTS = &H100&
Const CF_FORCEFONTEXIST = &H10000
Const CF_INITTOLOGFONTSTRUCT = &H40&
Const CF_LIMITSIZE = &H2000&
Const REGULAR_FONTTYPE = &H400
Const LF_FACESIZE = 32
Const CCHDEVICENAME = 32
Const CCHFORMNAME = 32
Const GMEM_MOVEABLE = &H2
Const GMEM_ZEROINIT = &H40
Const DM_DUPLEX = &H1000&
Const DM_ORIENTATION = &H1&
Const PD_PRINTSETUP = &H40
Const PD_DISABLEPRINTTOFILE = &H80000

Const BIF_RETURNONLYFSDIRS = &H1

Private Type POINTAPI
    X As Long
    Y As Long
End Type
Private Type RECT
    Left As Long
    Top As Long
    Right As Long
    Bottom As Long
End Type
Private Type OPENFILENAME
    lStructSize As Long
    hwndOwner As Long
    hInstance As Long
    lpstrFilter As String
    lpstrCustomFilter As String
    nMaxCustFilter As Long
    nFilterIndex As Long
    lpstrFile As String
    nMaxFile As Long
    lpstrFileTitle As String
    nMaxFileTitle As Long
    lpstrInitialDir As String
    lpstrTitle As String
    Flags As Long
    nFileOffset As Integer
    nFileExtension As Integer
    lpstrDefExt As String
    lCustData As Long
    lpfnHook As Long
    lpTemplateName As String
End Type
Private Type PAGESETUPDLG
    lStructSize As Long
    hwndOwner As Long
    hDevMode As Long
    hDevNames As Long
    Flags As Long
    ptPaperSize As POINTAPI
    rtMinMargin As RECT
    rtMargin As RECT
    hInstance As Long
    lCustData As Long
    lpfnPageSetupHook As Long
    lpfnPagePaintHook As Long
    lpPageSetupTemplateName As String
    hPageSetupTemplate As Long
End Type
Private Type CHOOSECOLOR
    lStructSize As Long
    hwndOwner As Long
    hInstance As Long
    rgbResult As Long
    lpCustColors As String
    Flags As Long
    lCustData As Long
    lpfnHook As Long
    lpTemplateName As String
End Type
Private Type LOGFONT
        lfHeight As Long
        lfWidth As Long
        lfEscapement As Long
        lfOrientation As Long
        lfWeight As Long
        lfItalic As Byte
        lfUnderline As Byte
        lfStrikeOut As Byte
        lfCharSet As Byte
        lfOutPrecision As Byte
        lfClipPrecision As Byte
        lfQuality As Byte
        lfPitchAndFamily As Byte
        lfFaceName As String * 31
End Type
Private Type CHOOSEFONT
        lStructSize As Long
        hwndOwner As Long          '  caller's window handle
        hdc As Long                '  printer DC/IC or NULL
        lpLogFont As Long          '  ptr. to a LOGFONT struct
        iPointSize As Long         '  10 * size in points of selected font
        Flags As Long              '  enum. type flags
        rgbColors As Long          '  returned text color
        lCustData As Long          '  data passed to hook fn.
        lpfnHook As Long           '  ptr. to hook function
        lpTemplateName As String     '  custom template name
        hInstance As Long          '  instance handle of.EXE that
                                       '    contains cust. dlg. template
        lpszStyle As String          '  return the style field here
                                       '  must be LF_FACESIZE or bigger
        nFontType As Integer          '  same value reported to the EnumFonts
                                       '    call back with the extra FONTTYPE_
                                       '    bits added
        MISSING_ALIGNMENT As Integer
        nSizeMin As Long           '  minimum pt size allowed &
        nSizeMax As Long           '  max pt size allowed if
                                       '    CF_LIMITSIZE is used
End Type
Private Type PRINTDLG_TYPE
    lStructSize As Long
    hwndOwner As Long
    hDevMode As Long
    hDevNames As Long
    hdc As Long
    Flags As Long
    nFromPage As Integer
    nToPage As Integer
    nMinPage As Integer
    nMaxPage As Integer
    nCopies As Integer
    hInstance As Long
    lCustData As Long
    lpfnPrintHook As Long
    lpfnSetupHook As Long
    lpPrintTemplateName As String
    lpSetupTemplateName As String
    hPrintTemplate As Long
    hSetupTemplate As Long
End Type
Private Type DEVNAMES_TYPE
    wDriverOffset As Integer
    wDeviceOffset As Integer
    wOutputOffset As Integer
    wDefault As Integer
    extra As String * 100
End Type
Private Type DEVMODE_TYPE
    dmDeviceName As String * CCHDEVICENAME
    dmSpecVersion As Integer
    dmDriverVersion As Integer
    dmSize As Integer
    dmDriverExtra As Integer
    dmFields As Long
    dmOrientation As Integer
    dmPaperSize As Integer
    dmPaperLength As Integer
    dmPaperWidth As Integer
    dmScale As Integer
    dmCopies As Integer
    dmDefaultSource As Integer
    dmPrintQuality As Integer
    dmColor As Integer
    dmDuplex As Integer
    dmYResolution As Integer
    dmTTOption As Integer
    dmCollate As Integer
    dmFormName As String * CCHFORMNAME
    dmUnusedPadding As Integer
    dmBitsPerPel As Integer
    dmPelsWidth As Long
    dmPelsHeight As Long
    dmDisplayFlags As Long
    dmDisplayFrequency As Long
End Type

Private Type BROWSEINFO
  hOwner As Long
  pidlRoot As Long
  pszDisplayName As String
  lpszTitle As String
  ulFlags As Long
  lpfn As Long
  lParam As Long
  iImage As Long
End Type

Private Declare Function CHOOSECOLOR Lib "comdlg32.dll" Alias "ChooseColorA" (pChoosecolor As CHOOSECOLOR) As Long
Private Declare Function GetOpenFileName Lib "comdlg32.dll" Alias "GetOpenFileNameA" (pOpenfilename As OPENFILENAME) As Long
Private Declare Function GetSaveFileName Lib "comdlg32.dll" Alias "GetSaveFileNameA" (pOpenfilename As OPENFILENAME) As Long
Private Declare Function PrintDialog Lib "comdlg32.dll" Alias "PrintDlgA" (pPrintdlg As PRINTDLG_TYPE) As Long
Private Declare Function PAGESETUPDLG Lib "comdlg32.dll" Alias "PageSetupDlgA" (pPagesetupdlg As PAGESETUPDLG) As Long
Private Declare Function CHOOSEFONT Lib "comdlg32.dll" Alias "ChooseFontA" (pChoosefont As CHOOSEFONT) As Long
Private Declare Sub CopyMemory Lib "kernel32" Alias "RtlMoveMemory" (hpvDest As Any, hpvSource As Any, ByVal cbCopy As Long)
Private Declare Function GlobalLock Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function GlobalUnlock Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function GlobalAlloc Lib "kernel32" (ByVal wFlags As Long, ByVal dwBytes As Long) As Long
Private Declare Function GlobalFree Lib "kernel32" (ByVal hMem As Long) As Long
Private Declare Function GetFileTitle Lib "comdlg32.dll" Alias "GetFileTitleA" (ByVal lpszFile As String, ByVal lpszTitle As String, ByVal cbBuf As Integer) As Integer
Private Declare Function SHGetPathFromIDList Lib "shell32.dll" Alias "SHGetPathFromIDListA" (ByVal pidl As Long, ByVal pszPath As String) As Long
Private Declare Function SHBrowseForFolder Lib "shell32.dll" Alias "SHBrowseForFolderA" (lpBrowseInfo As BROWSEINFO) As Long

Dim OFName As OPENFILENAME
'Dim customcolors() As Byte


'Private Sub Command1_Click()
'    Dim sFile As String
'    sFile = ShowOpen
'    If sFile <> "" Then
'        MsgBox "You chose this file: " + sFile
'    Else
'        MsgBox "You pressed cancel"
'    End If
'End Sub
'Private Sub Command2_Click()
'    Dim sFile As String
'    sFile = ShowSave
'    If sFile <> "" Then
'        MsgBox "You chose this file: " + sFile
'    Else
'        MsgBox "You pressed cancel"
'    End If
'End Sub
'Private Sub Command3_Click()
'    Dim NewColor As Long
'    NewColor = ShowColor
'    If NewColor <> -1 Then
'        Me.BackColor = NewColor
'    Else
'        MsgBox "You chose cancel"
'    End If
'End Sub
'Private Sub Command4_Click()
'    MsgBox ShowFont
'End Sub
'Private Sub Command5_Click()
'    ShowPrinter Me
'End Sub
'Private Sub Command6_Click()
'    ShowPageSetupDlg
'End Sub

'
Public Function ShowColor() As Long
    Dim cc As CHOOSECOLOR
    Dim Custcolor(16) As Long
    Dim lReturn As Long
    Dim customcolors() As Byte

    ReDim customcolors(0 To 16 * 4 - 1) As Byte
    Dim i As Integer
    For i = LBound(customcolors) To UBound(customcolors)
        customcolors(i) = 0
    Next i
    'set the structure size
    cc.lStructSize = Len(cc)
    'Set the owner
    cc.hwndOwner = m_dialoghwnd
    'set the application's instance
    cc.hInstance = App.hInstance
    'set the custom colors (converted to Unicode)
    cc.lpCustColors = StrConv(customcolors, vbUnicode)
    'no extra flags
    cc.Flags = 0

    'Show the 'Select Color'-dialog
    If CHOOSECOLOR(cc) <> 0 Then
        m_dialogcolor = cc.rgbResult
        ShowColor = 1
        customcolors = StrConv(cc.lpCustColors, vbFromUnicode)
    Else
        ShowColor = -1
    End If
End Function

Public Property Let Color(new_color As Single)
m_dialogcolor = new_color
End Property

Public Property Get Color() As Single
Color = m_dialogcolor
End Property

Public Property Let Dialogtitle(title As String)
m_dialogtitle = title
End Property

Public Property Get Dialogtitle() As String
Dialogtitle = m_dialogtitle
End Property

Public Property Let Filter(strfilter As String)
m_dialogfilter = strfilter
End Property

Public Property Get Filter() As String
Filter = m_dialogfilter
End Property

Public Property Let InitDir(strdir As String)
m_dialoginitdir = strdir
End Property

Public Property Get InitDir() As String
InitDir = m_dialoginitdir
End Property

Public Property Get FileName() As String
FileName = m_dialogfilename
End Property

Public Property Get FileTitle() As String
Dim Buffer As String
Buffer = String(255, 0)
GetFileTitle m_dialogfilename, Buffer, Len(Buffer)
Buffer = Left$(Buffer, InStr(1, Buffer, Chr$(0)) - 1)
m_dialogfiletitle = Buffer
FileTitle = m_dialogfiletitle
End Property

Public Property Let OwnerHwnd(varhwnd As Variant)
m_dialoghwnd = varhwnd
End Property

Public Property Get OwnerHwnd() As Variant
OwnerHwnd = m_dialoghwnd
End Property

Public Property Let Flags(varflags As Variant)
m_dialogflags = varflags
End Property

Public Property Get Flags() As Variant
Flags = m_dialogflags
End Property

Public Property Get Foldername() As String
Foldername = m_dialogfoldername
End Property



Public Function ShowOpen() As Boolean

    'Set the structure size
    OFName.lStructSize = Len(OFName)

    'Set the owner window
    If Trim(m_dialoghwnd) = "" Then
     MsgBox "Invalid 'Hwnd'"
     Exit Function
    End If
    OFName.hwndOwner = m_dialoghwnd

    'Set the application's instance
    OFName.hInstance = App.hInstance

    'Set the filter
    If Trim(m_dialogfilter) = "" Then
       m_dialogfilter = m_defdialogfilter
     End If
    OFName.lpstrFilter = m_dialogfilter

    'Create a buffer
    OFName.lpstrFile = Space$(254)

    'Set the maximum number of chars
    OFName.nMaxFile = 255

    'Create a buffer
    OFName.lpstrFileTitle = Space$(254)

    'Set the maximum number of chars
    OFName.nMaxFileTitle = 255

    'Set the initial directory
    OFName.lpstrInitialDir = m_dialoginitdir

    'Set the dialog title
     If Trim(m_dialogtitle) = "" Then
       m_dialogtitle = m_defopendialogtitle
     End If
     OFName.lpstrTitle = m_dialogtitle

    'no extra flags
     If Trim(m_dialogflags) = "" Then
        m_dialogflags = 0
     End If
     OFName.Flags = m_dialogflags

    'Show the 'Open File'-dialog
    If GetOpenFileName(OFName) Then
        m_dialogfilename = Trim$(OFName.lpstrFile)
        ShowOpen = True
    Else
         m_dialogfilename = ""
         ShowOpen = False
    End If
End Function



'
Public Sub ShowSave()
    'Set the structure size
    OFName.lStructSize = Len(OFName)

     'Set the owner window
    If Trim(m_dialoghwnd) = "" Then
     MsgBox "Invalid 'Hwnd'"
     Exit Sub
    End If
    OFName.hwndOwner = m_dialoghwnd

    'Set the application's instance
    OFName.hInstance = App.hInstance

    'Set the filter
    If Trim(m_dialogfilter) = "" Then
       m_dialogfilter = m_defdialogfilter
     End If
    OFName.lpstrFilter = m_dialogfilter

    'Create a buffer
    OFName.lpstrFile = Space$(254)
    'Set the maximum number of chars
    OFName.nMaxFile = 255
    'Create a buffer
    OFName.lpstrFileTitle = Space$(254)
    'Set the maximum number of chars
    OFName.nMaxFileTitle = 255
    'Set the initial directory
    OFName.lpstrInitialDir = m_dialoginitdir

   'Set the dialog title
     If Trim(m_dialogtitle) = "" Then
       m_dialogtitle = m_defsavedialogtitle
     End If
     OFName.lpstrTitle = m_dialogtitle

    'no extra flags
     If Trim(m_dialogflags) = "" Then
        m_dialogflags = 0
     End If
     OFName.Flags = m_dialogflags

    'Show the 'Save File'-dialog
    If GetSaveFileName(OFName) Then
        m_dialogfilename = Trim$(OFName.lpstrFile)
    Else
        m_dialogfilename = ""
    End If
End Sub
'
'Public Function ShowFont() As String
'    Dim cf As CHOOSEFONT, lfont As LOGFONT, hMem As Long, pMem As Long
'    Dim fontname As String, retval As Long
'    lfont.lfHeight = 0  ' determine default height
'    lfont.lfWidth = 0  ' determine default width
'    lfont.lfEscapement = 0  ' angle between baseline and escapement vector
'    lfont.lfOrientation = 0  ' angle between baseline and orientation vector
'    lfont.lfWeight = FW_NORMAL  ' normal weight i.e. not bold
'    lfont.lfCharSet = DEFAULT_CHARSET  ' use default character set
'    lfont.lfOutPrecision = OUT_DEFAULT_PRECIS  ' default precision mapping
'    lfont.lfClipPrecision = CLIP_DEFAULT_PRECIS  ' default clipping precision
'    lfont.lfQuality = DEFAULT_QUALITY  ' default quality setting
'    lfont.lfPitchAndFamily = DEFAULT_PITCH Or FF_ROMAN  ' default pitch, proportional with serifs
'    lfont.lfFaceName = "Times New Roman" & vbNullChar  ' string must be null-terminated
'    ' Create the memory block which will act as the LOGFONT structure buffer.
'    hMem = GlobalAlloc(GMEM_MOVEABLE Or GMEM_ZEROINIT, Len(lfont))
'    pMem = GlobalLock(hMem)  ' lock and get pointer
'    CopyMemory ByVal pMem, lfont, Len(lfont)  ' copy structure's contents into block
'    ' Initialize dialog box: Screen and printer fonts, point size between 10 and 72.
'    cf.lStructSize = Len(cf)  ' size of structure
'    cf.hwndOwner = m_dialoghwnd ' window Form1 is opening this dialog box
'    cf.hDC = Printer.hDC  ' device context of default printer (using VB's mechanism)
'    cf.lpLogFont = pMem   ' pointer to LOGFONT memory block buffer
'    cf.iPointSize = 120  ' 12 point font (in units of 1/10 point)
'    cf.Flags = CF_BOTH Or CF_EFFECTS Or CF_FORCEFONTEXIST Or CF_INITTOLOGFONTSTRUCT Or CF_LIMITSIZE
'    cf.rgbColors = RGB(0, 0, 0)  ' black
'    cf.nFontType = REGULAR_FONTTYPE  ' regular font type i.e. not bold or anything
'    cf.nSizeMin = 10  ' minimum point size
'    cf.nSizeMax = 72  ' maximum point size
'    ' Now, call the function.  If successful, copy the LOGFONT structure back into the structure
'    ' and then print out the attributes we mentioned earlier that the user selected.
'    retval = CHOOSEFONT(cf)  ' open the dialog box
'    If retval <> 0 Then  ' success
'        CopyMemory lfont, ByVal pMem, Len(lfont)  ' copy memory back
'        ' Now make the fixed-length string holding the font name into a "normal" string.
'        ShowFont = Left(lfont.lfFaceName, InStr(lfont.lfFaceName, vbNullChar) - 1)
'        Debug.Print  ' end the line
'    End If
'    ' Deallocate the memory block we created earlier.  Note that this must
'    ' be done whether the function succeeded or not.
'    retval = GlobalUnlock(hMem)  ' destroy pointer, unlock block
'    retval = GlobalFree(hMem)  ' free the allocated memory
'End Function
'
'Public Function ShowPageSetupDlg() As Long
'    Dim m_PSD As PAGESETUPDLG
'    'Set the structure size
'    m_PSD.lStructSize = Len(m_PSD)
'    'Set the owner window
'    m_PSD.hwndOwner = m_dialoghwnd
'    'Set the application instance
'    m_PSD.hInstance = App.hInstance
'    'no extra flags
'    m_PSD.Flags = 0
'
'    'Show the pagesetup dialog
'    If PAGESETUPDLG(m_PSD) Then
'        ShowPageSetupDlg = 0
'    Else
'        ShowPageSetupDlg = -1
'    End If
'End Function
'
'
'Public Sub ShowPrinter(frmOwner As Form, Optional PrintFlags As Long)
'    '-> Code by Donald Grover
'    Dim PrintDlg As PRINTDLG_TYPE
'    Dim DevMode As DEVMODE_TYPE
'    Dim DevName As DEVNAMES_TYPE
'
'    Dim lpDevMode As Long, lpDevName As Long
'    Dim bReturn As Integer
'    Dim objPrinter As Printer, NewPrinterName As String
'
'    ' Use PrintDialog to get the handle to a memory
'    ' block with a DevMode and DevName structures
'
'    PrintDlg.lStructSize = Len(PrintDlg)
'    PrintDlg.hwndOwner = frmOwner.hwnd
'
'    PrintDlg.Flags = PrintFlags
'    On Error Resume Next
'    'Set the current orientation and duplex setting
'    DevMode.dmDeviceName = Printer.DeviceName
'    DevMode.dmSize = Len(DevMode)
'    DevMode.dmFields = DM_ORIENTATION Or DM_DUPLEX
'    DevMode.dmPaperWidth = Printer.Width
'    DevMode.dmOrientation = Printer.Orientation
'    DevMode.dmPaperSize = Printer.PaperSize
'    DevMode.dmDuplex = Printer.Duplex
'    On Error GoTo 0
'
'    'Allocate memory for the initialization hDevMode structure
'    'and copy the settings gathered above into this memory
'    PrintDlg.hDevMode = GlobalAlloc(GMEM_MOVEABLE Or GMEM_ZEROINIT, Len(DevMode))
'    lpDevMode = GlobalLock(PrintDlg.hDevMode)
'    If lpDevMode > 0 Then
'        CopyMemory ByVal lpDevMode, DevMode, Len(DevMode)
'        bReturn = GlobalUnlock(PrintDlg.hDevMode)
'    End If
'
'    'Set the current driver, device, and port name strings
'    With DevName
'        .wDriverOffset = 8
'        .wDeviceOffset = .wDriverOffset + 1 + Len(Printer.DriverName)
'        .wOutputOffset = .wDeviceOffset + 1 + Len(Printer.Port)
'        .wDefault = 0
'    End With
'
'    With Printer
'        DevName.extra = .DriverName & Chr(0) & .DeviceName & Chr(0) & .Port & Chr(0)
'    End With
'
'    'Allocate memory for the initial hDevName structure
'    'and copy the settings gathered above into this memory
'    PrintDlg.hDevNames = GlobalAlloc(GMEM_MOVEABLE Or GMEM_ZEROINIT, Len(DevName))
'    lpDevName = GlobalLock(PrintDlg.hDevNames)
'    If lpDevName > 0 Then
'        CopyMemory ByVal lpDevName, DevName, Len(DevName)
'        bReturn = GlobalUnlock(lpDevName)
'    End If
'
'    'Call the print dialog up and let the user make changes
'    If PrintDialog(PrintDlg) <> 0 Then
'
'        'First get the DevName structure.
'        lpDevName = GlobalLock(PrintDlg.hDevNames)
'        CopyMemory DevName, ByVal lpDevName, 45
'        bReturn = GlobalUnlock(lpDevName)
'        GlobalFree PrintDlg.hDevNames
'
'        'Next get the DevMode structure and set the printer
'        'properties appropriately
'        lpDevMode = GlobalLock(PrintDlg.hDevMode)
'        CopyMemory DevMode, ByVal lpDevMode, Len(DevMode)
'        bReturn = GlobalUnlock(PrintDlg.hDevMode)
'        GlobalFree PrintDlg.hDevMode
'        NewPrinterName = UCase$(Left(DevMode.dmDeviceName, InStr(DevMode.dmDeviceName, Chr$(0)) - 1))
'        If Printer.DeviceName <> NewPrinterName Then
'            For Each objPrinter In Printers
'                If UCase$(objPrinter.DeviceName) = NewPrinterName Then
'                    Set Printer = objPrinter
'                    'set printer toolbar name at this point
'                End If
'            Next
'        End If
'
'        On Error Resume Next
'        'Set printer object properties according to selections made
'        'by user
'        Printer.Copies = DevMode.dmCopies
'        Printer.Duplex = DevMode.dmDuplex
'        Printer.Orientation = DevMode.dmOrientation
'        Printer.PaperSize = DevMode.dmPaperSize
'        Printer.PrintQuality = DevMode.dmPrintQuality
'        Printer.ColorMode = DevMode.dmColor
'        Printer.PaperBin = DevMode.dmDefaultSource
'        On Error GoTo 0
'    End If
'End Sub



Public Function ShowBrowsefolder() As Boolean
  Dim X As Long, bi As BROWSEINFO, dwIList As Long
  Dim szPath As String, wPos As Integer

    With bi
        .hOwner = m_dialoghwnd
        .lpszTitle = m_dialogtitle
        .ulFlags = BIF_RETURNONLYFSDIRS
    End With

    dwIList = SHBrowseForFolder(bi)
    szPath = Space$(512)
    X = SHGetPathFromIDList(ByVal dwIList, ByVal szPath)

    If X Then
        wPos = InStr(szPath, Chr(0))
        m_dialogfoldername = Left$(szPath, wPos - 1)
        ShowBrowsefolder = True
    Else
        m_dialogfoldername = ""
        ShowBrowsefolder = False
    End If
End Function


