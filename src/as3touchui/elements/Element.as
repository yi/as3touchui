package as3touchui.elements
{
	import as3touchui.utils.Alignment;
	import as3touchui.utils.Configure;

	import flash.display.Sprite;
	import flash.system.Capabilities;

	public class Element extends Sprite
	{
		private static  const HVGA_RESOLUTION_X:uint = 320 ;
		private static  const HVGA_RESOLUTION_Y:uint = 480 ;

		private static  var _scaleRatio:Number = -1;

		static public function get ScaleRatio():Number
		{
			return _scaleRatio;
		}

		private static  function staticInit():void
		{
			if(_scaleRatio > 0) return; /* ratio has already been set */
			var screenResolutionY:Number = Math.max(Capabilities.screenResolutionY, Capabilities.screenResolutionX);
			var screenResolutionX:Number = Math.min(Capabilities.screenResolutionY, Capabilities.screenResolutionX);
			_scaleRatio = Math.min(screenResolutionY/ HVGA_RESOLUTION_Y, screenResolutionX/HVGA_RESOLUTION_X);
			/* scaleRatio must be multiply of 0.5 for better pixel snaping */
			_scaleRatio = Math.round(_scaleRatio * 2)/2;
			if(_scaleRatio < 1)_scaleRatio = 1;
			trace("[Element.staticInit] _scaleRatio:"+_scaleRatio);
		}

		/**
		 * constructor
		 * @param registerPointAt the register point of this element
		 */
		public function Element(registerPointAt:uint=257)
		{
			this.registerPointAt = registerPointAt;
		}

		private var _registerPointAt:uint = Alignment.TOP_LEFT ;

		private var _x:int ;
		private var _y:int ;

		public function get registerPointAt():uint
		{
			return _registerPointAt;
		}

		public function set registerPointAt(value:uint):void
		{
			if(_registerPointAt == value) return;
			_registerPointAt = value;
			x = _x;
			y = _y;
		}

		/**
		 * return the computed scale ratio value
		 * @return
		 */
		public function get scaleRatio():Number
		{
			return _scaleRatio;
		}

		static public function set fixedScaleRatio(value:uint):void
		{
			if(value > MAX_SCALE_RATIO) value = MAX_SCALE_RATIO;
			_scaleRatio = value;
		}

		static private const MAX_SCALE_RATIO:uint = 4 ;

		override public function get x():Number
		{
			return _x;
		}

		override public function set x(value:Number):void
		{
			_x = value >= 0 ? (value + 0.5) >> 0 : (value - 0.5) >> 0; /* Math.round */
			super.x = _x - ((_registerPointAt & 0xff) - 1)/2 * width;
		}

		override public function get y():Number
		{
			return _y;
		}

		override public function set y(value:Number):void
		{
			_y = value >= 0 ? (value + 0.5) >> 0 : (value - 0.5) >> 0; /* Math.round */
			super.y = _y - ((registerPointAt >> 8) - 1)/2 * height;
		}
		staticInit();
	}
}