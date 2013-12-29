VERSION 5.00
Begin VB.Form frmMenu 
   BackColor       =   &H00000000&
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   7440
   ClientLeft      =   5670
   ClientTop       =   4605
   ClientWidth     =   9750
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7440
   ScaleWidth      =   9750
   Begin VB.CommandButton cmdHelp 
      BackColor       =   &H0000FFFF&
      Caption         =   "Help"
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   4920
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   4440
      Width           =   855
   End
   Begin VB.CheckBox chkBonus 
      BackColor       =   &H00000000&
      Caption         =   "Power Ups"
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   3720
      TabIndex        =   2
      Top             =   4680
      Value           =   1  'Checked
      Width           =   2055
   End
   Begin VB.CheckBox chkBounce 
      BackColor       =   &H00000000&
      Caption         =   "Bounce"
      ForeColor       =   &H00FFFFFF&
      Height          =   495
      Left            =   3720
      TabIndex        =   1
      Top             =   4320
      Value           =   1  'Checked
      Width           =   2055
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H00FFFFFF&
      Caption         =   "PLAY"
      BeginProperty Font 
         Name            =   "Fixedsys"
         Size            =   18
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   3720
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   3233
      Width           =   2055
   End
   Begin VB.Shape Shape4 
      BorderColor     =   &H00FFFFFF&
      FillColor       =   &H00FF0000&
      FillStyle       =   0  'Solid
      Height          =   1200
      Left            =   0
      Shape           =   3  'Circle
      Top             =   6240
      Width           =   1200
   End
   Begin VB.Shape Shape3 
      BorderColor     =   &H00FFFFFF&
      FillColor       =   &H00FF0000&
      FillStyle       =   0  'Solid
      Height          =   1200
      Left            =   8520
      Shape           =   3  'Circle
      Top             =   0
      Width           =   1200
   End
   Begin VB.Shape Shape2 
      BorderColor     =   &H00FFFFFF&
      FillColor       =   &H000000FF&
      FillStyle       =   0  'Solid
      Height          =   1200
      Left            =   8520
      Shape           =   3  'Circle
      Top             =   6240
      Width           =   1200
   End
   Begin VB.Shape Shape1 
      BorderColor     =   &H00FFFFFF&
      FillColor       =   &H000000FF&
      FillStyle       =   0  'Solid
      Height          =   1200
      Left            =   0
      Shape           =   3  'Circle
      Top             =   0
      Width           =   1200
   End
End
Attribute VB_Name = "frmMenu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdHelp_Click()
    frmHelp.Show 1
End Sub

Private Sub Command1_Click()
    frmMain.Show
    frmMain.Bounce = chkBounce.Value
    frmMain.PowerUps = chkBonus.Value
    Me.Hide
End Sub
