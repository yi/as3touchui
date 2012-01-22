package as3touchui.elements
{
	import flash.text.*;

	public class StaticText extends Element
	{

		private static  var tf:TextField = new TextField;

		private static var tft:TextFormat;

		public function StaticText(text:String, fontSize:uint = 12, textColor:uint = 0xffffff, shadowColor:uint = 0x262626)
		{
			super();
			_fontSize = fontSize;
			_textColor = textColor;
			_shadowColor = shadowColor;
			this.text = text;
		}

		private var _fontSize:uint ;
		private var _height:Number = 0;
		private var _shadowColor:uint ;
		private var _text:String ;
		private var _textColor:uint ;
		private var _width:Number = 0;

		override public function get width():Number
		{
			return _width;
		}

		override public function get height():Number
		{
			return _height;
		}

		public function set text(value:String):void
		{
			if(_text == value) return;
			_text = value;
			graphics.clear();
			if(value.length == 0) return;

			/* draw shadow */

			/* draw content */
		}
	}
}