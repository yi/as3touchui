package as3touchui.elements
{
	import as3touchui.utils.Alignment;

	import flash.events.Event;
	import flash.geom.Rectangle;

	import spark.primitives.Rect;

	[Embed(source="../../assets/as3touchui.swf", symbol="BgArrowBtnDark")]
	public class BgArrowBtnDark extends Element
	{
		public function BgArrowBtnDark()
		{
			super(Alignment.MIDDLE_LEFT);
//			super(Alignment.BOTTOM_RIGHT);
			// var rect:Rectangle = this.scale9Grid;
//			var newRect = new Rectangle
//			rect.left = rect.left * scaleRatio;
//			rect.top = rect.top * scaleRatio;
//			rect.bottom = rect.bottom * scaleRatio;
//			rect.right = rect.right * scaleRatio;
			// scale9Grid = null;
			scaleX = scaleY = scaleRatio;
			// this.scale9Grid = new Rectangle(rect.x * scaleRatio, rect.y * scaleRatio, rect.width * scaleRatio, height);
			var grid:Rectangle = new Rectangle(10, 10, 1, 1);
//			this.scale9Grid = grid;
		}
	}
}