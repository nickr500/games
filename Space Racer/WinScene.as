package  {
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class WinScene extends MovieClip {
		var time:int;
		var level:String;
		var is_highscore:Boolean = false;
		public function WinScene(time, level : String) {
			this.time = time;
			this.level = level;
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
			this["btnMenu"].addEventListener(MouseEvent.CLICK, onMenu);
		}
		
		function onStage(e) {
			this["txtTime"].text = "Time: " + util.getTime(this.time);
			var score = util.getHighScore(level);
			if(!score || !score.time || this.time < score.time) {
				this.is_highscore = true;
			}
		}
		
		function onMenu(e) {
			var next = this.is_highscore ? new AddHighScore(this.time, this.level) : new MainMenu();
			parent.addChild(next);
			parent.removeChild(this);
		}

	}
	
}
