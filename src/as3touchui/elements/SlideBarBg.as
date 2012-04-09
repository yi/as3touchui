package as3touchui.elements
{
	import as3touchui.utils.*;

	import flash.display.*;
	import flash.geom.Matrix;

	public class SlideBarBg extends HExpandableElement
	{

		private static  const PRESERVER_LEFT_WIDTH:uint = 4 ;

		private static  const PRESERVER_RIGHT_WIDTH:uint = 4 ;

		[Embed(source="../../assets/as3touchui.swf", symbol="SlideBarBg")]
		private static  var _SRC:Class ;

		public function SlideBarBg()
		{
			super(Alignment.TOP_LEFT,
				Math.round(PRESERVER_LEFT_WIDTH * Element.ScaleRatio),
				Math.round(PRESERVER_RIGHT_WIDTH  * Element.ScaleRatio));
		}

		include "HExpandableElementSubClass.inc"
	}
}