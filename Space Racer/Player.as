package  {
	import flash.geom.Vector3D;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Player extends Movable {
		const rotationSpeed:Number = .2;
		const acceleration:Number = .35;
		const deceleration:Number = 0.02
		public var start:Point;
		public var upKey:uint;
		public var downKey:uint;
		public var leftKey:uint;
		public var rightKey:uint;
		public function get WinScene() : Class {
			return this is PlayerBlue ? BlueWin : RedWin
		}
		public function get Front() : Point {
			return this.localToGlobal(new Point(0, 11));
		}
		public function get TopRight() : Point {
			return this.localToGlobal(new Point(12, -16));
		}
		public function get TopLeft() : Point {
			return this.localToGlobal(new Point(-12, -11));
		}
		var _flames:Boolean = false;
		public function get Flames() : Boolean {
			return _flames;
		}
		public function set Flames(val : Boolean) : void {
			if(val == _flames)
				return;
			_flames = val;
			if(val) {
				this.gotoAndPlay(2);
			} else {
				this.gotoAndPlay(1);
			}
		}
		var _angle:Number = 0;
		public function get angle() : Number {
			return _angle
		}
		public function set angle(val : Number) {
			val %= Math.PI * 2;
			_angle = val;
			this.rotation = degrees(angle) - 90;
		}
		
		public function Player() {
			this.addEventListener(Event.ENTER_FRAME, onFrame);
			this.angle = 0;
		}
		
		public function CheckCollision(mc : MovieClip, precise:Boolean = true) : Boolean {
			return  mc.hitTestPoint(this.Front.x, this.Front.y, precise) ||
					mc.hitTestPoint(this.TopRight.x, this.TopRight.y, precise) ||
					mc.hitTestPoint(this.TopLeft.x, this.TopLeft.y, precise);
		}

		public function Die() : void {
			this.velocity = new Vector3D();
			this.angle = 0;
		}
			
		function onFrame(e) {
			if(isPressed(leftKey))
				this.angle -= rotationSpeed;
			else if(isPressed(rightKey))
				this.angle += rotationSpeed;
			if(isPressed(upKey))
				this.velocity = velocity.add(getDirection(this.angle, acceleration));
			else 
				this.velocity.scaleBy(1 - deceleration);
			this.Flames = isPressed(upKey);
		}
		
		static function isPressed(key:uint) : Boolean { return Main.keys[key]; }
		static function getDirection(angle:Number, amt:Number) : Vector3D {
			var nv:Vector3D = new Vector3D(Math.cos(angle), Math.sin(angle));
			nv.scaleBy(amt);
			return nv;
		}
		static function setLength(vec:Vector3D, val:Number) : void {
			vec.scaleBy(val / vec.length);
		}
		static function degrees(rad : Number) : Number {
			return rad * (180 / Math.PI);
		}
		static function radians(deg : Number) : Number {
			return deg * (Math.PI / 180);
		}
	}
	
}
