package  {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import events.changeSceneEvent;
	import events.updateHangarEvent;
	import events.updateCargoEvent;
	import events.IntegerEvent;
	
	public class LandedScene extends MovieClip {
		var hangarNo,sysId,tradeMode,dealAmt,crAmt,dealRes,dealProd:int;
		var bha,btr,bud,bct,bdt:SimpleButton;
		var mesh,darken,lower:Shape;
		var dropHangar,cargoHangar,tradeHangar:dragDropTarget;
		var credits,deal:infoText;
		var dealOn:Boolean;

		public function LandedScene(systemId:int) {
			sysId = systemId;
			tradeMode = dealAmt = crAmt = dealRes = dealProd = 0;
			
			deal = new infoText(0xFFFFFF00);
			deal.SetText("Deal: ");
			deal.visible = false;
			
			credits = new infoText(0xFFFFFF00);
			credits.SetText("Credits: ");
			credits.visible = false;
			
			deal.y = credits.y = 395;
			credits.x = 163;
			deal.x = 496;
			
			mesh = new Shape();
			mesh.x = mesh.y = 0;
			mesh.graphics.beginBitmapFill(new city(),null,true,false);
			mesh.graphics.drawRect(0,0,800,480);
			mesh.graphics.endFill();		
			
			lower = new Shape();
			lower.x = 105;
			lower.y = 425;
			lower.graphics.beginFill(0x000000, 0.5);
			lower.graphics.drawRect(0,0,600,55);
			lower.graphics.endFill();
			
			darken = new Shape();
			darken.x = darken.y = 105;
			darken.graphics.beginFill(0x000000, 0.5);
			darken.graphics.drawRect(0,0,600,320);
			darken.graphics.endFill();
			darken.visible = false;
			
			
			bha = new btnHangar();
			btr = new btnTrade();
			bud = new btnUndock();
			bct = new btnConfirmTrade();
			bct.visible = false;
					
			addChild(mesh);
			addChild(lower);
			addChild(darken);
			
			addChild(bct);
			addChild(bud);
			addChild(btr);
			addChild(bha);
			
			addChild(deal);
			addChild(credits);
			
			bha.addEventListener(MouseEvent.CLICK, toHangar);
			bud.addEventListener(MouseEvent.CLICK, toSpace);
			btr.addEventListener(MouseEvent.CLICK, showTrade);
			bct.addEventListener(MouseEvent.CLICK, ConfirmDeal);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		function init(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE,init);
			createPanelSystem();
			addEventListener("dealEvent",AddDeal);
			addEventListener("dealCancelEvent",CancelDeal);
		}
		
		function AddDeal(e:IntegerEvent){
			var amt = e.GetArg();
			if (e.GetArg2() == 1){
				dealProd += 1;
			} else if (e.GetArg2() == 2){
				dealRes += 1;
			}
			dealOn = true;
			deal.visible = true;
			bha.visible = false;
			bud.visible = false;
			btr.visible = false;
			dealAmt += amt;
			deal.SetText("Deal: " + dealAmt);
			if(dealAmt > 0){
				bct.visible = true;
			} else if (dealAmt < 0 && crAmt + dealAmt > 0){
				bct.visible = true;
			} else {
				bct.visible = false;
			}
		}
		
		function CancelDeal(e:IntegerEvent){
			var amt = e.GetArg();
			if (e.GetArg2() == 1){
				dealProd -= 1;
			} else if (e.GetArg2() == 2){
				dealRes -= 1;
			}
			dealAmt -= amt;
			deal.SetText("Deal: " + dealAmt);
			if(dealAmt > 0){
				bct.visible = true;
			} else if (dealAmt < 0 && crAmt + dealAmt > 0){
				bct.visible = true;
			} else {
				bct.visible = false;
			}
			if(dealAmt == 0 && !tradeHangar.HasLitPanels()){
				deal.visible = false;
				bha.visible = true;
				bud.visible = true;
				btr.visible = true;
			}
		}
		
		function ConfirmDeal(e:MouseEvent){
			if(dealRes > 0){
				tradeHangar.pp.IncResBought(dealRes);
				trace("Bought " + dealRes + " resources!");
				dealRes = 0;
			}
			if(dealProd > 0){
				tradeHangar.pp.IncProdSold(dealProd);
				trace("Sold " + dealProd + " products!");
				dealProd = 0;
			}
			crAmt += dealAmt;
			dealAmt = 0;
			credits.SetText("Credits: " + crAmt);
			dispatchEvent(new IntegerEvent("updateCredits",crAmt));
			var mysound = new chime();
			mysound.play();
			dropHangar.UnlightPanels();
			cargoHangar.UnlightPanels();
			tradeHangar.UnlightPanels();
			bct.visible = false;
			deal.visible = false;
			bha.visible = true;
			bud.visible = true;
			btr.visible = true;
		}
		
		function toHangar(e:MouseEvent){
			var hangarContents = GetHangarContents(dropHangar);
			dispatchEvent(new updateHangarEvent("updateHangar",hangarNo,hangarContents));
			hangarContents = GetHangarContents(cargoHangar);
			dispatchEvent(new updateCargoEvent("updateCargo",hangarContents));
			tradeHangar.UpdateOfferedEquip();
			var mysound = new chime();
			mysound.play();
			dispatchEvent(new changeSceneEvent("changeScene","shipyard",hangarNo));
		}
		
		function toSpace(e:MouseEvent){
			var hangarContents = GetHangarContents(dropHangar);
			dispatchEvent(new updateHangarEvent("updateHangar",hangarNo,hangarContents));
			hangarContents = GetHangarContents(cargoHangar);
			dispatchEvent(new updateCargoEvent("updateCargo",hangarContents));
			tradeHangar.UpdateOfferedEquip();
			var mysound = new chime();
			mysound.play();
			dispatchEvent(new changeSceneEvent("changeScene","starSystem",sysId));
		}
		
		function showTrade(e:MouseEvent){
			var mysound = new chime();
			mysound.play();
			
			if(tradeMode == 0){
				tradeMode = 1;
				darken.visible = true;
				credits.visible = true;
				dropHangar.ShowPanels(true);
				cargoHangar.ShowPanels(true);
				tradeHangar.ShowPanels(true);
			} else {
				tradeMode = 0;
				darken.visible = false;
				credits.visible = false;
				dropHangar.ShowPanels(false);
				cargoHangar.ShowPanels(false);
				tradeHangar.ShowPanels(false);
			}
		}
		
		function createPanelSystem(){		
			dropHangar = new dragDropTarget("Hangar",90,0);
			dropHangar.x = 163;
			dropHangar.y = 125;
			
			cargoHangar = new dragDropTarget("Cargo",40,0);
			cargoHangar.x = 330;
			cargoHangar.y = 125;
			
			tradeHangar = new dragDropTarget("Trade",90,0);
			tradeHangar.x = 496;
			tradeHangar.y = 125;
						
			addChild(dropHangar);
			addChild(cargoHangar);
			addChild(tradeHangar);
		}
		
		function destroyPanelSystem(){
			removeChild(dropHangar);
			removeChild(cargoHangar);
			removeChild(tradeHangar);
		}
		
		function clearEventListeners(){
			removeEventListener("dealEvent",AddDeal);
			removeEventListener("dealCancelEvent",CancelDeal);
		}
		
		public function LoadItemCargoData(hangarIt:Vector.<String>, hNo:int, sCargo:Vector.<String>, crValue:int, pp:pricePolitics){
			credits.SetText("Credits: " + crValue);
			crAmt = crValue;
			
			// hangar
			hangarNo = hNo;
			if(hNo > 5999){
				mesh.graphics.beginBitmapFill(new interior(),null,true,false);
				mesh.graphics.drawRect(0,0,800,480);
				mesh.graphics.endFill();		
			}
			var equip;
			var txt:String;
			var tmp,i:int;
			i = hangarIt.length;
			while(i-- > 0){
				txt = hangarIt[i];
				equip = new equipItem(txt);
				tmp = equip.actType;
				dropHangar.AddPanel(txt,dropHangar.GetFreePanelId(),tmp);
			}
			
			// cargo
			i = sCargo.length;
			while(i-- > 0){
				txt = sCargo[i];
				equip = new equipItem(txt);
				tmp = equip.actType;
				cargoHangar.AddPanel(txt,cargoHangar.GetFreePanelId(),tmp);
			}
			
			dropHangar.SetPricePolitics(pp);
			cargoHangar.SetPricePolitics(pp);
			tradeHangar.SetPricePolitics(pp);
			
			tradeHangar.FillShop();
			
			dropHangar.ShowPanels(false);
			cargoHangar.ShowPanels(false);
			tradeHangar.ShowPanels(false);
		}
		
		function GetHangarContents(org:dragDropTarget):Vector.<String>{
			var hContents = new Vector.<String>;
			var i:int;
			i = org.panelAmt;
			while(i-- > 0){
				var pnlText = org.panels[i].textStr.text;
				if(pnlText != "Empty"){
					hContents.push(pnlText);
				}
			}
			
			return hContents;
		}

	}
	
}
