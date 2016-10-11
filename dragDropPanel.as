package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	import events.IntegerEvent;
	
	
	public class dragDropPanel extends MovieClip {
		var startX,startY;
		var origin;
		var itm:equipItem;
		var dropType,originNo:int;  // drop type: 0 - any, 1 - small weap, 2 - large weap, 3 - utility, 4 - passive
		var tooltip;
		var buyReduction,calcmod;
		
		public function dragDropPanel(textStr:String,drT:int,org,orgno:int,light:Boolean = false) {
			dragDropHighlight.visible = light;
			origin = org;
			originNo = orgno;
			SetText(textStr);
			dropType = drT;
			ico.gotoAndStop(dropType + 1);
			if(textStr == "Empty"){
				panelShadow.visible = true;
			} else {
				panelShadow.visible = false;
				itm = new equipItem(textStr);
			}
			if(dropType != 0){
				buyReduction = 0.5;
			} else {
				buyReduction = 0.9;
			}
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		function onAdded(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			if(textStr.text != "Empty"){
				addEventListener(MouseEvent.MOUSE_OVER,itemTooltip);
				addEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
			}
			addEventListener(MouseEvent.MOUSE_DOWN, onPick, true);
			startX = x;
			startY = y;
		}
		
		function itemTooltip(e:MouseEvent){
			parent.addChild(this);
			if(origin.dropType == 0){
				var tgt = e.target.parent;
				if(tgt.hasOwnProperty("textStr")){
					var txt = tgt.textStr.text;
					if(origin.pp != null){
						calcmod = origin.pp.GetModByProdType(itm.tradeType);
					} else {
						calcmod = 1;
					}
					if((origin.textStr.text != "Trade" && !dragDropHighlight.visible) || (origin.textStr.text == "Trade" && dragDropHighlight.visible)){
						calcmod *= buyReduction;
					}
					if(tooltip == null || txt != tooltip.componentName.textStr.text || tooltip.showCost != calcmod ){
						// var itm = new equipItem(txt);
						if(getQualifiedClassName(parent) == "LandedScene"){
							tooltip = new simpleTooltip(dropType,txt,itm,calcmod);
						} else {
							tooltip = new simpleTooltip(dropType,txt,itm,0);
						}
						addChild(tooltip);
					} else {
						tooltip.visible = true;
					}
				
					tooltip.x = mouseX + 48;
					tooltip.y = mouseY - tooltip.height;
					
					if(tooltip.x + x > 640){
						tooltip.x = 640 - x;
					}
					if(tooltip.y + y < 15 ){
						tooltip.y = 15 - y;
					}
			   }
			}
		}
		
		function hideTooltip(e:MouseEvent){
			if(tooltip!=null){
				tooltip.visible = false;			
			}
		}
				
		public function SetText(str){
			textStr.text = str;
		}
		
		function onPick(e:MouseEvent){
			removeEventListener(MouseEvent.MOUSE_OVER,itemTooltip);
			removeEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
				
			var mysound = new tick();
			mysound.play();
			
			hideTooltip(e);
			if(textStr.text == "Empty") return;
			if(textStr.text == "Disabled") return;
			startDrag();
			parent.addChild(this);
			scaleX = scaleY = 0.9;
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop, true);
		}
		
		function onDrop(e:MouseEvent){
			addEventListener(MouseEvent.MOUSE_OVER,itemTooltip);
			addEventListener(MouseEvent.MOUSE_OUT,hideTooltip);
				
			stopDrag();
			x = stage.mouseX;
			y = stage.mouseY;
			scaleX = scaleY = 1;
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop, true);
			if(dropTarget != null && dropTarget.parent != null && getQualifiedClassName(dropTarget.parent) == "dragDropPanel"){
				checkDrop(dropTarget.parent);
			} else {
				x = startX;
				y = startY;	
			}
		}
		
		function checkDrop(tgt){
			var org = tgt.origin;
			var ordt = org.dropType;
			var txt = tgt.textStr.text;
			var lit:Boolean = false;
			
			
			if(origin.pp != null){
				calcmod = origin.pp.GetModByProdType(itm.tradeType);
			} else {
				calcmod = 1;
			}
			
			// if item started it's way here
			if(org != origin){
				if(!dragDropHighlight.visible){
					if(org.trade){
						var prodType = origin.pp.GetProdType();
						var resType = origin.pp.GetResType();
						var incr:int = 0;
						lit = true;
						if (itm.tradeType == resType){
							incr = 2;
						}
						dispatchEvent(new IntegerEvent("dealEvent", buyReduction * calcmod * itm.Cost,incr));
					}
					if(origin.trade){
						prodType = origin.pp.GetProdType();
						resType = origin.pp.GetResType();
						incr = 0;
						lit = true;
						if(itm.tradeType == prodType){
							incr = 1;
						}
						dispatchEvent(new IntegerEvent("dealEvent", - calcmod * itm.Cost, incr));
					}
				} else {
					if(org.trade){
						prodType = origin.pp.GetProdType();
						resType = origin.pp.GetResType();
						incr = 0;
						if(itm.tradeType == prodType){
							incr = 1;
						}
						dispatchEvent(new IntegerEvent("dealCancelEvent", - calcmod * itm.Cost, incr));
					} else if(origin.trade){
						prodType = origin.pp.GetProdType();
						resType = origin.pp.GetResType();
						incr = 0;
						if (itm.tradeType == resType){
							incr = 2;
						}
						dispatchEvent(new IntegerEvent("dealCancelEvent", buyReduction * calcmod * itm.Cost, incr));
					} else {
						if(dragDropHighlight.visible){
							lit = true;
						}
					}
				}
			} else {
				if(dragDropHighlight.visible){
					lit = true;
				}
			}
												
			if((ordt == dropType || ordt == 0) && (org != origin || txt == "Empty" )){
				var freeId;
				if(txt == "Empty"){ 
					freeId = tgt.originNo;
				} else {
					freeId = org.GetFreePanelId();
				}
				if(freeId >= 0){
					var mysound = new tick();
					mysound.play();
			
					org.AddPanel(textStr.text,freeId,dropType,true,lit);
					origin.AddPanel("Empty",originNo,0);

					origin.PanelsToTop();
					
					return;
				}
			}
			
			x = startX;
			y = startY;	
		}
		
	}
	
}
