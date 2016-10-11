package celestial{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import dynamics.DynamicObject;
	
	public class CelestialBody extends DynamicObject{
		// celestial body - star, planet or moon
		var orbitAround:CelestialBody;
		var orbitHeight,radianSpeed;
		var FI;

		public function CelestialBody() {
			// constructor code
			addEventListener(Event.ENTER_FRAME,enterFrameF);
			signature = 128;
			rotation = 0;
			FI = 0;
		}
				
		public function SetOrbit(ref:CelestialBody,distance,rad,pos){
			x = ref.x;
			y = ref.y;
			orbitAround = ref;
			orbitHeight = distance;
			radianSpeed = rad;
			FI = pos;
		}
		
		public function ModifyFI(time:int){
			FI += time * radianSpeed;
		}
		
		public function SetStatic(X,Y){
			x = X;
			y = Y;
		}
				
		function enterFrameF(e:Event){
			if(orbitAround != null){
				// move like a boss in POLAR COORDINATES
				FI+=radianSpeed;
				if(FI == 2*PI) FI = 0;
				x = orbitAround.x + orbitHeight*Math.cos(FI);
				y = orbitAround.y + orbitHeight*Math.sin(FI);
			}
		}

	}
	
}
