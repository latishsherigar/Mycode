VERSION 5.00
Begin VB.MDIForm frmMainMDI 
   BackColor       =   &H8000000C&
   Caption         =   "Mamta Trading"
   ClientHeight    =   3090
   ClientLeft      =   165
   ClientTop       =   855
   ClientWidth     =   4680
   Icon            =   "MainMDI.frx":0000
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuFileOpen 
         Caption         =   "&Open"
         Begin VB.Menu mnuFileopenContractGen 
            Caption         =   "&Contract Generator"
         End
         Begin VB.Menu mnuFileOpenRegister 
            Caption         =   "&Register"
         End
      End
      Begin VB.Menu mnuFileClose 
         Caption         =   "&Close"
      End
      Begin VB.Menu mnuFileExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuEdit 
      Caption         =   "&Edit"
      Begin VB.Menu mnuEditBuyers 
         Caption         =   "&Buyers"
      End
      Begin VB.Menu mnuEditSellers 
         Caption         =   "&Sellers"
      End
   End
End
Attribute VB_Name = "frmMainMDI"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit





Private Sub mnuFileExit_Click()
End
End Sub

Private Sub mnuFileopenContractGen_Click()

frmContractGen.Show
 
End Sub

