package  {
	
	import flash.display.MovieClip;
	
	
	public class infoText extends MovieClip {
		
		public function infoText(clr) {
			SetColor(clr);
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		public function SetText(str){
			textStr.text = str;
		}
		
		public function SetColor(clr){
			textStr.textColor = clr;
		}
	}
	
}
