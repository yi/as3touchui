package as3touchui.elements
{
	import as3touchui.utils.Alignment;

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

		static private const SCALE_RATIO_IPAD1N2:Number = 1 ;
		static private const SCALE_RATIO_ANDROID_LARGE_SCREEN:Number = 1.5 ;

		static private var MAX_DPI_FOR_DUE_RATIO:uint = 149 ;

		private static  function staticInit():void
		{
			if(_scaleRatio > 0) return; /* ratio has already been set */

			/* try to detect specific device */
			var os:String = Capabilities.os;
			var screenResolutionX:Number = Capabilities.screenResolutionX;
			var screenResolutionY:Number = Capabilities.screenResolutionY;
			var screenDPI:Number = Capabilities.screenDPI;
			var version:String = Capabilities.version;
			var osVersion:String = version.substr(0,3).toUpperCase();

			/* 对于屏幕颗粒度小于 150 的设备，全部采用 1:1 的精度 */
			if(screenDPI < MAX_DPI_FOR_DUE_RATIO)
			{
				_scaleRatio = 1;
				return;
			}

			switch(osVersion)
			{
				case 'IOS': /* 苹果设备 */
					if(screenResolutionX == 768 && screenResolutionY == 1024 && os.indexOf('iPad') > -1)
					{ /* 这是 iPad */
						_scaleRatio = SCALE_RATIO_IPAD1N2;
						return;
					}
					break;
				case 'AND': /* Android 设备 */
					if(screenResolutionX == 480 && screenResolutionY == 800 && screenDPI >= 160)
					{ /* 常见的4寸屏 Android 设备 */
						_scaleRatio = SCALE_RATIO_ANDROID_LARGE_SCREEN;
						return;
					}
					break;
			}

			screenResolutionY = Math.max(Capabilities.screenResolutionY, Capabilities.screenResolutionX);
			screenResolutionX = Math.min(Capabilities.screenResolutionY, Capabilities.screenResolutionX);
			_scaleRatio = Math.min(screenResolutionY/ HVGA_RESOLUTION_Y, screenResolutionX/HVGA_RESOLUTION_X);
			/* scaleRatio must be multiply of 0.5 for better pixel snaping */
			_scaleRatio = Math.round(_scaleRatio * 2)/2;
			if(_scaleRatio < 1)_scaleRatio = 1;
			trace("[Element.staticInit] _scaleRatio:"+_scaleRatio);
		}

		/**
		 * constructor
		 * @param registerPointAt the register point of this element, default value: TOP_LEFT
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