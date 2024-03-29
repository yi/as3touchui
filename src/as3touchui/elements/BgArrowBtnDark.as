package as3touchui.elements
{
	import as3touchui.utils.*;

	import flash.display.*;
	import flash.geom.Matrix;

	public class BgArrowBtnDark extends HExpandableElement
	{

		private static  const PRESERVER_LEFT_WIDTH:uint = 18 ;

		private static  const PRESERVER_RIGHT_WIDTH:uint = 10 ;

		[Embed(source="../../assets/as3touchui.swf", symbol="BgArrowBtnDark")]
		private static  var _SRC:Class ;

		public function BgArrowBtnDark()
		{
			super(Alignment.TOP_LEFT,
				Math.round(PRESERVER_LEFT_WIDTH * Element.ScaleRatio),
				Math.round(PRESERVER_RIGHT_WIDTH  * Element.ScaleRatio));
		}

		include "HExpandableElementSubClass.inc"
	}
}