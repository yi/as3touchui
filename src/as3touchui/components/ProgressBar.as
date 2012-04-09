/**
 * ProgressBar.as
 * Keith Peters
 * version 0.9.10
 *
 * A progress bar component for showing a changing value in relation to a total.
 *
 * Copyright (c) 2011 Keith Peters
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package as3touchui.components
{
	import as3touchui.elements.SlideBarBg;
	import as3touchui.elements.SlideBarProgress;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;

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