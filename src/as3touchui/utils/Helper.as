package as3touchui.utils
{
	import flash.display.*;
	import flash.geom.Matrix;
	import flash.text.*;

	public class Helper
	{

		static public var reusableMatrix:Matrix = new Matrix ;

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