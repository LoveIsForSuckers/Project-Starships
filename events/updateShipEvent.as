package  events{
	import flash.events.Event;
	import flash.display.BitmapData;
	
	public class updateShipEvent extends Event{
		var shipEquipment:Vector.<equipItem>;
		var shipStats:Stats;
		var shipSlots:Slots;
		var shipMini:BitmapData;
		var constrCode:int;
		
		public function updateShipEvent(type:String, sEquip:Vector.<equipItem>, sStats:Stats, sSlots:Slots, sMini:BitmapData, code:int) {
			// constructor code
			super(type);
			shipEquipment = sEquip;
			shipStats = sStats;
			shipSlots = sSlots;
			shipMini = sMini;
			constrCode = code;
		}
		
		public function GetEquipment():Vector.<equipItem>{
			return shipEquipment;
		}
		
		public function GetStats():Stats{
			return shipStats;
		}
		
		public function GetSlots():Slots{
			return shipSlots;
		}
		
		public function GetMini():BitmapData{
			return shipMini;
		}
		
		public function GetConstructionCode():int{
			return constrCode;
		}

	}
	
}
