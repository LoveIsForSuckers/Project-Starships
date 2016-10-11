package  celestial {
	
	import flash.display.Shape;
	import flash.display.GraphicsGradientFill;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	
	public class Star extends CelestialBody{
	
		var texture,gradmask,colormask:Shape;
		
		public function Star(scale,color,nm,descr) { 
			// constructor code
			setInfo(nm,descr);
			SetStatic(0,0);
			texture = new Shape();
			gradmask = new Shape();
			colormask = new Shape();
			texture.cacheAsBitmap = true;
			gradmask.cacheAsBitmap = true;
			colormask.cacheAsBitmap = true;
			addChild(texture);
			addChild(colormask);
			addChild(gradmask);
			drawTexture(color);
			drawMask();
			gradmask.mask = texture;
			upscale(scale);
			addEventListener(Event.ENTER_FRAME,enterFrameF);
		}
		
		override function enterFrameF(e:Event){
			texture.rotation += 0.05;
		}
		
		function drawMask(){
			var mat:Matrix= new Matrix();
			var colors:Array=[0xFFFFFF,0xFFFFFF];
			var alphas:Array=[1,0];
			var ratios:Array=[160,255];
			mat.createGradientBox(256,256,0,-128,-128);
			gradmask.graphics.lineStyle();
			gradmask.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat);
			gradmask.graphics.drawCircle(0,0,256);
			gradmask.graphics.endFill();
		}
		
		function drawTexture(color){
			var mat:Matrix= new Matrix();
			mat.translate(-128,-128);
			texture.graphics.beginBitmapFill(new nebulaTex1(), mat, true, false);
			texture.graphics.drawCircle(0,0,256);
			texture.graphics.endFill();
			var colors:Array=[0xFFFFFF,color];
			var alphas:Array=[0.9,0];
			var ratios:Array=[160,255];
			mat.createGradientBox(256,256,0,-128,-128);
			colormask.graphics.lineStyle();
			colormask.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat);
			colormask.graphics.drawCircle(0,0,256);
			colormask.graphics.endFill();
		}
		
		function upscale(scale){
			signature *= scale;
			texture.scaleX = gradmask.scaleX = colormask.scaleX = texture.scaleY = gradmask.scaleY = colormask.scaleY = scale;
		}
	}
	
}
