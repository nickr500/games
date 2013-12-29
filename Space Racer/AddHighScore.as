package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	
	public class AddHighScore extends MovieClip {
		var time:int;
		var level:String;
		public function AddHighScore(time, level) {
			this.time = time;
			this.level = level;
			if(util.lastPerson)
				txtName.text = util.lastPerson;
			btnMenu.addEventListener(MouseEvent.CLICK, onMenu);
		}
		
		function onMenu(e) {
			util.addHighScore(this.level, txtName.text, this.time);
			util.lastPerson = txtName.text;
			var next = new MainMenu();
			parent.addChild(next);
			parent.removeChild(this);
		}
	}
	
}
