package  dynamics{
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.display.GradientType;
	import flash.display.GraphicsGradientFill;
	import events.UpdateHUDEvent;
	import dynamics.DynamicObject;
	
	
	public class Starship extends DynamicObject{
		static var PI = Math.PI;
		
		var angleR,angleD,targetX,targetY,isAccelerating;
		var acceleration,rotSpeed,maxSpeed:int;
		var stats:Stats;
		var slots:Slots;
		var equipment:Vector.<equipItem>
		var shd:Shape;
		var bmp:Bitmap;
		
		public function Starship(bodyType, kX, kY, stts:Stats,slts:Slots,eqip:Vector.<equipItem>,raw:BitmapData) {
			// constructor code
			construct(bodyType);
			addEventListener(Event.ADDED_TO_STAGE, init);
			isAccelerating = false;
			canMove = true;
			speed = 0;
			rotSpeed = 5;
			x = kX;
			y = kY;
			rotation = 0;
			angleR = 0;
			angleD = 0;
			acceleration = 0;
			
			stats = stts;
			slots = slts;
			equipment = eqip;
			
			shd = new Shape();
			var mat:Matrix= new Matrix();
			mat.translate(-256,-256);
			var colors:Array=[0x000000,0x000000];
			var alphas:Array=[0.4,0];
			var ratios:Array=[0,255];
			mat.createGradientBox(512,512,0,-256,-256);
			shd.graphics.lineStyle();
			shd.graphics.beginGradientFill(GradientType.RADIAL,colors,alphas,ratios,mat);
			shd.graphics.drawCircle(0,0,512);
			shd.graphics.endFill();
			
			
			bmp = new Bitmap(raw);
			bmp.x = bmp.y = -256;
			scaleX = scaleY = 0.125;
			
			addChild(shd);
			addChild(bmp);
			
		}
		
		function init(e:Event){
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseD);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseU);
			addEventListener(Event.ENTER_FRAME, enterFrameF);
			
			var tmp = stats.GetEngineForce() / stats.GetMass();
			acceleration = tmp / 30;
			
			maxSpeed = 6 + int(1.5 * tmp);
		}
		
		function construct(bT){
			switch(bT){
				case 0:
					setInfo("Mandrake","Your ship. Prototype modular frigate.");
					break;
				default:
					setInfo("Espero","Basic human frigate.");
					break;
			}
		}
		
		function mouseD(e:MouseEvent){
			 isAccelerating = true;
		}
		
		function mouseU(e:MouseEvent){
			 isAccelerating = false;
		}
		
		function enterFrameF(e:Event):void{
			
			dispatchEvent(new UpdateHUDEvent("updateHUD",x,y));
			
			angleR = Math.atan2(parent.mouseY - y,parent.mouseX - x)/(PI/180); //between mouse and player
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
					if(speed < maxSpeed){
						speed += acceleration;
					}
				} else {
					if(speed > 0.3){
						speed *= 0.9;
					} else {
						speed = 0;
					}
				}
				x += speed*Math.cos(rotation/180*PI);
				y += speed*Math.sin(rotation/180*PI);
			}
			
		}

	}
	
}
