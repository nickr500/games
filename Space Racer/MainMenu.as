package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.getClassByAlias;
	import flash.utils.*;
	
	
	public class MainMenu extends MovieClip {
		
		var levels = ['TheBox', 'Slots', 'Windmill', 'Field', 'Spiral', 'Pie', 'Slants'];
		var start_scores = {'TheBox': 20, 'Slots': 16, 'Windmill': 30, 'Field': 10, 'Spiral': 26, 'Pie': 11, 'Slants': 16};
		
		public function MainMenu() {
			for(var level in start_scores) {
				util.addHighScore(level, 'Nick', start_scores[level]);
			}
			btnScores.addEventListener(MouseEvent.CLICK, onScores);
			for each(var l in levels) {
				this[l].addEventListener(MouseEvent.CLICK, function(e:MouseEvent) { Play(e.target.name) });
			}
		}
		function onScores(e) {
			var mc = new HighScores();
			parent.addChild(mc);
			parent.removeChild(this);
		}
		function Play(level:String) {
			var cls:Class = getDefinitionByName(level) as Class;
			var instance:Level = new cls();
			parent.addChild(instance);
			parent.removeChild(this);
		}
		
	}
	
}
