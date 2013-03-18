/**
 * Copyright (C) 2013 Fernando Bevilacqua
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software,
 * and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or substantial
 * portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
 * TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
 * CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */
package  
{
	import com.as3gamegears.achieve.Achieve;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.text.TextField;
	import flash.ui.Keyboard;

	public class Game extends MovieClip
	{
		public static var mouse 		:Vector3D = new Vector3D(100, 100);
		public static var width 		:Number = 0;
		public static var height 		:Number = 0;
		
		public var achieve	 	:Achieve;
		public var logs	 		:TextField;
		
		public static var instance 		:Game;
		
		public var boids :Vector.<Boid> = new Vector.<Boid>;
		
		public function Game() {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e :Event) :void {
			var i :int, boid :Boid;

			Game.instance 			= this;
			Game.width 				= stage.stageWidth;
			Game.height 			= stage.stageHeight;
			Game.instance.achieve	= new Achieve();
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			for (i = 0; i < 10; i++) {
				boid = new Boid(Game.width / 2 * Math.random() * 0.8, Game.height / 2 * Math.random() * 0.8, 20 +  Math.random() * 20);
				
				addChild(boid);
				boids.push(boid);
				
				boid.reset();
			}
			
			logs 					= new TextField();
			logs.width 				= Game.width * 0.6; 
			logs.height 			= Game.height * 0.3; 
			logs.background 		= true;
			logs.backgroundColor 	= 0x000000;
			logs.textColor			= 0xffffff;
			logs.alpha				= 0.7;
			logs.text	= "Console\n-------------------------------\n";
			addChild(logs);
			
			Game.instance.achieve.defineProperty("kills", Achieve.ACTIVE_IF_GREATER_THAN, 5, ["partial"]);
			Game.instance.achieve.defineProperty("criticalDamages", Achieve.ACTIVE_IF_GREATER_THAN, 6, ["partial"]);
			Game.instance.achieve.defineProperty("deaths", Achieve.ACTIVE_IF_LESS_THAN, 2);
			
			Game.instance.achieve.defineAchievement("killer", ["kills"]);
			Game.instance.achieve.defineAchievement("last", ["deaths"]);
			Game.instance.achieve.defineAchievement("hero", ["kills", "criticalDamages", "deaths"]);
		}
		
		private function onClick(e :MouseEvent) :void {
			Game.instance.achieve.addValue(["kills", "criticalDamages"], 1);
			Game.instance.achieve.setValue("deaths", 1);
			
			logs.appendText("kills = " + Game.instance.achieve.getValue("kills") + "\n");
			trace("Partial check: " + Game.instance.achieve.checkAchievements(["partial"]));
		}
		
		private function onKeyDown(e :KeyboardEvent) :void {
			if (e.keyCode == Keyboard.C) {
				trace("Complete CHECK: " + Game.instance.achieve.checkAchievements());
			}
		}
		
		public function update():void {
			var i :int;
						
			for (i = 0; i < boids.length; i++) { 
				boids[i].update();
			}
		}
	}
}