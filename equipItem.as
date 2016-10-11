package  {
	
	public class equipItem extends basicItem {
		var stats:Stats;
		var abilityStrength,abilityCost,abilitySpecial,abilityRange:int;
		var ability:String;
		
		public function equipItem(iId:String) {
			stats = new Stats();
			itemId = iId;
			actType = 0;
			tradeType = 5; // 0 = agrarian, 1 = ores, 2 = industrial, 3 = scientifical, 4 = luxury, 5 = ship equipment
			if(itemId == "Random Equipment"){
				itemId = GetRandomEquip();
			}
			createItemById(itemId);
		}
		
		function createItemById(idd){
			switch(idd){
				case "Micrometeorite Gun":
					actType = 1;
					stats.SetStats(0,0,-10,5,0,0,0,-5,0,0,0,0,0,0);
					ability = "Kinetic Damage";
					abilityRange = 2;
					abilityStrength = 10;
					abilitySpecial = 4;
					abilityCost = 0;
					Cost = 17187;
					break;
				case "Giant Buster Gun":
					actType = 2;
					stats.SetStats(0,0,-30,40,0,0,0,-5,0,0,0,0,0,0);
					ability = "Kinetic Damage";
					abilityRange = 3;
					abilityStrength = 90;
					abilitySpecial = 1;
					abilityCost = 20;
					Cost = 32318;
					break;
				case "Light Artillery":
					actType = 1;
					stats.SetStats(0,0,-10,10,0,0,0,-5,0,0,0,0,0,0);
					ability = "Kinetic Damage";
					abilityRange = 4;
					abilityStrength = 30;
					abilitySpecial = 1;
					abilityCost = 5;
					Cost = 17241;
					break;
				case "Electron Blaster":
					actType = 1;
					stats.SetStats(0,0,-15,10,0,0,0,-10,0,0,0,0,0,0);
					ability = "Electric Damage";
					abilityRange = 3;
					abilityStrength = 40;
					abilitySpecial = 1;
					abilityCost = 15;
					Cost = 12692;
					break;
				case "Thermal Blaster":
					actType = 1;
					stats.SetStats(0,0,-15,10,0,0,0,-10,0,0,0,0,0,0);
					ability = "Thermal Damage";
					abilityRange = 3;
					abilityStrength = 40;
					abilitySpecial = 1;
					abilityCost = 15;
					Cost = 12692;
					break;
				case "200mm Armor Plate":
					actType = 4;
					stats.SetStats(20,0,0,20,0,0,0,0,0,0,0,0,0,0);
					ability = "Passive";
					Cost = 8922;
					break;
				case "200mm Kanvium Plate":
stats.SetStats(25,0,0,20,0,0,0,0,0,0,0,1,1,1);
ability = "Passive";
Cost = 25930; actType = 4; break;
				case "400mm Armor Plate":
stats.SetStats(40,0,0,40,0,0,0,0,0,0,0,0,0,0);
ability = "Passive";
Cost = 10503; actType = 4; break;
				case "400mm Kanvium Plate":
stats.SetStats(50,0,0,40,0,0,0,0,0,0,0,1,1,1);
ability = "Passive";
Cost = 30034; actType = 4; break;
				case "Shield Booster A1":
stats.SetStats(0,0,0,10,0,0,0,-40,0,0,0,0,0,0);
ability = "Shield boost";abilityRange = 0; abilityStrength = 10; abilitySpecial = 1; abilityCost = 10;
Cost = 8588; actType = 3; break;
				case "Shield Booster A2":
stats.SetStats(0,0,0,10,0,0,0,-40,0,0,0,0,0,0);
ability = "Shield boost";abilityRange = 0; abilityStrength = 20; abilitySpecial = 1; abilityCost = 20;
Cost = 383844; actType = 3; break;
				case "Nanite Repair System":
stats.SetStats(0,0,-10,20,0,0,0,-10,0,0,0,0,0,0);
ability = "Armor repair";abilityRange = 0; abilityStrength = 10; abilitySpecial = 1; abilityCost = 10;
Cost = 23432; actType = 3; break;
				case "N4N1-T3 Field Repair":
stats.SetStats(0,0,-10,50,0,0,0,-10,0,0,0,0,0,0);
ability = "Armor repair";abilityRange = 0; abilityStrength = 20; abilitySpecial = 1; abilityCost = 35;
Cost = 226090; actType = 3; break;
				case "E-W Remote Disruptor":
stats.SetStats(0,0,0,10,0,0,0,-15,0,0,0,0,0,0);
ability = "System hack";abilityRange = 5; abilityStrength = 30; abilitySpecial = 0; abilityCost = 5;
Cost = 20980; actType = 3; break;
				case "Control Destabilizer":
stats.SetStats(0,0,0,10,0,0,0,-10,0,0,0,0,0,0);
ability = "System hack";abilityRange = 5; abilityStrength = 35; abilitySpecial = 0; abilityCost = 5;
Cost = 91518; actType = 3; break;
				case "Stasis Beam Generator":
stats.SetStats(0,0,-5,10,0,0,0,-5,0,0,0,0,0,0);
ability = "Slow";abilityRange = 3; abilityStrength = 1; abilitySpecial = 1; abilityCost = 5;
Cost = 32545; actType = 3; break;
				case "E-W Stasis Entangler":
stats.SetStats(0,0,-10,15,0,0,0,-10,0,0,0,0,0,0);
ability = "Slow";abilityRange = 2; abilityStrength = 3; abilitySpecial = 1; abilityCost = 10;
Cost = 61887; actType = 3; break;
				case "Remote Stasis Projector":
stats.SetStats(0,0,-10,15,0,0,0,-10,0,0,0,0,0,0);
ability = "Slow";abilityRange = 6; abilityStrength = 1; abilitySpecial = 1; abilityCost = 5;
Cost = 53775; actType = 3; break;
				case "Ext. Power Core Mk.2":
stats.SetStats(0,0,35,10,0,0,5,-15,0,0,0,0,0,0);
ability = "Passive";
Cost = 116582; actType = 4; break;
				case "External Power Core":
					actType = 4;
					stats.SetStats(0,0,30,10,0,0,5,-5,0,0,0,0,0,0);
					ability = "Passive";
					Cost = 29635;
					break;
				case "Energy Diag. System":
stats.SetStats(0,0,10,10,0,0,10,0,0,0,0,0,0,0);
ability = "Passive";
Cost = 14524; actType = 4; break;
				case "Shield Projection Amp.":
					actType = 4;
					stats.SetStats(0,35,-30,10,0,0,0,-20,0,0,0,0,0,0);
					Cost = 21701;
					ability = "Passive";
					break;
				case "M44 Shield Projection":
stats.SetStats(0,60,-30,15,0,0,0,-25,0,0,0,0,0,0);
ability = "Passive";
Cost = 42081; actType = 4; break;
				case "M60 Heavy Shield":
stats.SetStats(0,90,-35,50,0,0,0,-30,0,0,0,0,0,0);
ability = "Passive";
Cost = 209272; actType = 4; break;
				case "Shock Dampeners":
					actType = 4;
					stats.SetStats(0,0,0,25,0,0,0,-5,5,0,0,5,0,0);
					ability = "Passive";
					Cost = 31879;
					break;
				case "Heat Dispensers":
stats.SetStats(0,0,0,25,0,0,0,-5,0,0,5,0,0,5);
ability = "Passive";
Cost = 31879; actType = 4; break;
				case "Repulsor Barriers":
stats.SetStats(0,0,0,20,0,0,-1,-5,0,5,0,0,5,0);
ability = "Passive";
Cost = 30861; actType = 4; break;
				case "R2 Subprocessor":
					actType = 4;
					stats.SetStats(0,0,-5,5,0,0,0,20,0,0,0,0,0,0);
					ability = "Passive";
					Cost = 10589;
					break;
				case "R3 Subprocessor":
stats.SetStats(0,0,-5,5,0,0,0,25,0,0,0,0,0,0);
ability = "Passive";
Cost = 125265; actType = 4; break;
				case "Deflection Catalyst":
					actType = 4;
					stats.SetStats(0,0,0,10,0,0,0,-10,1,2,3,0,0,0);
					ability = "Passive";
					Cost = 16208;
					break;
				case "Tri-Stront Coating":
					actType = 4;
					stats.SetStats(0,0,0,20,0,0,0,0,0,0,0,0,0,5);
					ability = "Passive";
					Cost = 18952;
					break;
				case "Ablative Coating":
stats.SetStats(0,0,0,15,0,0,0,0,0,0,0,0,0,5);
ability = "Passive";
Cost = 16761; actType = 4; break;
				case "Polymer Coating":
stats.SetStats(0,0,0,10,0,0,0,0,0,0,0,5,0,0);
ability = "Passive";
Cost = 14530; actType = 4; break;
				case "Shield Recharger":
stats.SetStats(0,0,0,10,0,3,0,-5,0,0,0,0,0,0);
ability = "Passive";
Cost = 13770; actType = 4; break;
				case "Shield Pump Control":
stats.SetStats(0,0,0,15,0,10,-5,-10,0,0,0,0,0,0);
ability = "Passive";
Cost = 43178; actType = 4; break;
				case "Auxiliary Booster":
					actType = 4;
					stats.SetStats(0,0,-30,30,150,0,-5,-5,0,0,0,0,0,0);
					ability = "Passive";
					Cost = 26555;
					break;
				case "Neutron Turbine":
stats.SetStats(0,0,-40,40,225,0,-5,-5,0,0,0,0,0,0);
ability = "Passive";
Cost = 89336; actType = 4; break;
				case "Food":
					tradeType = 0;
					Cost = 100;
					break;
				case "Organic Materials":
					tradeType = 0;
					Cost = 150;
					break;
				case "Alcohol":
					tradeType = 0;
					Cost = 200;
					break;
				case "Common Ores":
					tradeType = 1;
					Cost = 50;
					break;
				case "Kanvium Ore":
					tradeType = 1;
					Cost = 250;
					break;
				case "Noble Gas":
					tradeType = 1;
					Cost = 300;
					break;
				case "Tri-Stront Ore":
					tradeType = 1;
					Cost = 350;
					break;
				case "Construction Blocks":
					tradeType = 2;
					Cost = 400;
					break;
				case "Mechanical Parts":
					tradeType = 2;
					Cost = 450;
					break;
				case "Scrap Metal":
					tradeType = 2;
					Cost = 150;
					break;
				case "Chemicals":
					tradeType = 2;
					Cost = 550;
					break;
				case "Medicals":
					tradeType = 3;
					Cost = 150;
					break;
				case "Electronics":
					tradeType = 3;
					Cost = 600;
					break;
				case "Data Cores":
					tradeType = 3;
					Cost = 800;
					break;
				case "Luxury":
					tradeType = 4;
					Cost = 1000;
					break;
				default:
					break;
			}
		}
		
		function GetRandomEquip():String{
			var amt = 37;
			var temp:String;
			var rnd = int(Math.random() * amt)
			switch(rnd){
				case 0:
					temp = "Micrometeorite Gun";
					break;
				case 1:
					temp = "Giant Buster Gun";
					break;
				case 2: 
					temp = "Light Artillery";
					break;
				case 3:
					temp = "Electron Blaster";
					break;
				case 4:
					temp = "Thermal Blaster";
					break;
				case 5:
					temp = "200mm Armor Plate";
					break;
				case 6:
					temp = "200mm Kanvium Plate";
					break;
				case 7:
					temp = "400mm Armor Plate";
					break;
				case 8:
					temp = "400mm Kanvium Plate";
					break;
				case 9:
					temp = "Shield Booster A1";
					break;
				case 10:
					temp = "Shield Booster A2"; 
					break;
				case 11:
					temp = "Nanite Repair System";
					break;
				case 12:
					temp = "N4N1-T3 Field Repair";
					break;
				case 13:
					temp = "E-W Remote Disruptor";
					break;
				case 14:
					temp = "Control Destabilizer";
					break;
				case 15:
					temp = "Stasis Beam Generator";
					break;
				case 16: 
					temp = "E-W Stasis Entangler";
					break;
				case 17: 
					temp = "Remote Stasis Projector";
					break;
				case 18:
					temp = "Ext. Power Core Mk.2";
					break;
				case 19:
					temp = "External Power Core";
					break;
				case 20:
					temp = "Energy Diag. System";
					break;
				case 21:
					temp = "Shield Projection Amp.";
					break;
				case 22:
					temp = "M44 Shield Projection";
					break;
				case 23:
					temp = "M60 Heavy Shield";
					break;
				case 24:
					temp = "Shock Dampeners";
					break;
				case 25:
					temp = "Heat Dispensers";
					break;
				case 26:
					temp = "Repulsor Barriers";
					break;
				case 27:
					temp = "R2 Subprocessor";
					break;
				case 28:
					temp = "R3 Subprocessor";
					break;
				case 29: 
					temp = "Deflection Catalyst";
					break;
				case 30:
					temp = "Tri-Stront Coating";
					break;
				case 31:
					temp = "Ablative Coating";
					break;
				case 32:
					temp = "Polymer Coating";
					break;
				case 33:
					temp = "Shield Recharger";
					break;
				case 34:
					temp = "Shield Pump Control";
					break;
				case 35:
					temp = "Auxiliary Booster";
					break;
				case 36:
					temp = "Neutron Turbine";
					break;
				default:
					temp = "200mm Armor Plate";
					break;
			}
			return temp;
		}

	}
	
}
