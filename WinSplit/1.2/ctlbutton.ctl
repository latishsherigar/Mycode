VERSION 5.00
Begin VB.UserControl ctlbutton 
   ClientHeight    =   3600
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
   ScaleHeight     =   3600
   ScaleWidth      =   4800
   ToolboxBitmap   =   "ctlbutton.ctx":0000
   Begin VB.Label lblbuttontext 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "    GO"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   240
      Left            =   360
      TabIndex        =   0
      Top             =   120
      Width           =   315
   End
   Begin VB.Shape Shpbuttonborder 
      BorderColor     =   &H00FFFFFF&
      FillColor       =   &H00F5D1BA&
      FillStyle       =   0  'Solid
      Height          =   375
      Left            =   0
      Shape           =   4  'Rounded Rectangle
      Top             =   0
      Width           =   1095
   End
End
Attribute VB_Name = "ctlbutton"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Private MouseIn As Boolean

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

'Default Property Values:
'Const m_def_visible = 0
Const m_def_HoverColor = 0
Const m_def_text = "Text"
Const m_def_hover = False
'Property Variables:
'Dim m_visible As Variant
Dim m_HoverColor As OLE_COLOR
Dim m_Text As String
Dim m_hover As Boolean

'Event Declarations:
Event Click() 'MappingInfo=lblbuttontext,lblbuttontext,-1,Click
Attribute Click.VB_Description = "Occurs when the user presses and then releases a mouse button over an object."
Event DblClick() 'MappingInfo=lblbuttontext,lblbuttontext,-1,DblClick
Attribute DblClick.VB_Description = "Occurs when the user presses and releases a mouse button and then presses and releases it again over an object."
Event KeyDown(KeyCode As Integer, Shift As Integer)
Attribute KeyDown.VB_Description = "Occurs when the user presses a key while an object has the focus."
Event KeyPress(KeyAscii As Integer)
Attribute KeyPress.VB_Description = "Occurs when the user presses and releases an ANSI key."
Event KeyUp(KeyCode As Integer, Shift As Integer)
Attribute KeyUp.VB_Description = "Occurs when the user releases a key while an object has the focus."
Event MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single) 'MappingInfo=lblbuttontext,lblbuttontext,-1,MouseDown
Attribute MouseDown.VB_Description = "Occurs when the user presses the mouse button while an object has the focus."
Event MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single) 'MappingInfo=lblbuttontext,lblbuttontext,-1,MouseMove
Attribute MouseMove.VB_Description = "Occurs when the user moves the mouse."
Event MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single) 'MappingInfo=lblbuttontext,lblbuttontext,-1,MouseUp
Attribute MouseUp.VB_Description = "Occurs when the user releases the mouse button while an object has the focus."
Event MouseOver()
Event MouseOut()



'Private Sub lblbuttontext_Click()
'    RaiseEvent Click
'End Sub
'
'Private Sub lblbuttontext_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
'If Button = 1 Then
'  RaiseEvent Click
'End If
'Call usercontrol_MouseMove(Button, Shift, X, Y)
'End Sub
'
'Private Sub UserControl_Click()
'    RaiseEvent Click
'End Sub

Private Sub UserControl_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    RaiseEvent Click
End Sub

Private Sub usercontrol_MouseMove(Button As Integer, Shift As _
Integer, X As Single, Y As Single)

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
      If MouseIn Then
         RaiseEvent MouseOut
         If Button = 0 Then
            ReleaseCapture
         End If
         MouseIn = False
      End If
   Else
      RaiseEvent MouseMove(Button, Shift, X, Y)
      If Not MouseIn Then
         RaiseEvent MouseOver
         MouseIn = True
      End If
   End If
   
'   If Button = 1 Then
'     RaiseEvent Click
'   End If

End Sub

Private Sub UserControl_Resize()
Shpbuttonborder.Width = UserControl.Width
Shpbuttonborder.Height = UserControl.Height
lblbuttontext.Left = UserControl.Width / 2 - lblbuttontext.Width / 2
lblbuttontext.Top = UserControl.Height / 2 - lblbuttontext.Height / 2
UserControl.BackColor = Ambient.BackColor
End Sub

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=Shpbuttonborder,Shpbuttonborder,-1,FillColor
Public Property Get BackColor() As OLE_COLOR
    BackColor = Shpbuttonborder.FillColor
End Property

Public Property Let BackColor(ByVal New_BackColor As OLE_COLOR)
    Shpbuttonborder.FillColor() = New_BackColor
    PropertyChanged "BackColor"
End Property
Public Property Get HoverColor() As OLE_COLOR
    HoverColor = m_HoverColor
End Property

Public Property Let HoverColor(ByVal New_HoverColor As OLE_COLOR)
    m_HoverColor = New_HoverColor
    PropertyChanged "HoverColor"
End Property
Public Property Get ForeColor() As OLE_COLOR
Attribute ForeColor.VB_Description = "Returns/sets the foreground color used to display text and graphics in an object."
    ForeColor = lblbuttontext.ForeColor
End Property

Public Property Let ForeColor(ByVal New_ForeColor As OLE_COLOR)
    lblbuttontext.ForeColor() = New_ForeColor
    PropertyChanged "ForeColor"
End Property

Public Property Get Enabled() As Boolean
Attribute Enabled.VB_Description = "Returns/sets a value that determines whether an object can respond to user-generated events."
    Enabled = UserControl.Enabled
End Property

Public Property Let Enabled(ByVal New_Enabled As Boolean)
    UserControl.Enabled() = New_Enabled
    PropertyChanged "Enabled"
End Property

Public Property Let hover(ByVal New_Hover As Boolean)
Static originalcolor As OLE_COLOR
If Ambient.UserMode Then
    If New_Hover Then
        originalcolor = Shpbuttonborder.FillColor
        Shpbuttonborder.FillColor = m_HoverColor
        m_hover = True
    Else
        Shpbuttonborder.FillColor = originalcolor
        m_hover = False
    End If
 End If
End Property

Public Property Get hover() As Boolean
    hover = m_hover
End Property

Public Property Get Text() As String
Attribute Text.VB_Description = "Returns a Font object."
Attribute Text.VB_UserMemId = -512
    lblbuttontext.Caption = m_Text
    Text = m_Text
End Property

Public Property Let Text(ByVal New_Text As String)
    lblbuttontext.Caption = New_Text
    m_Text = New_Text
    PropertyChanged "Text"
    Call UserControl_Resize
End Property

Public Property Get Font() As Font
    Set Font = lblbuttontext.Font
End Property

Public Property Set Font(ByVal New_Font As Font)
    Set lblbuttontext.Font = New_Font
    PropertyChanged "Font"
End Property

Public Sub Refresh()
Attribute Refresh.VB_Description = "Forces a complete repaint of a object."
    lblbuttontext.Refresh
End Sub

'Initialize Properties for User Control
Private Sub UserControl_InitProperties()
    m_HoverColor = m_def_HoverColor
    m_Text = m_def_text
    m_hover = m_def_hover
'    m_visible = m_def_visible
End Sub

'Load property values from storage
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
    lblbuttontext.ForeColor = PropBag.ReadProperty("ForeColor", &HFFFFFF)
    UserControl.Enabled = PropBag.ReadProperty("Enabled", True)
    Set lblbuttontext.Font = PropBag.ReadProperty("Font", Ambient.Font)
    m_HoverColor = PropBag.ReadProperty("HoverColor", m_def_HoverColor)
    m_Text = PropBag.ReadProperty("Text", m_def_text)
    m_hover = PropBag.ReadProperty("Hover", m_def_hover)
    
    lblbuttontext.Caption = m_Text
    lblbuttontext.Left = UserControl.Width / 2 - lblbuttontext.Width / 2
    lblbuttontext.Top = UserControl.Height / 2 - lblbuttontext.Height / 2

    Shpbuttonborder.FillColor = PropBag.ReadProperty("BackColor", &HF5D1BA)
    Shpbuttonborder.Shape = PropBag.ReadProperty("Shape", 4)
'    m_visible = PropBag.ReadProperty("visible", m_def_visible)
End Sub

'Write property values to storage
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
    Call PropBag.WriteProperty("ForeColor", lblbuttontext.ForeColor, &HFFFFFF)
    Call PropBag.WriteProperty("Enabled", UserControl.Enabled, True)
    Call PropBag.WriteProperty("Font", lblbuttontext.Font, Ambient.Font)
    Call PropBag.WriteProperty("HoverColor", m_HoverColor, m_def_HoverColor)
    Call PropBag.WriteProperty("Text", m_Text, m_def_text)
    Call PropBag.WriteProperty("Hover", m_hover, m_def_hover)
    Call PropBag.WriteProperty("BackColor", Shpbuttonborder.FillColor, &HF5D1BA)
    Call PropBag.WriteProperty("Shape", Shpbuttonborder.Shape, 4)
'    Call PropBag.WriteProperty("visible", m_visible, m_def_visible)
End Sub



'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=Shpbuttonborder,Shpbuttonborder,-1,Shape
Public Property Get Shape() As Integer
Attribute Shape.VB_Description = "Returns/sets a value indicating the appearance of a control."
    Shape = Shpbuttonborder.Shape
End Property

Public Property Let Shape(ByVal New_Shape As Integer)
    Shpbuttonborder.Shape() = New_Shape
    PropertyChanged "Shape"
End Property

''WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
''MemberInfo=14,0,0,0
'Public Property Get visible() As Boolean
'    visible = m_visible
'End Property
'
'Public Property Let visible(ByVal New_visible As Boolean)
'    m_visible = New_visible
'    Shpbuttonborder.visible = m_visible
'    lblbuttontext.visible = m_visible
'    PropertyChanged "visible"
'End Property

