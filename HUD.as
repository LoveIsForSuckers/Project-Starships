package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import events.UpdateHUDEvent;
	
	
	public class HUD extends MovieClip {
		var angleR,angleD;
		
		public function HUD() {
			// constructor code
			x = y = 0;
		}
		
		public function updateCoord(a,b,c,d){
			coordinates.text = "hero X: " + String(a) + " Y: " + String(b); // coordstring
			
			if((c < 0) || (c > 800) || (d < 0) || (d > 480)){ // pointer arrow atan2 rotation
				pointerArrow.visible = true;
				angleR = Math.atan2(d - pointerArrow.y,c - pointerArrow.x)/(Math.PI/180);
				angleD = pointerArrow.rotation - angleR;
				if(angleD > 180){
					angleD = -360 + angleD;
				}
				if(angleD < -180){
					angleD = 360 + angleD;
				}
				pointerArrow.rotation -= angleD;
			} else if(pointerArrow.visible == true){
				pointerArrow.visible = false;
			}
		}
	}
	
}
