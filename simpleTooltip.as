package  {
	import flash.display.MovieClip;
	
	public class simpleTooltip extends MovieClip {
		var componentName:infoText;
		var labels:Vector.<infoText>;
		var strings,layout:int;
		var stats:Stats;
		var thing:equipItem;
		var showCost;
		
		public function simpleTooltip(layTyp:int, eName:String, eItem:equipItem, displayCost = 0) {
			showCost = displayCost;
			strings = 0;
			labels = new Vector.<infoText>;
			
			layout = layTyp;
			thing = eItem;
			stats = thing.stats;
			
			componentName = new infoText(0xFFFFFFFF);
			componentName.x = componentName.y = 0;
			componentName.SetText(eName);
			
			addChild(componentName);
			
			CreateStrings();
			
			backgr.height = 15 * strings + 13;
			backgr.width = 160;
			
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		function CreateStrings(){
			var tmp = stats.GetMass();
			var lbl:infoText;
		
			if(showCost != 0){
				var calcPrice = int(thing.Cost * showCost);
				lbl = new infoText(0xFFFFFF00);
				lbl.SetText("Cost: " + calcPrice);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			if(tmp != 0){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("Mass: " + tmp);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			tmp = stats.GetStructure();
			if(tmp != 0){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("Structure: " + tmp);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			tmp = stats.GetShield();
			if(tmp != 0){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("Shield: " + tmp);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			tmp = stats.GetPower();
			if(tmp != 0){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("Power: " + tmp);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			tmp = stats.GetEngineForce();
			if(tmp != 0){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("Engine force: " + tmp);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			tmp = stats.GetShieldRegen();
			if(tmp != 0){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("Shield Regen: " + tmp);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			tmp = stats.GetPowerRegen();
			if(tmp != 0){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("PowerRegen: " + tmp);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			tmp = stats.GetCpuBonus();
			if(tmp != 0){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("CPU: " + tmp);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			if(stats.GetArmorElectricResist() != 0 || stats.GetArmorKineticResist() != 0 || stats.GetArmorThermalResist() != 0){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("Armor res. (E/K/T): " + stats.GetArmorElectricResist() + " / " + stats.GetArmorKineticResist() + " / " + stats.GetArmorThermalResist());
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			if(stats.GetShieldElectricResist() != 0 || stats.GetShieldKineticResist() != 0 || stats.GetShieldThermalResist() != 0){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("Shield res. (E/K/T): " + stats.GetShieldElectricResist() + " / " + stats.GetShieldKineticResist() + " / " + stats.GetShieldThermalResist());
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			if(layout == 0){
				strings += 1;
					
				lbl = new infoText(0xFF00FF00);
				lbl.x = 8;
				lbl.y = 12 * strings;
				lbl.SetText("Trade Good");
				labels.push(lbl);
				
				addChild(lbl);
			}
			
			if(layout == 1 || layout == 2){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText(thing.ability);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 + 12 * strings;
				labels.push(lbl);
				addChild(lbl);
				
				lbl = new infoText(0xFF00FF00);
				var str:String;
				if(thing.abilitySpecial > 1){
					str = "Dmg: " + thing.abilitySpecial + "x" + thing.abilityStrength;
				} else {
					str = "Dmg: " + thing.abilityStrength;
				}
				lbl.SetText(str);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 + 12 * strings;
				labels.push(lbl);
				addChild(lbl);
				
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("Range: " + thing.abilityRange);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 + 12 * strings;
				labels.push(lbl);
				addChild(lbl);
				
				
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("Power use: " + thing.abilityCost);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 + 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}
			
			if(layout == 3){
				lbl = new infoText(0xFF00FF00);
				lbl.SetText(thing.ability);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 + 12 * strings;
				labels.push(lbl);
				addChild(lbl);
				
				lbl = new infoText(0xFF00FF00);
				str = "Ability Value: " + thing.abilityStrength;
				lbl.SetText(str);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 + 12 * strings;
				labels.push(lbl);
				addChild(lbl);
				
				lbl = new infoText(0xFF00FF00);
				if(thing.abilityRange == 0){
					str = "Range: SELF";
				} else {
					str = "Range: " + thing.abilityRange;
				}
				lbl.SetText(str);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 +  12 * strings;
				labels.push(lbl);
				addChild(lbl);
				
				lbl = new infoText(0xFF00FF00);
				lbl.SetText("Power use: " + thing.abilityCost);
				strings += 1;
				lbl.x = 8;
				lbl.y = 12 + 12 * strings;
				labels.push(lbl);
				addChild(lbl);
			}			
		}

	}
	
}
