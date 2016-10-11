package  {
	import flash.display.MovieClip;
	
	public class StatsDisplay extends MovieClip {
		var structure,shield,power,mass,engineForce,shieldRegen,powerRegen,cpuBonus,armorResist,shieldResist,structureLabel,shieldLabel,powerLabel,massLabel,engineForceLabel,cpuBonusLabel,armorResistLabel,shieldResistLabel:infoText;
		
		public function StatsDisplay(stats:Stats) {
			structureLabel = new infoText(0xFFFFFFFF);
			structureLabel.SetText("Structure: ");
			structureLabel.x = 12;
			structureLabel.y = 36;
			
			shieldLabel = new infoText(0xFFFFFFFF);
			shieldLabel.SetText("Shield: ");
			shieldLabel.x = 12;
			shieldLabel.y = 50;
			
			powerLabel = new infoText(0xFFFFFFFF);
			powerLabel.SetText("Power: ");
			powerLabel.x = 12;
			powerLabel.y = 64;
			
			massLabel = new infoText(0xFFFFFFFF);
			massLabel.SetText("Mass: ");
			massLabel.x = 12;
			massLabel.y = 78;
			
			engineForceLabel = new infoText(0xFFFFFFFF);
			engineForceLabel.SetText("Engine force: ");
			engineForceLabel.x = 12;
			engineForceLabel.y = 92;
			
			cpuBonusLabel = new infoText(0xFFFFFFFF);
			cpuBonusLabel.SetText("CPU: ");
			cpuBonusLabel.x = 12;
			cpuBonusLabel.y = 106;
			
			armorResistLabel = new infoText(0xFFFFFFFF);
			armorResistLabel.SetText("Resists: Armor:");
			armorResistLabel.x = 12;
			armorResistLabel.y = 120;
			
			shieldResistLabel = new infoText(0xFFFFFFFF);
			shieldResistLabel.SetText("(E/K/T)  Shield:");
			shieldResistLabel.x = 12;
			shieldResistLabel.y = 134;
			
			addChild(structureLabel);
			addChild(shieldLabel);
			addChild(powerLabel);
			addChild(massLabel);
			addChild(engineForceLabel);
			addChild(cpuBonusLabel);
			addChild(armorResistLabel);
			addChild(shieldResistLabel);
			
			update(stats);
		}
		
		public function HasValidStats():Boolean{
			if( int(power.textStr.text) < 0){
				return false;
			}
			if( int(powerRegen.textStr.text) < 0){
				return false;
			}
			if( int(cpuBonus.textStr.text) < 0){
				return false;
			}
			return true;
		}
		
		public function update(stats:Stats){
			if(this.numChildren > 10){
				removeChild(structure);
				removeChild(shield);
				removeChild(power);
				removeChild(mass);
				removeChild(engineForce);
				removeChild(shieldRegen);
				removeChild(powerRegen);
				removeChild(cpuBonus);
				removeChild(armorResist);
				removeChild(shieldResist);
			}
			
			structure = new infoText(0xFF00FF00);
			structure.SetText(stats.GetStructure());
			structure.x = 100;
			structure.y = 36;
			
			shield = new infoText(0xFF00FF00);
			shield.SetText(stats.GetShield());
			shield.x = 100;
			shield.y = 50;
			
			power = new infoText(0xFF00FF00);
			power.SetText(stats.GetPower());
			if( int(power.textStr.text) < 0){
				power.SetColor(0xFFFF0000);
			}
			power.x = 100;
			power.y = 64;
			
			mass = new infoText(0xFF00FF00);
			mass.SetText(stats.GetMass());
			mass.x = 100;
			mass.y = 78;
			
			engineForce = new infoText(0xFF00FF00);
			engineForce.SetText(stats.GetEngineForce());
			engineForce.x = 100;
			engineForce.y = 92;
			
			shieldRegen = new infoText(0xFF00FF00);
			shieldRegen.SetText("(+ "+stats.GetShieldRegen()+")");
			shieldRegen.x = 128;
			shieldRegen.y = 50;
			
			powerRegen = new infoText(0xFF00FF00);
			powerRegen.SetText("(+ "+stats.GetPowerRegen()+")");
			if( int(powerRegen.textStr.text) < 0){
				powerRegen.SetColor(0xFFFF0000);
			}
			powerRegen.x = 128;
			powerRegen.y = 64;
			
			cpuBonus = new infoText(0xFF00FF00);
			cpuBonus.SetText(stats.GetCpuBonus());
			if( int(cpuBonus.textStr.text) < 0){
				cpuBonus.SetColor(0xFFFF0000);
			}
			cpuBonus.x = 100;
			cpuBonus.y = 106;
			
			armorResist = new infoText(0xFF00FF00);
			armorResist.SetText(stats.GetArmorElectricResist() + " / " + stats.GetArmorKineticResist() + " / " + stats.GetArmorThermalResist());
			armorResist.x = 100;
			armorResist.y = 120;
			
			shieldResist = new infoText(0xFF00FF00);
			shieldResist.SetText(stats.GetShieldElectricResist() + " / " + stats.GetShieldKineticResist() + " / " + stats.GetShieldThermalResist());
			shieldResist.x = 100;
			shieldResist.y = 134;
			
			
			addChild(structure);
			addChild(shield);
			addChild(power);
			addChild(mass);
			addChild(engineForce);
			addChild(shieldRegen);
			addChild(powerRegen);
			addChild(cpuBonus);
			addChild(armorResist);
			addChild(shieldResist);
		}

	}
	
}
