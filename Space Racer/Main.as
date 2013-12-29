package  {
	
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	
	
	public class Main extends MovieClip {
		public static var keys:Dictionary = new Dictionary();
		
		public function Main() {
			this.addChild(new MainMenu());
		}
	}
	
}
