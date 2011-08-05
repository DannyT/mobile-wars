package com.moov2.mobilewars.vo
{
	public class BombVO
	{
		public function BombVO(id:String, user:String, timer:int)
		{
			this.id = id;
			this.user = user;
			this.timer = timer;
		}
		
		public var id : String;
		public var user : String;
		public var timer : int;
	}
}