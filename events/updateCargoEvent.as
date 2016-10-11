package events {
	import flash.events.Event;
	
	public class updateCargoEvent extends Event {
		var hangarContents:Vector.<String>;

		public function updateCargoEvent(type:String,hItems:Vector.<String>) {
			super(type);
			hangarContents = hItems;
		}

		public function GetHangarContents():Vector.<String>{
			return hangarContents;
		}
	}
	
}
