package  {
	
	import flash.display.MovieClip;
	
	
	public class sceneActTooltip extends MovieClip {
		var id:int;
		
		public function sceneActTooltip(str:String) {
			id = -1;
			SetText(str);
		}
		
		public function SetText(str:String){
			textStr.text = str;
		}
		
		public function SetId(idd:int){
			id = idd;
		}
		
		public function GetId():int{
			return id;
		}
		
	}
	
}
