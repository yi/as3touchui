package as3touchui.utils
{
	import as3touchui.elements.LabelText;

	import com.greensock.TimelineLite;
	import com.greensock.TweenLite;

	import flash.display.Stage;

	import mx.effects.Tween;

	public class Toaster
	{

		static private var _stage:Stage ;

		static private var field:LabelText ;

        static private var msgs:Vector.<String> = new Vector.<String>;

		static private var timeline:TimelineLite;

		static public function init(stage:Stage):void
		{
			if(stage == null)return;
            _stage = stage;
            field = new LabelText;

			timeline =  new TimelineLite({onComplete:checkMsgQueue});
			timeline.append(new TweenLite(field, 1, {y: String(100)}));
			timeline.append(new TweenLite(field, 2, {alpha: 0}));
			 
		}

        static private const MAX_LENGTH_OF_MSG:int = 16;

		static public function push(msg:String):void
		{
            if(_stage == null || msg == null || msg.length == 0) return;

            if(msg.length > MAX_LENGTH_OF_MSG)msg = msg.substr(0, MAX_LENGTH_OF_MSG);

            if(msgs.indexOf(msg) >= 0) return;

            msgs.push(msg);
		}

		static public function checkMsgQueue():void
        {
            if(_stage == null || msgs.length == 0 || (timeline.currentProgress > 0 && timeline.currentProgress < 1))
			{
				if(field.parent != null) field.parent.removeChild(field);
				return;
			}

            var msg:String = msgs.shift();
            field.text = msg;

			field.alpha = 0;
			field.y = _stage.stageHeight;
			field.x = (_stage.stageWidth - field.width) / 2;
			_stage.addChild(field);

			timeline.restart();
        }
	}
}
import as3touchui.elements.LabelText;

class ToastText extends LabelText
{
}
