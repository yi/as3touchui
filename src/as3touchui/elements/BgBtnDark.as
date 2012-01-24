package as3touchui.elements
{
	import as3touchui.utils.*;
	import flash.display.*;

	public class BgBtnDark extends HExpandableElement
	{
		private static  const PRESERVER_BOARD:uint = 10 ;

		[Embed(source="../../assets/as3touchui.swf", symbol="BgBtnDark")]
		private static  var _SRC:Class ;
		private static  var source:DisplayObject = new _SRC as DisplayObject ;

		private static  var _sourceBmpd:BitmapData = new BitmapData(
			source.width * Element.ScaleRatio,
			source.height * Element.ScaleRatio,
			true, 0) ;


		public function BgBtnDark()
		{
			var preserveBoard:uint = ((PRESERVER_BOARD * Element.ScaleRatio) + 0.5) >> 0;
			super(Alignment.TOP_LEFT, preserveBoard, preserveBoard);
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