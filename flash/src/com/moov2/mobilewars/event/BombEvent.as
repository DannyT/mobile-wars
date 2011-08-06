package com.moov2.mobilewars.event
{
	
	import com.moov2.mobilewars.vo.BombVO;
	
	import flash.events.Event;
	
	public class BombEvent extends Event
	{
		public static const TAPPED:String = "tapped";
		
		public var bomb : BombVO;
		
		public function BombEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}