// // ///////////////////////////////////////////////////////
// MouseStyleNow.as
// Macromedia ActionScript Implementation of the Class MouseStyleNow
// Generated by Enterprise Architect
// Created on:      31-十二月-2011 11:59:44
// Original author: LuXianli
// // ///////////////////////////////////////////////////////
package com.raytoon.cannonfodder.tools.utils {
	import com.raytoon.cannonfodder.puremvc.view.ui.UIMain;
	import flash.system.ApplicationDomain;

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.utils.Timer;

	/**
	 * @author LuXianli
	 * @version 1.0
	 * @created 31-十二月-2011 11:59:44
	 */
	public class MouseStyleNow extends Sprite {
		private static var _instance : MouseStyleNow;
		public static const NAME : String = "MouseStyleNow";

		public function MouseStyleNow() {
		}

		/**
		 * 得到鼠标样式显示实例
		 * @return
		 */
		public static function getInstace() : MouseStyleNow {
			if (!_instance) {
				_instance = new MouseStyleNow();
				UIMain.setInstance(NAME, _instance);
				(UIMain.getInstance(CannonFodder.NAME) as CannonFodder).addChild(_instance);
				(UIMain.getInstance(CannonFodder.NAME) as CannonFodder).addEventListener(MouseEvent.CLICK, mouseClickHandler);
			}

			return _instance;
		}

		private static function mouseClickHandler(event : MouseEvent) : void {
		}

		private var _mouse : MovieClip;
		private var _mouseTimer : Timer;
		private var _mouseTime : int = 1000 / 60;

		/**
		 * 显示鼠标形状
		 */
		public function showMouse() : void {
			if (!_mouse) {
				if (ApplicationDomain.currentDomain.hasDefinition("CannonfodderMouseStyle")) {
					var _mClass : Class = UICommand.getClass("CannonfodderMouseStyle");
					_mouse = new _mClass() as MovieClip;

					// addChild(_mouse);
					_mClass = null;
					_mouse.gotoAndStop(3);
					_mouse.mouse.gotoAndStop(1);
				}
				
				// _mouse.visible = false;
			}
		}

		private function moveMouseStyle(...args) : void {
			if (_mouse) {
				_mouse.x = mouseX;
				_mouse.y = mouseY;
			}
		}

		private var _mouseFrame : int = 1;

		/**
		 * 改变鼠标形状
		 * @param	...args
		 */
		private function changeMouseStyle(...args) : void {
			var s : String = Mouse.cursor;

			switch(Mouse.cursor) {
				case MouseCursor.ARROW:
					if (_mouseFrame != 3) {
						if (_mouseFrame != 1) {
							_mouseFrame = 1;
							if (_mouse) _mouse.gotoAndStop(_mouseFrame);
						}
					}
					break;
				case MouseCursor.BUTTON:
					if (_mouseFrame != 3) {
						if (_mouseFrame != 2) {
							_mouseFrame = 2;
							if (_mouse) _mouse.gotoAndStop(_mouseFrame);
						}
					}
					break;
			}
		}

		/**
		 * 是否显示转表状态
		 * @param	flowFlag  true: 显示转表状态；false：清楚转表状态
		 */
		public function changeMouseFlow(par : Sprite = null) : void {
			if (par && _mouse) {
				addEventListener(Event.ENTER_FRAME, moveMouseStyle);
				par.addChild(_mouse);
				_mouse.visible = true;
				_mouse.mouse.play();
				Mouse.hide();
			} else if(_mouse) {
				removeEventListener(Event.ENTER_FRAME, moveMouseStyle);
				_mouse.parent.removeChild(_mouse);
				_mouse.mouse.gotoAndStop(1);
				_mouse.visible = false;
				Mouse.show();
			}
		}

		/**
		 * 改变鼠标状态
		 * @param	flag
		 */
		public function showMouseStyle(flag : int = 1) : void {
			switch(flag) {
				case 1:
					if (_mouseFrame != 1) {
						_mouseFrame = 1;
						if (_mouse) _mouse.gotoAndStop(_mouseFrame)
					}
					break;
				case 2:
					if (_mouseFrame != 2) {
						_mouseFrame = 2;
						if (_mouse) _mouse.gotoAndStop(_mouseFrame)
					}
					break;
				case 3:
					if (_mouseFrame != 3) {
						_mouseFrame = 3;
						if (_mouse) _mouse.gotoAndStop(_mouseFrame)
					}
					break;
			}
		}
	}
	// end MouseStyleNow
}