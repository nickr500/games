VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Bullet"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Public location As Point
Private start, dest As Point
Private start_time As Double
Const speed As Double = 1.5


Public Sub Begin(ByVal time As Double, ByVal dest_pnt As Point, Optional start_pnt As Point = Nothing)
    If Not (start_pnt Is Nothing) Then Set Me.location = start_pnt
    Set start = Me.location
    Set dest = MakePoint(dest_pnt.x, dest_pnt.y)
    start_time = time
End Sub

Public Sub Update(time As Double)
    Set Me.location = GetPosition(start, dest, speed, time - start_time)
End Sub
