package events {
	import flash.events.Event;
	
	public class updateHangarEvent extends Event {
		var hangarContents:Vector.<String>;
		var hangarNumber:int;

		public function updateHangarEvent(type:String,hNo:int,hItems:Vector.<String>) {
			super(type);
			hangarNumber = hNo;
			hangarContents = hItems;
		}

		public function GetHangarContents():Vector.<String>{
			return hangarContents;
		}
		
		public function GetHangarNumber():int{
			return hangarNumber;
		}
	}
	
}
