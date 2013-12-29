package  {
	import flash.events.*;
	import flash.geom.*;
	import flash.utils.*;
	import flash.display.MovieClip;
	
	public class Level extends MovieClip {
	
		protected var puck:Puck;
		var maxx:int, maxy:int;
		var dragging:Boolean = false;
		var start:Boolean = false;
		var end:Boolean = false;
		var walls:Array = new Array();
		var goal:End;
		const GRAVITY:Number = 1.5;
		public function Level() {
			this.addEventListener(Event.ADDED_TO_STAGE, onAdd);
			this.addEventListener(Event.ENTER_FRAME, onFrame);
		}
		function onAdd(e) {
			maxx = this.width;
			maxy = this.height;
			puck = _puck;
			puck.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addObjects();
			
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			btnQuit.addEventListener(MouseEvent.CLICK, onQuit);
		}
		
		function onQuit(e) {
			this.Lose();
		}
		
		function addObjects() {
			for (var i:int = 1; i < this.numChildren; i++)
			{
				var child = this.getChildAt(i);
				if(child is Line)
				  	walls.push(child);
				if(!goal && (child is End))
					goal = child;
			}
		}
		
		function onDown(e) {
			if(start)
				return;
			dragging = true;
		}
		function onUp(e) {
			if(start || !dragging) return;
			dragging = false;
			start = true;
			this.graphics.clear();
			puck.velocity = new Vector3D(post.x - puck.x, post.y - puck.y);
			puck.velocity.scaleBy(0.3);
		}
		
		function onFrame(e) {
			if(this.end)
				return;
			if(start) {
				if(puck.velocity.lengthSquared > 2500)
					puck.velocity.scaleBy(50/puck.velocity.length);
				var dx:int = puck.velocity.x;
				var dy:int = puck.velocity.y;
				puck.velocity.y += GRAVITY;
				while(dx != 0 || dy != 0)
				{
					var cx = dx ? dx / Math.abs(dx) : 0;
					var cy = dy ? dy / Math.abs(dy) : 0;
					puck.x += cx;
					puck.y += cy;
					dx -= cx;
					dy -= cy;
					
					if(checkCollide())
						break;
				}
				
			}
		}
		
		function checkCollide() : Boolean {
			var r:Boolean = false;
			if(goal && puck.hitTestObject(goal)) {
				removeChild(goal);
				goal = null;
				Win();
				return true;
			}
			/*if(puck.left < 0 || puck.right > maxx)
			{
				puck.left = Math.max(0, puck.left);
				puck.right = Math.min(puck.right, maxx);
				puck.velocity.x *= -puck.restitution;
				r = true;
			}
			if(puck.top < 0 || puck.bottom > maxy)
			{
				puck.top = Math.max(0, puck.top);
				puck.bottom = Math.min(puck.bottom, maxy);
				puck.velocity.y *= -puck.restitution;
				r = true;
			}*/
			if(puck.right < 0 || puck.left > maxx || puck.top > maxy)
			{
				Lose();
				return true;
			}
			r = checkWalls() || r;
			if(checkPortals())
				return checkCollide();
			return r;
		}
		
		function checkWalls() {
			var r:Boolean = false;
			for each(var wall:Line in walls) {
				var collide = false;
				if(puck.hitTestPoint(wall.point1.x, wall.point1.y) ||
				   puck.hitTestPoint(wall.point2.x, wall.point2.y)) {
					collide = true;
				}
				var hit:Point;
				if(wall.isVertical) {
					hit = new Point(wall.x, puck.y);
					if((hit.y < wall.point1.y || hit.y > wall.point2.y) && !collide)
						continue;

					if(puck.hitTestPoint(hit.x, hit.y) || collide)
					{
						r = true;
						if(puck.velocity.x > 0)
							puck.right = hit.x;
						else
							puck.left = hit.x + wall.width;
						puck.velocity.x *= -puck.restitution;
					}
				} else {
					hit = new Point(puck.x, wall.y);
					if((hit.x < wall.point1.x || hit.x > wall.point2.x) && !collide)
						continue;
					if(puck.hitTestPoint(hit.x, hit.y) || collide)
					{
						r = true;
						if(puck.velocity.y > 0)
							puck.bottom = hit.y;
						else
							puck.top = hit.y + wall.height;
							
						puck.velocity.y *= -puck.restitution;
					}
				}
			}
			return r;
		}
		
		function checkPortals() {
			var portal1:MovieClip = this["portal1"];
			var portal2:MovieClip = this["portal2"];
			if(!portal1 || !portal2)
				return;
			var purad = puck.width / 2;
			var porad = portal1.width / 2;
			var a = puck.x - portal1.x;
			var b = puck.y - portal1.y;
			var hitdist = purad + porad;
			if(a*a + b*b < hitdist*hitdist) {
				puck.x = portal2.x;
				puck.y = portal2.y;
				return true;
			}
			return false;
		}
		
		function onMove(e:MouseEvent) {
			if(!dragging) return;
			var nx:int = e.stageX - this.x;
			var ny:int = e.stageY - this.y;
			var np:Point = new Point(nx, ny);
			var pp:Point = new Point(post.x, post.y);
			if(!Move(nx, ny)) {
				// sqrt(nx*nx + y*y) = 100
				// nx * nx + y * y = 10000
				// y*y = 10,000 - nx*nx
				// y = sqrt(10,000 - nx*nx);
			}
		}
		
		function Move(nx:int, ny:int) : Boolean {
			var p:Vector3D = new Vector3D(nx - post.x, ny - post.y);
			var ppost:Point = new Point(post.x, post.y);
			if(p.lengthSquared > 10000) 
			{
				p.scaleBy(100 / p.length);
			}
			puck.x = ppost.x + p.x;
			puck.y = ppost.y + p.y;
			this.graphics.clear();
			this.graphics.lineStyle(2, 0);
			this.graphics.moveTo(ppost.x, ppost.y);
			this.graphics.lineTo(puck.x, puck.y);
			return true;
		}
		
		function Win()
		{
			if(this.end)
				return;
			parent.addChild(new WinScreen(Class(getDefinitionByName(getQualifiedClassName(this)))));
			EndGame();
		}
		
		function Lose()
		{
			if(this.end)
				return;
			parent.addChild(new LoseScreen(Class(getDefinitionByName(getQualifiedClassName(this)))));
			EndGame();
		}
		
		function EndGame()
		{
			this.end = true;
			this.removeEventListener(Event.ENTER_FRAME, onFrame);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			parent.removeChild(this);
		}
	}

}
	