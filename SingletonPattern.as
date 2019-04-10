package {
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.display.*;
	
	public class SingletonPattern {
    
		private static var instance:SingletonPattern;
		public static const staticDispatcher:EventDispatcher = new EventDispatcher();
		
		private var st:Stage;

		public function SingletonPattern(_prop:PropertyItem) {}
		
		public static function getInstance():SingletonPattern {
			if(SingletonPattern.instance == null) {
				SingletonPattern.instance = new SingletonPattern(new PropertyItem());
			}
			return SingletonPattern.instance;
		}
		
		public function set stageReference(s:Stage):void {
			st = s;
		}
		
		public function get stageReference():Stage {
			return st;
		}
    
		/*
		* ------------------------------------------------------------------------------------------
		* ------------------------------- SINGLETON EVENT LISTENERS  -------------------------------
		* ------------------------------------------------------------------------------------------
		*/
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
			staticDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
			staticDispatcher.addEventListener(type, listener, useCapture);
		}
		
		public static function dispatchEvent(e:Event):Boolean {
			return staticDispatcher.dispatchEvent(e);
		}
		
		public static function hasEventListener(type:String):Boolean {
			return staticDispatcher.hasEventListener(type);
		}
		
		public static function willTrigger(type:String):Boolean {
			return staticDispatcher.willTrigger(type);
		}

	}
	
}

class PropertyItem {
	
	public function PropertyItem() {}
}
