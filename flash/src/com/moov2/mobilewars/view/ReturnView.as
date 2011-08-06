package com.moov2.mobilewars.view
{
	import com.moov2.mobilewars.vo.BombVO;
	
	import flash.display.GraphicsPathCommand;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public class ReturnView extends Sprite
	{
		private var _currentTime:int;
		private var _bombReturnCallback:Function;
		
		public var modal : Sprite;
		public var clockFace : Sprite;
		public var clockSegment : Shape;
		public var bomb:BombVO;
		
		public function ReturnView( bombReturnCallback:Function )
		{
			super();
			this._bombReturnCallback = bombReturnCallback;
			this.clockSegment = new Shape();
			this.addChild(clockSegment);
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.modal.width = stage.stageWidth;
			this.modal.height = stage.stageHeight;
			
			this.clockFace.width = stage.stageWidth * 0.8;
			this.clockFace.height = this.clockFace.width;
			this.clockFace.x = (stage.stageWidth / 2)- (this.clockFace.width/2);
			this.clockFace.y = (stage.stageHeight / 2)- (this.clockFace.height/2);
			this.clockSegment.x = this.clockFace.x + (this.clockFace.width /2);
			this.clockSegment.y = this.clockFace.y + (this.clockFace.height /2);
			setupSeconds();
		}
		
		private function setupSeconds():void
		{
			var midPoint:Point = new Point(this.clockSegment.x - 10, this.clockSegment.y -10);
			var radius:int = (this.clockFace.width / 2) + 20;
			var tf:TextField;
			var points : Array = getPointsOnCircle(midPoint, radius, Main.MAX_TIMER);

			for(var i:int=0; i<points.length; i++)
			{
				tf = new TextField();
				tf.text = (i+1).toString();
				tf.x = points[i].x;
				tf.y = points[i].y;
				this.addChild(tf);
			}
		}
		
		private function getPointsOnCircle( center:Point, radius:Number, n:Number = 10 ) : Array
		{
			var alpha:Number = Math.PI * 2 / n;
			var points:Array = new Array( n );
			var topY:int =stage.stageHeight;
			var topYindex:int = 0;
			var i:int = -1;
			while( ++i < n )
			{
				var theta:Number = alpha * i;
				var pointOnCircle:Point = new Point( Math.cos( theta ) * radius, Math.sin( theta ) * radius );
				points[ i ] = center.add( pointOnCircle );
				if(points[i].y < topY)
				{
					topY = points[i].y;
					topYindex = i;
				}
			}
			// reorder array so it starts from top of circle
			var front:Array = points.splice(topYindex+1, points.length-1);
			points = front.concat(points);
			return points;
		}
		
		public function timeTick():void
		{ 
			const TWO_PI:Number = Math.PI * 2;
			
			// level of detail of circle
			var resolution:Number = 90;
			// percent of circle to fill
			this._currentTime = Main.GetRandomTimer();
			var segmentPercent:Number = this._currentTime / Main.MAX_TIMER;
			var radius:Number = (this.clockFace.width/2) - 10;
			// angle as a number of steps towards a full circle
			var angle:Number = Math.ceil(resolution*segmentPercent);
			// size of each step
			var step:Number = TWO_PI / resolution;
			// drawing points 
			var coords:Vector.<Number> = new Vector.<Number>();
			// collection of lineTo commands
			var drawCommands:Vector.<int> = new Vector.<int>(); 
			// populate vectors
			for (var i:Number = 0; i <TWO_PI + step; i += step)
			{
				    coords.push(radius * Math.cos(i), radius * Math.sin(i));
				    drawCommands.push(GraphicsPathCommand.LINE_TO);
			}
			clockSegment.rotation = -90; // makes us start from 12 o'clock 
			clockSegment.graphics.clear();
			clockSegment.graphics.beginFill(0xFF0000);
	        // step up to angle (*2 because coords has 2 values for every command - x and y)
		    clockSegment.graphics.drawPath(drawCommands, coords.slice(0, angle*2));
		}
		
		private function onClick(e:Event):void
		{
			this._bombReturnCallback(this.bomb);
		}
	}
}