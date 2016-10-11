package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.system.System;
	import events.*;
	
	
	public class Game extends MovieClip {
		var scene,hud,mouse,bg,backsc,backm:MovieClip;
		var pData:PlayerData;
		
		public function Game() {
			Key.initialize(stage);
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		function init(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE, init);
			pData = new PlayerData();
			
			scene = new ShipViewer();
			addChild(scene);
			
			scene.addEventListener("changeScene",changeScene);
			scene.addEventListener("updateShip",updateShip);
			scene.addEventListener("updateHangar",updateHangar);
		
			hud = new HUD();
			addChild(hud);
			
			mouse = new Cursor();
			addChild(mouse);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,redrawCursor);
			Mouse.hide();
			
		}
		
		function changeScene(e:changeSceneEvent){
			trace(" chSc Mem: "  + ((System.totalMemory)/1024) + "kB");
			e.stopPropagation();
			var str = e.GetNewSceneName();
			clearScene();
			switch(str){
				case "starSystem":
					var arg = e.GetArg();
					var kX = pData.GetLastKnownX();
					var kY = pData.GetLastKnownY();
					var dC = pData.GetPrevSys() - arg + 2;
					if(dC > 0 && dC < 25 && pData.GetPrevSys() != arg){
						kY = -kY;
					} else if( pData.GetPrevSys() != arg ){
						kX = -kX;
					}
					makeStarSystem(arg);
					scene.makeHero(kX,kY,pData.GetStats(),pData.GetSlots(),pData.GetEquipment(),pData.GetShipMini());
					scene.hero.addEventListener("updateHUD",updateHUD);
					scene.ModifyTimeOffset(pData.GetGameTime());
					pData.SetPrevSys(arg);
					break;
				case "shipyard":
					arg = e.GetArg();
					scene = new ShipViewer();
					addChild(scene);
					scene.addEventListener("changeScene",changeScene);
					scene.addEventListener("updateShip",updateShip);
					scene.addEventListener("updateHangar",updateHangar);
					scene.LoadItemShipData(pData.GetHangar(arg),arg,pData.GetEquipment(),pData.GetConstructionCode());
					break;
				case "landed":
					arg = e.GetArg();
					scene = new LandedScene(pData.GetPrevSys());
					addChild(scene);
					scene.addEventListener("changeScene",changeScene);
					scene.addEventListener("updateHangar",updateHangar);
					scene.addEventListener("updateCargo",updateCargo);
					scene.addEventListener("updateCredits",updateCredits);
					scene.LoadItemCargoData(pData.GetHangar(arg),arg,pData.GetCargo(),pData.GetCredits(),pData.GetPricePolitic(arg));
					break;
				default:
					trace("wrong changeScene argument: " + e.GetNewSceneName() + e.GetArg());
					break;
			}
			cursorToTop();
			trace(" chSe Mem: "  + ((System.totalMemory)/1024) + "kB");
		}
		
		function clearScene(){
			scene.clearEventListeners();
			if(numChildren > 3){
				removeChild(bg);
				removeChild(backsc);
				removeChild(backm);
				scene.hero.removeEventListener("updateHUD",updateHUD);
				stage.removeEventListener(MouseEvent.MOUSE_MOVE,redrawCursor);
				scene.removeEventListener("sceneMove",sceneControl);
				scene.removeEventListener("changeScene",changeScene);
			}
			if(scene.hasEventListener("updateShip")){
				scene.removeEventListener("updateShip",updateShip);
				scene.removeEventListener("updateHangar",updateHangar);
			}
			removeChild(scene);
			scene = null;
		}
		
		function cursorToTop(){
			removeChild(hud);
			addChild(hud);
			removeChild(mouse);
			addChild(mouse);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,redrawCursor);
		}
		
		function makeStarSystem(code){  // 0-999
			bg = new Background(code);
			addChild(bg);
			backsc = new backScene(code);
			addChild(backsc);
			backm = new back2(code);
			addChild(backm);
			trace(" mkSs Mem: " + ((System.totalMemory)/1024) + "kB");
			scene = new Scene(code);
			addChild(scene);
			scene.addEventListener("sceneMove",sceneControl);
			scene.addEventListener("changeScene",changeScene);
		}
		
		function updateShip(e:updateShipEvent){
			pData.SetShipMini(e.GetMini());
			pData.SetSlots(e.GetSlots());
			pData.SetStats(e.GetStats());
			pData.SetEquipment(e.GetEquipment());
			pData.SetConstructionCode(e.GetConstructionCode());
		}
		
		function updateHangar(e:updateHangarEvent){
			pData.SetHangar(e.GetHangarNumber(),e.GetHangarContents());
		}
		
		function updateCredits(e:IntegerEvent){
			pData.SetCredits(e.GetArg());
		}
		
		function updateCargo(e:updateCargoEvent){
			pData.SetCargo(e.GetHangarContents());
		}
		
		function updateHUD(e:UpdateHUDEvent){
			hud.updateCoord(e.getX(),e.getY(),scene.x+e.getX(),scene.y+e.getY()); // returns coordinates of player
			pData.SetLastCoords(e.getX(),e.getY());
		}
		
		function sceneControl(e:sceneMoveEvent){
			bg.setcoord(0.3*e.getX(),0.1*e.getY()); // returns scene movements
			backsc.setcoord(0.4*e.getX(),0.2*e.getY());
			backm.setcoord(0.5*e.getX(),0.3*e.getY());
		}
		
		function redrawCursor(e:MouseEvent){
			mouse.x = e.stageX;
			mouse.y = e.stageY;
		}
	}
	
}
