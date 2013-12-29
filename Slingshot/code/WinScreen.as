package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class WinScreen extends MovieClip {
		var ltype : Class;
		
		public function WinScreen(cl : Class) {
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
