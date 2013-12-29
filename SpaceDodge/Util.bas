Attribute VB_Name = "Util"
' start:   Object's start position
' dest:    Object's destination
' speed:   Speed of object
' time:    Time elapsed
Public Type POINTAPI
    x As Long
    y As Long
End Type
Private Declare Function GetCursorPos Lib "user32" (lpPoint As POINTAPI) As Long
Private Declare Function ScreenToClient Lib "user32" (ByVal hWnd As Long, _
    lpPoint As POINTAPI) As Long
    
Private Const DT_BOTTOM = &H8
Private Const DT_CENTER = &H1
Private Const DT_LEFT = &H0
Private Const DT_RIGHT = &H2
Private Const DT_TOP = &H0
Private Const DT_VCENTER = &H4
Private Const DT_WORDBREAK = &H10

Public Type RECT
   Left As Long
   Top As Long
   Right As Long
   Bottom As Long
End Type
Public Declare Function DrawText Lib "user32" Alias "DrawTextA" _
    (ByVal hdc As Long, ByVal lpStr As String, ByVal nCount As Long, _
    lpRect As RECT, ByVal wFormat As Long) As Long

Public Function GetPosition(ByVal start As Point, ByVal dest As Point, _
                            ByVal speed As Double, ByVal time As Integer) As Point
    Dim dblTotalTime As Double
    '    time =              distance / speed
    totalTime = Distance(start, dest) / speed
    Set GetPosition = New Point
    Dim dblTotalDist As Double
    dblTotalDist = dest.x - start.x
    ' starting position + % of time that has passed * the distance the object will travel in all
    GetPosition.x = start.x + (time / totalTime) * dblTotalDist
    dblTotalDist = dest.y - start.y
    GetPosition.y = start.y + (time / totalTime) * dblTotalDist
End Function

' Pythagorean Theorem/Distance Formula
Public Function Distance(a As Point, b As Point) As Double
    Distance = Math.Sqr((a.x - b.x) ^ 2 + (a.y - b.y) ^ 2)
End Function

Public Function MakePoint(x As Double, y As Double) As Point
    Set MakePoint = New Point
    MakePoint.x = x
    MakePoint.y = y
End Function

Public Sub SetPosition(ctrl As Control, P As Point)
    ctrl.Move P.x, P.y
End Sub

Public Function Mouse(Optional hWnd As Long) As Point
    Dim lpPoint As POINTAPI
    GetCursorPos lpPoint
    If hWnd Then ScreenToClient hWnd, lpPoint
    Set Mouse = New Point
    Mouse.x = lpPoint.x
    Mouse.y = lpPoint.y
End Function

Public Function Bounds(ByVal a As Double, ByVal lower As Double, ByVal upper As Double) As Double
    If a > upper Then
        Bounds = upper
    ElseIf a < lower Then
        Bounds = lower
    Else
        Bounds = a
    End If
End Function

Public Function Wrap(ByVal a As Double, ByVal lower As Double, ByVal upper As Double) As Double
    If a > upper Then
        Wrap = lower
    ElseIf a < lower Then
        Wrap = upper
    Else
        Wrap = a
    End If
End Function

Public Sub WrapPoint(ByRef loc As Point, ByVal TopLeft As Point, ByVal BottomRight As Point)
    loc.x = Wrap(loc.x, TopLeft.x, BottomRight.x)
    loc.y = Wrap(loc.y, TopLeft.y, BottomRight.y)
End Sub

Public Function Prob(chance As Double) As Boolean
    chance = Bounds(chance, 1, 100)
    Dim intRand As Double
    intRand = 100 * Rnd() + 1
    If intRand <= chance Then
        Prob = True
    Else
        Prob = False
    End If
End Function

Public Function CheckCollision(loc1 As Point, radius1 As Integer, _
                               loc2 As Point, radius2 As Integer) As Boolean
    CheckCollision = False
    If Distance(loc1, loc2) < radius1 + radius2 Then CheckCollision = True
End Function

Public Sub ShiftArray(ByRef arr() As Bullet, ByVal start As Integer)
    For i = start To UBound(arr)
        If i > 0 Then
            Set arr(i - 1) = arr(i)
            Set arr(i) = Nothing
        Else
            Set arr(i) = Nothing
        End If
    Next
End Sub

 



