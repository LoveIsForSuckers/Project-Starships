package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class medStarShimmer extends MovieClip {
		
		var timer;
		var up:Boolean;
		
		public function medStarShimmer() {
			// constructor code
			timer = int(Math.random()*50);
			up = true;
			addEventListener(Event.ENTER_FRAME,enterFrameF);
		}
		
		function enterFrameF(e:Event){
			if(up == true){
				timer += 1;
			}
			if(up == false){
				timer -= 1;
			}
			if(timer > 100){
				up = false;
			}
			if(timer < 0){
				up = true;
			}
			alpha = 0.1 + Math.sin(0.01*timer);
		}
	}
	
}
