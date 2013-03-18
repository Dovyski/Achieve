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
package com.as3gamegears.achieve 
{	
	public class Achieve 
	{
		public static const ACTIVE_IF_GREATER_THAN	:String = ">";
		public static const ACTIVE_IF_LESS_THAN		:String = "<";
		
		private var mProps 			:Object;
		private var mAchievements 	:Object;
		
		public function Achieve() {
			mProps 			= { };
			mAchievements 	= { };
		}
		
		public function defineProperty(theName :String, theTriggerMode :String, theValue :int, theTags :Array = null) :void {
			mProps[theName] = new Property(theName, theTriggerMode, theValue, theTags);
		}
		
		public function defineAchievement(theName :String, theRelatedProps :Array) :void {
			mAchievements[theName] = new Achievement(theName, theRelatedProps);
		}
		
		public function getValue(theProp :String) :int {
			if (mProps[theProp] == null) {
				throw new ArgumentError("Unknown achievement property \""+theProp+"\".");
			}
			return mProps[theProp].value; // TODO: check for null
		}
		
		public function addValue(theProp :String, theValue :int) :void {
			setValue(theProp, getValue(theProp) + theValue);
		}
		
		public function setValue(theProp :String, theValue :int) :void {
			if (mProps[theProp] == null) {
				throw new ArgumentError("Unknown achievement property \""+theProp+"\".");
			}
			mProps[theProp].value = theValue; // TODO: check for null
		}
		
		public function resetProperties(theTags :Array = null) :void {
			for (var n :String in mProps) {
				var aProp :Property = mProps[n];
				
				if(theTags == null || hasTag(aProp, theTags)) {
					aProp.value = 0; // TODO: constraints?
				}
			}
		}
		
		private function hasTag(theProp :Property, theTags :Array) :Boolean {
			var aRet :Boolean = false;
			
			for (var i:int = 0; i < theTags.length; i++) {
				if (theProp.tags.indexOf(theTags[i]) != -1) {
					aRet = true;
					break;
				}
			}
			
			return aRet;
		}
		
		public function checkAchievements() :Vector.<Achievement> {
			var aRet :Vector.<Achievement> = null;
			
			for (var n :String in mAchievements) {
				var aAchivement :Achievement = mAchievements[n];

				if (aAchivement.unlocked == false) {
					var aActiveProps :int = 0;
					
					for (var p :int = 0; p < aAchivement.props.length; p++) {
						if (mProps[aAchivement.props[p]].isActive()) {
							aActiveProps++;
						}
					}

					if (aActiveProps == aAchivement.props.length) {
						aAchivement.unlocked = true;
						aRet = aRet || new Vector.<Achievement>;
						aRet.push(aAchivement);
					}
				}
			}
			
			return aRet;
		}
	}
}