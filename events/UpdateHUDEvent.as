package  events{
	
	import flash.events.Event;
	
	public class UpdateHUDEvent extends Event{
		private var heroX,heroY;
		public function UpdateHUDEvent(type:String, X, Y) {
			// constructor code
			super(type);
			heroX = X;
			heroY = Y;
		}

		public function getX(){
			return heroX;
		}
		public function getY(){
			return heroY;
		}

	}
	
}
