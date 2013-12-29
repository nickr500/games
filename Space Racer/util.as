package  {
	import flash.net.SharedObject;
	import flash.utils.Dictionary;
	
	public class util {

		public static function get lastPerson() : String {
			return SharedObject.getLocal("ndrioux-targets-online", "/").data.lastPerson;
		}
		public static function set lastPerson(val : String) : void {
			var so = SharedObject.getLocal("ndrioux-targets-online", "/");
			so.data.lastPerson = val;
			so.flush();
		}

		public static function addHighScore(level : String, person : String, time : int) {
			var so : SharedObject = SharedObject.getLocal("ndrioux-targets-online", "/");
			var scores:Dictionary = so.data.scores;
			var people:Dictionary = so.data.people;
			if(!scores) {
				scores = new Dictionary();
				so.data.scores = scores;
			}
			if(!people) {
				people = new Dictionary();
				so.data.people = people;
			}
			if(!scores[level] || scores[level] > time) {
				scores[level] = time;
				people[level] = person;
			}
			so.flush();
		}
		
		public static function getHighScore(level : String) {
			var so : SharedObject = SharedObject.getLocal("ndrioux-targets-online", "/");
			var scores:Dictionary = so.data.scores;
			var people:Dictionary = so.data.people;
			if(!scores || !people)
				return null;
			return {"person": people[level], "time": scores[level]};
		}
		
		public static function clearHighScore() {
			var so : SharedObject = SharedObject.getLocal("ndrioux-targets-online", "/");
			so.data.scores = new Dictionary();
			so.data.people = new Dictionary();
			so.flush();
		}
		
		public static function getScores() {
			var so : SharedObject = SharedObject.getLocal("ndrioux-targets-online", "/");
			return so.data.scores;
		}
		
		public static function getTime(seconds:int) : String {
			var m = Math.floor(seconds / 60);
			var s = seconds % 60;
			return m.toString() + ":" + (s < 10 ? "0" : "") + s.toString();
		}

	}
	
}
