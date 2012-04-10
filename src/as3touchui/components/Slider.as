package as3touchui.components
{
	import as3touchui.elements.SlideBarHandler;

	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;

	[Event(name="change", type="flash.events.Event")]
	public class Slider extends ProgressBar
	{
		protected var _handle:SlideBarHandler;

		protected var _backClick:Boolean = true;
		protected var _min:Number = 0;
		protected var _tick:Number = 0.01;

		/* 自定义的鼠标响应区域 */
		private var hitAreaSprit:Sprite;


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

			hitAreaSprit = new Sprite;
			hitAreaSprit.mouseChildren = false;
			hitAreaSprit.mouseEnabled = false;
			addChild(hitAreaSprit);
			hitAreaSprit.visible = false;
			// hitAreaSprit.alpha = 0.1;
			hitArea = hitAreaSprit;
		}

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
			_handle.x = (_value - _min) / (_max - _min) * _width;
		}

		override protected function whenAddToStage(event:Event = null):void
		{
			super.whenAddToStage();
			addEventListener(MouseEvent.MOUSE_DOWN, handleMouseDown);
			addEventListener(MouseEvent.CLICK, handleMouseClick);
		}

		protected function handleMouseDown(event:MouseEvent):void
		{
			// trace("[Slider.handleMouseDown] ");
			percent = mouseX / _width;
			addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			addEventListener(MouseEvent.MOUSE_UP, handleMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleStageMouseUp);
		}

		protected function handleStageMouseUp(event:MouseEvent):void
		{
			// trace("[Slider.handleMouseUp] ");
			removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			removeEventListener(MouseEvent.MOUSE_OUT, handleMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_UP, handleStageMouseUp);
		}

		private function handleMouseClick(event:MouseEvent):void
		{
			// trace("[Slider.handleMouseClick] mouseX:"+mouseX);
			percent = mouseX / _width;
			event.stopImmediatePropagation();
		}

		protected function handleMouseUp(event:MouseEvent):void
		{
			// trace("[Slider.handleMouseOut] ");
			event.stopImmediatePropagation();
			removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			removeEventListener(MouseEvent.MOUSE_OUT, handleMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_UP, handleStageMouseUp);
		}

		protected function handleMouseMove(event:MouseEvent):void
		{
			// trace("[Slider.handleMouseMove] mouseX:"+mouseX);
			percent = mouseX / _width;
		}

		private function set percent(value:Number):void
		{
			value = value < 0 ? 0 : value > 1 ? 1 : value;
			var oldValue:Number = _value;
			_value = value * (_max - _min) + _min;
			if(_value != oldValue)
			{
				invalidate();
				dispatchEvent(new Event(Event.CHANGE));
			}
		}

		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			super.draw();
			positionHandle();
		}

		/**
		 * Sets/gets the width of the component.
		 */
		override public function set width(w:Number):void
		{
			super.width = w;
			var h:int = _handle.height;
			hitAreaSprit.graphics.beginFill(0xff0000);
			hitAreaSprit.graphics.drawRect(-h/2 , -h/2 , _width + h , h);
			hitAreaSprit.graphics.endFill();
		}

		/**
		 * Sets the size of the component.
		 * @param w The width of the component.
		 * @param h The height of the component.
		 */
		override public function setSize(w:Number, h:Number):void
		{
			super.setSize(w,h);
			var height:int = _handle.height;
			hitAreaSprit.graphics.beginFill(0xff0000);
			hitAreaSprit.graphics.drawRect(-height/2 , -height/2 , _width + height , height);
			hitAreaSprit.graphics.endFill();
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


