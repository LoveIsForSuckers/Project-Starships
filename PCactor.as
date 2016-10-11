package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import events.UpdateHUDEvent;
	import dynamics.DynamicObject;

	public class PCactor extends DynamicObject {
		var attackDelay,rotSpeed,angleR,angleD,isAccelerating;
		static var PI = Math.PI;

		public function PCactor(kX,kY) {
			// constructor code
			addEventListener(Event.ADDED_TO_STAGE, init);
			gotoAndStop(1); // Stand animation
			isAccelerating = false;
			canMove = true;
			attackDelay = 30;
			speed = 5;
			rotSpeed = 5;
			x = kX;
			y = kY;
			rotation = 0;
			angleR = 0;
			angleD = 0;
			mouseChildren = false;
			mouseEnabled = false;
		}
		
		function init(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseD);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseU);
			addEventListener(Event.ENTER_FRAME, enterFrameF);
		}
		
		function mouseD(e:MouseEvent){
			 isAccelerating = true;
		}
		
		function mouseU(e:MouseEvent){
			 isAccelerating = false;
		}
		
		function enterFrameF(e:Event):void{
			dispatchEvent(new UpdateHUDEvent("updateHUD",x,y));
			attackDelay--;
			angleR = Math.atan2(parent.mouseY - y,parent.mouseX - x)/(Math.PI/180); //between mouse and player
			angleD = rotation - angleR;	// between actual rotation and desired
			if(angleD > 180){
				angleD = -360 + angleD;
			}
			if(angleD < -180){
				angleD = 360 + angleD;
			}
			//slowly rotating
			if(Math.abs(angleD) < rotSpeed){
				rotation -= angleD;
			} else if (angleD > 0){
				rotation -= rotSpeed;
			} else {
				rotation += rotSpeed;
			}
			
			if(canMove){			
				if(isAccelerating){
					x += speed*Math.cos(rotation/180*PI);
					y += speed*Math.sin(rotation/180*PI);
					gotoAndStop(2);
				} else {
					gotoAndStop(1);
				}
			}
			
		}
		
		
	}
	
}





	
