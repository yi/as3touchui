package as3touchui.elements
{
	import as3touchui.utils.Alignment;

	[Embed(source="../../assets/as3touchui.swf", symbol="BgBtnDark")]
	public class BgBtnDark extends Element
	{
		public function BgBtnDark()
		{
			super(Alignment.MIDDLE_LEFT);
			scaleX = scaleY = scaleRatio;
		}
	}
}