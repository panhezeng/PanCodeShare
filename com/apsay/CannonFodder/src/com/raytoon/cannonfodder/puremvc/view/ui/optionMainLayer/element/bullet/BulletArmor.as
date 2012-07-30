///////////////////////////////////////////////////////////
//  BulletArmor.as
//  Macromedia ActionScript Implementation of the Class BulletArmor
//  Generated by Enterprise Architect
//  Created on:      11-七月-2011 16:03:24
//  Original author: LuXianli
///////////////////////////////////////////////////////////

package com.raytoon.cannonfodder.puremvc.view.ui.optionMainLayer.element.bullet
{
	import com.raytoon.cannonfodder.puremvc.view.ui.optionMainLayer.element.Element;
	import com.raytoon.cannonfodder.puremvc.view.ui.optionMainLayer.OptionMainLayer;
	import com.raytoon.cannonfodder.puremvc.view.ui.soundLayer.SoundLayer;
	import com.raytoon.cannonfodder.puremvc.view.ui.UIMain;
	import flash.display.MovieClip;
	import flash.system.ApplicationDomain;
	/**
	 * @author LuXianli
	 * @version 1.0
	 * @created 11-七月-2011 16:03:24
	 */
	public class BulletArmor extends Element
	{
		
		//子弹射击单位
		private var _shooter:Element;
		//单位发出子弹速度
		private var _bSpeed:int = 15;
		public function set bSpeed(value:int):void {
			_bSpeed = value;
		}
		public function get bSpeed():int {
			return _bSpeed;
		}
		//子弹 X 轴 分速度
		private var _xSpeed:Number;
		//子弹 Y 轴 分速度
		private var _ySpeed:Number;
		
		private var _bulletMovie:MovieClip;
		public function BulletArmor(from:Element,to:Element,pngName:String = "ArmorBullet"){
			super();
			row = 20;
			_shooter = from;
			target = to;
			attack = _shooter.attack;
			x = from.x;
			y = from.y;
			
			var _pngClass:Class = ApplicationDomain.currentDomain.getDefinition(pngName) as Class;
			_bulletMovie = new _pngClass() as MovieClip;
			_bulletMovie.gotoAndStop(1);
			addChild(_bulletMovie);
		}
		/**
		 * 清空子弹
		 */
		override public function clear():void 
		{
			
		}
		
		private var _bAngle:Number;
		/**
		 * 重新渲染单位
		 */
		override public function rendering():void 
		{
			if ((UIMain.getInstance(OptionMainLayer.NAME) as OptionMainLayer).getTargetIndex(target) != -1) {
				
				//实时计算射击目标的 射击角度
				_bAngle = Math.atan2(target.position.y - position.y, target.position.x - position.x);
				//设定子弹 X ，Y 分速度
				_bulletMovie.rotation = _bAngle * 57;
				_xSpeed = Math.round(_bSpeed * Math.cos(_bAngle));
				_ySpeed = Math.round(_bSpeed * Math.sin(_bAngle));
			}
			//子弹位置重定向
			x += _xSpeed;
			y += _ySpeed;
			//状态关 检测碰撞（子弹是否击中）
			if (target)
				checkHurt();
			//如果未击中并且 超出舞台 则 删除自身
			super.rendering();
		}
		/**
		 * 碰撞检测，子弹是否击中单位
		 */
		private function checkHurt():void {
			
			if (target.hitTestObject(this)) {
				(UIMain.getInstance(SoundLayer.NAME) as SoundLayer).playSound(target.attackedSound);
				_bulletMovie.gotoAndStop(2);
				(_bulletMovie["bullet_" + _bulletMovie.currentFrame] as MovieClip).addFrameScript((_bulletMovie["bullet_" + _bulletMovie.currentFrame] as MovieClip).totalFrames - 1, removeThis );
				target.downArmor(attack);
				target = null;
				attack = 0
			}
		}
	}//end BulletArmor

}