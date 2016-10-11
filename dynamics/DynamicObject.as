package dynamics{
	
	import flash.display.MovieClip;
	
	public class DynamicObject extends MovieClip {
		// This is the object which interacts with all other DO's in the game
		protected var speed,signature:uint;
		protected var vName,dscription;
		protected var canMove:Boolean;
		protected static var PI = Math.PI;
		public function DynamicObject() {
			// constructor code
		}
		
		public function distanceTo(X,Y) {
			var a,b:uint;
			a = Math.pow(x - X,2);
			b = Math.pow(y - Y,2);
			return Math.sqrt(a + b);
		}
		
		public function setInfo(nm,dscr){
			vName = nm;
			dscription = dscr;
		}
		
		public function GetName(){
			return vName;
		}
		
		public function GetDescription(){
			return dscription;
		}
		
		public function GetSignature(){
			return signature;
		}
		
		public function GetMovement(){
			return canMove;
		}
		
		public function SetMovement(arg:Boolean){
			canMove = arg;
		}

	}
	
}
