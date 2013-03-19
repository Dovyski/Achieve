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
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class UnlockedSign extends MovieClip
	{
		public static const WIDTH 	:Number = 220;
		public static const HEIGHT 	:Number = 60;
		
		private var mTTL 	:Number = 100;
		private var mTitle 	:TextField;
		private var mText 	:TextField;
		
		public function UnlockedSign(theX :Number, theY :Number, theAchivementName :String) {
			x = theX;
			y = theY;
			
			graphics.lineStyle(2, 0x9f9f9f);
			graphics.beginFill(0x000000);
			graphics.moveTo(0, 0);
			graphics.lineTo(WIDTH, 0);
			graphics.lineTo(WIDTH, HEIGHT);
			graphics.lineTo(0, HEIGHT);
			graphics.lineTo(0, 0);
			graphics.endFill();
			
			initTexts(theAchivementName);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function initTexts(theAchivementName :String) :void {
			var aFormat :TextFormat = new TextFormat();
			aFormat.font = "Arial";
			aFormat.bold = true;
			
			mTitle 				= new TextField();
			mTitle.width 		= WIDTH * 0.95;
			mTitle.x 			= WIDTH * 0.05;
			mTitle.y 			= 5;
			mTitle.textColor 	= 0xffffff;
			
			mText 				= new TextField();
			mText.width 		= WIDTH * 0.95;
			mText.x 			= WIDTH * 0.05;
			mText.y 			= 24;
			mText.wordWrap 		= true;
			mText.textColor 	= 0xffffff;
			
			mTitle.defaultTextFormat = aFormat;
			aFormat.bold = false;
			mText.defaultTextFormat = aFormat;
			
			addChild(mTitle);
			addChild(mText);
			
			switch(theAchivementName) {
				case "killer": mTitle.text = "Unlocked: MONSTER KILL"; mText.text = "Kill 5 or more enemies."; break;
				case "last": mTitle.text = "Unlocked: ZOMBIE"; mText.text = "Beat a level with 2 or less lives."; break;
				case "hero": mTitle.text = "Unlocked: GAME MASTER"; mText.text = "Kill 5+ enemies, critical damage and lives."; break;
			}
		}
		
		private function init(e :Event) :void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e :Event) :void {
			if (--mTTL <= 0) {
				alpha -= 0.01;
				
				if(alpha <= 0) {
					removeEventListener(Event.ENTER_FRAME, update);
					parent.removeChild(this);
				}
			}
		}
	}
}