package  {
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	public class Line extends MovieClip {
		public function get isVertical() : Boolean {
			return this is VerticalLine;
		}
		public function get point1() : Point {
			return new Point(this.x, this.y);
		}
		public function get point2() : Point {
			return new Point(this.isVertical ? this.x : this.x + this.width, 
							 this.isVertical ? this.y + this.height : this.y);
		}
		public function Line() {
			// constructor code
		}

	}
	
}
