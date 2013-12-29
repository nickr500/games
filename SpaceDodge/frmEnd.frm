VERSION 5.00
Begin VB.Form frmEnd 
   BackColor       =   &H00000000&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Game Over"
   ClientHeight    =   5655
   ClientLeft      =   6330
   ClientTop       =   4770
   ClientWidth     =   8280
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5655
   ScaleWidth      =   8280
   ShowInTaskbar   =   0   'False
   Begin VB.Shape shapeWinner 
      BorderColor     =   &H00FFFFFF&
      FillStyle       =   0  'Solid
      Height          =   495
      Left            =   4080
      Shape           =   3  'Circle
      Top             =   2040
      Width           =   495
   End
   Begin VB.Label lblWinner 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "... Wins!"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   2228
      TabIndex        =   0
      Top             =   1080
      Width           =   3855
   End
End
Attribute VB_Name = "frmEnd"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


Private Sub Form_Unload(Cancel As Integer)
    frmMenu.Show
End Sub
