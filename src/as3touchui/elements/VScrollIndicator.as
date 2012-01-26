package as3touchui.elements
{
	import as3touchui.utils.Color;

	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	public class VScrollIndicator extends Shape
	{

		private static const WIDTH:uint = 5 ;
		private static const MARGIN_RIGHT:uint = 1 ;

		public function VScrollIndicator()
		{
			alpha = 0;
			_width = WIDTH * Element.ScaleRatio;
			if(stage) init()
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		override public function get width():Number
		{
			return _width;
		}

		override public function set width(value:Number):void
		{
			// do nothing
		}

		protected function fadeOut():void
		{
			addEventListener(Event.ENTER_FRAME, fadingOut);
		}


		// private var _height:uint;

		override public function set height(value:Number):void
		{
			_height = value + 0.5 >> 0;
			_normalLength = (_height * .36) >> 0;
		}

		protected var _height:uint ;

		protected var _width:uint ;

		protected var _normalLength:uint ;


		protected var scheduleFadeOutAt:int ;


		/**
		 *
		 * @param percent 0-1 percentage of content scrolled
		 * @param offset 0-1 percentage of content off screen
		 */
		public function showScroll(percent:Number, offset:Number=0):void
		{
			trace("[VScrollIndicator.showScroll] percent:"+percent+"; offset:"+offset);
			removeEventListener(Event.ENTER_FRAME, fadingOut);
			alpha = 1;

			graphics.clear();

			var top:uint, length:uint;

			if(percent <= 0 || percent >= 1)
			{
				percent = percent <= 0 ? 0 : 1;
				length = _normalLength * (1 - offset * 2);
				if(length < _width) length = _width;
			}
			else
			{
				length  = _normalLength;
			}

			top = _height * percent - length;
			if(top < 0) top = 0;

			trace("[VScrollIndicator.showScroll] top:"+top+"; _width:"+_width+"; length:"+length);

			graphics.clear();
			graphics.beginFill(Color.SCROLL_INDICATOR);
			graphics.drawRoundRect(0, top, _width, length, _width, _width);
			graphics.endFill();

			clearTimeout(scheduleFadeOutAt);
			scheduleFadeOutAt = setTimeout(fadeOut, 500);
		}

		protected function init(event:Event=null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			this.x = stage.stageWidth - (WIDTH + MARGIN_RIGHT) * Element.ScaleRatio;
		}


		override public function set x(value:Number):void
		{
			_x = value;
			super.x = ((value - _width / 2) + 0.5) >> 0;
		}

		protected var _x:Number ;

		override public function get x():Number
		{
			return _x;
		}

		private function fadingOut(event:Event = null):void
		{
			alpha = alpha * .9
			if(alpha <= 0.15)
			{
				removeEventListener(Event.ENTER_FRAME, fadingOut);
				alpha = 0;
			}
		}
	}
}