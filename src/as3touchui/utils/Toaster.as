package as3touchui.utils
{
	import as3touchui.elements.LabelText;

	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	import mx.effects.Tween;

	public class Toaster
	{

		static private var _stage:Stage ;
		static private var label:LabelText ;
		static private var field:Sprite ;
		static private var _hPercent:Object ;
		static private var _vPercent:Object ;

		static public function init(stage:Stage, hPercent:Object = .5, vPercent:Object=.5, w:int = 200, h:int=24):void
		{
			if(stage == null) return;

			_stage = stage;
			stage.addEventListener(Event.RESIZE, positionField);

			_hPercent = hPercent;
			_vPercent = vPercent;

            label = new LabelText(null, 12, 0xffffff, 0x000000, Alignment.MIDDLE_CENTER);

			field = new Sprite;
			field.addChild(label);
			field.graphics.beginFill(0, 0.3);
			field.graphics.drawRoundRect( -w/2, -h/2, w, h, 16, 16);
			field.graphics.endFill();
		}

        static private const MAX_LENGTH_OF_MSG:int = 16;

		static public function push(msg:String):void
		{
            if(_stage == null || msg == null || msg.length == 0) return;

            if(msg.length > MAX_LENGTH_OF_MSG)msg = msg.substr(0, MAX_LENGTH_OF_MSG);

			label.text = msg;

			if(field.parent != null)
			{ /* 正在显示toast */
				TweenLite.killTweensOf(field);
				field.alpha = 1;
			}
			else
			{
				field.alpha = 1;
				positionField();
				_stage.addChild(field);
			}
			TweenLite.to(field, 2, {alpha:0, onComplete:removeField, delay:2});
		}

		static private function positionField(event:Event=null):void
		{
			if(_stage == null) return;
			var x:Number;
			var y:Number;

			if(_hPercent is Number)
			{
				x = Number(_hPercent);
				if(x < 1) x = _stage.stageWidth * x;
			}
			else if(_hPercent is String)
			{
				x = parseInt(_hPercent.toString());
				if(isNaN(x)) x = _stage.stageWidth /2;
				if(x < 0) x = _stage.stageWidth - x;
			}

			if(_vPercent is Number)
			{
				y = Number(_vPercent);
				if(y < 1) y = _stage.stageHeight * y;
			}
			else if(_vPercent is String)
			{
				y = parseInt(_vPercent.toString());
				if(isNaN(y)) y = _stage.stageHeight /2;
				if(y < 0) y = _stage.stageHeight + y;
			}

			trace("[Toaster.positionField] x:"+x+"; y:"+y);
			field.x = x;
			field.y = y;
		}

		static public function removeField():void
		{
			if(field.parent != null)field.parent.removeChild(field);
		}
	}
}
