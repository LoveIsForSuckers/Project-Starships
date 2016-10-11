package events {
	import flash.events.Event;
	
	public class IntegerEvent extends Event {
		var eValue,eValue2:int;
		
		public function IntegerEvent(type, arg:int = 0, arg2:int = 0) {
			super(type,true);
			eValue = arg;
			eValue2 = arg2;
		}
		
		public function GetArg():int{
			return eValue;
		}
		
		public function GetArg2():int{
			return eValue2;
		}

	}
	
}
