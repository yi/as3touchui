package as3touchui.components
{
	import flash.display.DisplayObjectContainer;

	public class VScrollPane extends Component
	{
		public function VScrollPane(parent:DisplayObjectContainer=null, xpos:Number=0, ypos:Number=0)
		{
			super(parent, xpos, ypos);
			invalidateOnStageResize = true;
		}


		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
		}

		override public function draw():void
		{
			setSize(stage.stageWidth, stage.stageHeight - y);
			graphics.clear();
			graphics.beginFill(0xffbbdd);
			graphics.drawRoundRect(0, 0, _width, _height, 100, 100);
			graphics.endFill();
		}

	}
}