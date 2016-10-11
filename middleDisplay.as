package  {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class middleDisplay extends MovieClip {
		var stats:Stats;
		var slots:Slots;
		var mesh:Shape;	
		var picId = 0;
		var maxId = 4;
		var partName:String;
		var tooltipType = 2;
		
		public function middleDisplay() {
			// constructor code
			stats = new Stats();
			slots = new Slots();
			y = 171;
			drawShape(0);
		}
		
		function drawShape(id){
			mesh = new Shape();
			mesh.x = mesh.y = 0;
			switch(id){
				case 0:
					mesh.graphics.beginBitmapFill(new middleA(), null, true, false);
					slots.SetSlots(1,0,0,1);
					stats.SetStats(100,20,125,130,0,1,20,0,0,2,5,5,2,0);
					partName = "Phoenix Body";
					break;
				case 1:
					mesh.graphics.beginBitmapFill(new middleB(), null, true, false);
					stats.SetStats(100,20,150,200,0,1,25,0,0,2,5,5,2,0);
					slots.SetSlots(0,2,0,1);
					partName = "Siege Reconfiguration";
					break;
				case 2:
					mesh.graphics.beginBitmapFill(new middleC(), null, true, false);
					stats.SetStats(80,20,90,120,0,1,15,0,0,2,5,5,2,0);
					slots.SetSlots(2,0,0,0);
					partName = "Traveler M";
					break;
				case 3:
					mesh.graphics.beginBitmapFill(new middleD(), null, true, false);
					stats.SetStats(60,50,100,100,0,1,20,0,0,2,5,5,2,0);
					slots.SetSlots(1,0,1,2);
					partName = "The SR-3";
					break;
				case 4:
					mesh.graphics.beginBitmapFill(new middleE(), null, true, false);
					stats.SetStats(180,20,210,350,0,1,25,0,0,2,5,5,2,0);
					slots.SetSlots(1,1,1,1);
					partName = "Atlas";
					break;
			}

			mesh.graphics.drawRect(0,0,512,171);
			mesh.graphics.endFill();
			addChild(mesh);
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
		
		public function GetAttachPoint(idd:int):attachPoint{
			var point;
			switch(picId){
				case 0:
					point = new attachPoint(1,256,285);
					break;
				case 1:
					if(idd == 0){
						point = new attachPoint(2,97,259);
					} else {
						point = new attachPoint(2,415,259);
					}
					break;
				case 2:
					if(idd == 0){
						point = new attachPoint(1,256,221);
					} else {
						point = new attachPoint(1,293,296);
					}
					break;
				case 3:
					point = new attachPoint(1,256,321);
					break;
				case 4:
					if(idd == 0){
						point = new attachPoint(1,121,203);
					} else {
						point = new attachPoint(2,388,247);
					}
					break;
			}
			
			return point;
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
