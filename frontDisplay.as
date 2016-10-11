package  {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	public class frontDisplay extends MovieClip {
		var stats:Stats;
		var slots:Slots;
		var partName:String;
		var mesh:Shape;	
		var picId = 0;
		var maxId = 4;
		var tooltipType = 1;
		
		public function frontDisplay() {
			// constructor code		
			stats = new Stats();
			slots = new Slots();
			y = 0;
			drawShape(0);
		}
		
		function drawShape(id){
			mesh = new Shape();
			mesh.x = mesh.y = 0;
			switch(id){
				case 0:
					mesh.graphics.beginBitmapFill(new frontA(), null, true, false);
					stats.SetStats(50,0,0,70,0,0,0,80,0,0,0,0,0,0);
					slots.SetSlots(0,0,1,0);
					partName = "Phoenix";
					break;
				case 1:
					mesh.graphics.beginBitmapFill(new frontB(), null, true, false);
					stats.SetStats(90,0,20,140,0,0,0,60,0,0,0,0,0,0);
					slots.SetSlots(2,0,0,1);
					partName = "XM-3158";
					break;
				case 2:
					mesh.graphics.beginBitmapFill(new frontC(), null, true, false);
					stats.SetStats(20,0,0,40,0,0,0,100,0,0,0,0,0,0);
					slots.SetSlots(1,0,1,0);
					partName = "Gearhead Mk.II";
					break;
				case 3:
					mesh.graphics.beginBitmapFill(new frontD(), null, true, false);
					stats.SetStats(20,0,0,30,0,0,0,100,0,0,0,0,0,0);
					slots.SetSlots(0,0,1,1);
					partName = "Swift";
					break;
				case 4:
					mesh.graphics.beginBitmapFill(new frontE(), null, true, false);
					stats.SetStats(100,0,20,180,0,0,0,80,0,0,0,0,0,0);
					slots.SetSlots(2,0,1,1);
					partName = "SecuryCo Lynx";
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
					if(idd == 0){
						point = new attachPoint(1,184,118);
					} else {
						point = new attachPoint(1,328,118);
					}
					break;
				case 2:
					point = new attachPoint(1,243,83);
					break;
				case 3:
					break;
				case 4:
					if(idd == 0){
						point = new attachPoint(1,205,120);
					} else {
						point = new attachPoint(1,307,120);
					}
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
