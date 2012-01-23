package as3touchui.elements
{
	import flash.display.Sprite;

	[Embed(source="../../assets/as3touchui.swf", symbol="BgBarDark")]
	public class BgBarDark extends Element
	{
		public function BgBarDark()
		{
			super();
			scaleX = scaleY = scaleRatio;
		}
	}
}