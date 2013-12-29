package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class Movable extends MovieClip {
		public var velocity:Vector3D = new Vector3D();
		
		public function Movable() {
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		private function onFrame(e) {
			this.x += this.velocity.x;
			this.y += this.velocity.y;
		}

	}
	
}
