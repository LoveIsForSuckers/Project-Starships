package {
	
	import flash.display.MovieClip;
	
	public class shipComponentTooltip extends MovieClip {
		var componentName,label1,label2,label3,label4,label5,label6,swSlotLabel,lwSlotLabel,utSlotLabel,paSlotLabel:infoText;
		var strings:int;
		var stats:Stats;
		var slots:Slots;
		
		public function shipComponentTooltip(layout:int, componentNameString:String, componentStats:Stats, componentSlots:Slots){
						
			stats = componentStats;
			slots = componentSlots;
			
			componentName = new infoText(0xFFFFFFFF);
			componentName.x = componentName.y = 0;
			componentName.SetText(componentNameString);
			
			addChild(componentName);
			
			label1 = new infoText(0xFF00FF00);
			label1.x = 8;
			label1.y = 12;
			label1.SetText("Mass: " + stats.GetMass());
			
			addChild(label1);
			
			if(layout < 4 && layout != 0){
				swSlotLabel = new infoText(0xFF00FF00);
				swSlotLabel.x = 120;
				swSlotLabel.y = 12;
				swSlotLabel.SetText("S.weapons : " + slots.GetSmallWeaponSlots());
				addChild(swSlotLabel);
				
				lwSlotLabel = new infoText(0xFF00FF00);
				lwSlotLabel.x = 120;
				lwSlotLabel.y = 24;
				lwSlotLabel.SetText("L.weapons : " + slots.GetLargeWeaponSlots());
				addChild(lwSlotLabel);
				
				utSlotLabel = new infoText(0xFF00FF00);
				utSlotLabel.x = 120;
				utSlotLabel.y = 36;
				utSlotLabel.SetText("Utility : " + slots.GetUtilitySlots());
				addChild(utSlotLabel);
				
				paSlotLabel = new infoText(0xFF00FF00);
				paSlotLabel.x = 120;
				paSlotLabel.y = 48;
				paSlotLabel.SetText("Passive : " + slots.GetPassiveSlots());
				addChild(paSlotLabel);
			}
			
			switch(layout){
				case 1:
					// Front
					strings = 4;
					
					label2 = new infoText(0xFF00FF00);
					label2.x = 8;
					label2.y = 24;
					label2.SetText("Structure: " + stats.GetStructure());
															
					label3 = new infoText(0xFF00FF00);
					label3.x = 8;
					label3.y = 48;
					label3.SetText("CPU bonus : " + stats.GetCpuBonus());
					
					label4 = new infoText(0xFF00FF00);
					label4.x = 8;
					label4.y = 64;
					label4.SetText("Power bonus: " + stats.GetPower());
					
					addChild(label2);
					addChild(label3);
					addChild(label4);
					
					break;
				case 2:
					// Middle
					strings = 4;
					
					label2 = new infoText(0xFF00FF00);
					label2.x = 8;
					label2.y = 24;
					label2.SetText("Structure: " + stats.GetStructure());
					
					label3 = new infoText(0xFF00FF00);
					label3.x = 8;
					label3.y = 36;
					label3.SetText("Shield: " + stats.GetShield());
					
					label4 = new infoText(0xFF00FF00);
					label4.x = 8;
					label4.y = 48;
					label4.SetText("Power regen: " + stats.GetPowerRegen());
					
					label5 = new infoText(0xFF00FF00);
					label5.x = 8;
					label5.y = 64;
					label5.SetText("Power bonus: " + stats.GetPower());
					
					addChild(label2);
					addChild(label3);
					addChild(label4);
					addChild(label5);
					
					break;
				case 3:
					// Tail
					strings = 3;
					
					label2 = new infoText(0xFF00FF00);
					label2.x = 8;
					label2.y = 24;
					label2.SetText("Structure: " + stats.GetStructure());
					
					label3 = new infoText(0xFF00FF00);
					label3.x = 8;
					label3.y = 36;
					label3.SetText("Engine force: " + stats.GetEngineForce());
					
					addChild(label2);
					addChild(label3);
					
					break;
				default:
					// Part
					break;
			}
			
			backgr.height = 20 * strings + 10;
			backgr.width = 256;
		}
	}
}