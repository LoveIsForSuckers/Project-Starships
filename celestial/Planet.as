package  celestial{
	
	import flash.display.Shape;
	import flash.display.GraphicsGradientFill;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.Event;
	
	public class Planet extends CelestialBody{
		
		var texture,gradmask,colormask,shadowmask:Shape;
		var angleR,angleD;
		var canLand:Boolean;
		var tp;
		
		public function Planet(type,scale,color,orbitT,orbitH,orbitS,orbitA,nm:String,descr:String,landable:Boolean) {
			// constructor code
			setInfo(nm,descr);
			SetOrbit(orbitT,orbitH,orbitS,orbitA);
			tp = type;
			texture = new Shape();
			gradmask = new Shape();
			colormask = new Shape();
			shadowmask = new Shape();
			texture.cacheAsBitmap = true;
			gradmask.cacheAsBitmap = true;
			colormask.cacheAsBitmap = true;
			shadowmask.cacheAsBitmap = true;
			addChild(texture);
			addChild(gradmask);
			addChild(colormask);
			addChild(shadowmask);
			drawTexture(tp,color);
			drawAtmos(tp,color);
			colormask.mask = shadowmask;
			upscale(scale);
			canLand = landable;
			addEventListener(Event.ENTER_FRAME,enterFrameF);
		}
		
		function drawAtmos(type,color){
			if(type < 3){ // atmosphere + aurora
				var mat:Matrix= new Matrix();
				var colors:Array=[color,0xFFFFFF,color];
				var alphas:Array=[0.2,0.5,0];
				var ratios:Array=[0,224,255];
				mat.createGradientBox(280,280,0,-140,-140);
				gradmask.graphics.lineStyle();
				gradmask.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat);
				gradmask.graphics.drawCircle(0,0,280);
				gradmask.graphics.endFill();
			}
			if(type == 3 || type == 4){
				// gas giants: atmosphere + aurora but a bit different
				mat = new Matrix();
				colors =[color,color,0xFFFFFF];
				alphas =[0.2,0.5,0];
				ratios =[0,230,255];
				mat.createGradientBox(280,280,0,-140,-140);
				gradmask.graphics.lineStyle();
				gradmask.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat);
				gradmask.graphics.drawCircle(0,0,280);
				gradmask.graphics.endFill();
			}
			if(type >= 5){ // additional tint
				mat = new Matrix();
				colors=[color,color,color];
				alphas=[0.2,0.5,0];
				ratios=[0,250,255];
				mat.createGradientBox(260,260,0,-130,-130);
				gradmask.graphics.lineStyle();
				gradmask.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat);
				gradmask.graphics.drawCircle(0,0,260);
				gradmask.graphics.endFill();
			}
		}
		
		function drawTexture(type,color){
			var mat:Matrix= new Matrix();
			mat.translate(-128,-128);
			mat.rotate(90);
			switch(type){ // textures
				case 0:
					texture.graphics.beginBitmapFill(new uniqueArghusSmall(), mat, true, false);
					texture.graphics.drawCircle(0,0,128);
					texture.graphics.endFill();
					break;
				case 1:
					texture.graphics.beginBitmapFill(new uniqueVertos(), mat, true, false);
					texture.graphics.drawCircle(0,0,128);
					texture.graphics.endFill();
					break;
				case 2:
					texture.graphics.beginBitmapFill(new uniqueNimerus(), mat, true, false);
					texture.graphics.drawCircle(0,0,128);
					texture.graphics.endFill();
					break;
				case 3:
					texture.graphics.beginBitmapFill(new gasGiantSimple(), mat, true, false);
					texture.graphics.drawCircle(0,0,128);
					texture.graphics.endFill();
					break;
				case 4:
					texture.graphics.beginBitmapFill(new gasGiantDark(), mat, true, false);
					texture.graphics.drawCircle(0,0,128);
					texture.graphics.endFill();
					break;
				case 6:
					texture.graphics.beginBitmapFill(new greyRock3(), mat, true, false);
					texture.graphics.drawCircle(0,0,128);
					texture.graphics.endFill();
					break;
				case 7:
					texture.graphics.beginBitmapFill(new greyRock2(), mat, true, false);
					texture.graphics.drawCircle(0,0,128);
					texture.graphics.endFill();
					break;
				case 8:
					texture.graphics.beginBitmapFill(new greyRock1(), mat, true, false);
					texture.graphics.drawCircle(0,0,128);
					texture.graphics.endFill();
					break;
				default:
					texture.graphics.beginBitmapFill(new nebulaTex1(), mat, true, false);
					texture.graphics.drawCircle(0,0,128);
					texture.graphics.endFill();
					break;
			}
			
			// linear shadows
			var colors:Array=[0x000000,0x333333,color,0xFFFFFF];
			var alphas:Array=[0.8,0.5,0.05,0.1];
			var ratios:Array=[0,96,192,255];
			mat.createGradientBox(140,140,0,-70,-70);
			colormask.graphics.lineStyle();
			colormask.graphics.beginGradientFill(GradientType.LINEAR,colors,alphas,ratios,mat);
			if(type < 5){
				colormask.graphics.drawCircle(0,0,140);
			} else {
				colormask.graphics.drawCircle(0,0,128);
			}
			colormask.graphics.endFill();
			
			// gradiental shadow mask
			colors=[0xFFFFFF,0xFFFFFF];
			alphas=[0.2,1];
			ratios=[0,224];
			mat.createGradientBox(256,500,0,-128,-250);
			shadowmask.graphics.lineStyle();
			shadowmask.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat);
			if(type < 5){
				shadowmask.graphics.drawCircle(0,0,140);
			} else {
				shadowmask.graphics.drawCircle(0,0,128);
			}
			shadowmask.graphics.endFill();
		}
		
		function upscale(scale){
			signature *= scale;
			texture.scaleX = gradmask.scaleX = colormask.scaleX = texture.scaleY = gradmask.scaleY = colormask.scaleY = shadowmask.scaleX = shadowmask.scaleY = scale;
		}
		
		public function IsLandable():Boolean{
			return canLand;
		}
		
		override function enterFrameF(e:Event){
			super.enterFrameF(e);
			angleR = Math.atan2(orbitAround.y -  y,orbitAround.x  -  x)/(PI/180);
			angleD = rotation - angleR;
			if(angleD > 180){
				angleD = -360 + angleD;
			}
			if(angleD < -180){
				angleD = 360 + angleD;
			}
			rotation -= angleD;
			if(tp > 2){
				texture.rotation -= 0.03*tp;
			}
		}
	}
	
}
