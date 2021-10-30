VERSION 5.00
Begin VB.Form Form1 
   ClientHeight    =   0
   ClientLeft      =   60
   ClientTop       =   60
   ClientWidth     =   1560
   ControlBox      =   0   'False
   Icon            =   "frmcleaner.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   0
   ScaleWidth      =   1560
   StartUpPosition =   3  'Windows Default
   Begin VB.Timer Timer1 
      Interval        =   100
      Left            =   480
      Top             =   360
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit



Private Sub Timer1_Timer()
Call Main
Unload Me

End Sub
