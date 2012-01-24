package as3touchui.components
{
	import as3touchui.elements.*;
	import as3touchui.utils.*;

	import flash.display.*;
	import flash.events.MouseEvent;

	public class ActionBar extends Component
	{
		public function ActionBar(parent:DisplayObjectContainer=null,
								  title:String=null,
								  navBtnLabel:String = null)
		{
			super(parent, 0, 0);
			invalidateOnStageResize = true;
			this.title = title;
		}

		protected var _titleText:LabelText ;

		protected var _navButton:TextButton ;

		protected var _bg:BgBarDark ;

		public function set title(value:String):void
		{
			_titleText.text = value;
			// draw();
		}

		public function get title():String
		{
			return _titleText.text;
		}

		override protected function addChildren():void
		{
			_bg = new BgBarDark;
			addChild(_bg);

			_titleText = new LabelText('',
				Style.FONT_SIZE_TITLE, Color.TEXT_ON_DARK_BG,
				Color.TEXT_SHADOW_ON_DARK_BG, Alignment.MIDDLE_CENTER
			);
			addChild(_titleText);

			_navButton = new TextButton(this, 'Back', 0, 0, TextButton.BOARD_TYPE_ARROW);
		}

		/**
		 * set the label of the navigation button
		 * @param value if value is null or empty string, the nav button will be hide
		 */
		public function set navButtonLabel(value:String):void
		{
			if(value == null || value.length == 0)
			{
				_navButton.visible = false;
			}
			else
			{
				_navButton.label = value;
				_navButton.visible = true;
			}
		}

		public function set navButtonClickHandler(hanlder:Function):void
		{
			if(hanlder != null)	_navButton.addEventListener(MouseEvent.CLICK, hanlder);
		}

		/**
		 * Abstract draw function.
		 */
		override public function draw():void
		{
			var stageWidth:int = stage.stageWidth
			_bg.width = stageWidth;
			_titleText.x = stageWidth / 2;
			_titleText.y = _bg.height / 2;
			_navButton.x = Style.MARGIN_NAV_BUTTON_LEFT * Element.ScaleRatio;
			_navButton.y = (_bg.height - _navButton.height) / 2;
			super.draw();
		}
	}
}