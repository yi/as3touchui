package as3touchui.elements
{
	import as3touchui.utils.*;

	import flash.display.*;
	import flash.geom.Matrix;

	public class BgArrowBtnDark extends Element
	{

		private static  const PRESERVER_LEFT_WIDTH:uint = 18 ;
		private static  const PRESERVER_RIGHT_WIDTH:uint = 10 ;

		[Embed(source="../../assets/as3touchui.swf", symbol="BgArrowBtnDark")]
		private static  var _SRC:Class ;
		private static  var source:DisplayObject = new _SRC as DisplayObject ;

		private static  var sourceBmpd:BitmapData = new BitmapData(
			source.width * Element.ScaleRatio,
			source.height * Element.ScaleRatio,
			true, 0) ;

		public function BgArrowBtnDark()
		{
			super(Alignment.TOP_LEFT);

			preserverLeftWidth = ((PRESERVER_LEFT_WIDTH * Element.ScaleRatio) + 0.5) >> 0;
			preserverRightWidth = ((PRESERVER_RIGHT_WIDTH  * Element.ScaleRatio) + 0.5) >> 0;
			minWidth = preserverLeftWidth + preserverRightWidth;
			expendableAreaWidth = sourceBmpd.width - minWidth;

			this.width = sourceBmpd.width;
			/**
			 * NOTE:
			 *  scale9Grid just fails to work here :-(
			 *
			 *  refer to: scale9Grid – When it works and when it does not
			 *  http://www.ovidiudiac.ro/blog/2009/05/scale9grid-work-and-fail/
			 *
			 * ty Jan 24, 2012
			 */
		}

		protected var expendableAreaWidth:uint ;
		protected var minWidth:uint ;

		protected var preserverLeftWidth:uint ;
		protected var preserverRightWidth:uint ;

		private var _width:uint ;

		override public function get height():Number
		{
			return sourceBmpd.height;
		}

		override public function get width():Number
		{
			return _width;
		}

		override public function set width(value:Number):void
		{
			value = value || 0;
			if(value < minWidth) value = minWidth;
			_width = value;

			var h:uint = (this.height + 0.5) >> 0,
				m:Matrix = Helper.reusableMatrix;

			/* draw left part */
			graphics.clear();
			graphics.beginBitmapFill(sourceBmpd);
			graphics.drawRect(0, 0, preserverLeftWidth, h);

			/* draw middle part */
			m.identity();
			m.translate(-preserverLeftWidth,0);
			m.scale(10,1);
			graphics.beginBitmapFill(sourceBmpd, m);
			graphics.drawRect(preserverLeftWidth, 0, value - minWidth, h);

			/* draw right part */
			m.identity();
			m.translate( (value - minWidth) - expendableAreaWidth, 0);
			graphics.beginBitmapFill(sourceBmpd, m);
			graphics.drawRect(value - preserverRightWidth, 0, preserverRightWidth, h);

			graphics.endFill();
		}

		/* static init */
		Helper.reusableMatrix.identity();
		Helper.reusableMatrix.scale(Element.ScaleRatio, Element.ScaleRatio);
		_SRC = null;
		sourceBmpd.draw(source, Helper.reusableMatrix);
	}
}