package  celestial {
	
	public class Station extends CelestialBody{
		
		import flash.display.Shape;
		import flash.display.GraphicsGradientFill;
		import flash.geom.Matrix;
		import flash.display.GradientType;
		import flash.display.BitmapData;
		import flash.display.Bitmap;
		import flash.events.Event;
		
		var texture,colormask:Shape;
		var angleR,angleD;
		
		public function Station(type,scale,color,orbitT,orbitH,orbitS,orbitA,nm,descr) {
			// constructor code
			setInfo(nm,descr);
			SetOrbit(orbitT,orbitH,orbitS,orbitA);
			texture = new Shape();
			colormask = new Shape();
			texture.cacheAsBitmap = true;
			colormask.cacheAsBitmap = true;
			addChild(texture);
			addChild(colormask);
			drawTexture(type,color);
			upscale(scale);
		}
		
		function drawTexture(type,color){
			var mat:Matrix= new Matrix();
			mat.translate(-128,-128);
			switch(type){ // textures
				case 0:
					texture.graphics.beginBitmapFill(new tempStation(), mat, true, false);
					texture.graphics.drawRect(-128,-128,256,256);
					texture.graphics.endFill();
					break;
				case 1:
					texture.graphics.beginBitmapFill(new scienceStation(), mat, true, false);
					texture.graphics.drawRect(-128,-128,256,256);
					texture.graphics.endFill();
					break;
				case 2:
					texture.graphics.beginBitmapFill(new militaryStation(), mat, true, false);
					texture.graphics.drawRect(-128,-128,256,256);
					texture.graphics.endFill();
					break;
				default:
					texture.graphics.beginBitmapFill(new nebulaTex1(), mat, true, false);
					texture.graphics.drawRect(-128,-128,256,256);
					texture.graphics.endFill();
					break;
			}
			
			// radial glow
			var colors:Array=[0xFFFFFF,color,color,0xFFFFFF];
			var alphas:Array=[0.3,0.2,0.1,0];
			var ratios:Array=[0,96,224,255];
			mat.createGradientBox(256,256,0,-128,-128);
			colormask.graphics.lineStyle();
			colormask.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat);
			colormask.graphics.drawCircle(0,0,256);
			colormask.graphics.endFill();
		}
		
		function upscale(scale){
			signature *= scale;
			texture.scaleX = colormask.scaleX = texture.scaleY = colormask.scaleY = scale;
		}
		
		override function enterFrameF(e:Event){
			super.enterFrameF(e);
			colormask.alpha = Math.random()*0.3 + 0.7;
		}
	}
	
}
