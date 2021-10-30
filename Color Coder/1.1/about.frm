VERSION 5.00
Begin VB.Form About 
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   0  'None
   Caption         =   "About"
   ClientHeight    =   3510
   ClientLeft      =   0
   ClientTop       =   -105
   ClientWidth     =   6285
   BeginProperty Font 
      Name            =   "Verdana"
      Size            =   9.75
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "about.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3510
   ScaleWidth      =   6285
   ShowInTaskbar   =   0   'False
   StartUpPosition =   1  'CenterOwner
   Begin VB.CommandButton cmdCloseAbout 
      Caption         =   "OK"
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
      Left            =   2520
      TabIndex        =   6
      Top             =   2880
      Width           =   1215
   End
   Begin VB.Label lblmail 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "latishsherigar@yahoo.co.in"
      ForeColor       =   &H00FF0000&
      Height          =   240
      Left            =   1440
      MouseIcon       =   "about.frx":030A
      MousePointer    =   99  'Custom
      TabIndex        =   8
      Top             =   1200
      Width           =   2655
   End
   Begin VB.Label lblwebsite 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "http://www.geocities.com/latishsherigar"
      ForeColor       =   &H00FF0000&
      Height          =   240
      Left            =   1440
      MouseIcon       =   "about.frx":0614
      MousePointer    =   99  'Custom
      TabIndex        =   7
      Top             =   1560
      Width           =   4020
   End
   Begin VB.Image Image1 
      Height          =   480
      Left            =   840
      Picture         =   "about.frx":091E
      Top             =   120
      Width           =   480
   End
   Begin VB.Label Label8 
      BackColor       =   &H00FFFFFF&
      Caption         =   "For more Programms or any queries regarding this program please visit my site or contact me by email."
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   435
      Left            =   240
      TabIndex        =   5
      Top             =   2160
      Width           =   5805
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Latish Sherigar"
      ForeColor       =   &H00FF0000&
      Height          =   240
      Left            =   2040
      TabIndex        =   4
      Top             =   840
      Width           =   1470
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Website :"
      Height          =   240
      Left            =   240
      TabIndex        =   3
      Top             =   1560
      Width           =   960
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Email ID :"
      Height          =   240
      Left            =   240
      TabIndex        =   2
      Top             =   1200
      Width           =   945
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Program Author  :"
      Height          =   240
      Left            =   240
      TabIndex        =   1
      Top             =   840
      Width           =   1770
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFFF&
      Caption         =   "Color Coder"
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   15.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   375
      Left            =   2160
      TabIndex        =   0
      Top             =   120
      Width           =   2025
   End
   Begin VB.Shape Shape1 
      Height          =   3495
      Left            =   0
      Top             =   0
      Width           =   6255
   End
End
Attribute VB_Name = "About"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'Private Declare Function GetTempPath Lib "kernel32" Alias "GetTempPathA" (ByVal nBufferLength As Long, ByVal lpBuffer As String) As Long
Private Declare Function ShellExecute Lib "shell32.dll" Alias "ShellExecuteA" (ByVal hwnd As Long, ByVal lpOperation As String, ByVal lpFile As String, ByVal lpParameters As String, ByVal lpDirectory As String, ByVal nShowCmd As Long) As Long
Const SW_SHOWNORMAL = 1

Private Sub cmdCloseAbout_Click()
Unload Me
End Sub

Private Sub Form_Click()
Unload Me
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblmail.FontUnderline = False
lblwebsite.FontUnderline = False
End Sub

Private Sub lblmail_Click()
   ShellExecute Me.hwnd, vbNullString, "mailto:latishsherigar@yahoo.co.in", vbNullString, "", SW_SHOWNORMAL
End Sub

Private Sub lblmail_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblmail.FontUnderline = True
End Sub

Private Sub lblwebsite_Click()
   ShellExecute Me.hwnd, vbNullString, "http://www.geocities.com/latishsherigar", vbNullString, "", SW_SHOWNORMAL
End Sub

Private Sub lblwebsite_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
lblwebsite.FontUnderline = True
End Sub

'Private Sub Form_Activate()
'Dim strtemp As String
'Dim a() As Byte
'
'Screen.MousePointer = 11
'a = LoadResData(101, "custom")
'Open gettempdir() & "backmusic.wma" For Binary As 1
'Put #1, 1, a
'Close
'Open gettempdir() & "a.htm" For Output As 1
'strtemp = "<html><body><p><img border=0 dynsrc=backmusic.wma start=fileopen  loop=infinite></p></body></html>"
'Print #1, strtemp
'Close
'WebBrowser1.Navigate2 (gettempdir() & "a.htm")
'Screen.MousePointer = 0
'End Sub
'
'Private Function gettempdir() As String
'Dim strtemp As String
'    'Create a buffer
'    strtemp = String(100, Chr$(0))
'    'Get the temporary path
'    GetTempPath 100, strtemp
'    'strip the rest of the buffer
'    strtemp = Left$(strtemp, InStr(strtemp, Chr$(0)) - 1)
'    gettempdir = strtemp
'End Function
'

