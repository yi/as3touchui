/**
 * Slider.as
 * Keith Peters
 * version 0.9.10
 *
 * Abstract base slider class for HSlider and VSlider.
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
	import as3touchui.elements.SlideBarHandler;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	[Event(name="change", type="flash.events.Event")]
	public class Slider extends ProgressBar
	{
		protected var _handle:SlideBarHandler;

		protected var _backClick:Boolean = true;
		protected var _min:Number = 0;
		protected var _tick:Number = 0.01;

		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this Slider.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (change in this case).
		 */
		public function Slider(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, defaultHandler:Function = null)
		{
			super(parent, xpos, ypos);
			_max = 100;

			if(defaultHandler != null)
			{
				addEventListener(Event.CHANGE, defaultHandler);
			}
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
			super.addChildren();

			_handle = new SlideBarHandler;
			addChild(_handle);
		}

//		/**
//		 * Draws the back of the slider.
//		 */
//		protected function drawBack():void
//		{
//			_back.graphics.clear();
//			_back.graphics.beginFill(Style.BACKGROUND);
//			_back.graphics.drawRect(0, 0, _width, _height);
//			_back.graphics.endFill();
//
//			if(_backClick)
//			{
//				_back.addEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
//			}
//			else
//			{
//				_back.removeEventListener(MouseEvent.MOUSE_DOWN, onBackClick);
//			}
//		}

//		/**
//		 * Draws the handle of the slider.
//		 */
//		protected function drawHandle():void
//		{
//			_handle.graphics.clear();
//			_handle.graphics.beginFill(Style.BUTTON_FACE);
//			if(_orientation == HORIZONTAL)
//			{
//				_handle.graphics.drawRect(1, 1, _height - 2, _height - 2);
//			}
//			else
//			{
//				_handle.graphics.drawRect(1, 1, _width - 2, _width - 2);
//			}
//			_handle.graphics.endFill();
//			positionHandle();
//		}

		/**
		 * Adjusts value to be within minimum and maximum.
		 */
		protected function correctValue():void
		{
			if(_max > _min)
			{
				_value = Math.min(_value, _max);
				_value = Math.max(_value, _min);
			}
			else
			{
				_value = Math.max(_value, _max);
				_value = Math.min(_value, _min);
			}
		}

		/**
		 * Adjusts position of handle when value, maximum or minimum have changed.
		 * TODO: Should also be called when slider is resized.
		 */
		protected function positionHandle():void
		{
			var range:Number;
			range = _width - _height;
			_handle.x = (_value - _min) / (_max - _min) * range;
		}

		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			positionHandle();
//			drawBack();
//			drawHandle();
		}

		/**
		 * Convenience method to set the three main parameters in one shot.
		 * @param min The minimum value of the slider.
		 * @param max The maximum value of the slider.
		 * @param value The value of the slider.
		 */
		public function setSliderParams(min:Number, max:Number, value:Number):void
		{
			this.minimum = min;
			this.maximum = max;
			this.value = value;
		}

		/**
		 * Handler called when user clicks the background of the slider, causing the handle to move to that point. Only active if backClick is true.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onBackClick(event:MouseEvent):void
		{
			_handle.x = mouseX - _height / 2;
			_handle.x = Math.max(_handle.x, 0);
			_handle.x = Math.min(_handle.x, _width - _height);
			_value = _handle.x / (width - _height) * (_max - _min) + _min;
			dispatchEvent(new Event(Event.CHANGE));

		}

		/**
		 * Internal mouseDown handler. Starts dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onDrag(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			_handle.startDrag(false, new Rectangle(0, 0, _width - _height, 0));
		}

		/**
		 * Internal mouseUp handler. Stops dragging the handle.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onDrop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, onDrop);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlide);
			stopDrag();
		}

		/**
		 * Internal mouseMove handler for when the handle is being moved.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onSlide(event:MouseEvent):void
		{
			var oldValue:Number = _value;
			_value = _handle.x / (width - _height) * (_max - _min) + _min;
			if(_value != oldValue)
			{
				dispatchEvent(new Event(Event.CHANGE));
			}
		}


		/**
		 * Sets / gets whether or not a click on the background of the slider will move the handler to that position.
		 */
		public function set backClick(b:Boolean):void
		{
			_backClick = b;
			invalidate();
		}

		public function get backClick():Boolean
		{
			return _backClick;
		}

		/**
		 * Sets / gets the current value of this slider.
		 */
		override public function set value(v:Number):void
		{
			_value = v;
			correctValue();
			positionHandle();

		}

		override public function get value():Number
		{
			return Math.round(_value / _tick) * _tick;
		}

        /**
         * Gets the value of the slider without rounding it per the tick value.
         */
        public function get rawValue():Number
        {
            return _value;
        }

		/**
		 * Gets / sets the maximum value of this slider.
		 */
		override public function set maximum(m:Number):void
		{
			_max = m;
			correctValue();
			positionHandle();
		}

		override public function get maximum():Number
		{
			return _max;
		}

		/**
		 * Gets / sets the minimum value of this slider.
		 */
		public function set minimum(m:Number):void
		{
			_min = m;
			correctValue();
			positionHandle();
		}
		public function get minimum():Number
		{
			return _min;
		}

		/**
		 * Gets / sets the tick value of this slider. This round the value to the nearest multiple of this number.
		 */
		public function set tick(t:Number):void
		{
			_tick = t;
		}
		public function get tick():Number
		{
			return _tick;
		}

	}
}


