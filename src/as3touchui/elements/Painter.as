package as3touchui.elements
{
	import as3touchui.utils.Helper;

	import flash.display.*;
	import flash.geom.Matrix;

	public class Painter
	{


		[Embed(source="../../assets/panel_bg.png")]
		static private var _panelBgSrc:Class ;

		static private const PANEL_BG_BMPD:BitmapData = (new _panelBgSrc as Bitmap).bitmapData ;
		_panelBgSrc = null;

		/**
		 * 在给定的 graphics 对象上绘制背景
		 * @param graph
		 * @param width
		 * @param height
		 *
		 */
		static public function DrawBackground(graph:Graphics, width:Number, height:Number):void
		{
			if(graph == null) return;

			var m:Matrix = Helper.reusableMatrix;
			m.identity();
			m.scale(Element.ScaleRatio, Element.ScaleRatio);
			graph.clear();
			graph.beginBitmapFill(PANEL_BG_BMPD, m, true, false);
			graph.drawRect(0, 0, width, height);
			graph.endFill();

		}

	}
}