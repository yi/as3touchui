package as3touchui.elements
{
	import as3touchui.utils.Alignment;
	import as3touchui.utils.Helper;

	import flash.display.Sprite;

	[Embed(source="../../assets/as3touchui.swf", symbol="BgBarDarkLarge")]
	public class BgBarDarkLarge extends Element
	{
		public function BgBarDarkLarge()
		{
			super();
			scaleX = scaleY = scaleRatio;
			Helper.disableInteractive(this);
		}
	}
}