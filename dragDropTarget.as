package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	
	public class dragDropTarget extends MovieClip {
		var panels:Vector.<dragDropPanel>;
		var pp:pricePolitics;
		var pageNo:infoText;
		var btnLeft,btnRight;
		var panelAmt,dropType,pages,page,initialized:int;
		var origin = this;
		var trade:Boolean;
		
		public function dragDropTarget(str,panelAmount:int,drT:int) {
			initialized = 0;
			dropType = drT;
			ico.gotoAndStop(dropType + 1);
			if(str == "Trade"){
				trade = true;
			} else {
				trade = false;
			}
			SetText(str);
			panelAmt = panelAmount;
			panels = new Vector.<dragDropPanel>(panelAmt);
			dropTargetBackground.y = 20;
			if(panelAmt <= 10){
				dropTargetBackground.height = panelAmt * 25 - 5;
			}
			if(panelAmt > 10){
				createPageControl();
				dropTargetBackground.height = 245;
			} else {
				pages = page = 1;
			}
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		function onAdded(e:Event){
			EmptyPanels();
			ShowPanels(true);
			initialized = 1;
		}
		
		function createPageControl(){
			btnLeft = new btnMicro();
			btnLeft.x = x + 64;
			btnLeft.y = 3;
			
			btnRight = new btnMicroRight();
			btnRight.x = x + 116;
			btnRight.y = 3;
			
			pageNo = new infoText(0xFF00FF00);
			pageNo.SetText("1");
			pageNo.x = x + 100;
			pageNo.y = 3;
			page = 1;
			
			addChild(pageNo);
			addChild(btnLeft);
			addChild(btnRight);
			
			btnLeft.addEventListener(MouseEvent.CLICK, prevPage);
			btnRight.addEventListener(MouseEvent.CLICK, nextPage);
		}
		
		function prevPage(e:MouseEvent){
			var mysound = new chime();
			mysound.play();
			if(page > 1){
				page -= 1;
				pageNo.SetText(page);
			}
			ShowPanels(true);
		}
		
		function nextPage(e:MouseEvent){
			var mysound = new chime();
			mysound.play();
			if(page < pages){
				page += 1;
				pageNo.SetText(page);
			}			
			ShowPanels(true);
		}
		
		public function SetText(str){
			textStr.mouseEnabled = false;
			textStr.text = str;
		}
		
		public function GetText():String{
			return textStr.text;
		}
		
		public function GetFreePanelId():int{
			var i = panelAmt;
			while(i-- > 0){
				if(panels[i] == null){
					return i;
				}
				if(panels[i].textStr.text == "Empty"){
					return i;
				}
			}
			return -1;
		}
		
		public function HasLitPanels():Boolean{
			var i = panelAmt;
			while(i-- > 0){
				if(panels[i] == null){
					continue;
				}
				if(panels[i].dragDropHighlight.visible){
					return true;
				}
			}
			return false;
		}
		
		public function UnlightPanels(){
			var i = panelAmt;
			while(i-- > 0){
				if(panels[i] == null){
					continue;
				}
				if(panels[i].dragDropHighlight.visible){
					panels[i].dragDropHighlight.visible = false;
				}
			}
		}
		
		public function FillShop(){
			var amt = pp.GetProdInStock();
			var pt = pp.GetProdType();
			var oe:Vector.<String> = pp.GetOfferedEquipment();
			var oel = oe.length;
			while(oel-- > 0){
				var itm = new equipItem(oe[oel]);
				AddPanel(itm.itemId,GetFreePanelId(),itm.actType);
				if(pt == 5){
					amt--;
				}
			}
			while(amt-- > 0){
				switch(pt){
					case 0:
						var rnd = GetFreePanelId() % 3;
						if(rnd == 0){
							AddPanel("Food",GetFreePanelId(),0);
						} else if (rnd == 1){
							AddPanel("Organic Materials",GetFreePanelId(),0);
						} else {
							AddPanel("Alcohol",GetFreePanelId(),0);
						}
						break;
					case 1:
						rnd = GetFreePanelId() % 4;
						if(rnd == 0){
							AddPanel("Common Ores",GetFreePanelId(),0);
						} else if (rnd == 1){
							AddPanel("Kanvium Ore",GetFreePanelId(),0);
						} else if (rnd == 2) {
							AddPanel("Noble Gas",GetFreePanelId(),0);
						} else {
							AddPanel("Tri-Stront Ore",GetFreePanelId(),0);
						}
						break;
					case 2:
						rnd = GetFreePanelId() % 4;
						if(rnd == 0){
							AddPanel("Construction Blocks",GetFreePanelId(),0);
						} else if (rnd == 1){
							AddPanel("Mechanical Parts",GetFreePanelId(),0);
						} else if (rnd == 2){
							AddPanel("Chemicals",GetFreePanelId(),0);
						} else {
							AddPanel("Scrap Metal",GetFreePanelId(),0);
						}
						break;
					case 3:
						rnd = GetFreePanelId() % 3;
						if(rnd == 0){
							AddPanel("Medicals",GetFreePanelId(),0);
						} else if (rnd == 1){
							AddPanel("Electronics",GetFreePanelId(),0);
						} else {
							AddPanel("Data Cores",GetFreePanelId(),0);
						}
						break;
					case 4:
						AddPanel("Luxury",GetFreePanelId(),0);
						break;
					case 5:
						itm = new equipItem("Random Equipment");
						while(itm.Cost > pp.GetMaxEquipPrice()){
							itm = new equipItem("Random Equipment");
						}
						AddPanel(itm.itemId,GetFreePanelId(),itm.actType);
						break;
				}
			}
		}
		
		public function SetPricePolitics(arg:pricePolitics){
			pp = arg;
		}
		
		public function UpdateOfferedEquip(){
			var hContents = new Vector.<String>;
			var i:int;
			i = panelAmt;
			while(i-- > 0){
				var pnlText = panels[i].textStr.text;
				if(pnlText != "Empty" && panels[i].itm.tradeType == 5){
					hContents.push(pnlText);
				}
			}
			
			pp.SetOfferedEquipment(hContents);
		}
		
		public function IncProdSold(){
			pp.IncProdSold();
		}
		
		public function IncResBought(){
			pp.IncResBought();
		}
		
		public function AddPanel(str,idd:int,dropType:int,dispatchEvents:Boolean = true,light:Boolean = false){
			if(panels[idd] != null){
				parent.removeChild(panels[idd]);
			}
			if(idd < 0){
				return;
			}
			if(str == "Disabled"){
				panels[idd] = new dragDropPanel("Empty",0,this,idd);
			}
			if(str == "Empty"){
				panels[idd] = new dragDropPanel("Empty",0,this,idd);
			} else {
				if(panels[idd].textStr.text == "Empty"){
					panels[idd] = new dragDropPanel(str,dropType,this,idd,light);
				} else {
					return;
				}
			}
			
			var no = (Math.ceil(panelAmt/10) - int(idd/10) - 1);
			
			panels[idd].x = x;
			panels[idd].y = y + (panelAmt - idd) * 25 - (250*no) - 5;
			
			parent.addChild(panels[idd]);
			
			if(initialized == 1 && dispatchEvents == true){
				dispatchEvent(new Event("panelsUpdated",true));		
				ShowPanels(true);
			}
		}
		
		public function PanelsToTop(){
			var i = panelAmt;
			while(i-- > 0){
				var freeId;
				var txt = panels[i].textStr.text;
				var originNo = panels[i].originNo;
				var dType = panels[i].dropType;
				var lit = panels[i].dragDropHighlight.visible;
				if(txt == "Empty"){ 
					freeId = originNo;
				} else {
					freeId = GetFreePanelId();
				}
				if(freeId >= i){
					AddPanel(txt,freeId,dType,false,lit);
					AddPanel("Empty",originNo,0,false);
					// stage.removeChild(this);
					
					
				}
			}
			ShowPanels(true);
		}
		
		function EmptyPanels(){
			pages = Math.ceil(panelAmt/10);
			var i = panelAmt;
			while(i-- > 0){
					AddPanel("Empty",i,0,true);
			}
			
		}
		
		public function ShowPanels(arg:Boolean){
			var i = panelAmt;
			
			if(arg){
				while(i-- > 0){
					panels[i].visible = false;
					if(int(i/10) == pages - page){
						panels[i].visible = true;
					}
				}
				visible = true;
			} else {
				while(i-- > 0){
					panels[i].visible = false;
				}
				visible = false;
			}
		}
	}
	
}
