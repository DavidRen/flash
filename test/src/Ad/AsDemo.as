package Ad
{

	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.display.StageDisplayState;
	import spark.components.Application;
	public class AsDemo extends Application
	{
		
		import mx.controls.Alert;
		import mx.controls.ProgressBarDirection;
		import mx.controls.sliderClasses.Slider;
		import mx.events.MetadataEvent;
		import mx.events.SliderEvent;
		import mx.events.VideoEvent;
		import mx.utils.ObjectUtil;
		
		
		
		[Bindable]  
		private var videoSource:String;         //媒体路径  
		
		private var isPause:Boolean = false;        //暂停状态  
		private var isSound:Boolean = true;         //声音状态  
		private var isFullScreen:Boolean = false;   //是否是全屏  
		private var tmpSound:Number = 0;            //临时声音大小  
		private var testDemo:test;
		[Bindable]  
		private var fileSize:String;                 //视频文件大小
		
		[Bindable]  
		private var playPosition:Number;            //播放进度   
		
		public function AsDemo(testDemo:test):void{  
			//videoSource = parameters.videosource;
			this.testDemo = testDemo;
			
			this.videoSource = "http://127.0.0.1/flv/1.flv";
			
			
		}  
		
		private function keyboardPress(evt:KeyboardEvent):void{
			
			Alert.show('space was pressed');
			
		}
		
		private function playingMove(event:mx.events.VideoEvent):void{  
			testDemo.my_hs.value = testDemo.myVid.playheadTime;  //视频播放时同步进度条状态值
		}
		
		//拖动进度条时改变播放位置  
		private function hs_onchange(event:SliderEvent):void{  
			if(testDemo.myVid.playheadTime == -1){  
				testDemo.my_hs.value = 0;  
				return;  
			}  
			playPosition =testDemo.my_hs.value;             //保正播放进度統一  
			testDemo.myVid.playheadTime = playPosition;
			Alert.show(String(playPosition));
		}  
		
		//进度条鼠标按下  
		private function thumbPress():void{  
			testDemo.myVid.pause();  
		}  
		
		//进度条鼠标弹起  
		private function thumbRelease():void{  
			testDemo.myVid.playheadTime = playPosition;  
			testDemo.myVid.play();  
		}  
		
		
		//播放，暂停  
		private function playButton():void{  
			if(!isPause){  
				testDemo.myVid.play();  
				testDemo.playBtn.source = testDemo.pauseClass;  
				isPause = true;  
			}else{  
				testDemo.myVid.pause();  
				testDemo.playBtn.source = testDemo.playClass;  
				isPause = false;  
			}  
		}  
		
		//播放完成  
		private function vidComplete():void{  
			testDemo.playBtn.source = testDemo.playClass;  
			isPause = false;  
		}  
		
		//停止播放  
		private function stopButton():void{  
			testDemo.myVid.stop();  
			testDemo.playBtn.source = testDemo.playClass;  
			isPause = false;  
		}  
		
		//切換全屏顯示  
		private function display():void{  
			if(!isFullScreen){  
				testDemo.stage.fullScreenSourceRect = new Rectangle(testDemo.myVid.x,testDemo.myVid.y,testDemo.myVid.width,testDemo.myVid.height);
				testDemo.stage.displayState =StageDisplayState.FULL_SCREEN;  
				isFullScreen = true;  
			}else{  
				//StageDisplayState.stage.displayState = StageDisplayState.NORMAL;  
				isFullScreen = false;  
			}  
		}  
		
		//调整声音  
		private function sound_thumbChanges(event:SliderEvent):void{  
			testDemo.myVid.volume = testDemo.hs_sound.value;  
		}  
		
		//静音  
		private function closeSound():void{  
			if(isSound){  
				testDemo.closeImg.source = testDemo.sound;  
				tmpSound = testDemo.myVid.volume;  
				testDemo.myVid.volume = 0;  
				isSound = false;  
			}else{  
				testDemo.closeImg.source = testDemo.sound1;  
				testDemo.myVid.volume = tmpSound;  
				isSound = true;  
			}  
		}  
		
		
		//格式化时间  
		private function formatTime(time:Number):String{  
			var min:Number = Math.floor(time/60);  
			var sec:Number = Math.floor(time%60);  
			var timeResult:String = (min < 10 ? "0"+min.toString() : min.toString()) + ":" + (sec == 10 ? "0"+sec.toString() : sec.toString());  
			return timeResult;  
		}  
		
		//slider格式化  
		private function dataTipFormat(data:Number):String{  
			return formatTime(data);  
		}  
		
		
		private function myVid_metadataReceived(evt:MetadataEvent):void {
			
			//fileSize = (meta.filesize/(1024*1024)).toFixed(2).toString()+"MB";//换算成兆字节并保留两位小数
			
			var meta:Object = evt.info; // 视频的元数据信息
			
			//读取所有元数据属性和值
			var i:int = 0;
			var arr:Array = [];
			var item:String;
			var value:*;
			for (item in meta) {
				if (ObjectUtil.isSimple(meta[item])) {
					if (meta[item] is Array) {
						value = "[Array]";
					} else {
						value = meta[item]
					}
					Alert.show(item+":"+value);  	
				}	
			}	
		}	
	}
}