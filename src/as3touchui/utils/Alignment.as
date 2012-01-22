package as3touchui.utils
{
	import flash.display.DisplayObject;

	/**
	 * 各种对齐方式的枚举
	 * @author ty
	 *
	 */
	public class Alignment
	{
		/**
		 * y方向 下方
		 */
		public static const BOTTOM:int = 3;

		/**
		 * 对齐方向: 中下角
		 */
		public static const BOTTOM_CENTER:int = BOTTOM << 8 | ONLY_CENTER ;

		/**
		 * 对齐方向: 左下角
		 */
		public static const BOTTOM_LEFT:int = BOTTOM << 8 | ONLY_LEFT;
		/**
		 * 对齐方向: 右下角
		 */
		public static const BOTTOM_RIGHT:int = BOTTOM << 8 | ONLY_RIGHT;

		/**
		 * x方向不管
		 */
		public static const CUSTOM_H:int = 0;

		/**
		 * y方向不管
		 */
		public static const CUSTOM_V:int = 0;

		/**
		 * y方向 中
		 */
		public static const MIDDLE:int = 2;

		/**
		 * 对齐方向: 中中角
		 */
		public static const MIDDLE_CENTER:int = MIDDLE << 8 | ONLY_CENTER;

		/**
		 * 对齐方向: 左中角
		 */
		public static const MIDDLE_LEFT:int = MIDDLE << 8 | ONLY_LEFT;

		/**
		 * 对齐方向: 右中角
		 */
		public static const MIDDLE_RIGHT:int = MIDDLE << 8 | ONLY_RIGHT;

		/**
		 * 仅仅在底部对齐
		 */
		public static const ONLY_BOTTOM:int = BOTTOM << 8 | CUSTOM_H;

		/**
		 * x方向 中
		 */
		public static const ONLY_CENTER:int = 2;

		/**
		 * x 方向 靠左
		 */
		public static const ONLY_LEFT:int = 1;

		/**
		 * 仅仅在中部对齐
		 */
		public static const ONLY_MIDDLE:int = MIDDLE << 8 | CUSTOM_H;

		/**
		 * x方向 右
		 */
		public static const ONLY_RIGHT:int = 3;

		/**
		 * 仅仅在顶部对齐
		 */
		public static const ONLY_TOP:int = TOP << 8 | CUSTOM_H;

		/**
		 * y方向 上
		 */
		public static const TOP:int = 1;

		/**
		 * 对齐方向: 中上角
		 */
		public static const TOP_CENTER:int = TOP << 8 | ONLY_CENTER;

		/**
		 * 对齐方向: 左上角
		 */
		public static const TOP_LEFT:int = TOP << 8 | ONLY_LEFT;

		/**
		 * 对齐方向: 右上角
		 */
		public static const TOP_RIGHT:int = TOP << 8 | ONLY_RIGHT;

		/**
		 * 计算出x方向的对齐偏移的权重
		 * @param value
		 * @return
		 */
		public static  function GetXOffsetPercent(alignment:int):Number
		{
			return ((alignment & 0xff) - 1) / 2.0
		}

		/**
		 * 计算出y方向的对齐偏移的权重
		 * @param value
		 * @return
		 */
		public static  function GetYOffsetPercent(alignment:int):Number
		{
			return ((alignment >> 8) - 1) / 2.0
		}

		/**
		 * 计算应用注册点之后的实际位置，根据给定的宽度，对齐方式和目标对其点来计算出实际对齐位置
		 * @param width 被对齐对象的宽度
		 * @param alignment 对齐方式
		 * @param targetX 目标对齐位置
		 * @return 实际对齐位置
		 */
		static public function CalcXRegedValue(width:int, alignment:int, targetX:Number):Number
		{
			if((alignment & 0xff) == 0 || width == 0) return targetX; /* CUSTOM_H */
			return  targetX - width * ((alignment & 0xff) - 1) / 2.0;
		}

		/**
		 * 计算应用注册点之后的实际位置，根据给定的高度，y对齐方式和目标对其点来计算出实际对齐位置
		 * @param height 被对齐对象的高度
		 * @param alignment 对齐方式
		 * @param targetY 目标对齐位置
		 * @return 实际对齐位置
		 */
		static public function CalcYRegedValue(height:int, alignment:int, targetY:Number):Number
		{
			if((alignment >> 8) == 0 || height == 0) return targetY; /* CUSTOM_V */
			return  targetY - height * ((alignment >> 8) - 1) / 2.0;
		}

		/**
		 * 在父级显示容器中对齐时，根据对齐方式计算实际对齐的坐标点x
		 * @param containerWidth 父级显示容器的宽度
		 * @param alignment 对齐方式
		 * @param xOffset 在对齐方式的基础上的x偏移
		 * @param currentX 对象的当前Y坐标，这个值的作用是当对象在水平方向时候是自动对齐的情况下使用
		 * @return 实际对齐位置
		 */
		static public function CalcXAlignedValue(containerWidth:int, alignment:int, xOffset:int=0, currentX:int=0):Number
		{
			if((alignment & 0xff) == 0 || containerWidth == 0) return currentX; /* CUSTOM_H */
			return containerWidth * ((alignment & 0xff) - 1) / 2.0 + xOffset;
		}

		/**
		 * 在父级显示容器中对齐时，根据对齐方式计算实际对齐的坐标点y
		 * @param containerHeight 父级显示容器的高度
		 * @param alignment 对齐方式
		 * @param yOffset 在对齐方式的基础上的y偏移
		 * @param currentY 对象的当前Y坐标，这个值的作用是当对象在垂直方向时候是自动对齐的情况下使用
		 * @return 实际对齐位置
		 */
		static public function CalcYAlignedValue(containerHeight:int, alignment:int, yOffset:int=0, currentY:int=0):Number
		{
			if((alignment >> 8) == 0 || containerHeight == 0) return currentY; /* CUSTOM_V */
			return containerHeight * ((alignment >> 8) - 1) / 2.0 + yOffset;
		}
	}
}