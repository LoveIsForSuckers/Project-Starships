package  {
	
	import flash.display.MovieClip;
	
	
	public class Stone extends MovieClip {
		
		
		public function Stone() {
			// constructor code
			x = Math.random()*4096;
			y = Math.random()*4096;
			scaleX = scaleY = 0.5*Math.random() + 0.5;
			rotation = Math.random()*360;
		}
	}
	
}
