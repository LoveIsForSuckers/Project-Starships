package  {
	
	public class Slots {
		var swSlots,lwSlots,utSlots,paSlots:uint;
		
		public function Slots() {
			SetSlots(0,0,0,0);
		}
		
		public function SetSlots(smallWeapons:uint,largeWeapons:uint,utility:uint,passive:uint){
			swSlots = smallWeapons;
			lwSlots = largeWeapons;
			utSlots = utility;
			paSlots = passive;
		}
		
		public function GetSmallWeaponSlots(){
			return swSlots;
		}
		
		public function GetLargeWeaponSlots(){
			return lwSlots;
		}
		
		public function GetUtilitySlots(){
			return utSlots;
		}
		
		public function GetPassiveSlots(){
			return paSlots;
		}

	}
	
}
