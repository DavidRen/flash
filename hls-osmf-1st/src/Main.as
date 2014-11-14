package
{
	import flash.display.MovieClip;
	
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
		
		////////////////////////////////////////////////////
		//CONSTRUCTOR
		////////////////////////////////////////////////////
		
		public function Main()
		{
			this.initPlayer();
		}
		
		
		protected function initPlayer():void
		{			
			var factory:DefaultMediaFactory = new DefaultMediaFactory();
			factory.addEventListener(MediaFactoryEvent.PLUGIN_LOAD, onPluginLoaded);
			factory.addEventListener(MediaFactoryEvent.PLUGIN_LOAD_ERROR, onPluginLoadError);
			factory.loadPlugin(new PluginInfoResource(new HLSPluginInfo()));
			var res:URLResource =new URLResource( HLS_VIDEO );
			var element:MediaElement = factory.createMediaElement(res);
			if (element == null) throw new Error('Unsupported media type!');
			var player:MediaPlayer = new MediaPlayer(element);
			var container:MediaContainer = new MediaContainer();
			container.addMediaElement(element);
			container.scaleX = .75;
			container.scaleY = .75;
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