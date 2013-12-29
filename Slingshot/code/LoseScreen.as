package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class LoseScreen extends MovieClip {
		var ltype : Class;
		
		public function LoseScreen(cl : Class) {
			this.ltype = cl;
			this.btnPlay.addEventListener(MouseEvent.CLICK, onPlay);
			this.btnMenu.addEventListener(MouseEvent.CLICK, onMenu);
		}
		
		function onPlay(e) {
			parent.addChild(new ltype());
			parent.removeChild(this);
		}
		
		function onMenu(e) {
			parent.addChild(new MainMenu());
			parent.removeChild(this);
		}
	}
	
}
