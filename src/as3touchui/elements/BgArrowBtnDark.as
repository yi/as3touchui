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
		private static  var source:DisplayObject = new _SRC as DisplayObject ;

		private static  var _sourceBmpd:BitmapData = new BitmapData(
			source.width * Element.ScaleRatio,
			source.height * Element.ScaleRatio,
			true, 0) ;

		public function BgArrowBtnDark()
		{
			super(Alignment.TOP_LEFT,
				((PRESERVER_LEFT_WIDTH * Element.ScaleRatio) + 0.5) >> 0,
				((PRESERVER_RIGHT_WIDTH  * Element.ScaleRatio) + 0.5) >> 0);
		}

		/**
		 * return the scaled graphic bitmap
		 */
		override protected function get sourceBmpd():BitmapData
		{
			return _sourceBmpd;
		}

		/* static init */
		Helper.reusableMatrix.identity();
		Helper.reusableMatrix.scale(Element.ScaleRatio, Element.ScaleRatio);
		_sourceBmpd.draw(source, Helper.reusableMatrix);
		_SRC = null;
		source = null;
	}
}