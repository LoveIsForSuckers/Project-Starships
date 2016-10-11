package  {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
    import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class backScene extends MovieClip {
		var particle:Array = new Array(1000);
		
		public function backScene(seed) {
			// constructor code
			var i=1000;
			var j=3;
			var r=seed;
			var d=0;
			var color1,color2;
			switch(seed){
				case 24:
					color1 = 0x443388;
					color2 = 0xFFFF99;
					break;
				case 182:
					color1 = 0x99FF99;
					color2 = 0x006688;
					break;
				case 224:
					color1 = 0x990000;
					color2 = 0x555555;
					break;
				case 333:
					color1 = 0x443388;
					color2 = 0x990099;
					break;
				case 477:
					color1 = 0x333399;
					color2 = 0x0000FF;
					break;
				case 525:
					color1 = 0x99CC00;
					color2 = 0x99FF99;
					break;
				case 66:
					color1 = 0x990000;
					color2 = 0xFF0000;
					break;
				case 799:
					color1 = 0x443388;
					color2 = 0x440044;
					break;
				default:
					switch(seed%4){
						case 0:
							color1 = 0x339966;
							color2 = 0xAACC00;
							break;
						case 1:
							color1 = 0x330066;
							color2 = 0xFF3300;
							break;
						case 2:
							color1 = 0x660000;
							color2 = 0x333333;
							break;
						default:
							color1 = 0x330066;
							color2 = 0x00CCFF;
							break;
					}
					break;
			}
			while(i>120){
				i--;
				particle[i-1] = new GrassParticle(0.7); // middle stars
				addChild(particle[i-1]);
			}
			while(i<=120 && i>0){
				i--;
				j--;
				d+= 0.2*i;
				r++;
				if(j == 0) j = 3;
				if(r%2 == 1) particle[i-1] = new Flower(j,color1,2 + Math.cos(d),1 + 0.5*Math.cos(d));
				if(r%2 == 0) particle[i-1] = new Flower(j,color2,2 + Math.cos(d),1 + 0.5*Math.cos(d));
				particle[i-1].setcoord(1024+d*Math.cos(r),1024+d*Math.sin(r));
				addChild(particle[i-1]);
			}
			var tmpbitmap = new BitmapData(2600,2048,true,0x000000FF);
			tmpbitmap.draw(this);
			var bmp = new Bitmap(tmpbitmap);
			bmp.x = -950;
			bmp.y = -480;
			addChild(bmp);
			i=1000;
			while(i>0){
				i--;
				removeChild(particle[i-1]);
			}
		}
		
		function setcoord(X,Y){
			x = X;
			y = Y;
		}
	}
	
}
