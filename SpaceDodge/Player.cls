VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Player"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public location As Point
Public Radius, Lives, MaxSpeed As Integer
Public CanStop As Boolean
Public Ghost, Score As Integer
Public VerticalSpeed, HorizontalSpeed As Double
Public Dead As Boolean
Public Color As Long


Public Sub Up()
    VerticalSpeed = VerticalSpeed - 1
    If VerticalSpeed = 0 And Not CanStop Then Up
    FixSpeed
End Sub

Public Sub Down()
    VerticalSpeed = VerticalSpeed + 1
    If VerticalSpeed = 0 And Not CanStop Then Down
    FixSpeed
End Sub

Public Sub Left()
    HorizontalSpeed = HorizontalSpeed - 1
    If HorizontalSpeed = 0 And Not CanStop Then Left
    FixSpeed
End Sub

Public Sub Right()
    HorizontalSpeed = HorizontalSpeed + 1
    If HorizontalSpeed = 0 And Not CanStop Then Right
    FixSpeed
End Sub

Public Sub FixSpeed()
    VerticalSpeed = Bounds(VerticalSpeed, -MaxSpeed, MaxSpeed)
    HorizontalSpeed = Bounds(HorizontalSpeed, -MaxSpeed, MaxSpeed)
End Sub

Public Sub Move()
    location.X = location.X + HorizontalSpeed
    location.Y = location.Y + VerticalSpeed
End Sub

Private Sub Class_Initialize()
    Me.Dead = False
    Me.Lives = 3
    Me.Ghost = 0
End Sub
