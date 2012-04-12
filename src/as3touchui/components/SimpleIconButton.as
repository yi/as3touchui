package as3touchui.components
{
	import as3touchui.elements.Element;

	import com.greensock.TweenLite;

	import flash.display.*;
	import flash.events.MouseEvent;

	public class SimpleIconButton extends Sprite
	{

		[Embed(source="../../assets/hilighter.png")]
		static private var _srcHighlighter:Class ;

		static private var bmpdHighlighter:BitmapData = (new _srcHighlighter as Bitmap).bitmapData ;
		_srcHighlighter = null;

		private var hilighter:Bitmap ;

		/* 自定义的鼠标响应区域 */
		private var hitAreaSprit:Sprite;

		private var _width:Number ;

		private var _height:Number ;

		public function SimpleIconButton(icon:DisplayObject, w:int = 50, h:int = 50)
		{
			_width = w * Element.ScaleRatio;
			_height = h * Element.ScaleRatio;

			hitAreaSprit = new Sprite;
			hitAreaSprit.mouseChildren = false;
			hitAreaSprit.mouseEnabled = false;
			addChild(hitAreaSprit);
			// hitAreaSprit.visible = false;
			hitAreaSprit.alpha = 0.3;

			hitAreaSprit.graphics.beginFill(0x00ff00);
			hitAreaSprit.graphics.drawRect(- _width/2 , - _height/2 ,  _width , _height);
			hitAreaSprit.graphics.endFill();

			hitArea = hitAreaSprit;

			hilighter = new Bitmap(bmpdHighlighter);
			hilighter.scaleX = Element.ScaleRatio;
			hilighter.scaleY = Element.ScaleRatio;
			hilighter.x = - hilighter.width / 2;
			hilighter.y = - hilighter.height / 2;
			hilighter.visible = false;
			addChild(hilighter);

			this.icon = icon;

			addEventListener(MouseEvent.CLICK, handleClick, false);
			addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
		}


		override public function get height():Number
		{
			return 1;
		}

		override public function set height(value:Number):void
		{
			_height = value;
		}

		override public function get width():Number
		{
			return 1;
		}

		override public function set width(value:Number):void
		{
			_width = value;
		}

		protected function handleClick(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			TweenLite.killTweensOf(hilighter);
			hilighter.alpha = 1;
			hilighter.visible = true;
			fadeOut();
		}

		protected function handleMouseDown(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			TweenLite.killTweensOf(hilighter);
			hilighter.alpha = 1;
			hilighter.visible = true;
			addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			addEventListener(MouseEvent.MOUSE_OUT, handleMouseOut);
		}

		protected function handleMouseOut(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			removeEventListener(MouseEvent.MOUSE_OUT, handleMouseOut);
			hideHilighter();
		}

		protected function handleMouseUp(event:MouseEvent):void
		{
			event.stopImmediatePropagation();
			removeEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			removeEventListener(MouseEvent.MOUSE_OUT, handleMouseOut);
			fadeOut();
		}

		public function set icon(value:DisplayObject):void
		{
			if(value) addChild(value);
		}

		private function fadeOut():void
		{
			TweenLite.to(hilighter, 1, {alpha:0, onComplete:hideHilighter});
		}

		private function hideHilighter():void
		{
			hilighter.visible = false;
		}

	}
}