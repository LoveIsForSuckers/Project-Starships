package events {
	import flash.events.Event;
	
	public class changeSceneEvent extends Event{
		private var newScene:String;
		private var intArg:int;

		public function changeSceneEvent(type:String, sceneName:String, arg:int = 0) {
			// constructor code
			super(type);
			newScene = sceneName;
			intArg = arg;
		}
		
		public function GetNewSceneName():String{
			return newScene;
		}
		
		public function GetArg():int{
			return intArg;
		}

	}
	
}
