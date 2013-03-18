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
	/**
	 * Describes a property used to measure an achievement progress. A property is pretty much a counter
	 * with some special attributes (such as default value and update constraints).
	 */
	public class Property 
	{
		private var mName 				:String;
		private var mValue 				:int;
		private var mActivation 		:String;
		private var mActivationValue 	:int;
		private var mInitialValue 		:int;
		private var mTags				:Array;
		
		public function Property(theName :String, theInitialValue :int, theActivation :String, theActivationValue :int, theTags :Array = null) {
			mName 				= theName;
			mActivation 		= theActivation;
			mActivationValue 	= theActivationValue;
			mInitialValue 		= theInitialValue;
			mTags 				= theTags;
			
			reset();
		}
		
		public function isActive() :Boolean {
			var aRet :Boolean = false;
			
			switch(mActivation) {
				case Achieve.ACTIVE_IF_GREATER_THAN: 	aRet = mValue > mActivationValue; break;
				case Achieve.ACTIVE_IF_LESS_THAN: 		aRet = mValue < mActivationValue; break;
			}
			
			return aRet;
		}
		
		public function reset() :void {
			mValue = mInitialValue;
		}
		
		public function set value(v :int) 	:void 	{ mValue = v; }
		
		public function get value() 		:int 	{ return mValue; }
		public function get activation() 	:String { return mActivation; }
		public function get tags() 			:Array 	{ return mTags; }
		public function get name() 			:String { return mName; }
	}
}