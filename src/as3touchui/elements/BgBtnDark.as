package as3touchui.elements
{
	import as3touchui.utils.*;
	import flash.display.*;

	public class BgBtnDark extends HExpandableElement
	{
		private static  const PRESERVER_LEFT_WIDTH:uint = 10 ;
		private static  const PRESERVER_RIGHT_WIDTH:uint = 10 ;

		[Embed(source="../../assets/as3touchui.swf", symbol="BgBtnDark")]
		private static  var _SRC:Class ;

		public function BgBtnDark()
		{
			super(Alignment.TOP_LEFT,
				Math.round(PRESERVER_LEFT_WIDTH * Element.ScaleRatio),
				Math.round(PRESERVER_RIGHT_WIDTH  * Element.ScaleRatio));
		}

		include "HExpandableElementSubClass.inc"
	}
}