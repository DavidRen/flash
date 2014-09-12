package Clock
{
	import flash.events.KeyboardEvent;
	
	import mx.controls.Alert;
	
	public class Ren 
	{
		
		public var t:s;
		
		public function Ren()
		{
			
//			t.addEventListener(KeyboardEvent.KEY_DOWN,keyboardd);
		}
		public function tope():void{
			t.myVid.source = "http://127.0.0.1/flv/1.flv";
			
//			t.alertHi();
		}
		public function keyboardd(event:KeyboardEvent):void{
			
			if(event.keyCode == 32){
				t.display();
			}
		}	
	}
}