package as3touchui.components
{
	import as3touchui.elements.BgBarDark;
	import as3touchui.elements.LabelText;
	import as3touchui.utils.Alignment;
	import as3touchui.utils.Color;
	import as3touchui.utils.Style;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class ActionBar extends Component
	{
		public function ActionBar(parent:DisplayObjectContainer=null, title:String=null)
		{
			super(parent, 0, 0);
			invalidateOnStageResize = true;
			this.title = title;
		}

		protected var _titleText:LabelText ;

		protected var _bg:BgBarDark ;

		public function set title(value:String):void
		{
			_titleText.text = value;
		}

		public function get title():String
		{
			return _titleText.text;
		}

		/**
		 * Overriden in subclasses to create child display objects.
		 */
		override protected function addChildren():void
		{
			_bg = new BgBarDark;
			addChild(_bg);

			_titleText = new LabelText('',
				Style.FONT_SIZE_TITLE, Color.TEXT_ON_DARK_BG,
				Color.TEXT_SHADOW_ON_DARK_BG, Alignment.MIDDLE_CENTER
			);
			addChild(_titleText);
		}

//		override protected function whenAddToStage(event:Event = null):void
//		{
//			super.whenAddToStage(event);
//			draw();
//		}

		/**
		 * Abstract draw function.
		 */
		override public function draw():void
		{
			var stageWidth:int = stage.stageWidth
			_bg.width = stageWidth;
			_titleText.x = stageWidth / 2;
			_titleText.y = _bg.height / 2;
			super.draw();
		}
	}
}