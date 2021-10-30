Attribute VB_Name = "addimg2menu"
Option Explicit

'#####################################
'# This tutorial show how to make a  #
'# menu which looks like the menu of #
'# Office 2000 i.e with image on the #
'# left side of the text.            #
'# Dimension of all the image must be#
'# 13x13 pixels and mask color be    #
'# white                             #
'#####################################

'Get handle of the menu
Private Declare Function GetMenu Lib "user32" (ByVal hwnd As Long) As Long
'Get handle to the individual menu
Private Declare Function GetSubMenu Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
'Set the bitmap of the specified menu
Private Declare Function SetMenuItemBitmaps Lib "user32" (ByVal hMenu As Long, ByVal nPosition As Long, ByVal wFlags As Long, ByVal hBitmapUnchecked As Long, ByVal hBitmapChecked As Long) As Long
'Constant used by above function

'Identifier of the menu item.
'I will not use this constant in this project.
'Just becase it was part of the SetMenuItemBitmaps
'I added this constant
Private Const MF_BYCOMMAND = &H0&
'Position of the menu (this will be used)
'Zero-based relative position of the menu item.
Private Const MF_BYPOSITION = &H400&

Public Function AddBitmapMenu(Images, Form As Form)
Dim hwnd As Long
Dim hWndMenu As Long
'Get the hWnd of the main menu
hwnd = GetMenu(Form.hwnd)
'Get the hWnd of the menu (zero based i.e 0,1,2...)
'For the 1st menu
hWndMenu = GetSubMenu(hwnd, 0)

With Images
'This function just sets the bitmap of the menu
'First parameter is handle to the menu
'2nd parameter is position of the menu (zero based) or identifier of the menu
'3rd parameter specifies how the 2nd parameter is interpreted
'5th and 4th parameter is the picture for the menu

'For the 1st menu
'In this case
'hWndMenu is the hWnd of the menu,
'0 is the index for the menu item,
'MF_BYPOSITION is that we want to refer each menu
'by index not by menu identifier
'And last two parameter is the image
Call SetMenuItemBitmaps(hWndMenu, 0, MF_BYPOSITION, .ListImages(1).Picture, .ListImages(1).Picture)
Call SetMenuItemBitmaps(hWndMenu, 1, MF_BYPOSITION, .ListImages(2).Picture, .ListImages(2).Picture)
'Call SetMenuItemBitmaps(hWndMenu, 2, MF_BYPOSITION, .ListImages(3).Picture, .ListImages(3).Picture)
'For the 2nd menu
'Get new hWnd
'hWndMenu = GetSubMenu(hWnd, 1)
'Call SetMenuItemBitmaps(hWndMenu, 0, MF_BYPOSITION, .ListImages(4).Picture, .ListImages(4).Picture)
'Call SetMenuItemBitmaps(hWndMenu, 1, MF_BYPOSITION, .ListImages(5).Picture, .ListImages(5).Picture)
'Call SetMenuItemBitmaps(hWndMenu, 2, MF_BYPOSITION, .ListImages(6).Picture, .ListImages(6).Picture)
''For the sub-menu of the second menu
''Get the hWnd of the submenu
'hWndMenu = GetSubMenu(hWndMenu, 2)
'Call SetMenuItemBitmaps(hWndMenu, 0, MF_BYPOSITION, .ListImages(3).Picture, .ListImages(3).Picture)
End With
End Function

'-------------------------------------------------
'Private Declare Function GetMenu Lib "user32" (ByVal hWnd As Long) As Long
'Private Declare Function GetMenuItemID Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
'Private Declare Function GetSubMenu Lib "user32" (ByVal hMenu As Long, ByVal nPos As Long) As Long
'Private Declare Function ModifyMenu Lib "user32" Alias "ModifyMenuA" (ByVal hMenu As Long, ByVal nPosition As Long, ByVal wFlags As Long, ByVal wIDNewItem As Long, ByVal lpString As Any) As Long
'Const MF_BITMAP = 4
'Const MF_CHECKED = 8
'
'Public Function AddBitmapMenu(images As imagelist, Form As Form)
'    Dim hMenu As Long, hSubMenu As Long, lngID As Long
'    'Dim picbitmaps(2) As PictureBox
'    'Get the handle of the form's menu
'    hMenu = GetMenu(Form.hWnd)
'    'Get the handle of the form's submenu
'    hSubMenu = GetSubMenu(hMenu, 0)
'    'Change first item (index=0)
'    'picbitmaps(0).Picture = images.ListImages.item(1).Picture
'    lngID = GetMenuItemID(hSubMenu, 0)
'    Call ModifyMenu(hMenu, lngID, MF_BITMAP, lngID, CLng(images.ListImages.item(1).Picture))
'
'    'Change second item (index=1)
''    picbitmaps(1).Picture = picbitmaps(1).Image
''    lngID = GetMenuItemID(hSubMenu, 1)
''    Call ModifyMenu(hMenu, lngID, MF_BITMAP, lngID, CLng(picbitmaps(1).Picture))
'
'    'Change third item (index=2)
''    picbitmaps(2).Picture = picbitmaps(2).Image
''    lngID = GetMenuItemID(hSubMenu, 2)
''    Call ModifyMenu(hMenu, lngID, MF_BITMAP, lngID, CLng(picbitmaps(2).Picture))
'
'End Function

