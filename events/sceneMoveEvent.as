package  events {
	
	import flash.events.Event;
	
	public class sceneMoveEvent extends Event{
		private var scspdX,scspdY;
		public function sceneMoveEvent(type:String,X,Y) {
			// constructor code
			super(type);
			scspdX = X;
			scspdY = Y;
		}

		public function getX(){
			return scspdX;
		}
		public function getY(){
			return scspdY;
		}
	}
	
}
