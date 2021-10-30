VERSION 5.00
Begin VB.Form Form1 
   BackColor       =   &H00EB9F6C&
   BorderStyle     =   0  'None
   Caption         =   "Form1"
   ClientHeight    =   5850
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   7965
   LinkTopic       =   "Form1"
   ScaleHeight     =   5850
   ScaleWidth      =   7965
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub ctlbutton1_MouseOut(Index As Integer)
ctlbutton1(Index).hover = False
End Sub

Private Sub ctlbutton1_MouseOver(Index As Integer)
ctlbutton1(Index).hover = True
End Sub
