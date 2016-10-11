package  {
	
	import flash.display.Sprite;
	
	public class GrassParticle extends Sprite {
		
		public function GrassParticle(scale){
			x = Math.random()*4096;
			y = Math.random()*4096;
			scaleX = scaleY = (1.4 - Math.random())*scale;
			alpha = 0.5*scaleX + 0.5;
		}
	}
	
}
