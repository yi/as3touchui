package as3touchui.utils
{

	/**
	 * 各种对齐方式的枚举
	 * @author ty
	 *
	 */
	public class Alignment
	{

		/**
		 * 对齐方向: 中下角
		 */
		public static const BOTTOM_CENTER:int = BOTTOM << 8 | CENTER ;

		/**
		 * 对齐方向: 左下角
		 */
		public static const BOTTOM_LEFT:int = BOTTOM << 8 | LEFT;
		/**
		 * 对齐方向: 右下角
		 */
		public static const BOTTOM_RIGHT:int = BOTTOM << 8 | RIGHT;

		/**
		 * 对齐方向: 中中角
		 */
		public static const MIDDLE_CENTER:int = MIDDLE << 8 | CENTER;

		/**
		 * 对齐方向: 左中角
		 */
		public static const MIDDLE_LEFT:int = MIDDLE << 8 | LEFT;

		/**
		 * 对齐方向: 右中角
		 */
		public static const MIDDLE_RIGHT:int = MIDDLE << 8 | RIGHT;

		/**
		 * 对齐方向: 中上角
		 */
		public static const TOP_CENTER:int = TOP << 8 | CENTER;

		/**
		 * 对齐方向: 左上角
		 */
		public static const TOP_LEFT:int = TOP << 8 | LEFT;

		/**
		 * 对齐方向: 右上角
		 */
		public static const TOP_RIGHT:int = TOP << 8 | RIGHT;

		/**
		 * y方向 下方
		 */
		private static const BOTTOM:int = 3;

		/**
		 * x方向 中
		 */
		private static const CENTER:int = 2;

		/**
		 * x 方向 靠左
		 */
		private static const LEFT:int = 1;

		/**
		 * y方向 中
		 */
		private static const MIDDLE:int = 2;

		/**
		 * x方向 右
		 */
		private static const RIGHT:int = 3;

		/**
		 * y方向 上
		 */
		private static const TOP:int = 1;
	}
}