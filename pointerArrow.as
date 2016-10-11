package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class pointerArrow extends MovieClip {
		var timer;
		
		public function pointerArrow() {
			// constructor code
			addEventListener(Event.ENTER_FRAME, enterFrameF);
			timer = 0;
			visible = false;
		}
		function enterFrameF(e:Event):void{
			if(visible == true){
				timer += 1;
				if(timer < 10){
					scaleX += 0.02;
					scaleY += 0.02;
				}
				if(timer > 11){
					scaleX -= 0.02;
					scaleY -= 0.02;
				}
				if(timer == 20){
					timer = 0;
				}
			}
		}
	}
	
}
