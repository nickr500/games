package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class HelpScreen extends MovieClip {
		
		
		public function HelpScreen() {
			btnMenu.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		function onClick(e) {
			parent.addChild(new MainMenu());
			parent.removeChild(this);
		}
	}
	
}
