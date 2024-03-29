package as3touchui.elements
{
	import as3touchui.utils.Helper;

	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.*;
	import flash.utils.getTimer;
	/**
	 *
	 * @author ty
	 *
	 * Components with text make use of the font FreeUniversal from openfontlibrary.org
	 * This is a free font obtained from http://openfontlibrary.org/font/freeuniversal
	 */
	public class LabelText extends Element
	{

		// Flex 4.x sdk:
		// [Embed(source="../../assets/FreeUniversal-Regular.ttf", embedAsCFF="false", fontName="FreeUniversal Regular", mimeType="application/x-font")]
		[Embed(source="../../assets/Helvetica_Roman.ttf", embedAsCFF="false", fontName="FreeUniversal Regular", mimeType="application/x-font")]
		protected static var EmbededFont:Class;

		public static const FONT_NAME:String = "FreeUniversal Regular";

		private static  var tf:TextField = new TextField;

		public static const tft:TextFormat = new TextFormat(FONT_NAME);

		/**
		 * a switch to tell if the component should use embed fonts
		 */
		public static var useEmbedFonts:Boolean = false;

		/**
		 * Constructor function
		 * @param text content string
		 * @param fontSize size of text
		 * @param textColor forecolor of text
		 * @param shadowColor shadow color
		 */
		public function LabelText(text:String=null,
								  fontSize:uint = 12,
								  textColor:uint = 0xffffff,
								  shadowColor:uint = 0x262626,
								  registerPointAt:uint=257,
								  isShadowBelow:Boolean = false
		)
		{
			super(registerPointAt);
			_fontSize = fontSize;
			_textColor = textColor;
			_shadowColor = shadowColor;
			this.isShadowBelow = isShadowBelow;
			this.text = text;
		}

		protected var _fontSize:uint ;
		protected var _height:Number = 0;
		protected var _shadowColor:uint ;
		protected var _text:String ;
		protected var _textColor:uint ;
		protected var _width:Number = 0;

		/**
		 * true: 阴影在文字下方， false 在文字上方
		 */
		public var isShadowBelow:Boolean = false;

		public function get fontSize():uint
		{
			return Math.round(_fontSize * scaleRatio);
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
			tf.embedFonts = useEmbedFonts;
			var shadowOffset:int =  Math.round(scaleRatio);
			if(shadowOffset > 2) shadowOffset = 2;
			if(isShadowBelow)
			{
				shadowOffset = - shadowOffset;
			}

			tft.color = _shadowColor;
			tft.size = fontSize;
			tf.defaultTextFormat = tft;
			tf.text = _text;

			_width = tf.width;
			_height = tf.height + shadowOffset;

			var bmd:BitmapData = new BitmapData(_width , _height , true , 0);
			bmd.draw(tf);

			/* draw content */
			tft.color = _textColor;
			tf.defaultTextFormat = tft;
			tf.text = _text;

			var matrix:Matrix = Helper.reusableMatrix;
			matrix.identity();
			matrix.translate(0, shadowOffset);
			bmd.draw(tf, matrix);

			/* draw reusalt on canvas */
			graphics.beginBitmapFill(bmd, null, false);
			graphics.drawRect(0,0,bmd.width, bmd.height);
			graphics.endFill();

			/* clean up */
			// bmd.dispose();
			tf.text = '';

			this.x = x; /* reposition */
			this.y = y;
		}

		public function get text():String
		{
			return _text;
		}


		override public function get width():Number
		{
			return _width;
		}

		/* static init */
		Helper.disableInteractive(tf);
		tf.autoSize = TextFieldAutoSize.LEFT;
		tf.antiAliasType = AntiAliasType.ADVANCED;
		/**
		 * NOTE:
		 *  if not set the tf.antiAliasType to advanced, it won't be antialiased on Android
		 *  Why?
		 *
		 * ty Jan 24, 2012
		 */
		tf.wordWrap = false
	}
}