package  {
	
	public class Stats {
		var ste,shi,pow,mas,efc,shr,por,cpu,ser,skr,str,aer,akr,atr:int;
		
		public function Stats() {
			SetStats(0,0,0,0,0,0,0,0,0,0,0,0,0,0);
		}
		
		public function SetStats(structure, shield, power, mass, engineForce, shieldRegen, powerRegen, cpuBonus,shieldElectricResist,shieldThermalResist,shieldKineticResist,armorElectricResist,armorThermalResist,armorKineticResist){
			ste = structure;
			shi = shield;
			pow = power;
			mas = mass;
			efc = engineForce;
			shr = shieldRegen;
			por = powerRegen;
			cpu = cpuBonus;			
			ser = shieldElectricResist;
			skr = shieldKineticResist;
			str = shieldThermalResist;
			aer = armorElectricResist;
			akr = armorKineticResist;
			atr = armorThermalResist;
		}
		
		public function GetStructure(){
			return ste;
		}
		
		public function GetShield(){
			return shi;
		}
		
		public function GetPower(){
			return pow;
		}
		
		public function GetMass(){
			return mas;
		}
		
		public function GetEngineForce(){
			return efc;
		}
		
		public function GetShieldRegen(){
			return shr;
		}
		
		public function GetPowerRegen(){
			return por;
		}
		
		public function GetCpuBonus(){
			return cpu;
		}
		
		public function GetShieldElectricResist(){
			return ser;
		}
		
		public function GetShieldKineticResist(){
			return skr;
		}
		
		public function GetShieldThermalResist(){
			return str;
		}
		
		public function GetArmorElectricResist(){
			return aer;
		}
		
		public function GetArmorKineticResist(){
			return akr;
		}
		
		public function GetArmorThermalResist(){
			return atr;
		}

	}
	
}
