VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "PowerUp"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public location As Point
Public Radius, Timeleft As Integer
Public Color As Long
Public Draw As Boolean
Private Kind As Byte
Private Original As Double
Public affects As player
Enum Types
    Big = 1
    Small = 2
    Invincible = 3
    Fast = 4
    Invisible = 5
End Enum

Private Sub Class_Initialize()
    Me.Timeleft = 500
    Kind = CInt(4 * Rnd() + 1)
    Me.Draw = True
    Select Case Kind
        Case Big:
            Me.Color = RGB(255, 165, 0)
        Case Small:
            Me.Color = RGB(175, 0, 175)
        Case Invincible:
            Me.Color = RGB(127, 127, 127)
        Case Fast:
            Me.Color = vbGreen
        Case Invisible:
            Me.Color = vbBlack
        Case Else:
            Stop
    End Select
    Me.Radius = 5
End Sub

Public Sub Use(player As player, other As player)
    Select Case Kind
        Case Big:
            Set Me.affects = other
            Original = Me.affects.Radius
            Me.affects.Radius = Me.affects.Radius * 1.8
        Case Small:
            Set Me.affects = player
            Original = Me.affects.Radius
            Me.affects.Radius = Me.affects.Radius / 1.5
        Case Invincible:
            Set Me.affects = player
            Original = 0
            Me.affects.Ghost = Me.Timeleft
            Me.Timeleft = 0
        Case Fast:
            Set Me.affects = player
            Original = Me.affects.MaxSpeed
            Me.affects.MaxSpeed = Me.affects.MaxSpeed + 5
            Me.affects.VerticalSpeed = Me.affects.VerticalSpeed * 2
            Me.affects.HorizontalSpeed = Me.affects.HorizontalSpeed * 2
            Me.affects.FixSpeed
        Case Invisible:
            Set Me.affects = player
            Original = Me.affects.Color
            Me.affects.Color = vbBlack
    End Select
    Me.Draw = False
End Sub

Public Sub EndUse()
    Select Case Kind
        Case Big:
            Me.affects.Radius = Original
        Case Small:
            Me.affects.Radius = Original
        Case Fast:
            Me.affects.MaxSpeed = Original
            Me.affects.FixSpeed
        Case Invisible:
            Me.affects.Color = Original
        Case Else:
            Exit Sub
    End Select
End Sub

