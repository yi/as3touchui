package as3touchui.elements
{
	import flash.display.MovieClip;

	[Embed(source="../../assets/as3touchui.swf", symbol="AniLoading")]
	public class AniLoading extends MovieClip
	{
		public function AniLoading()
		{
			scaleX = scaleY = Element.ScaleRatio;
		}
	}
}