package as3touchui.elements
{
	import as3touchui.utils.Alignment;
	import as3touchui.utils.Helper;

	[Embed(source="../../assets/as3touchui.swf", symbol="SlideBarHandler")]
	public class SlideBarHandler extends Element
	{
		public function SlideBarHandler()
		{
			super(Alignment.MIDDLE_CENTER);
			scaleX = scaleY = scaleRatio;
			Helper.disableInteractive(this);
			cacheAsBitmap = true;
		}
	}
}