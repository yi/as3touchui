
package as3touchui.components
{
	import as3touchui.elements.*;
	import flash.display.*;
	import flash.events.*;

	public class ProgressBar extends Component
	{
		protected var _back:SlideBarBg;
		protected var _bar:SlideBarProgress;
		protected var _value:Number = 0;
		protected var _max:Number = 1;

		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this ProgressBar.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function ProgressBar(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
		}

		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			setSize(100, 10);
			// Helper.disableInteractive(this);
		}

		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_back = new SlideBarBg;
			addChild(_back);

			_bar = new SlideBarProgress;
			addChild(_bar);
		}

		/**
		 * Sets/gets the height of the component.
		 */
		override public function set height(h:Number):void
		{
			/* ignore, height can't be set */
			return;
		}

		override public function get height():Number
		{
			return _back.height;
		}

		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		override public function setSize(w:Number, h:Number):void
		{
			_width = w;
			dispatchEvent(new Event(Event.RESIZE));
			invalidate();
		}

		/**
		 * Updates the size of the progress bar based on the current value.
		 */
		protected function update():void
		{
			_bar.width = _back.width * _value / _max;
		}

		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			_back.width = _width;
			update();
		}

		/**
		 * Gets / sets the maximum value of the ProgressBar.
		 */
		public function set maximum(m:Number):void
		{
			_max = m;
			_value = Math.min(_value, _max);
			update();
		}

		public function get maximum():Number
		{
			return _max;
		}

		/**
		 * Gets / sets the current value of the ProgressBar.
		 */
		public function set value(v:Number):void
		{
			_value = Math.min(v, _max);
			update();
		}

		public function get value():Number
		{
			return _value;
		}

	}
}