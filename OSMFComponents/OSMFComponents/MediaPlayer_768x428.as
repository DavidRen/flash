package
{
	import com.devnet.osmf.controls.SimpleButton;
	import com.devnet.osmf.events.*;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	public class MediaPlayer_768x428 extends MovieClip
	{
		public function MediaPlayer_768x428()
		{
			trace("media player start");
			stage.addEventListener(KeyboardEvent.KEY_DOWN,keyboardPress);
			
			
		//		PlayPauseButton.addEventListener(MouseEvent.CLICK,mouseClick);
		}
		
		public function keyboardPress(evt:KeyboardEvent):void{
			
			if(evt.keyCode == 32){
			
				stage.fullScreenSourceRect = new Rectangle(0,0,320,240);
				trace('space was pressed');
				
			}
		}
		
//		public function mouseClick(evt:MouseEvent):void{
//			trace('click');
//		}
		
}
}