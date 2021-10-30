VERSION 5.00
Begin VB.UserControl ctlprogressbar 
   ClientHeight    =   3600
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4800
   ScaleHeight     =   3600
   ScaleWidth      =   4800
   Begin VB.Label progresstext 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   " "
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   240
      Left            =   1200
      TabIndex        =   2
      Top             =   0
      Width           =   75
   End
   Begin VB.Label innerbar 
      BackColor       =   &H00FF0000&
      Height          =   180
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   1575
   End
   Begin VB.Label outerbar 
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   2415
   End
End
Attribute VB_Name = "ctlprogressbar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
'Default Property Values:
Const m_def_progress = 0
Const m_def_progresstextcaption = "0 % completed"
'Property Variables:
Dim m_progress As Integer
Dim m_progresstextcaption As String
Dim read As Boolean

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=innerbar,innerbar,-1,BackColor
Public Property Get BackColor() As OLE_COLOR
Attribute BackColor.VB_Description = "Returns/sets the background color used to display text and graphics in an object."
    BackColor = innerbar.BackColor
End Property

Public Property Let BackColor(ByVal New_BackColor As OLE_COLOR)
    innerbar.BackColor = New_BackColor
    PropertyChanged "BackColor"
End Property

Public Property Get ProgressTextColor() As OLE_COLOR
   ProgressTextColor = progresstext.ForeColor
End Property

Public Property Let ProgressTextColor(ByVal New_ProgressTextColor As OLE_COLOR)
    progresstext.ForeColor = New_ProgressTextColor
    PropertyChanged "progresstextColor"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
Public Property Get Font() As Font
    Set Font = progresstext.Font
End Property

Public Property Set Font(ByVal New_Font As Font)
    Set progresstext.Font = New_Font
    PropertyChanged "Font"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=outerbar,outerbar,-1,Enabled
Public Property Get Enabled() As Boolean
Attribute Enabled.VB_Description = "Returns/sets a value that determines whether an object can respond to user-generated events."
    Enabled = outerbar.Enabled
End Property

Public Property Let Enabled(ByVal New_Enabled As Boolean)
    outerbar.Enabled() = New_Enabled
    PropertyChanged "Enabled"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=outerbar,outerbar,-1,BorderStyle
Public Property Get BorderStyle() As Integer
Attribute BorderStyle.VB_Description = "Returns/sets the border style for an object."
    BorderStyle = outerbar.BorderStyle
End Property

Public Property Let BorderStyle(ByVal New_BorderStyle As Integer)
    outerbar.BorderStyle() = New_BorderStyle
    PropertyChanged "BorderStyle"
End Property

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MappingInfo=innerbar,innerbar,-1,Refresh
Public Sub Refresh()
Attribute Refresh.VB_Description = "Forces a complete repaint of a object."
    innerbar.Refresh
End Sub

'WARNING! DO NOT REMOVE OR MODIFY THE FOLLOWING COMMENTED LINES!
'MemberInfo=7,0,0,0
Public Property Get progress() As Integer
    progress = m_progress
    innerbar.Width = ((outerbar.Width - 100) * m_progress) / 100
    progresstext.Caption = m_progress & " % Completed"
End Property

Public Property Let progress(ByVal New_progress As Integer)
    If New_progress >= 0 And New_progress <= 100 Then
    m_progress = New_progress
    PropertyChanged "progress"
    innerbar.Width = ((outerbar.Width - 100) * m_progress) / 100
    progresstext.Caption = m_progress & " % Completed"
    progresstext.Left = outerbar.Width / 2 - progresstext.Width / 2
   Else
    MsgBox "Invalid Property" & New_progress
   End If
End Property

Public Property Get progresstextcaption() As String
    progresstextcaption = m_progresstextcaption
    progresstext.Caption = m_progresstextcaption
End Property

Public Property Let progresstextcaption(ByVal New_progresstextcaption As String)
    m_progresstextcaption = New_progresstextcaption
    PropertyChanged "progresstextcaption"
    progresstext.Caption = m_progresstextcaption
End Property

'Initialize Properties for User Control
Private Sub UserControl_InitProperties()
  m_progress = m_def_progress
  m_progresstextcaption = m_def_progresstextcaption
End Sub

'Load property values from storage
Private Sub UserControl_ReadProperties(PropBag As PropertyBag)
    read = True
    innerbar.BackColor = PropBag.ReadProperty("BackColor", &HFF0000)
    progresstext.ForeColor = PropBag.ReadProperty("ForeColor", &HFF0000)
    outerbar.Enabled = PropBag.ReadProperty("Enabled", True)
    outerbar.BorderStyle = PropBag.ReadProperty("BorderStyle", 1)
    m_progress = PropBag.ReadProperty("progress", m_def_progress)
    m_progresstextcaption = PropBag.ReadProperty("progresstextcaption", m_def_progresstextcaption)
 
    innerbar.Width = ((outerbar.Width - 100) * m_progress) / 100
    progresstext.Caption = m_progress & " % Completed"
    progresstext.Left = (outerbar.Width / 2 - progresstext.Width / 2)
    Set progresstext.Font = PropBag.ReadProperty("Font", Ambient.Font)

End Sub

 Private Sub UserControl_Resize()
outerbar.Height = UserControl.Height
outerbar.Width = UserControl.Width
innerbar.Height = outerbar.Height - 80
innerbar.Top = outerbar.Height / 2 - innerbar.Height / 2
innerbar.Left = outerbar.Left + 50

If Trim(progresstext.Caption) <> "" Then
 progresstext.Left = (outerbar.Width / 2 - progresstext.Width / 2)
End If

progresstext.Top = outerbar.Height / 2 - progresstext.Height / 2
If read = True Then
    innerbar.Width = ((outerbar.Width - 100) * m_progress) / 100
    progresstext.Caption = m_progress & " % Completed"
End If
End Sub

'Write property values to storage
Private Sub UserControl_WriteProperties(PropBag As PropertyBag)
    Call PropBag.WriteProperty("BackColor", innerbar.BackColor, &HFF0000)
    Call PropBag.WriteProperty("ForeColor", progresstext.ForeColor, &HFF0000)
    Call PropBag.WriteProperty("Enabled", outerbar.Enabled, True)
    Call PropBag.WriteProperty("BorderStyle", outerbar.BorderStyle, 1)
    Call PropBag.WriteProperty("progress", m_progress, m_def_progress)
    Call PropBag.WriteProperty("Font", progresstext.Font, Ambient.Font)
    Call PropBag.WriteProperty("progresstextcaption", m_progresstextcaption, m_def_progresstextcaption)

End Sub
