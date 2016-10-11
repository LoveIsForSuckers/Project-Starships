package  {
	
	public class pricePolitics {
 		// 0 = agrarian, 1 = ores, 2 = industrial, 3 = scientifical, 4 = luxury, 5 = ship equipment
		var agrMod,oreMod,indMod,sciMod,luxMod,equMod;
		var mProdType,mResType,mProdSold,mResBought,prodInStock,maxEquipPrice:int;
		var offeredEquip:Vector.<String>;
		
		public function pricePolitics(agrarianMod = 1, oresMod = 1, industrialMod = 1, scientificalMod = 1, luxuryMod = 1, equipmentMod = 1,prType = 0,rsType = 2) {
			SetPricePolitics(agrarianMod, oresMod, industrialMod, scientificalMod, luxuryMod, equipmentMod);
			SetProductionData(prType,rsType,0,0,1);
			maxEquipPrice = 20000;
			offeredEquip = new Vector.<String>;
		}
		
		public function SetPricePolitics(agrarianMod, oresMod, industrialMod, scientificalMod, luxuryMod, equipmentMod){
			agrMod = agrarianMod;
			oreMod = oresMod;
			indMod = industrialMod;
			sciMod = scientificalMod;
			luxMod = luxuryMod;
			equMod = equipmentMod;
		}
		
		public function SetProductionData(prodType, resType, ProdSold, ResBought, InStock){
			mProdType = prodType;
			mResType = resType;
			mProdSold = ProdSold;
			mResBought = ResBought;
			prodInStock = InStock;
		}
		
		public function GetOfferedEquipment(){
			return offeredEquip;
		}
		
		public function SetOfferedEquipment(equ:Vector.<String>){
			offeredEquip = equ;
		}
		
		public function GetProdType(){
			return mProdType;
		}
		
		public function GetProdInStock(){
			return prodInStock;
		}
		
		public function GetMaxEquipPrice(){
			return maxEquipPrice;
		}
		
		public function GetResType(){
			return mResType;
		}
		
		public function IncResBought(amt:int = 1){
			mResBought += amt;
		}
		
		public function IncProdSold(amt:int = 1){
			mProdSold += amt;
			prodInStock -= amt;
			maxEquipPrice += 1000;
		}
		
		
		public function UpdateValues(){
			var resPrc = 1;
			var prdPrc = 1;
			if(mProdSold > mResBought){
				prdPrc += 0.01;
				resPrc -= 0.01;
			} else {
				resPrc += 0.01;
				prdPrc -= 0.01;
			}
			if(mProdSold > 5){
				prdPrc += 0.03;
				resPrc += 0.01;
			}
			if(mProdSold == 0){
				prdPrc -= 0.03;
				resPrc -= 0.01;
			}
			if(mResBought > 5){
				resPrc -= 0.02;
			}
			if(mResBought == 0){
				resPrc += 0.02;
			}
			
			var prdCost = GetModByProdType(mProdType) * prdPrc;
			var resCost = GetModByProdType(mResType) * resPrc;			
			
			if(prdCost > 0.5){
				SetModByType(mProdType,prdCost);
			}
			
			if(resCost > 0.5){
				SetModByType(mResType,resCost);
			}
			
			if(prodInStock < 20){
				prodInStock += (mResBought + 1);
			} else if (prodInStock < 30){
				prodInStock += 1;
			}
			
			maxEquipPrice += int(maxEquipPrice * 0.05);
			mProdSold = mResBought = 0;
		}
		
		public function SetModByType(type:int,arg){
			switch(type){
					case 0:
						SetAgrarianMod(arg);
						break;
					case 1:
						SetOresMod(arg);
						break;
					case 2:
						SetIndustrialMod(arg);
						break;
					case 3:
						SetScientificalMod(arg);
						break;
					case 4:
						SetLuxuryMod(arg);
						break;
					case 5:
						SetEquipmentMod(arg);
						break;
				}
		}
		
		public function GetModByProdType(arg:int){
			var temp;
			switch(arg){
					case 0:
						temp = GetAgrarianMod();
						break;
					case 1:
						temp = GetOresMod();
						break;
					case 2:
						temp = GetIndustrialMod();
						break;
					case 3:
						temp = GetScientificalMod();
						break;
					case 4:
						temp = GetLuxuryMod();
						break;
					case 5:
						temp = GetEquipmentMod();
						break;
				}
			return temp;
		}
		
		public function SetAgrarianMod(aMod){
			agrMod = aMod;
		}
		
		public function SetOresMod(oMod){
			oreMod = oMod;
		}
		
		public function SetIndustrialMod(iMod){
			indMod = iMod;
		}
		
		public function SetScientificalMod(sMod){
			sciMod = sMod;
		}
		
		public function SetLuxuryMod(lMod){
			luxMod = lMod;
		}
		
		public function SetEquipmentMod(eMod){
			equMod = eMod;
		}
		
		public function GetAgrarianMod(){
			return agrMod;
		}
		
		public function GetOresMod(){
			return oreMod;
		}
		
		public function GetIndustrialMod(){
			return indMod;
		}
		
		public function GetScientificalMod(){
			return sciMod;
		}
		
		public function GetLuxuryMod(){
			return luxMod;
		}
		
		public function GetEquipmentMod(){
			return equMod;
		}

	}
	
}
