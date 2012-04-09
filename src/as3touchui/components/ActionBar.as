package as3touchui.components
{
	import flash.display.*;
	import flash.events.MouseEvent;
	import as3touchui.elements.*;
	import as3touchui.utils.*;
	/**
	 * max width x height (45 px)
	 * @author houjie
	 */
	public class ActionBar extends Component
	{
		/**
		 *
		 * @param parent parent container
		 * @param title title text
		 * @param navBtnLabel label of the nav button, if null or '' will hide the nav button
		 * @param menuBtnLabel label of the menu button, if null or '' will hide the menu button
		 */
		public function ActionBar(parent:DisplayObjectContainer=null, title:String='', navBtnLabel:String = null, menuBtnLabel:String = null)
		{
			super(parent, 0, 0);
			invalidateOnStageResize = true;
			this.title = title;
			this.navButtonLabel = navBtnLabel;
			this.menuButtonLabel = menuBtnLabel;
		}

		/**
		 * bg arsset
		 */
		protected var _bg:BgBarDark ;

		protected var _menuButton:TextButton ;

		protected var _navButton:TextButton ;

		protected var _titleText:LabelText ;

		private var onClickMenu:Function ;

		private var onClickNav:Function ;

		/**
		 * Abstract draw function.
		 */
		override public function draw():void
		{
			var stageWidth:int = stage.stageWidth;
			var stageHeight:int = stage.stageHeight;
			_bg.width = stageWidth;
			_titleText.x = stageWidth / 2;
			_titleText.y = _bg.height / 2;
			_navButton.x = Style.MARGIN_NAV_BUTTON_LEFT * Element.ScaleRatio;
			_navButton.y = (_bg.height - _navButton.height) / 2;
			_menuButton.x = stageWidth - _menuButton.width - Style.MARGIN_MENU_BUTTON_RIGHT * Element.ScaleRatio;
			_menuButton.y = (_bg.height - _menuButton.height) / 2;
			super.draw();
		}

		public function set menuButtonClickHandler(handler:Function):void
		{
			onClickMenu = handler;
		}

		public function set menuButtonLabel(value:String):void
		{
			if(value == null || value.length == 0)
			{
				_menuButton.visible = false;
			}
			else
			{
				_menuButton.label = value;
				_menuButton.visible = true;
			}
		}
		public function set navButtonClickHandler(hanlder:Function):void
		{
			/*只添加 没有移除监听 很危险*/
//			if(hanlder != null)	_navButton.addEventListener(MouseEvent.CLICK, hanlder);
			onClickNav = hanlder;
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

		public function get title():String
		{
			return _titleText.text;
		}

		public function set title(value:String):void
		{
			_titleText.text = value;
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
			_navButton.addEventListener(MouseEvent.CLICK,navClickHandler);

			_menuButton = new TextButton(this,'menu',0,0,TextButton.BOARD_TYPE_NORMAL);
			_menuButton.addEventListener(MouseEvent.CLICK,menuClickHandler);
		}

		/**
		 * Initializes the component.
		 */
		override protected  function init():void
		{
			super.init();
			setSize(_bg.width, _bg.height);
		}

		private function menuClickHandler(e:MouseEvent):void
		{
			if(onClickMenu!=null)
				onClickMenu(e);
		}

		private function navClickHandler(e:MouseEvent):void
		{
			if(onClickNav!=null)
				onClickNav(e);
		}
	}
}