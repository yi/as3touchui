package as3touchui.utils
{
	import flash.display.*;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.text.*;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;

	public class Helper
	{

		static public var reusableMatrix:Matrix = new Matrix ;

		static public var reusablePoint:Point = new Point ;

		/**
		 * Utility method to set up usual stage align and scaling.
		 */
		public static function initStage(stage:Stage):void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		}

		/**
		 * 禁止一个可交互对象上的所有交互行为
		 * @param interactiveObj
		 */
		static public function disableInteractive(interactiveObj:InteractiveObject):void
		{
			interactiveObj.mouseEnabled = false;
			interactiveObj.tabEnabled = false;

			/* disable interaction for text field */
			var tf:TextField = interactiveObj as TextField;
			if(tf != null)
			{
				tf.border = false;
				tf.background = false;
				tf.selectable = false;
				tf.multiline = false;
				tf.mouseWheelEnabled = false;
			}

			var disoc:DisplayObjectContainer = interactiveObj as DisplayObjectContainer;
			if(disoc != null)
			{
				disoc.mouseChildren = false;
			}
		}
	}
}