package  {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
    import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	public class miniPreview extends MovieClip {
		var mesh:Bitmap;
		
		public function miniPreview(target) {
			update(target);
		}
		
		public function update(target){
			if(this.numChildren > 0){
				removeChild(mesh);			
			}
			var raw:BitmapData = new BitmapData(512,512,true,0x33FFFFFF);
			raw.draw(target);
			mesh = new Bitmap(raw);
			
			addChild(mesh);
			
			scaleX = scaleY = 0.18;
		}
	}
	
}
