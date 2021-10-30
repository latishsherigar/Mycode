VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MsComCtl.ocx"
Begin VB.Form frmprogress 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   1080
   ClientLeft      =   15
   ClientTop       =   15
   ClientWidth     =   5565
   ControlBox      =   0   'False
   Icon            =   "frmprogress.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   1080
   ScaleWidth      =   5565
   StartUpPosition =   1  'CenterOwner
   Begin VB.Timer tmrload 
      Interval        =   100
      Left            =   0
      Top             =   1200
   End
   Begin MSComctlLib.ProgressBar prgbar 
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   600
      Width           =   5175
      _ExtentX        =   9128
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   1
   End
   Begin VB.Label lblcaption 
      Height          =   255
      Left            =   240
      TabIndex        =   1
      Top             =   120
      Width           =   5055
   End
End
Attribute VB_Name = "frmprogress"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private Sub Form_Load()
tmrload.Enabled = True
End Sub

Private Sub tmrload_Timer()
prgbar.Value = 10

Select Case PresentCommand
 Case Save: lblcaption = "Saving Product Information ...."
            DoEvents
            Call savedata

  
 Case FindProduct:  lblcaption = "Finding Product Information ...."
                    DoEvents
                    If openexcelsheet(g_makespecificationsheetpath) Then
                    If findquality(frmmain.txtqualityname) Then
                      g_productexists = True
                    Else
                      g_productexists = False
                    End If
                    End If
    
End Select

tmrload.Enabled = False
Unload Me
End Sub

