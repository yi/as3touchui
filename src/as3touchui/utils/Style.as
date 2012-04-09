package as3touchui.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;

	/**
	 * All style-related configurations go here
	 * @author ty
	 */
	public class Style
	{
		static public const FONT_SIZE_TITLE:uint = 20 ;

		static public const FONT_SIZE_LABEL:uint = 12 ;

		static public const MARGIN_NAV_BUTTON_LEFT:uint = 5 ;

		static public const MARGIN_MENU_BUTTON_RIGHT:uint = 5 ;

		static public const MARGIN_CONTENT:uint = 9 ;

		public static const COLOR_PANEL:uint = 0xF3F3F3;

		[Embed(source="../../assets/bg_tile.jpg")]
		static private var _srcBgTile:Class ;
		static public var BmpdBgTile:BitmapData = (new _srcBgTile as Bitmap).bitmapData ;
		_srcBgTile = null;


		static public function drawBackgroupd(graphic:Graphics, width:uint, height:uint):void
		{
			graphic.beginBitmapFill(BmpdBgTile);
			graphic.drawRect(0,0,width, height);
			graphic.endFill();
		}

	}
}