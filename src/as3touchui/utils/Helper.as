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
			stage.quality = StageQuality.HIGH;
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


		static public function scaleToLetterBox(content:DisplayObject, containerWidth:int, containerHeight:int):void
		{
			if(content == null || containerWidth * containerHeight == 0) return;

			var contentWidth:int = content.width;
			var contentHeight:int = content.height;
			var ratio:Number;

			if(contentWidth < containerWidth || contentHeight < containerHeight)
			{ /* enlarge */
				ratio = Math.max(containerWidth / contentWidth, containerHeight / contentHeight);
			}
			else
			{ /* shrink */
				ratio = Math.min(containerWidth / contentWidth, containerHeight / contentHeight)
			}

			contentWidth *= ratio;
			contentHeight *= ratio;

			content.width = contentWidth;
			content.height = contentHeight;

			content.x = (containerWidth - contentWidth) / 2;
			content.y = (containerHeight - contentHeight) / 2;
		}
	}
}