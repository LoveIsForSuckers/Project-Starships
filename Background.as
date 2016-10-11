package  {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class Background extends MovieClip {
		
		var particle:Array = new Array(1200);
		var mesh:Shape;
		
		public function Background(seed) {
			// constructor code
			mesh = new Shape();
			if(seed < 40){
				mesh.graphics.beginBitmapFill(new b1(), null, true, false);
			} else if (seed < 121){
				mesh.graphics.beginBitmapFill(new b7(), null, true, false);
			} else if (seed < 188){
				mesh.graphics.beginBitmapFill(new b2(), null, true, false);
			} else if (seed < 280){
				mesh.graphics.beginBitmapFill(new b3(), null, true, false);
			} else if (seed < 354){
				mesh.graphics.beginBitmapFill(new b4(), null, true, false);
			} else if (seed < 500){
				mesh.graphics.beginBitmapFill(new b5(), null, true, false);
			} else if (seed < 640){
				mesh.graphics.beginBitmapFill(new b6(), null, true, false);
			} else if (seed < 800){
				mesh.graphics.beginBitmapFill(new b4(), null, true, false);
			} else {
				mesh.graphics.beginBitmapFill(new b2(), null, true, false);
			}
			mesh.graphics.drawRect(0,0,1920,918);
			mesh.graphics.endFill();
			mesh.x = mesh.y = 0;
			addChild(mesh);
			var i=1200;
			while(i>0){
				i--;
				particle[i-1] = new GrassParticle(0.4); // middle stars
				addChild(particle[i-1]);
			}
			var tmpbitmap = new BitmapData(1920,918,false,0x00000000);
			tmpbitmap.draw(this);
			var bmp = new Bitmap(tmpbitmap);
			bmp.x = -700;
			bmp.y = -260;
			addChild(bmp);
			i=1200;
			while(i>0){
				i--;
				removeChild(particle[i-1]);
			}
			removeChild(mesh);
			x = y = 0;
		}
		
		function setcoord(X,Y){
			x = X;
			y = Y;
		}
	}
	
}
