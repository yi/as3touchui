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
			scaleX = scaleY = scaleRatio;
		}
	}
}