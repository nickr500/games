package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	import flash.geom.Point;
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	import flash.events.TimerEvent;
	import flash.utils.getQualifiedClassName;
	
	public class Level extends MovieClip {
		var player1:Player;
		var player2:Player;
		var players:Array = new Array();
		var walls:Array = new Array();
		var maxx:int, maxy:int;
		var timer : Timer = new Timer(1000);
		var timerTxt : TextField = new TextField();
		var txtFormat : TextFormat = new TextFormat('_sans', 32, 0xFFFFFF);
		
		public function Level() {
			this.addEventListener(Event.ENTER_FRAME, onFrame);
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			maxx = this.width;
			maxy = this.height;
			this.player1 = p1;
			this.player2 = p2;
			player1.leftKey = Keyboard.LEFT;
			player1.rightKey = Keyboard.RIGHT;
			player1.upKey = Keyboard.UP;
			player2.leftKey = Keyboard.A;
			player2.rightKey = Keyboard.D;
			player2.upKey = Keyboard.W;
			player2.downKey = Keyboard.S;
			players.push(player1, player2);
			for each(var p:Player in players) {
				p.start = new Point(p.x, p.y);
			}
			for(var i = 0; i < this.numChildren; i++) {
				var mc:DisplayObject = this.getChildAt(i);
				if(mc is Wall) {
					walls.push(mc);
				}
			}
		}
		
		private function onAdd(e) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onUp);
			stage.focus = this;
			var txt : TextField = this.timerTxt;	
			txt.defaultTextFormat = txtFormat;
			txt.selectable = false;
			txt.text = '0:00';
			txt.x = stage.width - txt.width * 2;
			this.addChild(txt);
			
			timer.addEventListener(TimerEvent.TIMER, onTick);
			timer.start();
		}
		
		private function onTick(e : TimerEvent) {
			var m : String = Math.floor(timer.currentCount / 60).toString();
			var s : String = (timer.currentCount % 60).toString();
			if(s.length < 2)
				s = '0' + s;
			this.timerTxt.text = m + ':' + s;
		}
		
		private function onDown(e:KeyboardEvent) {
			setPressed(e.keyCode, true);
		}
		
		function onUp(e:KeyboardEvent) {
			setPressed(e.keyCode, false);
		}
		
		function onFrame(e) {
			var dead = false;
			for each(var player:Player in players) {
				if(player.CheckCollision(this.goal, false)) {
					End(player.WinScene);
					return;
				}
				if(player.x < 0 || player.x > maxx || 
				   player.y < 0 || player.y > maxy) {
						player.Die(); 
						player.x = player.start.x;
						player.y = player.start.y;
						continue;
				}
				for each(var wall:MovieClip in walls) {
					if(player.CheckCollision(wall)) {
						player.Die(); 
						player.x = player.start.x;
						player.y = player.start.y;
					}
				}
			}
		}
		
		function End(scene:Class) {
			timer.stop();
			this.removeEventListener(Event.ENTER_FRAME, onFrame);
			Main.keys = new Dictionary();
			parent.addChild(new scene(timer.currentCount, flash.utils.getQualifiedClassName(this)));
			parent.removeChild(this);
		}
		
		function isPressed(key:uint):Boolean {
			return Main.keys[key];
		}
		
		function setPressed(key:uint, val:Boolean):void {
			Main.keys[key] = val;
		}
		
	}
	
}
