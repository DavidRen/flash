package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osmf.events.BufferEvent;
	import org.osmf.events.MediaElementEvent;
	import org.osmf.events.PlayEvent;
	import org.osmf.events.TimeEvent;
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.traits.PlayState;
	
	//Sets the size of the SWF
	[SWF(width="800", height="600")]
	
	public class Main extends MovieClip
	{
		import org.osmf.media.MediaPlayerSprite;
		import org.osmf.elements.VideoElement;
		import org.osmf.media.URLResource;
		import org.osmf.utils.URL;
		import org.osmf.media.DefaultMediaFactory;
		import org.osmf.events.MediaFactoryEvent;
		import org.osmf.media.PluginInfoResource;
		import org.osmf.media.MediaElement;
		import org.osmf.media.MediaPlayer;
		import org.osmf.containers.MediaContainer;
		import org.denivip.osmf.plugins.HLSPluginInfo;
		import org.denivip.osmf.events.HTTPHLSStreamingEvent;
		import flash.display.StageDisplayState;
		import org.osmf.containers.MediaContainer;
		import org.osmf.elements.ImageElement;
		import org.osmf.layout.LayoutMetadata;
		import org.osmf.traits.LoadTrait;
		import org.osmf.traits.MediaTraitType;
		import org.osmf.layout.ScaleMode;
		////////////////////////////////////////////////////
		//DECLARATIONS
		////////////////////////////////////////////////////
		
		//URI of the media
		public static const PROGRESSIVE_PATH:String = "http://localhost/media/1.flv";
		public static const STREAMING_PATH:String = "rtmp://cp67126.edgefcs.net/ondemand/mediapm/osmf/content/test/akamai_10_year_f8_512K";
		public static const STREAMING_MP4_PATH:String = "http://114.80.149.144/vweixinp.tc.qq.com/1007_4458be5ba195444fb6cb1eebf2cd83d7.f10.mp4?sha=a733f8d534ed7bbf6b40690574292a5b6dc6aa48&vkey=85EE78C42679B6B5B6076492BC65855DB929AEB4E66630B9EFAC71F60B909D8805A662717F4A3E94&sha=0&ocid=2406412298&locid=f05381ad-3adb-4e71-9909-a08b9431b59a&size=14825305&ocid=294854572";
		
		public static const HLS_VIDEO:String = "http://101.66.255.104:9110/real.m3u8?channel_idx=1&device_id=A006yd14sc00troxOUPR&rate=1000 ";
		public var playerSprite:MediaPlayerSprite;
		public var player:MediaPlayer;
		private var element:MediaElement
		private var container:MediaContainer
		private var ifPlayed:Boolean = false;
		private var bugLoadTraitStatus:Boolean = false;
		private var bugLoadTrait:LoadTrait
		////////////////////////////////////////////////////
		//CONSTRUCTOR
		////////////////////////////////////////////////////
		
		public function Main()
		{
			this.initPlayer();
			stage.addEventListener(MouseEvent.DOUBLE_CLICK,doubelClickEvent);
			player.addEventListener(BufferEvent.BUFFERING_CHANGE,bufferEvent);
			
			var timer:Timer = new Timer(1000);
			timer.addEventListener(TimerEvent.TIMER,checkBuffer);
			timer.start();
			stage.doubleClickEnabled = false;
			stage.addEventListener(MouseEvent.CLICK,ClickEvent);
			
		}
		
		protected function checkBuffer(e:TimerEvent):void{
			trace('bufferTime is '+player.bufferTime+'||bufferLength is '+player.bufferLength);
			if(player.bufferLength < player.bufferTime && bugLoadTraitStatus == false ){
				bugLoadTrait.load();
				bugLoadTraitStatus = true;
				trace('buffering'+'||bufferTime is '+player.bufferTime+'||bufferLength is '+player.bufferLength);
			}
			else if(player.bufferLength >= player.bufferTime && bugLoadTraitStatus == true ){
				bugLoadTrait.unload();
				bugLoadTraitStatus = false;
				trace('playing'+'||bufferTime is '+player.bufferTime+'||bufferLength is '+player.bufferLength);
			}
		}
		
		protected function bufferEvent(e:BufferEvent):void{
			trace(player.buffering?'In buffer model':'In playing model');
		}
		
		
		
		protected function ClickEvent(e:MouseEvent):void{
			if(this.player.paused){
				this.player.play();
			}
			else{
				this.player.pause();
			}
			if(!this.ifPlayed){
				this.ifPlayed = true;
				player.bufferTime =16;// set buffertime of player if never set it before
			}
		}
		
		
		protected function doubelClickEvent(e:MouseEvent):void{
			this._onStageResize();
		}
		
		
		protected function _onStageResize():void{
			if (this.stage.displayState == StageDisplayState.NORMAL) {  
				this.stage.displayState = StageDisplayState.FULL_SCREEN;
	
			}  
				
			else if (this.stage.displayState == StageDisplayState.FULL_SCREEN) {    //if you later add fullscreen controls this could me useful  
				this.stage.displayState = StageDisplayState.NORMAL;
				
			}  

		}
		
		protected function initPlayer():void
		{			
			var factory:DefaultMediaFactory = new DefaultMediaFactory();
			factory.addEventListener(MediaFactoryEvent.PLUGIN_LOAD, onPluginLoaded);
			factory.addEventListener(MediaFactoryEvent.PLUGIN_LOAD_ERROR, onPluginLoadError);
			factory.loadPlugin(new PluginInfoResource(new HLSPluginInfo()));
			
			var para:Object = stage.loaderInfo.parameters;
			var res:URLResource;
			//get media src from flashvars in web page
			try{
				res =new URLResource( para['src'] );
			}catch(e:Error){
				res = new URLResource(HLS_VIDEO)
			}
			//if res.url is empty
			if(res.url == null)
				res = new URLResource(HLS_VIDEO);
			element = factory.createMediaElement(res);
			
			if (element == null) throw new Error('Unsupported media type!');
			player = new MediaPlayer(element);
			trace(element.metadata);
			container = new MediaContainer();
			
			container.addMediaElement( element );
			
			var bugUrlResource:URLResource = new URLResource( "assets/buffering.gif" );
			var bug:ImageElement = new ImageElement( bugUrlResource );
			
			var layoutData:LayoutMetadata = new LayoutMetadata();
			layoutData.percentX = 50;
			layoutData.percentY = 50;
			layoutData.scaleMode = ScaleMode.STRETCH;
			bug.metadata.addValue( LayoutMetadata.LAYOUT_NAMESPACE, layoutData );
			bugLoadTrait = bug.getTrait( MediaTraitType.LOAD ) as LoadTrait; 
//			bugLoadTrait.load();
			container.addMediaElement( bug );
			this.addChild(container);
		}
		private function onPluginLoaded(event:MediaFactoryEvent):void
		{
			trace("Plugin successed to load.");
		}
		
		private function onPluginLoadError(event:MediaFactoryEvent):void
		{
			trace("Plugin failed to load.");
			
		}
	}
}