package  {
	import flash.display.BitmapData;
	
	public class PlayerData {
		var lastKnownX,lastKnownY,gameTime,prevSys,constrCode,credits:int;
		var hangarLoot:Vector.<Vector.<String>>,cargoLoot:Vector.<String>;
		var shipEquipment:Vector.<equipItem>;
		var economy:Vector.<pricePolitics>;
		var shipStats:Stats;
		var shipSlots:Slots;
		var shipMini:BitmapData;
		
		public function PlayerData() {
			var shipEquipment = new Vector.<equipItem>;
			credits = 1000;
			gameTime = 0;
			SetLastCoords(1337,10);
			SetPrevSys(24);
			constrCode = 0;
			cargoLoot = new Vector.<String>;
			hangarLoot = new Vector.<Vector.<String>>(10000);
			hangarLoot.fixed = true;
			economy = new Vector.<pricePolitics>(7000);
			economy.fixed = true;
			SetupDefaultHangar();
			SetupDefaultEconomy();
		}
		
		function SetupDefaultHangar(){
			var tmp = new Vector.<String>;
			tmp.push("Micrometeorite Gun");
			tmp.push("Shield Booster A1");
			tmp.push("Auxiliary Booster");
			tmp.push("Food");		
			hangarLoot[6024] = tmp;
		}
		
		function SetupDefaultEconomy(){
			economy[1024] = new pricePolitics(1.05,0.9,0.95,1.05,1.1,1,4,0);
			economy[6024] = new pricePolitics(1.05,0.95,0.95,1,1.1,1,3,2);
			economy[182] = new pricePolitics(1,0.9,0.9,0.9,1,1,0,4);
			economy[1224] = new pricePolitics(0.95,0.8,1,1,0.85,0.95,2,1);
			economy[6224] = new pricePolitics(1.12,0.9,0.9,1,0.9,0.95,5,3);
			economy[6477] = new pricePolitics(0.95,0.95,1,0.95,0.85,1,3,2);
			economy[1525] = new pricePolitics(1.1,0.9,1,1,0.95,1.1,1,0);
			economy[66] = new pricePolitics(1.1,1.1,1,1.1,0.9,1.2,2,1);
		}
				
		public function GetHangar(id:int):Vector.<String>{
			if(hangarLoot[id] == null){
				hangarLoot[id] = new Vector.<String>;
			}
			return hangarLoot[id];
		}
		
		public function GetPricePolitic(id:int):pricePolitics{
			if(economy[id] == null){
				economy[id] = new pricePolitics();
			}
			return economy[id];
		}
		
		public function SetPricePolitic(id:int,item:pricePolitics){
			economy[id] = item;
		}
		
		public function SetHangar(id:int,item:Vector.<String>){
			hangarLoot[id] = item;
		}
		
		public function SetCargo(item:Vector.<String>){
			cargoLoot = item;
		}
		
		public function GetCargo():Vector.<String>{
			return cargoLoot;
		}
		
		public function SetLastCoords(kX,kY){
			lastKnownX = int(kX);
			lastKnownY = int(kY);
			gameTime += 1;
			if(gameTime % 3000 == 0){
				trace("GT: " + gameTime);
				updateEconomy();
			}
			if(gameTime > 2592000){
				// spent 24 hours in open space
				gameTime = 0;
			}
		}
		
		function updateEconomy(){
			var inflatio:Boolean = false;
			for each (var tmp in economy){
				if(tmp == null){
					continue;
				}
				tmp.UpdateValues();
				if(!inflatio && tmp.GetModByProdType(tmp.GetProdType()) > 1.2){
					inflatio = true;
				}
			}
			if(inflatio){
				TuneEconomyAverages();
			}
		}
		
		function TuneEconomyAverages(){
			var agr,ore,ind,sci,lux,equ;
			var count:int = 0;
			agr = ore = ind = sci = lux = equ = 0;
			for each (var tmp in economy){
				if(tmp == null){
					continue;
				}
				agr += tmp.GetAgrarianMod();
				ore += tmp.GetOresMod();
				ind += tmp.GetIndustrialMod();
				sci += tmp.GetScientificalMod();
				lux += tmp.GetLuxuryMod();
				equ += tmp.GetEquipmentMod();
				count += 1;
			}
			
			agr = agr/count;
			ore = ore/count;
			ind = ind/count;
			sci = sci/count;
			lux = lux/count;
			equ = equ/count;
			
			for each (tmp in economy){
				if(tmp == null){
					continue;
				}
				var index = tmp.GetAgrarianMod();
				if(index < agr){
					tmp.SetAgrarianMod(1.02 * index);
				}
				index = tmp.GetOresMod();
				if(index < ore){
					tmp.SetOresMod(1.01 * index);
				}
				index = tmp.GetIndustrialMod();
				if(index < ind){
					tmp.SetIndustrialMod(1.01 * index);
				}
				index = tmp.GetScientificalMod();
				if(index < sci){
					tmp.SetScientificalMod(1.01 * index);
				}
				index = tmp.GetLuxuryMod();
				if(index < lux){
					tmp.SetLuxuryMod(1.02 * index);
				}
				index = tmp.GetEquipmentMod();
				if(index < equ){
					tmp.SetEquipmentMod(1.01 * index);
				}
				count += 1;
			}
		}
		
		public function GetLastKnownX():int{
			return lastKnownX;
		}
		
		public function GetLastKnownY():int{
			return lastKnownY;
		}
		
		public function GetGameTime(){
			return gameTime;
		}
		
		public function SetPrevSys(pS:int){
			prevSys = pS;
		}
		
		public function GetPrevSys():int{
			return prevSys;
		}
		
		public function SetShipMini(bmd:BitmapData){
			shipMini = bmd;
		}
		
		public function GetShipMini():BitmapData{
			return shipMini;
		}
		
		public function SetStats(bmd:Stats){
			shipStats = bmd;
		}
		
		public function GetEquipment():Vector.<equipItem>{
			return shipEquipment;
		}
		
		public function SetEquipment(vct:Vector.<equipItem>){
			shipEquipment = vct;
		}
		
		public function GetStats():Stats{
			return shipStats;
		}
		
		public function GetSlots():Slots{
			return shipSlots;
		}
		
		public function SetSlots(bmd:Slots){
			shipSlots = bmd;
		}
		
		public function GetConstructionCode():int{
			return constrCode;
		}
		
		public function SetConstructionCode(cd:int){
			constrCode = cd;
		}
		
		public function GetCredits(){
			return credits;
		}
		
		public function SetCredits(crValue:int){
			credits = crValue;
		}

	}
	
}
