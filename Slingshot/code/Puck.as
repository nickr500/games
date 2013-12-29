package  {
	
	import flash.display.MovieClip;
	import flash.geom.Vector3D;
	
	
	public class Puck extends MovieClip {
		public var velocity:Vector3D = new Vector3D();
		public var restitution:Number = 0.8;
		public function get left() : Number { return this.x - this.width/2; }
		public function set left(val:Number) { this.x = val + this.width/2 }
		public function get right() : Number { return this.x + this.width/2; }
		public function set right(val:Number) { this.x = val - this.width/2 }
		public function get top() : Number { return this.y - this.height/2; }
		public function set top(val:Number) { this.y = val + this.height/2; }
		public function get bottom() : Number { return this.y + this.height/2; }
		public function set bottom(val:Number) { this.y = val - this.height/2; }
		public function Puck() {
			// constructor code
		}
	}
	
}
