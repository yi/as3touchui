package as3touchui.elements
{
	import flash.display.Sprite;
	import flash.system.Capabilities;
	public class Element extends Sprite
	{
		private static  const HVGA_RESOLUTION_X:uint = 320 ;

		private static  const HVGA_RESOLUTION_Y:uint = 480 ;

		private static  var _scaleRatio:Number = 1;

		private static  function staticInit():void
		{
			var screenResolutionY:Number = Math.max(Capabilities.screenResolutionY, Capabilities.screenResolutionX);
			var screenResolutionX:Number = Math.min(Capabilities.screenResolutionY, Capabilities.screenResolutionX);
			_scaleRatio = Math.min(screenResolutionY/ HVGA_RESOLUTION_Y, screenResolutionX/HVGA_RESOLUTION_X);
			/* scaleRatio must be multiply of 0.5 for better pixel snaping */
			_scaleRatio = Math.round(_scaleRatio * 2)/2;
		}

		public function Element()
		{
		}

		public function get scaleRatio():Number
		{
			return _scaleRatio;
		}

		staticInit();
	}
}