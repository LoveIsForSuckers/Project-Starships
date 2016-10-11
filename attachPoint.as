package  {
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class attachPoint extends MovieClip{
		var occupied:Boolean;
		var attachType,w,h:int;
		var mesh:Shape;

		public function attachPoint(atchType:int,cX,cY) {
			x = cX;
			y = cY;
			attachType = atchType;
			occupied = false;
			if(attachType == 1){
				w = 48;
				h = 48;
			} else {
				w = h = 128;
			}
		}
		
		public function SetAttach(attachName:String){
			if(numChildren > 0){
				removeChild(mesh);
			}
			occupied = true;
			DrawGraphics(attachName);
		}
		
		public function ClearAttach(){
			if(numChildren > 0){
				removeChild(mesh);
			}
			occupied = false;
		}
		
		function DrawGraphics(idd:String){
			mesh = new Shape();
			mesh.x = mesh.y = -w/2;
			
			switch(idd){
				case "Micrometeorite Gun":
					mesh.graphics.beginBitmapFill(new cannonB(), null, true, false);
					break;
				case "Light Artillery":
					mesh.graphics.beginBitmapFill(new cannonA(), null, true, false);
					break;
				case "Electron Blaster":
					mesh.graphics.beginBitmapFill(new blasterA(), null, true, false);
					break;
				case "Thermal Blaster":
					mesh.graphics.beginBitmapFill(new blasterB(), null, true, false);
					break;
				case "Giant Buster Gun":
					mesh.graphics.beginBitmapFill(new biggunA(), null, true, false);
					break;
				default:
					break;
			}
			
			mesh.graphics.drawRect(0,0,w,h);
			mesh.graphics.endFill();
			addChild(mesh);	
		}

	}
	
}
