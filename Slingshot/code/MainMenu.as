package  {
	
	import flash.display.MovieClip;
	import fl.controls.List;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.data.SimpleCollectionItem;
	import fl.events.ListEvent;
	
	
	public class MainMenu extends MovieClip {
		static var assoc = { "Easy": EasyLevel, "Moving Target": MovingLevel, "The cake is a lie": Level2, 
							 "Companion Cube": Portal2, "Tricky": Level1, "The Box": BoxLevel,
							 "Tunnel": Level4, "Tunnel, Part 2": Level3,
							 "Wall Jump": BouncePortal}
		
		public function MainMenu() {
			this.levels.addEventListener(Event.CHANGE, onChange);
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			btnHelp.addEventListener(MouseEvent.CLICK, onHelp);
		}
		
		function onHelp(e) {
			parent.addChild(new HelpScreen());
			parent.removeChild(this);
		}
		
		function onAdd(e) {
			for(var lvl in assoc) {
				this.levels.addItem({label: lvl});
			}
		}
		
		function onChange(e) {
			var l:List = levels;
			if(!l.selectedItem)
				return;
			var lvl:MovieClip = new assoc[l.selectedItem.label]();
			parent.addChild(lvl);
			parent.removeChild(this);
		}
	}
	
}
