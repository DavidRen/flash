package
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import org.osmf.media.MediaPlayerSprite;
	
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
		////////////////////////////////////////////////////
		//DECLARATIONS
		////////////////////////////////////////////////////
		
		//URI of the media
		public static const PROGRESSIVE_PATH:String = "http://localhost/flv/1.flv";
		public static const STREAMING_PATH:String = "rtmp://cp67126.edgefcs.net/ondemand/mediapm/osmf/content/test/akamai_10_year_f8_512K";
		public static const STREAMING_MP4_PATH:String = "rtmp://cp67126.edgefcs.net/ondemand/mp4:mediapm/ovp/content/demo/video/elephants_dream/elephants_dream_768x428_24.0fps_408kbps.mp4";
		public static const HLS_VIDEO:String = "http://101.66.255.104:9110/real.m3u8?channel_idx=1&device_id=A006yd14sc00troxOUPR&rate=1000";
		//public static const HLS_VIDEO:String = "http://localhost/TestM3u8/t.m3u8";
		public var playerSprite:MediaPlayerSprite;
		public var player:MediaPlayer;
		private var element:MediaElement
		private var container:MediaContainer
		////////////////////////////////////////////////////
		//CONSTRUCTOR
		////////////////////////////////////////////////////
		
		public function Main()
		{
			this.initPlayer();
			//this.stage.displayState = StageDisplayState.NORMAL;
			this.stage.addEventListener(MouseEvent.DOUBLE_CLICK,doubelClickEvent);
			
			//this.stage.addEventListener(MouseEvent.CLICK,pauseClickEvent);
			this.stage.doubleClickEnabled = true;
		}
		
		protected function pauseClickEvent(e:MouseEvent):void{
			if(this.player.paused){
				this.player.play();
				
			}
			else{
				
				this.player.pause();
			}
		}
		
		protected function doubelClickEvent(e:MouseEvent):void{
			this._onStageResize();
			trace(e.toString());
		}
		
		protected function _onStageResize():void{
			if (this.stage.displayState == StageDisplayState.NORMAL) {  
				this.stage.displayState = StageDisplayState.FULL_SCREEN;
				
				this.container.width = this.width;  
				
				this.container.height = this.height;  
				
			}  
				
			else if (this.stage.displayState == StageDisplayState.FULL_SCREEN) {    //if you later add fullscreen controls this could me useful  
				this.stage.displayState = StageDisplayState.NORMAL;
//				this.container.width = stage.stageWidth;  
//				
//				this.container.height = stage.stageHeight;  
				
			}  

		}
		
		protected function initPlayer():void
		{			
			var factory:DefaultMediaFactory = new DefaultMediaFactory();
			factory.addEventListener(MediaFactoryEvent.PLUGIN_LOAD, onPluginLoaded);
			factory.addEventListener(MediaFactoryEvent.PLUGIN_LOAD_ERROR, onPluginLoadError);
			factory.loadPlugin(new PluginInfoResource(new HLSPluginInfo()));
			var res:URLResource =new URLResource( PROGRESSIVE_PATH );
			element = factory.createMediaElement(res);
			if (element == null) throw new Error('Unsupported media type!');
			player = new MediaPlayer(element);
			container = new MediaContainer();
			container.addMediaElement(element);
			
			container.scaleX = 1;
			container.scaleY = 1;
			
			
			addChild(container);
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