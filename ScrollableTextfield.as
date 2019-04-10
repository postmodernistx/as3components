package  {
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	import flash.events.MouseEvent;
	
	public class ScrollableTextfield extends MovieClip {
		
		private var textField:TextField;
		private var visibleAreaBounds:Rectangle;
		private var scrollBg:MovieClip;
		private var scroll:MovieClip;
		private var scrollBounds:Rectangle;
		private var textHeight:Number = 0;
		

		public function ScrollableTextfield(htmlText:String, fieldWidth:Number, fieldHeight:Number) {
			visibleAreaBounds = new Rectangle(0, 0, fieldWidth, fieldHeight);
			
			textField = new TextField();
			textField.width = visibleAreaBounds.width;
			textField.wordWrap = true;
			textField.selectable = false;
			textField.border = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.htmlText = htmlText;
			addChild(textField);
			textHeight = textField.height - visibleAreaBounds.height;
			
			if(textHeight < 0) {
				return;
			}
			
			textField.scrollRect = visibleAreaBounds;
			
			scrollBg = new MovieClip();
			scrollBg.graphics.beginFill(0xdfdfdf);
			scrollBg.graphics.drawRoundRect(0, 0, 10, visibleAreaBounds.height, 10, 10);
			addChild(scrollBg);
			scrollBg.x = textField.x + textField.width;
			
			var scrollHandleHeight:Number = Math.floor((visibleAreaBounds.height / textHeight) * 100);
			if(scrollHandleHeight < 35) {
				scrollHandleHeight = 35;
			}
			
			scroll = new MovieClip();
			scroll.graphics.beginFill(0xacacac);
			scroll.graphics.drawRoundRect(0, 0, 10, scrollHandleHeight, 10, 10);
			addChild(scroll);
			scroll.buttonMode =  true;
			scroll.x = scrollBg.x;
			
			scrollBounds = new Rectangle(scroll.x, 0, 0, visibleAreaBounds.height - scroll.height);
			
			scroll.addEventListener(MouseEvent.MOUSE_DOWN, startTextDrag);
		}
		
		private function startTextDrag(e:MouseEvent):void {
			scroll.removeEventListener(MouseEvent.MOUSE_DOWN, startTextDrag);
			stage.addEventListener(MouseEvent.MOUSE_UP, releaseDrag);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, calculateOffset);
			
			scroll.startDrag(false, scrollBounds);
		}
		
		private function releaseDrag(e:MouseEvent):void {
			scroll.addEventListener(MouseEvent.MOUSE_DOWN, startTextDrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP, releaseDrag);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, calculateOffset);
			
			scroll.stopDrag();
		}
		
		private function calculateOffset(e:MouseEvent):void {
			visibleAreaBounds.y = Math.ceil((scroll.y / scrollBounds.height) * textHeight);
			textField.scrollRect = visibleAreaBounds;
		}

	}
	
}
