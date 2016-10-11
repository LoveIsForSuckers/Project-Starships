package  {
	
	import flash.display.MovieClip;	
	
	public class Assembly extends MovieClip {
		var fd,md,td:MovieClip;
		var slots:Slots;
		var equippedItems:Vector.<equipItem>;
		var attachItems:Vector.<attachPoint>;
				
		public function Assembly() {	
			slots = new Slots();
			equippedItems = new Vector.<equipItem>();
			attachItems = new Vector.<attachPoint>();
			
			x = 270;
			scaleX = scaleY = 0.93;
			
			fd = new frontDisplay();
			md = new middleDisplay();
			td = new tailDisplay();
			
			addChild(fd);
			addChild(md);
			addChild(td);
			
			updateSlots();
		}
		
		public function updateSlots(){
			stripAttachPoints();
			slots.SetSlots(
						   (fd.slots.GetSmallWeaponSlots() + md.slots.GetSmallWeaponSlots() + td.slots.GetSmallWeaponSlots()),
						   (fd.slots.GetLargeWeaponSlots() + md.slots.GetLargeWeaponSlots() + td.slots.GetLargeWeaponSlots()),
						   (fd.slots.GetUtilitySlots() + md.slots.GetUtilitySlots() + td.slots.GetUtilitySlots()),
						   (fd.slots.GetPassiveSlots() + md.slots.GetPassiveSlots() + td.slots.GetPassiveSlots())
						   );
			var slotTmp = fd.slots.GetSmallWeaponSlots() + fd.slots.GetLargeWeaponSlots();
			while(slotTmp-- > 0){
				var at = fd.GetAttachPoint(slotTmp);
				if(at != null){
					addAttachPoint(at);
				}
			}
			slotTmp = md.slots.GetSmallWeaponSlots() + md.slots.GetLargeWeaponSlots();
			while(slotTmp -- > 0){
				var a2 = md.GetAttachPoint(slotTmp);
				if(a2 != null){
					addAttachPoint(a2);
				}
			}
			slotTmp = td.slots.GetSmallWeaponSlots() + td.slots.GetLargeWeaponSlots();
			while(slotTmp-- > 0){
				var a3 = td.GetAttachPoint(slotTmp);
				if(a3 != null){
					addAttachPoint(a3);
				}
			}
		}
		
		public function GetStats(){
			var stats,fStats,mStats,tStats,iStats:Stats;
			stats = new Stats();
			fStats = fd.GetStats();
			mStats = md.GetStats();
			tStats = td.GetStats();
			iStats = GetInventoryStats();
			stats.SetStats((fStats.GetStructure() + mStats.GetStructure() + tStats.GetStructure() + iStats.GetStructure()),(fStats.GetShield() + mStats.GetShield() + tStats.GetShield() + iStats.GetShield()),(fStats.GetPower() + mStats.GetPower() + tStats.GetPower() + iStats.GetPower()),(fStats.GetMass() + mStats.GetMass() + tStats.GetMass() + iStats.GetMass()),(fStats.GetEngineForce() + mStats.GetEngineForce() + tStats.GetEngineForce() + iStats.GetEngineForce()),(fStats.GetShieldRegen() + mStats.GetShieldRegen() + tStats.GetShieldRegen() + iStats.GetShieldRegen()),(fStats.GetPowerRegen() + mStats.GetPowerRegen() + tStats.GetPowerRegen() + iStats.GetPowerRegen()),(fStats.GetCpuBonus() + mStats.GetCpuBonus() + tStats.GetCpuBonus() + iStats.GetCpuBonus()),
						   (fStats.GetShieldElectricResist() + mStats.GetShieldElectricResist() + tStats.GetShieldElectricResist() + iStats.GetShieldElectricResist()),(fStats.GetShieldThermalResist() + mStats.GetShieldThermalResist() + tStats.GetShieldThermalResist() + iStats.GetShieldThermalResist()),(fStats.GetShieldKineticResist() + mStats.GetShieldKineticResist() + tStats.GetShieldKineticResist() + iStats.GetShieldKineticResist()),
						    (fStats.GetArmorElectricResist() + mStats.GetArmorElectricResist() + tStats.GetArmorElectricResist() + iStats.GetArmorElectricResist()),(fStats.GetArmorThermalResist() + mStats.GetArmorThermalResist() + tStats.GetArmorThermalResist() + iStats.GetArmorThermalResist()),(fStats.GetArmorKineticResist() + mStats.GetArmorKineticResist() + tStats.GetArmorKineticResist() + iStats.GetArmorKineticResist())
						   );
			return stats;
		}
		
		public function addEquipItem(itemId:String){
			var tempItem = new equipItem(itemId);
			equippedItems.push(tempItem);
			var actType = tempItem.actType;
			if(actType == 1 || actType == 2){
				attachWeapon(itemId,actType);
			}
		}
				
		public function stripEquipItems(){
			var i = equippedItems.length;
			while(i-- > 0){
				equippedItems.pop();
			}
			clearAttachPoints();
		}
		
		public function addAttachPoint(aPoint:attachPoint){
			attachItems.push(aPoint);
			addChild(aPoint);
		}
		
		public function attachWeapon(idName:String,atchType:int){
			var no = GetFreeAttachPoint(atchType);
			if(no < 0){
				trace("cant attach weapon no free points");
			} else {
				attachItems[no].SetAttach(idName);
			}
		}
		
		function GetFreeAttachPoint(atchType:int):int{
			var i = attachItems.length;
			while(i-- > 0){
				if(attachItems[i].occupied == 0 && attachItems[i].attachType == atchType){
					return i;
				}
			}
			return -1;
		}
				
		function clearAttachPoints(){
			var i = attachItems.length;
			while(i-- > 0){
				attachItems[i].ClearAttach();
			}
		}
		
		public function stripAttachPoints(){
			var i = attachItems.length;
			while(i-- > 0){
				var tmp = attachItems.pop();
				removeChild(tmp);
			}
		}
		
		function GetInventoryStats(){
			var stats = new Stats();
			var i = equippedItems.length;
			if(i <= 0){
				stats.SetStats(0,0,0,0,0,0,0,0,0,0,0,0,0,0);
			}
			while(i-- > 0){
				var temp = equippedItems[i].stats;
				stats.SetStats((stats.GetStructure() + temp.GetStructure()),(stats.GetShield() + temp.GetShield()),(stats.GetPower() + temp.GetPower()),(stats.GetMass() + temp.GetMass()),(stats.GetEngineForce() + temp.GetEngineForce()),(stats.GetShieldRegen() + temp.GetShieldRegen()),(stats.GetPowerRegen() + temp.GetPowerRegen()),(stats.GetCpuBonus() + temp.GetCpuBonus()),
						   (stats.GetShieldElectricResist() + temp.GetShieldElectricResist()),(stats.GetShieldThermalResist() + temp.GetShieldThermalResist()),(stats.GetShieldKineticResist() + temp.GetShieldKineticResist()),
						    (stats.GetArmorElectricResist() + temp.GetArmorElectricResist()),(stats.GetArmorThermalResist() + temp.GetArmorThermalResist()),(stats.GetArmorKineticResist() + temp.GetArmorKineticResist())
						   );
			}
			return stats;
		}
		
	}
	
}
