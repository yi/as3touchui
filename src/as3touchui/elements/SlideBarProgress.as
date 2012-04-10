package as3touchui.elements
{
	import flash.display.*;
	import flash.geom.Matrix;
	import as3touchui.utils.*;
	public class SlideBarProgress extends HExpandableElement
	{

		private static  const PRESERVER_LEFT_WIDTH:uint = 4 ;

		private static  const PRESERVER_RIGHT_WIDTH:uint = 4 ;

		[Embed(source="../../assets/as3touchui.swf", symbol="SlideBarProgress")]
		private static  var _SRC:Class ;

		public function SlideBarProgress()
		{
			super(Alignment.MIDDLE_LEFT,
				Math.round(PRESERVER_LEFT_WIDTH * Element.ScaleRatio),
				Math.round(PRESERVER_RIGHT_WIDTH  * Element.ScaleRatio));
		}

		include "HExpandableElementSubClass.inc"

	}
}