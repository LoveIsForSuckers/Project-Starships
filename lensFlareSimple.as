package  {
	
	import flash.display.MovieClip;
	import dynamics.DynamicObject;
	
	
	public class lensFlareSimple extends DynamicObject {

		public function lensFlareSimple(scale) {
			// constructor code
			this.mouseChildren = false;
			this.mouseEnabled = false;
			scaleX = scaleY = scale;
			cacheAsBitmap = true;
		}

	}
	
}
