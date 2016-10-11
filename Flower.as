package  {
	
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.GraphicsGradientFill;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	
	public class Flower extends Sprite {
		var maskingShape,maskedShape,colorShape:Shape;
		
		public function Flower(tex,color:uint,scl,ecc) {
			// constructor code
			maskingShape = new Shape();
			maskedShape = new Shape();
			colorShape = new Shape();
			maskedShape.cacheAsBitmap = true;
			colorShape.cacheAsBitmap = true;
			maskingShape.cacheAsBitmap = true;
			addChild(maskedShape);
			addChild(colorShape);
			addChild(maskingShape);
			drawTexture(tex,color);
			drawMask();
			maskedShape.mask = maskingShape;
			upscale(scl,ecc);
		}
		
		function drawMask(){
			var mat:Matrix= new Matrix();
			var colors:Array=[0xFFFFFF,0xFFFFFF];
			var alphas:Array=[0.7,0];
			var ratios:Array=[0,255];
			mat.createGradientBox(maskedShape.width,maskedShape.height);
			maskingShape.graphics.lineStyle();
			maskingShape.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat);
			maskingShape.graphics.drawEllipse(0,0,maskedShape.width,maskedShape.height);
			maskingShape.graphics.endFill();
		}
		
		function drawTexture(arg,color){
			if(arg == 1){
				maskedShape.graphics.beginBitmapFill(new nebulaTex1(), null, true, false);
			}
			if(arg == 2){
				maskedShape.graphics.beginBitmapFill(new nebulaTex2(), null, true, false);
			}
			if(arg == 3){
				maskedShape.graphics.beginBitmapFill(new nebulaTex3(), null, true, false);
			}
			maskedShape.graphics.drawRect(0,0,256,256);
			maskedShape.graphics.endFill();
			var mat:Matrix= new Matrix();
			var colors:Array=[color,color];
			var alphas:Array=[0.5,0];
			var ratios:Array=[128,255];
			mat.createGradientBox(maskedShape.width,maskedShape.height);
			colorShape.graphics.lineStyle();
			colorShape.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat);
			colorShape.graphics.drawEllipse(0,0,maskedShape.width,maskedShape.height);
			colorShape.graphics.endFill();
		}
		
		function upscale(scale,eccentrity){
			maskedShape.scaleX = maskingShape.scaleX = colorShape.scaleX = scale;
			maskedShape.scaleY = maskingShape.scaleY = colorShape.scaleY = scale*eccentrity;
			rotation = eccentrity;
			alpha = 0.5*scale - 1.1;
		}
		
		public function setcoord(X,Y){
			x = X;
			y = Y;
		}
	}
	
}
