VERSION 5.00
Begin VB.Form frmMain 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00000000&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Form1"
   ClientHeight    =   11415
   ClientLeft      =   3690
   ClientTop       =   2100
   ClientWidth     =   13590
   FillColor       =   &H0000FFFF&
   FillStyle       =   0  'Solid
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   761
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   906
   Visible         =   0   'False
   Begin VB.Timer tmrMove 
      Interval        =   100
      Left            =   10440
      Top             =   0
   End
   Begin VB.Timer tmrMain 
      Interval        =   5
      Left            =   9960
      Top             =   0
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private TopLeft, BottomRight, Center As Point
Private time As Long
Private Player1 As player
Private Player2 As player
Private bullets() As Bullet
Private bonus As PowerUp
Private KeyUp, KeyDown, KeyLeft, KeyRight, KeyW, KeyS, KeyA, KeyD As Boolean
Private message As String
Const Center_Radius As Integer = 70
Const Bullet_Radius As Integer = 5

Public TwoPlayer As Boolean
Public Bounce, PowerUps As Boolean

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode
        Case vbKeyUp
            KeyUp = True
        Case vbKeyDown
            KeyDown = True
        Case vbKeyLeft
            KeyLeft = True
        Case vbKeyRight
            KeyRight = True
        Case vbKeyW
            KeyW = True
        Case vbKeyA
            KeyA = True
        Case vbKeyS
            KeyS = True
        Case vbKeyD
            KeyD = True
    End Select
End Sub
Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode
        Case vbKeyUp
            KeyUp = False
        Case vbKeyDown
            KeyDown = False
        Case vbKeyLeft
            KeyLeft = False
        Case vbKeyRight
            KeyRight = False
        Case vbKeyW
            KeyW = False
        Case vbKeyA
            KeyA = False
        Case vbKeyS
            KeyS = False
        Case vbKeyD
            KeyD = False
    End Select
End Sub

Private Sub Form_Load()
    KeyUp = False
    KeyDown = False
    KeyLeft = False
    KeyRight = False
    KeyW = False
    KeyS = False
    KeyA = False
    KeyD = False
    Set bonus = Nothing
    Randomize
    ReDim bullets(0)
    Set TopLeft = MakePoint(0, 60)
    Set BottomRight = MakePoint(Me.ScaleWidth, Me.ScaleHeight)
    Set Center = MakePoint((BottomRight.x - TopLeft.x) / 2, (BottomRight.y - TopLeft.y) / 2)
    Set Player1 = New player
    Set Player1.location = MakePoint(TopLeft.x + 100, TopLeft.y + 100)
    Player1.Color = RGB(255, 0, 0)
    Player1.Radius = 15
    Player1.CanStop = False
    Player1.MaxSpeed = 8
    Set Player2 = New player
    Set Player2.location = MakePoint(BottomRight.x - 100, BottomRight.y - 100)
    Player2.Color = RGB(0, 0, 255)
    Player2.Radius = 15
    Player2.CanStop = False
    Player2.MaxSpeed = 8
End Sub

Private Sub Form_Unload(Cancel As Integer)
    frmMenu.Show
End Sub

Private Sub tmrMain_Timer()
    'On Error GoTo Err
    time = time + tmrMain.Interval
    Player1.Move
    Player2.Move
    If Me.Bounce Then
        'bounce off edges
        Player1.location.x = Bounds(Player1.location.x, TopLeft.x, BottomRight.x)
        Player1.location.y = Bounds(Player1.location.y, TopLeft.y, BottomRight.y)
        Player2.location.x = Bounds(Player2.location.x, TopLeft.x, BottomRight.x)
        Player2.location.y = Bounds(Player2.location.y, TopLeft.y, BottomRight.y)
        Const Rest = 0.8
        If Player1.location.y <= TopLeft.y Or Player1.location.y >= BottomRight.y Then
            Player1.VerticalSpeed = -Player1.VerticalSpeed * Rest
        End If
        If Player1.location.x <= TopLeft.x Or Player1.location.x >= BottomRight.x Then
            Player1.HorizontalSpeed = -Player1.HorizontalSpeed * Rest
        End If
        If Player2.location.y <= TopLeft.y Or Player2.location.y >= BottomRight.y Then
            Player2.VerticalSpeed = -Player2.VerticalSpeed * Rest
        End If
        If Player2.location.x <= TopLeft.x Or Player2.location.x >= BottomRight.x Then
            Player2.HorizontalSpeed = -Player2.HorizontalSpeed * Rest
        End If
    Else
        'Wrap around sides
        WrapPoint Player1.location, TopLeft, BottomRight
        WrapPoint Player2.location, TopLeft, BottomRight
    End If
    
    If time >= 1200 Then
        If Player1.Ghost <= 0 And Prob(3) Then
            FireBullet Predict(Player1)
        End If
        If Player2.Ghost <= 0 And Prob(3) Then
            FireBullet Predict(Player2)
        End If
        If Me.PowerUps And bonus Is Nothing And Prob(1.5) Then
            'spawn powerup
            Debug.Print time
            Set bonus = New PowerUp
            If Prob(50) Then
                Set bonus.location = MakePoint(TopLeft.x + bonus.Radius * 2 + 10, _
                                                BottomRight.y - bonus.Radius * 2 - 10)
            Else
                Set bonus.location = MakePoint(BottomRight.x - bonus.Radius * 2 - 10, _
                                                TopLeft.y + bonus.Radius * 2 + 10)
            End If
        End If
    End If
    
    'clear screen
    Me.Cls
    'count down ghost time
    If Player1.Ghost > 0 Then Player1.Ghost = Player1.Ghost - 1
    If Player2.Ghost > 0 Then Player2.Ghost = Player2.Ghost - 1
    'draw to screen
    DrawPowerUps
    DrawPlayers
    DrawLives
    DrawBullets
    'Center Circle
    Me.FillColor = RGB(255, 0, 255)
    Me.Circle (Center.x, Center.y), Center_Radius
    'Player collisions
    CheckCollisions Player1, Player2
    CheckCollisions Player2, Player1
    If Player1.Dead Then
        Player1.Lives = Player1.Lives - 1
        Set Player1.location = MakePoint(TopLeft.x + Player1.Radius, TopLeft.y + Player1.Radius)
        Player1.HorizontalSpeed = 0
        Player1.VerticalSpeed = 0
        Player1.Ghost = 100
        Player1.Dead = False
    End If
    If Player2.Dead Then
        Player2.Lives = Player2.Lives - 1
        Set Player2.location = MakePoint(BottomRight.x - Player2.Radius, BottomRight.y - Player2.Radius)
        Player2.HorizontalSpeed = 0
        Player2.VerticalSpeed = 0
        Player2.Ghost = 100
        Player2.Dead = False
    End If
    If Player1.Lives < 1 Or Player2.Lives < 1 Then EndGame
    'Power up
    If Not (bonus Is Nothing) Then
        If Not bonus.Draw Then bonus.Timeleft = bonus.Timeleft - 1
        If bonus.Timeleft <= 0 Then
            bonus.EndUse
            Set bonus = Nothing
        End If
    End If
    Exit Sub
Err:
    ReDim bullets(0)
    time = 0
End Sub
Private Sub FireBullet(targ As Point)
    Dim b As Bullet
    Set b = New Bullet
    Set b.location = Center
    b.Begin time, targ
    ReDim Preserve bullets(UBound(bullets) + 1)
    Set bullets(UBound(bullets)) = b
'    Stop
End Sub
Private Sub DrawPlayers()
    If Player1.Ghost <= 0 Then Me.FillColor = Player1.Color _
    Else Me.FillColor = RGB(127, 127, 127)
    Me.Circle (Player1.location.x, Player1.location.y), Player1.Radius, RGB(255, 255, 255)
    If Player2.Ghost <= 0 Then Me.FillColor = Player2.Color _
    Else Me.FillColor = RGB(127, 127, 127)
    Me.Circle (Player2.location.x, Player2.location.y), Player2.Radius, RGB(255, 255, 255)
End Sub
Private Sub DrawBullets()
    'Draw bullets
    Me.FillColor = RGB(255, 255, 0)
    i = 0
    num = UBound(bullets)
    While i < num + 1
        Dim b As Bullet
        Set b = bullets(i)
        If b Is Nothing Then
            i = i + 1
            GoTo Continue
        End If
        If b.location.x < TopLeft.x Or b.location.x > BottomRight.x Or _
            b.location.y < TopLeft.y Or b.location.y > BottomRight.y Then
            Set bullets(i) = Nothing
            ShiftArray bullets, i + 1
            ReDim Preserve bullets(num - 1)
            GoTo Continue
        End If
        b.Update (time)
        Me.Circle (b.location.x, b.location.y), Bullet_Radius
        i = i + 1
Continue:
        num = UBound(bullets)
    Wend
End Sub

Private Sub DrawPowerUps()
    If bonus Is Nothing Then Exit Sub
    If Not bonus.Draw Then Exit Sub
    Me.FillColor = bonus.Color
    Line (bonus.location.x - bonus.Radius, bonus.location.y - bonus.Radius)-(bonus.location.x + bonus.Radius, bonus.location.y + bonus.Radius), _
         vbWhite, B
End Sub

Private Sub MovePlayers()
    If KeyUp Then Player1.Up
    If KeyDown Then Player1.Down
    If KeyLeft Then Player1.Left
    If KeyRight Then Player1.Right
    If KeyW Then Player2.Up
    If KeyS Then Player2.Down
    If KeyA Then Player2.Left
    If KeyD Then Player2.Right
End Sub

Private Sub CheckCollisions(player As player, other As player)
    If CheckCollision(player.location, player.Radius, other.location, other.Radius) Then
        Player_Dead player
        Player_Dead other
        Exit Sub
    End If
    If CheckCollision(player.location, player.Radius, Center, Center_Radius) Then
        Player_Dead player
        Exit Sub
    End If
    For Each v In bullets
        Dim b As Bullet
        Set b = v
        If b Is Nothing Then GoTo Continue_each:
        If CheckCollision(player.location, player.Radius, b.location, Bullet_Radius) Then
            Player_Dead player
            Exit Sub
        End If
Continue_each:
    Next
    If Not (bonus Is Nothing) Then
        If bonus.Draw Then
            If CheckCollision(player.location, player.Radius, bonus.location, bonus.Radius) Then
                bonus.Use player, other
            End If
        End If
    End If
End Sub

Private Function Predict(player As player) As Point
    Set Predict = MakePoint(player.location.x + (player.HorizontalSpeed * 70), _
                            player.location.y + (player.VerticalSpeed * 70))
    If Not Bounce Then
        WrapPoint Predict, TopLeft, BottomRight
    Else
        Predict.x = Bounds(Predict.x, TopLeft.x, BottomRight.x)
        Predict.y = Bounds(Predict.y, TopLeft.y, BottomRight.y)
    End If
End Function

Private Sub tmrMove_Timer()
    MovePlayers
End Sub

Public Sub Player_Dead(player As player)
    If player.Ghost > 0 Then Exit Sub
    player.Dead = True
End Sub

Private Sub DrawLives()
    Me.FillColor = Player1.Color
    For i = 1 To Player1.Lives
        Me.Circle (i * 20, 15), 10, RGB(255, 255, 255)
    Next
    Me.FillColor = Player2.Color
    For i = 1 To Player2.Lives
        Me.Circle (i * 20 + 100, 15), 10, RGB(255, 255, 255)
    Next
    Me.Line (0, 40)-(Me.Width, 40), RGB(255, 255, 255)
End Sub

Public Sub EndGame()
    Dim msg As String
    If Player1.Lives > Player2.Lives Then
        msg = "Player 1 Wins!"
        frmEnd.shapeWinner.FillColor = Player1.Color
    ElseIf Player2.Lives > Player1.Lives Then
        msg = "Player 2 Wins!"
        frmEnd.shapeWinner.FillColor = Player2.Color
    Else
        msg = "Tie Game!"
        frmEnd.shapeWinner.FillColor = vbBlack
    End If
    
    frmEnd.lblWinner.Caption = msg
    Unload Me
    frmEnd.Show
End Sub

