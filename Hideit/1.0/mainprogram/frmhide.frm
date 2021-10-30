VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "Comdlg32.ocx"
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "ComCtl32.ocx"
Begin VB.Form frmmain 
   Caption         =   "Hide it"
   ClientHeight    =   5355
   ClientLeft      =   165
   ClientTop       =   855
   ClientWidth     =   8820
   BeginProperty Font 
      Name            =   "Verdana"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmhide.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   ScaleHeight     =   5355
   ScaleWidth      =   8820
   StartUpPosition =   3  'Windows Default
   Begin ComctlLib.Toolbar tlbar 
      Align           =   1  'Align Top
      Height          =   825
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   8820
      _ExtentX        =   15558
      _ExtentY        =   1455
      ButtonWidth     =   1482
      ButtonHeight    =   1296
      AllowCustomize  =   0   'False
      Wrappable       =   0   'False
      Appearance      =   1
      ImageList       =   "imglstTlBar"
      _Version        =   327682
   End
   Begin VB.PictureBox pictest 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      Height          =   615
      Left            =   2160
      ScaleHeight     =   555
      ScaleWidth      =   675
      TabIndex        =   2
      Top             =   4320
      Width           =   735
   End
   Begin ComctlLib.ListView lstfiles 
      Height          =   2295
      Left            =   0
      TabIndex        =   0
      Top             =   840
      Width           =   5295
      _ExtentX        =   9340
      _ExtentY        =   4048
      MultiSelect     =   -1  'True
      LabelWrap       =   -1  'True
      HideSelection   =   -1  'True
      OLEDragMode     =   1
      OLEDropMode     =   1
      _Version        =   327682
      Icons           =   "imglstdummy"
      SmallIcons      =   "imglstdummy"
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      OLEDragMode     =   1
      OLEDropMode     =   1
      NumItems        =   0
   End
   Begin MSComDlg.CommonDialog cmdg 
      Left            =   1560
      Top             =   4320
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin ComctlLib.ImageList imglst_disabled_toolbar 
      Left            =   840
      Top             =   4320
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   28
      ImageHeight     =   28
      MaskColor       =   12632256
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   8
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":08CA
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":102C
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":1756
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":1DF4
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":249E
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":2BC8
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":332A
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":3A70
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin ComctlLib.ImageList imglstTlBar 
      Left            =   120
      Top             =   4320
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   28
      ImageHeight     =   28
      _Version        =   327682
      BeginProperty Images {0713E8C2-850A-101B-AFC0-4210102A8DA7} 
         NumListImages   =   8
         BeginProperty ListImage1 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":4332
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":4CB4
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":5526
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":5C5C
            Key             =   ""
         EndProperty
         BeginProperty ListImage5 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":63B6
            Key             =   ""
         EndProperty
         BeginProperty ListImage6 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":6C90
            Key             =   ""
         EndProperty
         BeginProperty ListImage7 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":7612
            Key             =   ""
         EndProperty
         BeginProperty ListImage8 {0713E8C3-850A-101B-AFC0-4210102A8DA7} 
            Picture         =   "frmhide.frx":7F40
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuFileNew 
         Caption         =   " &New"
      End
      Begin VB.Menu mnuFileOpen 
         Caption         =   "&Open"
      End
      Begin VB.Menu mnuFilesep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFileProperties 
         Caption         =   "&Properties"
      End
      Begin VB.Menu mnuFileExit 
         Caption         =   "&Exit"
      End
   End
   Begin VB.Menu mnuActions 
      Caption         =   "&Actions"
      Begin VB.Menu mnuActionsAdd 
         Caption         =   "&Add"
      End
      Begin VB.Menu mnuActionsRemove 
         Caption         =   "&Remove"
      End
      Begin VB.Menu mnuActionsep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuActionsHide 
         Caption         =   "&Hide"
      End
      Begin VB.Menu mnuActionsShow 
         Caption         =   "S&how"
      End
      Begin VB.Menu mnuActionsep2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuActionsView 
         Caption         =   "&View"
      End
      Begin VB.Menu mnuActionsep3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuActionselectall 
         Caption         =   "&Select All"
      End
      Begin VB.Menu mnuActionInvSel 
         Caption         =   "&Invert Selection"
      End
   End
   Begin VB.Menu mnuoptions 
      Caption         =   "&Options"
      Begin VB.Menu mnuOptionsConfiguration 
         Caption         =   "&Configuration"
      End
      Begin VB.Menu mnuOptionsPassword 
         Caption         =   "&Password"
      End
   End
   Begin VB.Menu mnuView 
      Caption         =   "&View"
      Index           =   0
      Begin VB.Menu mnuViewlargeicons 
         Caption         =   "L&arge Icons"
      End
      Begin VB.Menu mnuViewlist 
         Caption         =   "L&ist"
      End
      Begin VB.Menu mnuViewReport 
         Caption         =   "&Details"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuHelpContentsIndex 
         Caption         =   "&Help Contents and Index"
      End
      Begin VB.Menu mnuHelpTipofDay 
         Caption         =   "&Tip of the Day"
      End
      Begin VB.Menu mnuhelpsep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuHelpLegalDisc 
         Caption         =   "&Legal Disclamer"
      End
      Begin VB.Menu mnuhelpsep2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuHelphomepage 
         Caption         =   "Hide It !& Home &Page"
      End
      Begin VB.Menu mnuHelpabout 
         Caption         =   "&About Hide It"
      End
   End
End
Attribute VB_Name = "frmmain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim firsttime As Boolean
Dim Titlebarlength As Integer
Dim validatedblclick As Boolean
Dim tipshown As Boolean

Private Sub Form_Activate()
    
    If INI_settings.ShowTipofDay = 1 And Not tipshown Then
        tipshown = True
        frmTip.Show (1)
    End If

End Sub


Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = vbKeyF1 Then
        Call mnuHelpContentsIndex_Click
    End If
End Sub

Private Sub lstfiles_DblClick()

    If validatedblclick Then
        If gbbool_new_archive_state Then
            Call viewfile
        ElseIf gbbool_open_archive_state Then
            Call mnuActionsShow_Click
        End If
    End If
    
End Sub


Private Sub lstfiles_KeyDown(KeyCode As Integer, Shift As Integer)

    If Shift = 2 And KeyCode = vbKeyA Then
        Call mnuActionselectall_Click
    End If
    
    If KeyCode = vbKeyDelete Then
        Call mnuActionsDelete_Click
    End If

    If KeyCode = vbKeyF1 Then
        Call mnuHelpContentsIndex_Click
    End If
End Sub


Public Sub mnuActionsShow_Click()
    gbint_operation_status = 1
    frmextractarchivedialog.Show (1)
End Sub

Private Sub mnuActionsView_Click()
    Call lstfiles_DblClick
End Sub

Private Sub mnuBRCexit_Click()
    Unload Me
End Sub

Private Sub mnuBRCnew_Click()
    Call mnuFileNew_Click
End Sub

Private Sub mnuBRCopen_Click()
    Call mnuFileOpen_Click
End Sub

Private Sub mnuFileNew_Click()
    frmnewarchivedialog.Show (1)
End Sub

Private Sub mnuFileOpen_Click()
    frmopenarchivedialog.Show (1)
End Sub

Private Sub mnuFileProperties_Click()
    Dim strselectedfile As String
    If gbbool_new_archive_state Then
        If lstfiles.SelectedItem.Selected Then
          strselectedfile = lstfiles.SelectedItem.SubItems(3)
          Call ShowProps(strselectedfile, Me.hwnd)
        End If
    End If
End Sub

Private Sub mnuHelpContentsIndex_Click()
    Call openurl(Me.hwnd, App.Path & "\help\index.htm")
End Sub

Private Sub mnuHelpLegalDisc_Click()
    Call create_dynamic_help(Me.hwnd, "disclaimer.htm")
End Sub

Private Sub mnuHelpTipofDay_Click()
    tipshown = True
    frmTip.Show (1)
End Sub

Private Sub mnuOptionsConfiguration_Click()
    frmconfiguration.Show (1)
End Sub

Private Sub mnuOptionsPassword_Click()
  frmpassword.Show (1)
  lstfiles.SetFocus
End Sub

Private Sub mnuactionsAdd_Click()
    Call AddFile
End Sub

Private Sub mnuActionsDelete_Click()
    Call remove_file_from_list
End Sub

Public Sub mnuFileExit_Click()
    Unload Me
End Sub

Private Sub mnuHelpabout_Click()
    frmabout.Show (1)
End Sub

Private Sub mnuHelphomepage_Click()
    ShellExecute Me.hwnd, vbNullString, "http://www.geocities.com/latishsherigar", vbNullString, "C:\", SW_SHOWNORMAL
End Sub

Private Sub mnuRClickAdd_Click()
    Call mnuactionsAdd_Click
End Sub

Private Sub mnuRClickDelete_Click()
    Call mnuActionsDelete_Click
End Sub

Private Sub mnuRclickInvertSel_Click()
    Call mnuActionInvSel_Click
End Sub

Private Sub mnuRclickProperties_Click()
    Call mnuFileProperties_Click
End Sub

Private Sub mnuRClickSelectall_Click()
    Call mnuActionselectall_Click
End Sub

Private Sub mnuRclickView_Click()
    Call mnuActionsView_Click
End Sub

Private Sub mnuViewlargeicons_Click()
    Call viewtype(1)
End Sub

Private Sub mnuViewlist_Click()
    Call viewtype(2)
End Sub

Private Sub mnuViewReport_Click()
    Call viewtype(3)
End Sub

Private Sub tlbar_ButtonClick(ByVal Button As ComctlLib.Button)

Select Case Button.index

  Case 1: Call mnuFileNew_Click

  Case 2: Call mnuFileOpen_Click

  Case 3: Call mnuactionsAdd_Click

  Case 4: Call mnuActionsDelete_Click

  Case 5: Call mnuOptionsPassword_Click

  Case 6: Call mnuActionsHide_Click

  Case 7: Call mnuActionsShow_Click

  Case 8: Call mnuHelpabout_Click

End Select

End Sub

Private Sub Form_Initialize()
    InitCommonControls
End Sub

Private Sub Form_Load()
    firsttime = True
    
    'set the mask color of the imgelist to the pic background color
     imglstTlBar.MaskColor = get_toolbar_image_color(imglstTlBar)
     imglst_disabled_toolbar.MaskColor = get_toolbar_image_color(imglst_disabled_toolbar)
    
    'Initialise the toolbar
    Call InitTB
    
    'set listview properties
    With lstfiles
    
      .Left = -20
      
      .Top = 820
      
      .Font.Size = 8
      
      .Font.Name = "Verdana"
      
      .BorderStyle = ccNone
      
      .LabelEdit = lvwManual
      
      .LabelWrap = False
   
    End With
    
    lstfiles.view = lvwList
    
    'Initialiase the Toolbar
    With tlbar
    
     .Buttons.Add , "new", "New", , 1
     
     .Buttons.Add , "open", "Open", , 2
     
     .Buttons.Add , "add", "Add", , 3
     
     .Buttons.Add , "remove", "Remove", , 4
     
     .Buttons.Add , "password", "Password", , 5
     
     .Buttons.Add , "hide", "Hide", , 6
     
     .Buttons.Add , "show", "Show", , 7
     
     .Buttons.Add , "about", "About", , 8
    
    End With
    
    
    'initialise all modules
    Call initialise
    
    'load the images on to the menu
    'Call AddBitmapMenu(ImageList1, frmmain)
    
    'read and apply the  settings
    Call readsettings
    
    frmmain.Height = INI_settings.Height
    frmmain.Width = INI_settings.Width
    firsttime = False
    
    'initialise the help path of the project
    gbstr_helppath = App.Path & "/help/"

End Sub

Private Sub Form_Resize()

    On Error GoTo errhnd:
    
    If Me.WindowState <> vbMinimized Then
        
        Titlebarlength = gettitlebarlength(Me.hwnd)
        
        If Titlebarlength > 23 Then
            lstfiles.Height = Me.Height - 1600
        Else
            lstfiles.Height = Me.Height - 1480
        End If
        
        
        lstfiles.Width = Me.Width - 100
    
    'if it is not the firsttime then assign the form height and width to the structure
    If Not firsttime Then
        INI_settings.Height = Me.Height
        INI_settings.Width = Me.Width
    End If
    
    End If
    
errhnd:

End Sub

Private Sub Form_Unload(cancel As Integer)
    Call writeinisettings
    Call cleanup
    End
End Sub

Private Sub lstFiles_MouseDown(Button As Integer, Shift As Integer, X As Single, y As Single)
    If Button = 1 Then
        validatedblclick = True
    Else
        validatedblclick = False
    End If
End Sub


Private Sub lstFiles_OLEDragDrop(Data As ComctlLib.DataObject, Effect As Long, Button As Integer, Shift As Integer, X As Single, y As Single)

On Error GoTo errhnd:
    Dim i As Integer
    For i = 1 To Data.files.count
    Call getfileinfo(Data.files.item(i))
      If Not fileinfo.filetype = "File Folder" Then
     
          If gbbool_new_archive_state = False Then
             Call mnuFileNew_Click
          End If
         
         If gbbool_new_archive_state = True Then
             Call add_file_2_list(Data.files.item(i))
         End If
      
      End If
    Next
errhnd:
End Sub

Private Sub mnuActionInvSel_Click()
    Dim a As Integer
    For a = 1 To lstfiles.ListItems.count
     lstfiles.ListItems(a).Selected = Not lstfiles.ListItems(a).Selected
    Next
End Sub

Private Sub mnuActionselectall_Click()
    Dim a As Integer
    For a = 1 To lstfiles.ListItems.count
     lstfiles.ListItems(a).Selected = True
    Next
End Sub


Private Sub mnuActionsHide_Click()
    gbint_operation_status = 0
    frmprogress.Show (1)
End Sub


Private Function InitTB(Optional intSize As Integer = 24) As Long

    ' Set up the toolbar
    Dim lngStyle As Long
    Dim lRes As Long
    
    On Error GoTo errhnd:
    
    ' Get the toolbar handle (we cannot just use tlbarMain.hwnd as this is a container
    ' window for the actual toolbar control)
    Dim hTBar As Long
    hTBar = FindWindowEx(tlbar.hwnd, 0&, "ToolbarWindow32", vbNullString)
        
    ' The style "TBSTYLE_FLAT" MUST be added.  Although this option is available
    ' in the property pages for the toolbar, it needs to be set here.
    
    ' Get the current style
    lngStyle = SendMessage(hTBar, TB_GETSTYLE, 0&, ByVal 0&)
    
    ' Add the TBSTYLE_FLAT style (could also apply other styles here)
    lngStyle = lngStyle Or TBSTYLE_FLAT
        
    ' Set the new style
    Call SendMessage(hTBar, TB_SETSTYLE, 0&, ByVal lngStyle)
    tlbar.Refresh
    
    ' Now add the ImageList's for the normal, hot, and disabled states
    lRes = SendMessage(hTBar, TB_SETIMAGELIST, 0, ByVal imglstTlBar.hImageList)
'    lRes = SendMessage(hTBar, TB_SETHOTIMAGELIST, 0, ByVal imlHot.hImageList)
    lRes = SendMessage(hTBar, TB_SETDISABLEDIMAGELIST, 0, ByVal imglst_disabled_toolbar.hImageList)
    
    Exit Function
errhnd:
End Function



Public Function get_toolbar_image_color(imglst As ImageList) As Long
    Dim pixel As Long
    Dim r As Integer, g As Integer, b As Integer
    
    On Error GoTo errhnd:
    
    pictest.Picture = imglst.ListImages(1).Picture
    pixel = GetPixel(pictest.hdc, 5 / Screen.TwipsPerPixelX, 5 / Screen.TwipsPerPixelY)
    
    r = pixel Mod 256
    g = (pixel \ 256) Mod 256
    b = (pixel \ 256 \ 256)
   
   get_toolbar_image_color = RGB(r, g, b)
    Exit Function
errhnd:
    get_toolbar_image_color = 0
End Function
