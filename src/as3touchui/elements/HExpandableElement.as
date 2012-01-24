package as3touchui.elements
{
	import flash.display.*;
	import flash.geom.Matrix;
	import as3touchui.utils.*;
	/**
	 * this is a base class for all horizatally expandable elements
	 * @author ty
	 *
	 */
	public class HExpandableElement extends Element
	{
		/**
		 * constructor method
		 * @param alignment the alignment of this graphic
		 * @param preserverLeftWidth width of the left end which should be preserved when width changed
		 * @param preserverRightWidth width of the right end which should be preserved when width changed
		 */
		public function HExpandableElement(alignment:uint = 257, preserverLeftWidth:uint = 10, preserverRightWidth:uint = 10)
		{
			super(Alignment.TOP_LEFT);

			minWidth = preserverLeftWidth + preserverRightWidth;
			expendableAreaWidth = sourceBmpd.width - minWidth;
			_preserverLeftWidth = preserverLeftWidth;
			_preserverRightWidth = preserverRightWidth;

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

		private var _preserverLeftWidth:uint ;
		private var _preserverRightWidth:uint ;

		private var _width:uint ;

		override public function get height():Number
		{
			return sourceBmpd.height;
		}

		public function get preserverLeftWidth():uint
		{
			return _preserverLeftWidth;
		}

		public function get preserverRightWidth():uint
		{
			return _preserverRightWidth;
		}

		override public function get width():Number
		{
			return _width;
		}

		public function set widthOfExpandableArea(value:Number):void
		{
			width = value + minWidth;
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
			graphics.beginBitmapFill(sourceBmpd, null, false);
			graphics.drawRect(0, 0, _preserverLeftWidth, h);

			/* draw middle part */
			m.identity();
			m.translate(- _preserverLeftWidth,0);
			m.scale(10,1);
			/**
			 * TODO:
			 *  the hardcoded x scale will cause problem for a very long button
			 *
			 * ty Jan 24, 2012
			 */
			graphics.beginBitmapFill(sourceBmpd, m, false);
			graphics.drawRect(_preserverLeftWidth, 0, value - minWidth, h);

			/* draw right part */
			m.identity();
			m.translate( (value - minWidth) - expendableAreaWidth, 0);
			graphics.beginBitmapFill(sourceBmpd, m, false);
			graphics.drawRect(value - _preserverRightWidth, 0, _preserverRightWidth, h);

			graphics.endFill();
		}

		/**
		 * return the scaled graphic bitmap
		 */
		protected function get sourceBmpd():BitmapData
		{
			/* need to be override by child classes */
			return null;
		}
	}
}