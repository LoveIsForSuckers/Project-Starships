package  {
	import flash.display.MovieClip;
	
	public class nameDescTooltip extends MovieClip {
		var vName,vDescription:infoText;

		public function nameDescTooltip(nm:String,dscr:String) {
			vName = new infoText(0xFFFFFF);
			vName.SetText(nm);
			
			vDescription = new infoText(0x00FF00);
			vDescription.SetText(dscr);
			//vName.x = vDescription.x = 8;
			vDescription.y = 16;
			
			addChild(vName);
			addChild(vDescription);
			
			backgr.height = 100;
			backgr.width = 160;
			
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		public function SetValues(nm:String,dscr:String){
			vName.SetText(nm);
			vDescription.SetText(dscr);
		}

	}
	
}
