package as3touchui.components
{
	import as3touchui.elements.*;
	import as3touchui.utils.*;

	import flash.display.BlendMode;
	import flash.display.DisplayObjectContainer;
	import flash.events.MouseEvent;

	public class TextButton extends Component
	{

		/**
		 * normal round corner button
		 */
		static public const BOARD_TYPE_NORMAL:uint = 0 ;

		/**
		 * round corner button with arrow indicator
		 */
		static public const BOARD_TYPE_ARROW:uint = 10 ;


		public function TextButton(parent:DisplayObjectContainer=null, label:String = null, xpos:Number=0, ypos:Number=0, boardType:uint = 0)
		{
			_boardType = boardType;
			super(parent, xpos, ypos);
			this.label = label;
		}

		public function set label(value:String):void
		{
			_labelText.text = value;
			draw();
		}

		override protected function init():void
		{
			super.init();
			addEventListener(MouseEvent.MOUSE_DOWN, whenMouseDown);
		}

		protected function whenMouseDown(event:MouseEvent = null):void
		{
			// _bg.filters = [];
			_bg.blendMode = BlendMode.MULTIPLY;
			/**
			 * TODO:
			 *  need a decent filter, and dely effect
			 *
			 * ty Jan 24, 2012
			 */
			addEventListener(MouseEvent.MOUSE_UP, whenMouseUp);
			addEventListener(MouseEvent.MOUSE_OUT, whenMouseOut);
		}

		protected function whenMouseUp(event:MouseEvent = null):void
		{
			removeEventListener(MouseEvent.MOUSE_UP, whenMouseUp);
			removeEventListener(MouseEvent.MOUSE_OUT, whenMouseOut);

			_bg.blendMode = BlendMode.NORMAL;
		}

		protected function whenMouseOut(event:MouseEvent = null):void
		{
			removeEventListener(MouseEvent.MOUSE_UP, whenMouseUp);
			removeEventListener(MouseEvent.MOUSE_OUT, whenMouseOut);

			_bg.blendMode = BlendMode.NORMAL;
		}

		public function get label():String
		{
			return _labelText.text;
		}


		protected var _boardType:uint ;

		protected var _labelText:LabelText ;

		protected var _bg:HExpandableElement ;

		override protected function addChildren():void
		{
			_bg = _boardType == BOARD_TYPE_NORMAL ? new BgBtnDark : new BgArrowBtnDark;
			addChild(_bg);

			_labelText = new LabelText('',
				Style.FONT_SIZE_LABEL, Color.TEXT_ON_DARK_BG,
				Color.TEXT_SHADOW_ON_DARK_BG, Alignment.MIDDLE_LEFT
			);
			addChild(_labelText);
		}

		/**
		 * Abstract draw function.
		 */
		override public function draw():void
		{
			_bg.widthOfExpandableArea = _labelText.width;
			_labelText.y = _bg.height / 2;
			_labelText.x = _bg.preserverLeftWidth;
		}

		override public function get width():Number
		{
			return _bg.width;
		}

		override public function get height():Number
		{
			return _bg.height;
		}

	}
}