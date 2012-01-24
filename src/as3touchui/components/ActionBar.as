package as3touchui.components
{
	import as3touchui.elements.*;
	import as3touchui.utils.*;

	import flash.display.*;

	public class ActionBar extends Component
	{
		public function ActionBar(parent:DisplayObjectContainer=null, title:String=null)
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

			_navButton = new TextButton(this, 'BackBackBack', 0, 0, TextButton.BOARD_TYPE_ARROW);
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
			_navButton.x = Style.MARGIN_COMMON * Element.ScaleRatio;
			_navButton.y = (_bg.height - _navButton.height) / 2;
			super.draw();
		}
	}
}