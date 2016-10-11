package  {
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import events.changeSceneEvent;
	import events.updateShipEvent;
	import events.updateHangarEvent;
	
	
	public class ShipViewer extends MovieClip{
		var hangarNo:int;
		var constructionMode:int;
		var tooltip:shipComponentTooltip;
		var assembly:MovieClip;
		var bfp,bfn,bmp,bmn,btp,btn,bcm,bem,bcs:SimpleButton;
		var header:MovieClip;
		var pView,sView:MovieClip;
		var dropHangar,smallWeapons,largeWeapons,utilitySlots,passiveSlots:dragDropTarget;
		
		public function ShipViewer() {
			hangarNo = 0;
			
			header = new infoText(0xFFFFFFFF);
			header.SetText("Construction Mode");
			header.x = 170;
			header.y = 8;
			
			bfn = new btnFrontNext();
			bfp = new btnFrontPrev();
			bmp = new btnMiddlePrev();
			bmn = new btnMiddleNext();
			btp = new btnTailPrev();
			btn = new btnTailNext();
			bcm = new btnConstructionMode();
			bem = new btnEquipmentMode();
			bcs = new btnConfirmShip();
			
			assembly = new Assembly();
			
			pView = new miniPreview(assembly);
			pView.x = 180;
			pView.y = 32;
			
			sView = new StatsDisplay(assembly.GetStats());
			sView.x = 0;
			sView.y = 16;
			
			dropHangar = new dragDropTarget("Hangar",90,0);
			dropHangar.x = 16;
			dropHangar.y = 196;
			dropHangar.visible = false;
			
			addChild(header);
			
			addChild(assembly);
			addChild(pView);
			addChild(sView);
			
			addChild(dropHangar);
			
			addChild(bfn);
			addChild(bfp);
			addChild(bmp);
			addChild(bmn);
			addChild(btp);
			addChild(btn);
			addChild(bcm);
			addChild(bem);
			addChild(bcs);
			
			bfn.addEventListener(MouseEvent.CLICK, frontNext);
			bfp.addEventListener(MouseEvent.CLICK, frontPrev);
			bmn.addEventListener(MouseEvent.CLICK, middleNext);
			bmp.addEventListener(MouseEvent.CLICK, middlePrev);
			btn.addEventListener(MouseEvent.CLICK, tailNext);
			btp.addEventListener(MouseEvent.CLICK, tailPrev);
			bcm.addEventListener(MouseEvent.CLICK, modeConstruction);
			bem.addEventListener(MouseEvent.CLICK, modeEquipment);
			bcs.addEventListener(MouseEvent.CLICK, confirmShip);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			assembly.addEventListener(MouseEvent.MOUSE_OVER,MouseOver);
			addEventListener(MouseEvent.CLICK,MouseOut);
			addEventListener("panelsUpdated", UpdateEquipment);
			
			assembly.updateSlots();
		}
		
		function init(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE,init);
			bfn.visible = false;
			bfp.visible = false;
			bmn.visible = false;
			bmp.visible = false;
			btn.visible = false;
			btp.visible = false;
			bcm.visible = false;
			bem.visible = false;
			bcs.visible = true;
			if(tooltip != null){
				tooltip.visible = false;
			}
			createPanelSystem();
			constructionMode = 1;
			header.SetText("Equipment Mode");
		}
		
		function EnableConstruction(){
			bcm.visible = true;
		}
		
		public function LoadItemShipData(hangarIt:Vector.<String>, hNo:int, sEquip:Vector.<equipItem>,code:int){
			// construction parts
			var cdF, cdM, cdT:int;
			cdT = code % 10;
			cdM = (code % 100 - cdT)/10;
			cdF = (code - 10*cdM - cdT)/100;
			assembly.fd.setPicId(cdF);
			assembly.md.setPicId(cdM);
			assembly.td.setPicId(cdT);
			pView.update(assembly);
			sView.update(assembly.GetStats());
			assembly.updateSlots();
			
			// equipment
			var i = sEquip.length;
			var m:equipItem;
			var tmp:int;
			var txt:String;
			while(i-- > 0){
				m = sEquip[i];
				tmp = m.actType;
				txt = m.itemId;
				if(tmp == 1){
					smallWeapons.AddPanel(txt,smallWeapons.GetFreePanelId(),tmp);
				} else if (tmp == 2){
					largeWeapons.AddPanel(txt,largeWeapons.GetFreePanelId(),tmp);
				} else if (tmp == 3){
					utilitySlots.AddPanel(txt,utilitySlots.GetFreePanelId(),tmp);
				} else if (tmp == 4){
					passiveSlots.AddPanel(txt,passiveSlots.GetFreePanelId(),tmp);
				}
			}
			
			
			// hangar
			hangarNo = hNo;
			var equip;
			i = hangarIt.length;
			while(i-- > 0){
				txt = hangarIt[i];
				equip = new equipItem(txt);
				tmp = equip.actType;
				dropHangar.AddPanel(txt,dropHangar.GetFreePanelId(),tmp);
			}
			
			// if one of the cool stations enable reconstruction
			if(hangarNo == 6024 || hangarNo == 6224){
				EnableConstruction();
			}
		}
		
		function MouseOver(e:MouseEvent){
			if(constructionMode == 0){
				var tgt = e.target;
				MakeTooltip(tgt);
			}
		}
		
		function MouseOut(e:MouseEvent){
			if(tooltip != null){
				tooltip.visible = false;
			}
		}
		
		function MakeTooltip(tgt){
			if(tooltip != null){
				removeChild(tooltip);
			}
			var sts = tgt.stats;
			var slt = tgt.slots;
			var nameStr = tgt.partName;
			var tt = tgt.tooltipType;
			
			tooltip = new shipComponentTooltip(tt,nameStr,sts,slt);
			tooltip.x = 530;
			tooltip.y = tgt.y + 16;
			addChild(tooltip);
		}
		
		function frontNext(e:MouseEvent):void{
			var mysound = new chime();
			mysound.play();
			assembly.fd.Incr();
			// fCount.SetText( (assembly.fd.getPicId() + 1) + " out of " + (assembly.fd.getMaxId() + 1) );
			pView.update(assembly);
			sView.update(assembly.GetStats());
			assembly.updateSlots();
		}
		
		function frontPrev(e:MouseEvent):void{
			var mysound = new chime();
			mysound.play();
			assembly.fd.Decr();
			// fCount.SetText( (assembly.fd.getPicId() + 1) + " out of " + (assembly.fd.getMaxId() + 1) );
			pView.update(assembly);
			sView.update(assembly.GetStats());
			assembly.updateSlots();
		}
		
		function middleNext(e:MouseEvent):void{
			var mysound = new chime();
			mysound.play();
			assembly.md.Incr();
			// mCount.SetText( (assembly.md.getPicId() + 1) + " out of " + (assembly.md.getMaxId() + 1) );
			pView.update(assembly);
			sView.update(assembly.GetStats());
			assembly.updateSlots();
		}
		
		function middlePrev(e:MouseEvent):void{
			var mysound = new chime();
			mysound.play();
			assembly.md.Decr();
			// mCount.SetText( (assembly.md.getPicId() + 1) + " out of " + (assembly.md.getMaxId() + 1) );
			pView.update(assembly);
			sView.update(assembly.GetStats());
			assembly.updateSlots();
		}
		
		function tailNext(e:MouseEvent):void{
			var mysound = new chime();
			mysound.play();
			assembly.td.Incr();
			// tCount.SetText( (assembly.td.getPicId() + 1) + " out of " + (assembly.td.getMaxId() + 1) );
			pView.update(assembly);
			sView.update(assembly.GetStats());
			assembly.updateSlots();
		}
		
		function tailPrev(e:MouseEvent):void{
			var mysound = new chime();
			mysound.play();
			assembly.td.Decr();
			// tCount.SetText( (assembly.td.getPicId() + 1) + " out of " + (assembly.td.getMaxId() + 1) );
			pView.update(assembly);
			sView.update(assembly.GetStats());
			assembly.updateSlots();
		}
		
		function createPanelSystem(){		
			smallWeapons = new dragDropTarget("Small Weapons",assembly.slots.GetSmallWeaponSlots(),1);
			smallWeapons.x = 180;
			smallWeapons.y = 128;
			smallWeapons.visible = false;
			
			largeWeapons = new dragDropTarget("Large Weapons",assembly.slots.GetLargeWeaponSlots(),2);
			largeWeapons.x = 280;
			largeWeapons.y = 16;
			largeWeapons.visible = false;
			
			utilitySlots = new dragDropTarget("Utility Modules",assembly.slots.GetUtilitySlots(),3);
			utilitySlots.x = 180;
			utilitySlots.y = 300;
			utilitySlots.visible = false;
			
			passiveSlots = new dragDropTarget("Passive Modules",assembly.slots.GetPassiveSlots(),4);
			passiveSlots.x = 640;
			passiveSlots.y = 16;
			passiveSlots.visible = false;
			
			addChild(smallWeapons);
			addChild(largeWeapons);
			addChild(utilitySlots);
			addChild(passiveSlots);
		}
		
		function destroyPanelSystem(){
			removeChild(smallWeapons);
			removeChild(largeWeapons);
			removeChild(utilitySlots);
			removeChild(passiveSlots);
		}
		
		function checkValid(){
			var okay:Boolean = sView.HasValidStats();
			
			if(okay){
				bcs.visible = true;
			} else {
				bcs.visible = false;
			}
		}
		function modeEquipment(e:MouseEvent):void{
			var mysound = new chime();
			mysound.play();
			bfn.visible = false;
			bfp.visible = false;
			bmn.visible = false;
			bmp.visible = false;
			btn.visible = false;
			btp.visible = false;
			bcm.visible = true;
			bem.visible = false;
			bcs.visible = true;
			if(tooltip != null){
				tooltip.visible = false;
			}
			dropHangar.ShowPanels(true);
			createPanelSystem();
			smallWeapons.ShowPanels(true);
			largeWeapons.ShowPanels(true);
			utilitySlots.ShowPanels(true);
			passiveSlots.ShowPanels(true);
			constructionMode = 1;
			header.SetText("Equipment Mode");
		}
		
		function modeConstruction(e:MouseEvent):void{
			var mysound = new chime();
			mysound.play();
			bfn.visible = true;
			bfp.visible = true;
			bmn.visible = true;
			bmp.visible = true;
			btn.visible = true;
			btp.visible = true;
			bcm.visible = false;
			bem.visible = true;
			StripPanelsToHangar();
			dropHangar.ShowPanels(false);
			smallWeapons.ShowPanels(false);
			largeWeapons.ShowPanels(false);
			utilitySlots.ShowPanels(false);
			passiveSlots.ShowPanels(false);
			destroyPanelSystem();
			constructionMode = 0;
			header.SetText("Construction Mode");
			bcs.visible = false;
		}
		
		function UpdateEquipment(e:Event){
			assembly.stripEquipItems();
			if(passiveSlots != null){
				EquipFrom(smallWeapons);
				EquipFrom(largeWeapons);
				EquipFrom(utilitySlots);
				EquipFrom(passiveSlots);
			}
			sView.update(assembly.GetStats());
			pView.update(assembly);
			checkValid();
		}
		
		function StripPanelsToHangar(){
			StripFrom(smallWeapons);
			StripFrom(largeWeapons);
			StripFrom(utilitySlots);
			StripFrom(passiveSlots);
			assembly.stripEquipItems();
			sView.update(assembly.GetStats());
			pView.update(assembly);
		}
		
		function StripFrom(org:dragDropTarget){
			var tgt = dropHangar;
			var i:int;
			i = org.panelAmt;
			while(i-- > 0){
				var pnlText = org.panels[i].textStr.text;
				if(pnlText != "Empty"){
					var pnlDT = org.panels[i].dropType;
					tgt.AddPanel(pnlText,tgt.GetFreePanelId(),pnlDT);
					org.AddPanel("Empty",i,0);				
				}
			}
		}
		
		function EquipFrom(org:dragDropTarget){
			var i:int;
			i = org.panelAmt;
			while(i-- > 0){
				var pnlText = org.panels[i].textStr.text;
				if(pnlText != "Empty"){
					assembly.addEquipItem(pnlText);	
				}
			}
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
		
		function clearEventListeners(){
			removeEventListener(MouseEvent.CLICK,MouseOut);
			removeEventListener("panelsUpdated", UpdateEquipment);
		}
		
		function confirmShip(e:MouseEvent){
			bcs.visible = false;
			
			var hangarContents = GetHangarContents(dropHangar);
			dispatchEvent(new updateHangarEvent("updateHangar",hangarNo,hangarContents));
						  
			var raw = new BitmapData(512,512,true,0x00FFFFFF);
			var matrix = new Matrix();
			matrix.translate(-raw.width / 2, -raw.height / 2);
			matrix.rotate(Math.PI / 2);
			matrix.translate(raw.width / 2, raw.height / 2);
			raw.draw(assembly,matrix);
			var code:int = assembly.fd.getPicId() * 100 + assembly.md.getPicId() * 10 + assembly.td.getPicId();
			dispatchEvent(new updateShipEvent("updateShip",assembly.equippedItems,assembly.GetStats(),assembly.slots,raw,code));
	
			var mysound = new chime();
			mysound.play();
			if(hangarNo == 0){
				dispatchEvent(new changeSceneEvent("changeScene","landed",6024));
				return;
			}
			dispatchEvent(new changeSceneEvent("changeScene","landed",hangarNo));
		}

	}
	
}
