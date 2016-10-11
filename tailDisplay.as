package  {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class tailDisplay extends MovieClip {
		var stats:Stats;
		var slots:Slots;
		var mesh:Shape;
		var picId = 0;
		var maxId = 4;
		var tooltipType = 3;
		var partName:String;
		
		public function tailDisplay() {
			// constructor code
			stats = new Stats();
			slots = new Slots();
			y = 342;
			drawShape(0);
		}
		
		function drawShape(id){
			mesh = new Shape();
			mesh.x = mesh.y = 0;
			switch(id){
				case 0:
					mesh.graphics.beginBitmapFill(new tailA(), null, true, false);
					stats.SetStats(50,0,0,80,800,0,0,0,0,0,0,0,0,0);
					slots.SetSlots(0,0,0,0);
					partName = "Fastlane";
					break;
				case 1:
					mesh.graphics.beginBitmapFill(new tailB(), null, true, false);
					stats.SetStats(80,0,0,100,600,0,0,0,0,0,0,0,0,0);
					slots.SetSlots(0,0,0,1);
					partName = "Armagio";
					break;
				case 2:
					mesh.graphics.beginBitmapFill(new tailC(), null, true, false);
					stats.SetStats(0,0,0,20,300,0,0,0,0,0,0,0,0,0);
					slots.SetSlots(0,0,0,3);
					partName = "Poodle Deluxe";
					break;
				case 3:
					mesh.graphics.beginBitmapFill(new tailD(), null, true, false);
					stats.SetStats(30,0,0,50,600,0,0,0,0,0,0,0,0,0);
					slots.SetSlots(0,0,1,2);
					partName = "Delta V Speedsters";
					break;
				case 4:
					mesh.graphics.beginBitmapFill(new tailE(), null, true, false);
					stats.SetStats(100,0,0,170,800,0,0,0,0,0,0,0,0,0);
					slots.SetSlots(0,1,1,1);
					partName = "Titan's Burden";
					break;
			}

			mesh.graphics.drawRect(0,0,512,171);
			mesh.graphics.endFill();
			addChild(mesh);
		}
		
		public function GetAttachPoint(idd:int):attachPoint{
			var point;
			switch(picId){
				case 0:
					break;
				case 1:
					break;
				case 2:
					break;
				case 3:
					break;
				case 4:
					point = new attachPoint(2,256,412);
					break;
			}
			
			return point;
		}
		
		public function Incr(){
			removeChild(mesh);
			if(picId < maxId){
				picId += 1;
			} else {
				picId = 0;
			}
			drawShape(picId);
		}
		
		public function Decr(){
			removeChild(mesh);
			if(picId > 0){
				picId -= 1;
			} else {
				picId = maxId;
			}
			drawShape(picId);
		}
		
		public function getPicId(){
			return picId;
		}
		
		public function setPicId(idd){
			removeChild(mesh);
			picId = idd;
			drawShape(picId);
		}
		
		public function getMaxId(){
			return maxId;
		}
		
		public function GetStats(){				
			return stats;
		}
	}
	
}
