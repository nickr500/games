package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class HighScores extends MovieClip {
		
		
		public function HighScores() {
			this.btnMenu.addEventListener(MouseEvent.CLICK, onMenu);
			var scores = util.getScores();
			if(!scores) return;
			txtList.text = "";
			for(var level in scores) {
				var info = util.getHighScore(level);
				txtList.appendText(level + " - " + util.getTime(info.time).toString() +  " by " + info.person + "\n");
			}
		}
		
		function onMenu(e) {
			var next = new MainMenu();
			parent.addChild(next);
			parent.removeChild(this);
		}
	}
	
}
