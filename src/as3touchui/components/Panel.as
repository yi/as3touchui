/**
 * Panel.as
 * Keith Peters
 * version 0.9.10
 *
 * A rectangular panel. Can be used as a container for other components.
 *
 * Copyright (c) 2011 Keith Peters
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package as3touchui.components
{
	import as3touchui.elements.Element;
	import as3touchui.utils.Helper;
	import as3touchui.utils.Style;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	public class Panel extends Component
	{
//		protected var _background:Sprite;

		/**
		 * Container for content added to this panel. This is masked, so best to add children to content, rather than directly to the panel.
		 */
		public var content:Sprite;

		protected var _mask:Sprite;

		[Embed(source="../../assets/panel_bg.png")]
		static private var _panelBgSrc:Class ;

		static private const PANEL_BG_BMPD:BitmapData = (new _panelBgSrc as Bitmap).bitmapData ;
		_panelBgSrc = null;


		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this Panel.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 */
		public function Panel(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0)
		{
			super(parent, xpos, ypos);
		}


		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			setSize(100, 100);
		}

		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
//			_background = new Sprite();
//			super.addChild(_background);

			_mask = new Sprite();
			_mask.mouseEnabled = false;
			super.addChild(_mask);

			content = new Sprite();
			super.addChild(content);
			content.mask = _mask;
		}

		/**
		 * Overridden to add new child to content.
		 */
		public override function addChild(child:DisplayObject):DisplayObject
		{
			content.addChild(child);
			return child;
		}

		/**
		 * Access to super.addChild
		 */
		public function addRawChild(child:DisplayObject):DisplayObject
		{
			super.addChild(child);
			return child;
		}

		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void
		{
			trace("[Panel.draw] ");
			super.draw();

			var m:Matrix = Helper.reusableMatrix;
			m.identity();
			m.scale(Element.ScaleRatio, Element.ScaleRatio);
			graphics.clear();
			graphics.beginBitmapFill(PANEL_BG_BMPD, m, true, false);
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();


//			_background.graphics.clear();
//			_background.graphics.
////			_background.graphics.lineStyle(1, 0, 0.1);
////			_background.graphics.beginFill(Style.COLOR_PANEL);
//			_background.graphics.drawRect(0, 0, _width, _height);
//			_background.graphics.endFill();

			_mask.graphics.clear();
			_mask.graphics.beginFill(0xff0000);
			_mask.graphics.drawRect(0, 0, _width, _height);
			_mask.graphics.endFill();
		}
	}
}