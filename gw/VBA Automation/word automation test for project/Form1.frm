VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   5595
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   5595
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdInsdatetime 
      Caption         =   "Insert Date time"
      Height          =   375
      Left            =   480
      TabIndex        =   2
      Top             =   960
      Width           =   1335
   End
   Begin VB.CommandButton cmdPagesetup 
      Caption         =   "Page setup"
      Height          =   375
      Left            =   2160
      TabIndex        =   1
      Top             =   480
      Width           =   1335
   End
   Begin VB.CommandButton printdoc 
      Caption         =   "Print Doc"
      Height          =   375
      Left            =   480
      TabIndex        =   0
      Top             =   480
      Width           =   1335
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdInsdatetime_Click()
Call insertdate
End Sub

Private Sub cmdPagesetup_Click()
Call showpagesetupdlg
End Sub

Private Sub Form_Load()
Call init
End Sub

Private Sub printdoc_Click()
Call printreport
End Sub
