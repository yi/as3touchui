package as3touchui.components
{
	import as3touchui.elements.Element;
	import as3touchui.elements.VScrollIndicator;
	import as3touchui.utils.Style;

	import com.greensock.TweenLite;
	import com.greensock.easing.Back;
	import com.greensock.easing.Expo;

	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;

	public class VScrollPane extends Panel
	{

		/**
		 * in sconds
		 */
		public static  const SCROLL_RESISTENT_DURATION:Number = 3 ;

		public static  const SCROLL_SPEED_DECREMENT_RATE:Number = 0.8;

		public function VScrollPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			invalidateOnStageResize = true;
		}

		protected var accumulateYDelta:Number ;

		protected var lastMouseY:Number;

		private var lastRenderYDelta:Number;

		override public function draw():void
		{
			_width = stage.stageWidth;
			_height = stage.stageHeight - y;
			super.draw();
			_scrollIndicator.x = _width - Style.MARGIN_CONTENT * Element.ScaleRatio / 2;
			_scrollIndicator.height = _height;
		}

		override public function set y(value:Number):void
		{
			super.y = value;
			if(stage != null)
			{
				draw();
			}
			/**
			 * TODO:
			 *  need a better way to handle resizing
			 *
			 * ty Jan 26, 2012
			 */
		}

		protected var _scrollIndicator:VScrollIndicator ;

		override protected function addChildren():void
		{
			super.addChildren();
			_scrollIndicator = new VScrollIndicator;
			addRawChild(_scrollIndicator);
		}

		protected function calcMoveToScroll(yDelta:Number):void
		{
			accumulateYDelta += yDelta;
			addEventListener(Event.ENTER_FRAME, renderScroll);
		}


		protected function clearFadeOutScroll():void
		{
			removeEventListener(Event.ENTER_FRAME, fadeOutScroll);
			TweenLite.killTweensOf(content);
			lastRenderYDelta = 0;
			accumulateYDelta = 0;
		}

		protected function fadeOutScroll(...rest):void
		{
			if(Math.abs(lastRenderYDelta) < 1)
			{ /* end the fading */
				removeEventListener(Event.ENTER_FRAME, fadeOutScroll);

				var contentY : Number = content.y, contentHeight:Number = content.height;
				if(contentY > 0)
				{
					TweenLite.to(content,
						SCROLL_RESISTENT_DURATION * (contentY / _height),
						{y:0, ease:Expo.easeOut, onUpdate:updateScrollIndicator});
				}
				else if(contentHeight > _height && contentY < - contentHeight + _height)
				{
					TweenLite.to(content,
						SCROLL_RESISTENT_DURATION * (_height - (contentY + contentHeight)) / _height,
						{y: - contentHeight + _height, ease:Expo.easeOut, onUpdate:updateScrollIndicator});
				}
			}
			accumulateYDelta = lastRenderYDelta * SCROLL_SPEED_DECREMENT_RATE;
			renderScroll();
		}

		protected function handleMouseDown(event:MouseEvent):void
		{
			clearFadeOutScroll();
			addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			lastMouseY = event.stageY;
		}

		protected function handleMouseMove(event:MouseEvent):void
		{
			calcMoveToScroll(event.stageY - lastMouseY);
			lastMouseY = event.stageY;
		}

		protected function handleMouseUp(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			addEventListener(Event.ENTER_FRAME, fadeOutScroll);
		}

		protected function handleTouchBegin(event:TouchEvent):void
		{
			clearFadeOutScroll();
			addEventListener(TouchEvent.TOUCH_MOVE, handleTouchMove);
			stage.addEventListener(TouchEvent.TOUCH_END, handleTouchEnd);
			lastMouseY = event.stageY;
		}

		protected function handleTouchEnd(event:TouchEvent):void
		{
			removeEventListener(TouchEvent.TOUCH_MOVE, handleTouchMove);
			stage.removeEventListener(TouchEvent.TOUCH_END, handleTouchEnd);
			addEventListener(Event.ENTER_FRAME, fadeOutScroll);
		}

		protected function handleTouchMove(event:TouchEvent):void
		{
			calcMoveToScroll(event.stageY - lastMouseY);
			lastMouseY = event.stageY;
		}

		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			if(Multitouch.inputMode == MultitouchInputMode.NONE)
			{
				addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			}else{
				addEventListener(TouchEvent.TOUCH_BEGIN, handleTouchBegin);
			}
		}

		protected function updateScrollIndicator():void
		{
			var newY:Number = content.y,
				contentHeight:Number = content.height
			if(contentHeight > _height)
			{ /* only display scroll indicator when content is larger then display area */

				var scrollPercent:Number, offsetPercent:Number = 0;

				if(newY >= 0)
				{
					scrollPercent = 0;
					offsetPercent = newY / _height;
				}
				else if(newY <= - contentHeight + _height)
				{
					scrollPercent = 1;
					offsetPercent =  - (contentHeight - _height + newY)  / _height
				}
				else
				{
					scrollPercent = (- newY + _height / 2) / contentHeight;
				}

				_scrollIndicator.showScroll(scrollPercent, offsetPercent);
			}
		}

		protected function renderScroll(event:Event=null):void
		{
			removeEventListener(Event.ENTER_FRAME, renderScroll);

			if(Math.abs(accumulateYDelta) < 2)
			{
				accumulateYDelta = 0;
				lastRenderYDelta = 0;
				return; /* lazy */
			}

			lastRenderYDelta = accumulateYDelta;

			var contentY : Number = content.y, contentHeight:Number = content.height;
			var newY:Number = contentY + accumulateYDelta;
			if(newY < - contentHeight + _height * 0.6)
			{
				newY = -contentHeight + _height * 0.6;
				lastRenderYDelta = 0;
			}
			if(newY > height * 0.4)
			{
				newY = height * 0.4;
				lastRenderYDelta = 0;
			}

			// content.y = Math.round(newY);
			content.y = newY;
			accumulateYDelta = 0;

			if(contentHeight > _height) updateScrollIndicator();
		}

		/**
		 * TODO:
		 *  switch to a proper tween lib for better experience
		 *
		 * ty Jan 26, 2012
		 */
	}
}