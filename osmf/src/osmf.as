package
{
	import flash.display.Sprite;
	
	import org.osmf.display;
	import org.osmf.display.MediaPlayerSprite;
	import org.osmf.elements.AudioElement;
	import org.osmf.elements.VideoElement;
	import org.osmf.media.MediaPlayerSprite;
	import org.osmf.media.URLResource;
	import org.osmf.net.NetLoader;
	import org.osmf.utils.URL;
	import org.osmf.video.VideoElement;
	
	/**
	 * 可能是最简单的OSMF框架范例
	 * 
	 * The metadata sets the SWF size to match that of the video.
	 **/
	[SWF(width="640", height="352")]
	public class osmf extends Sprite
	{
		public function osmf()
		{
			var urlResource:URLResource;     
			urlResource = new URLResource("http://localhost/1.flv");
			//创建一个Displaylist上的Sprite，以此来作为MediaPlayer的播放容器，值得我们高兴的是，OSMF连MediaPlayerSprite都给做好了。:)
			var sprite:MediaPlayerSprite = new MediaPlayerSprite();
			addChild(sprite);
			var videoElement:VideoElement = new VideoElement(urlResource,new NetLoader);
			//videoElement.resource = urlResource;
			//设定MediaPlayer上的媒体元素，因为自动播放autoPlay属性默认值是true，所以只要加载影片，就会自动放映了
			
			sprite.media = videoElement;
		
		}
		
		//加载一段来自Youku的视频
		private static const REMOTE_PROGRESSIVE:String
		= "http://59.175.136.209/1772AA58F7B49832E03CED28CF/03000201004B53CC6BC0E10108E7E6992CA757-ADCD-1881-882D-9BBD0FED99A0.flv";
	}
}