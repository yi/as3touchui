		/**
		 * instanitiate the source asset
		 */
		private static  var source:DisplayObject = new _SRC as DisplayObject ;

		/**
		 * the middle repeatable bitmap area
		 */
		private static  var _repeatPartBmpd:BitmapData = new BitmapData(
			(source.width - (PRESERVER_LEFT_WIDTH + PRESERVER_RIGHT_WIDTH)) * Element.ScaleRatio ,
			source.height * Element.ScaleRatio, false, 0) ;

		/**
		 * create an scaled bitmap data and draw the source onto it
		 */
		private static  var _sourceBmpd:BitmapData = new BitmapData(
			source.width * Element.ScaleRatio,
			source.height * Element.ScaleRatio,
			true, 0) ;

		/**
		 * return the scaled graphic bitmap
		 */
		override protected function get repeatPartBmpd():BitmapData
		{
			return _repeatPartBmpd;
		}

		/**
		 * return the scaled graphic bitmap
		 */
		override protected function get sourceBmpd():BitmapData
		{
			return _sourceBmpd;
		}

		/* static init */
		/* draw the source bmp */
		Helper.reusableMatrix.identity();
		Helper.reusableMatrix.scale(Element.ScaleRatio, Element.ScaleRatio);
		_sourceBmpd.draw(source, Helper.reusableMatrix);

		/* draw the repeatable bmp */
		Helper.reusableMatrix.identity();
		Helper.reusableMatrix.translate(- PRESERVER_LEFT_WIDTH, 0);
		Helper.reusableMatrix.scale(Element.ScaleRatio, Element.ScaleRatio);
		_repeatPartBmpd.draw(source, Helper.reusableMatrix);

		/* clean up */
		_SRC = null;
		source = null;