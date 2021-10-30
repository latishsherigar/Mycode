VERSION 5.00
Begin VB.UserControl ctlHyperLink 
   ClientHeight    =   3600
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
   MouseIcon       =   "ctlHyperLink.ctx":0000
   MousePointer    =   99  'Custom
   ScaleHeight     =   3600
   ScaleWidth      =   4800
   ToolboxBitmap   =   "ctlHyperLink.ctx":030A
   Begin VB.Image imghoverpointer 
      Height          =   480
      Left            =   2520
      Picture         =   "ctlHyperLink.ctx":061C
      Top             =   240
      Visible         =   0   'False
      Width           =   480
   End
   Begin VB.Label lblurl 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label1"
      Height          =   195
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   480
   End
End
Attribute VB_Name = "ctlHyperLink"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit


Private MouseOver As Boolean

Private Type POINTAPI
    X As Long
    Y As Long
End Type

Private Declare Function ReleaseCapture Lib "user32" () As Long
Private Declare Function SetCapture Lib "user32" (ByVal hwnd As _
Long) As Long

Private Declare Function GetCursorPos Lib "user32" (lpPoint As _
POINTAPI) As Long
Private Declare Function ScreenToClient Lib "user32" (ByVal _
hwnd As Long, lpPoint As POINTAPI) As Long

Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long

'Default Property Values:
Const m_def_UrlMode = True
Const m_def_BackStyle = 0
Const m_def_BorderStyle = 0
Const m_def_text = "http://www.geocities.com/latishsherigar"
Const m_def_URL = "http://www.geocities.com/latishsherigar"
Const m_def_HoverUnderLine = True

'Property Variables:
Dim m_UrlMode As Boolean
Dim m_BackStyle As Integer
Dim m_BorderStyle As Integer
Dim m_Text As String
Dim m_URL As String
Dim m_HoverColor As OLE_COLOR
Dim m_ForeColor As OLE_COLOR
Dim m_HoverUnderLine As Boolean

'Event Declarations:
Event Click() 'MappingInfo=lblurl,lblurl,-1,Click
Event DblClick() 'MappingInfo=lblurl,lblurl,-1,DblClick
Event KeyDown(KeyCode As Integer, Shift As Integer)
Attribute KeyDown.VB_Description = "Occurs when the user presses a key while an object has the focus."
Event KeyPress(KeyAscii As Integer)
Attribute KeyPress.VB_Description = "Occurs when the user presses and releases an ANSI key."
Event KeyUp(KeyCode As Integer, Shift As Integer)
Attribute KeyUp.VB_Description = "Occurs when the user releases a key while an object has the focus."
Event MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single) 'MappingInfo=lblurl,lblurl,-1,MouseDown
Event MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single) 'MappingInfo=lblurl,lblurl,-1,MouseMove
Event MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single) 'MappingInfo=lblurl,lblurl,-1,MouseUp
Event Resize()
Attribute Resize.VB_Description = "Occurs when a form is first displayed or the size of an object changes."
Public Event MouseOver()
Public Event MouseOut()

Private Sub lblurl_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Call usercontrol_MouseMove(Button, Shift, X, Y)
End Sub

Private Sub UserControl_Click()
RaiseEvent Click
End Sub

Private Sub UserControl_DblClick()
RaiseEvent DblClick
End Sub

Private Sub UserControl_KeyDown(KeyCode As Integer, Shift As Integer)
RaiseEvent KeyDown(KeyCode, Shift)
End Sub

Private Sub UserControl_KeyPress(KeyAscii As Integer)
RaiseEvent KeyPress(KeyAscii)
End Sub

Private Sub UserControl_KeyUp(KeyCode As Integer, Shift As Integer)
RaiseEvent KeyUp(KeyCode, Shift)
End Sub

Private Sub UserControl_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'Call onmouseoverout(False)
If UrlMode Then
ShellExecute hwnd, "open", m_URL, vbNullString, vbNullString, 1
End If
RaiseEvent MouseDown(Button, Shift, X, Y)
End Sub

Private Sub UserControl_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
RaiseEvent MouseUp(Button, Shift, X, Y)
End Sub

'Private Sub lblurl_Click()
'Call UserControl_Click
'End Sub
'
'Private Sub lblurl_DblClick()
'Call UserControl_DblClick
'End Sub
'
'Private Sub lblurl_KeyDown(KeyCode As Integer, Shift As Integer)
'Call UserControl_KeyDown(KeyCode, Shift)
'End Sub
'
'Private Sub lblurl_KeyPress(KeyAscii As Integer)
'Call UserControl_KeyPress(KeyAscii)
'End Sub
'
'Private Sub lblurl_KeyUp(KeyCode As Integer, Shift As Integer)
'Call UserControl_KeyUp(KeyCode, Shift)
'End Sub
'
'Private Sub lblurl_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
'Call UserControl_MouseDown(Button, Shift, X, Y)
'End Sub
'
'Private Sub lblurl_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
'Call UserControl_MouseUp(Button, Shift, X, Y)
'End Sub

Private Sub usercontrol_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

   Dim xyCursor As POINTAPI
   Dim Xi As Long
   Dim Yi As Long

   SetCapture UserControl.hwnd
   
   GetCursorPos xyCursor
   ScreenToClient UserControl.hwnd, xyCursor

   Xi = xyCursor.X * Screen.TwipsPerPixelX
   Yi = xyCursor.Y * Screen.TwipsPerPixelY

   If Xi < 0 Or Yi < 0 Or Xi > UserControl.Width Or Yi > _
   UserControl.Height Then
      If Button > 0 Then
         RaiseEvent MouseMove(Button, Shift, X, Y)
      End If
      If MouseOver Then
         Call onmouseoverout(False)
         RaiseEvent MouseOut
         If Button = 0 Then
            ReleaseCapture
         End If
         MouseOver = False
      End If
   Else
      RaiseEvent MouseMove(Button, Shift, X, Y)
      If Not MouseOver Then
         Call onmouseoverout(True)
         RaiseEvent MouseOver
         MouseOver = True
      End If
   End If
'Debug.Print "in the loop"
End Sub

'Internal mouseover and mouseout event
Private Sub onmouseoverout(ByVal over As Boolean)
Static originalcolor As OLE_COLOR
If over Then
  'Screen.MousePointer = 99
 ' Screen.MouseIcon = imghoverpointer.Picture
  originalcolor = lblurl.ForeColor
  lblurl.ForeColor = m_HoverColor
  If m_HoverUnderLine Then
     lblurl.FontUnderline = True
  End If
Else
  lblurl.ForeColor = originalcolor
  lblurl.FontUnderline = False
  'Screen.MousePointer = 0

End If
'Debug.Print originalcolor
End Sub

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lblurl,lblurl,-1,BackColor
Public Property Get BackColor() As OLE_COLOR
BackColor = UserControl.BackColor
End Property

Public Property Let BackColor(ByVal New_BackColor As OLE_COLOR)
    UserControl.BackColor = New_BackColor
    PropertyChanged "BackColor"
End Property


'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lblurl,lblurl,-1,BackColor
Public Property Get HoverColor() As OLE_COLOR
    HoverColor = m_HoverColor
End Property

Public Property Let HoverColor(ByVal New_HoverColor As OLE_COLOR)
    m_HoverColor = New_HoverColor
    PropertyChanged "HoverColor"
End Property
'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lblurl,lblurl,-1,ForeColor
Public Property Get ForeColor() As OLE_COLOR
    'm_ForeColor = lblurl.ForeColor
    'ForeColor = m_ForeColor
    ForeColor = lblurl.ForeColor
End Property

Public Property Let ForeColor(ByVal New_ForeColor As OLE_COLOR)
    'm_ForeColor = New_ForeColor
    lblurl.ForeColor = New_ForeColor
    PropertyChanged "ForeColor"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lblurl,lblurl,-1,Enabled
Public Property Get Enabled() As Boolean
    Enabled = UserControl.Enabled
End Property

Public Property Let Enabled(ByVal New_Enabled As Boolean)
    UserControl.Enabled = New_Enabled
    PropertyChanged "Enabled"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lblurl,lblurl,-1,Font
Public Property Get Font() As Font
    Set Font = lblurl.Font
End Property

Public Property Set Font(ByVal New_Font As Font)
    Set lblurl.Font = New_Font
    PropertyChanged "Font"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=7,0,0,0
Public Property Get BackStyle() As Integer
    BackStyle = m_BackStyle
End Property

Public Property Let BackStyle(ByVal New_BackStyle As Integer)
    m_BackStyle = New_BackStyle
    PropertyChanged "BackStyle"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=7,0,0,0
Public Property Get BorderStyle() As Integer
    BorderStyle = m_BorderStyle
End Property

Public Property Let BorderStyle(ByVal New_BorderStyle As Integer)
    m_BorderStyle = New_BorderStyle
    PropertyChanged "BorderStyle"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lblurl,lblurl,-1,Refresh
Public Sub Refresh()
    lblurl.Refresh
End Sub

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lblurl,lblurl,-1,ToolTipText
Public Property Get ToolTipText() As String
Attribute ToolTipText.VB_Description = "Returns/sets the text displayed when the mouse is paused over the control."
    ToolTipText = lblurl.ToolTipText
End Property

Public Property Let ToolTipText(ByVal New_ToolTipText As String)
    lblurl.ToolTipText() = New_ToolTipText
    PropertyChanged "ToolTipText"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=14,0,0,0
Public Property Get Text() As Variant
    Text = m_Text
    lblurl.Caption = m_Text
End Property

Public Property Let Text(ByVal New_Text As Variant)
    lblurl.Caption = New_Text
    m_Text = New_Text
    PropertyChanged "Text"
    Call UserControl_Resize
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=14,0,0,0
Public Property Get URL() As Variant
    URL = m_URL
End Property

Public Property Let URL(ByVal New_URL As Variant)
    m_URL = New_URL
    PropertyChanged "URL"
End Property

'Initialize Properties for User Control
Private Sub UserControl_InitProperties()
    m_BackStyle = m_def_BackStyle
    m_BorderStyle = m_def_BorderStyle
    m_Text = m_def_text
    m_URL = m_def_URL
    m_HoverUnderLine = m_def_HoverUnderLine
    UserControl.BackColor = Ambient.BackColor
    lblurl.Font = Ambient.Font
    lblurl.FontBold = Ambient.Font.Bold
    lblurl.FontItalic = Ambient.Font.Italic
    lblurl.FontSize = Ambient.Font.Size
    m_UrlMode = m_def_UrlMode
    
    UserControl.Width = lblurl.Width
    UserControl.Height = lblurl.Height

End Sub



'Load property values from storage
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)

    UserControl.BackColor = PropBag.ReadProperty("BackColor", &H8000000F)
    lblurl.ForeColor = PropBag.ReadProperty("ForeColor", &H80000012)
    m_HoverColor = PropBag.ReadProperty("HoverColor", &H8000000F)
    UserControl.Enabled = PropBag.ReadProperty("Enabled", True)
    Set lblurl.Font = PropBag.ReadProperty("Font", Ambient.Font)
    m_BackStyle = PropBag.ReadProperty("BackStyle", m_def_BackStyle)
    m_BorderStyle = PropBag.ReadProperty("BorderStyle", m_def_BorderStyle)
    lblurl.ToolTipText = PropBag.ReadProperty("ToolTipText", "")
    m_Text = PropBag.ReadProperty("Text", m_def_text)
    m_URL = PropBag.ReadProperty("URL", m_def_URL)
    lblurl.Caption = m_Text
    m_HoverUnderLine = PropBag.ReadProperty("HoverUnderLine", 0)
    m_UrlMode = PropBag.ReadProperty("UrlMode", m_def_UrlMode)
End Sub

Private Sub UserControl_Resize()
UserControl.Width = lblurl.Width
UserControl.Height = lblurl.Height
End Sub

'Write property values to storage
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)

    Call PropBag.WriteProperty("BackColor", UserControl.BackColor, &H8000000F)
    Call PropBag.WriteProperty("ForeColor", lblurl.ForeColor, &H80000012)
    Call PropBag.WriteProperty("HoverColor", m_HoverColor, &H80000012)
    Call PropBag.WriteProperty("Enabled", UserControl.Enabled, True)
    Call PropBag.WriteProperty("Font", lblurl.Font, Ambient.Font)
    Call PropBag.WriteProperty("BackStyle", m_BackStyle, m_def_BackStyle)
    Call PropBag.WriteProperty("BorderStyle", m_BorderStyle, m_def_BorderStyle)
    Call PropBag.WriteProperty("ToolTipText", lblurl.ToolTipText, "")
    Call PropBag.WriteProperty("Text", m_Text, m_def_text)
    Call PropBag.WriteProperty("URL", m_URL, m_def_URL)
    Call PropBag.WriteProperty("HoverUnderLine", m_HoverUnderLine, 0)
    Call PropBag.WriteProperty("UrlMode", m_UrlMode, m_def_UrlMode)
End Sub


'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=lblurl,lblurl,-1,FontUnderline
Public Property Get HoverUnderLine() As Boolean
        HoverUnderLine = m_HoverUnderLine
End Property

Public Property Let HoverUnderLine(ByVal New_HoverUnderLine As Boolean)
        m_HoverUnderLine = New_HoverUnderLine
        PropertyChanged "HoverUnderLine"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=0,0,0,True
Public Property Get UrlMode() As Boolean
Attribute UrlMode.VB_Description = "Specifies Whether the Hyperlink control should operate in URL mode or form mode"
    UrlMode = m_UrlMode
End Property

Public Property Let UrlMode(ByVal New_UrlMode As Boolean)
    m_UrlMode = New_UrlMode
    PropertyChanged "UrlMode"
End Property

