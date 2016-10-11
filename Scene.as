package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Shape;
    import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	import events.sceneMoveEvent;
	import events.changeSceneEvent;
	import dynamics.DynamicObject;
	import dynamics.Starship;
	import celestial.*;
	
	public class Scene extends MovieClip {
		var tooltip:sceneActTooltip;
		var nmDscrTooltip:nameDescTooltip;
		var systemId:int;
		var maxX,maxY,minX,minY;
		var speedX,speedY;
		var hero:DynamicObject;
		var stars:Vector.<medStarShimmer> = new Vector.<medStarShimmer>;
		var homestar:Star;
		var lensFlare:lensFlareFancy;
		var flareA,flareB,flareC,flareD:lensFlareSimple;
		var planets:Vector.<Planet> = new Vector.<Planet>;
		var station:Station;
		static var PI = Math.PI;
		
		public function Scene(key) {
			// constructor code
			systemId = key;
			
			// start creating static objects here
			var i = 50;
			while(i>0){
				i--;
				var stat = new medStarShimmer();
				stat.x = Math.random()*4096;
				stat.y = Math.random()*4096;
				addChild(stat);
				stars.push(stat);
			}
			// end creating static objects here
			
			// celestial bodies here
			planets.length = 5;
			planets.fixed = true;
			starSystemInit(systemId);
			// end celestial bodies
			
			// lens flares here
			lensFlare = new lensFlareFancy();
			flareA = new lensFlareSimple(1);
			flareB = new lensFlareSimple(0.5);
			flareC = new lensFlareSimple(0.5);
			flareD = new lensFlareSimple(0.3);
			addChild(lensFlare);
			addChild(flareA);
			addChild(flareB);
			addChild(flareC);
			addChild(flareD);
			// end lens flares			
						
			tooltip = new sceneActTooltip("kek");
			tooltip.visible = false;
			addChild(tooltip);
			
			nmDscrTooltip = new nameDescTooltip("kek","kek");
			nmDscrTooltip.visible = false;
			addChild(nmDscrTooltip);
			
			addEventListener(Event.ENTER_FRAME, enterFrameF);
			addEventListener(MouseEvent.MOUSE_OVER,MouseOver);
			addEventListener(MouseEvent.MOUSE_OUT,MouseOut);
			
			x = y = 0;
			speedX = speedY = 0;
			maxX = 2048;
			maxY = 2048;
			minX = -1247;
			minY = -1567;
		}
		
		function MouseOver(e:MouseEvent){
			var tgt = e.target;
			var tst = getQualifiedClassName(tgt);
			// && (tgt.distanceTo(mouseX, mouseY) < tgt.GetSignature())
			if((tst == "celestial::Planet" || tst == "celestial::Star" || tst == "celestial::Station") ){
				MakeTooltip(tgt);
				nmDscrTooltip.visible = true;
			}
		}
		
		function MouseOut(e:MouseEvent){
			if(nmDscrTooltip != null){
				nmDscrTooltip.visible = false;
			}
		}
		
		function MakeTooltip(tgt){
			var nm = tgt.GetName();
			var ds = tgt.GetDescription();
			
			nmDscrTooltip.SetValues(nm,ds);
			nmDscrTooltip.x = mouseX + 16;
			nmDscrTooltip.y = mouseY + 16;
			
			addChild(nmDscrTooltip);
		}
		
		function flareEffectsToTop(){
			removeChild(lensFlare);
			removeChild(flareA);
			removeChild(flareB);
			removeChild(flareC);
			removeChild(flareD);
			addChild(lensFlare);
			addChild(flareA);
			addChild(flareB);
			addChild(flareC);
			addChild(flareD);
		}
		
		function starSystemInit(key){
			switch(key){
				case 24:
					homestar = new Star(1.2,0xFF9900,"Arghus","Oldest humanity outpost in this distant sector.");
					planets[0] = new Planet(8,0.25,0x884422,homestar,550,0.001,1.5,"Varh","Small and hot boulder. Has some valuable minerals, but the extraction is too costly.",false);
					planets[1] = new Planet(0,0.5,0x9999FF,homestar,1200,0.0002,0,"Arghus Prime","Main human colony, it's a lush planet with 1 big continent, a lot of water and resources.",true);
					planets[2] = new Planet(3,1,0x00CC99,homestar,1800,0.0001,0.3,"Koelas","Typical hydrogen-helium gas giant. A few low-orbit stations produce fuel here.",false);
					station = new Station(0,0.35,0xCC9900,planets[1],150,0.005,0,"Albios Project","The remains of a sleeper ship from Earth now serve as an orbital station.");
					break;
				case 182:
					homestar = new Star(0.9,0x00FF44,"Emerald Crown","The star earned it's name for unique color. Now it's most valuable system in the sector.");
					planets[0] = new Planet(1,0.6,0x00CCAA,homestar,1450,0.0003,0.8,"Vertos","Oceanic planet, full of primitive life forms, with numerous islands having different climate and flora.",true);
					planets[1] = new Planet(6,0.3,0x009944,homestar,1800,0.0003,0.2,"Aeos","Small cold planet with no atmosphere. Has a huge impact crater.",false);
					break;
				case 224:
					homestar = new Star(1.6,0xFF0000,"Vaseneva","This unfriendly system serves as home to human military production.");
					planets[0] = new Planet(7,0.1,0xFF3333,homestar,300,0.005,0,"Molto","Extremely hot planet is pulled closer to the star with each day, but speed saves it for now.",false);
					planets[1] = new Planet(8,0.4,0x660000,homestar,900,0.0001,1.8,"Kerensky","Harsh planet rich with metals. Powerful production facilities cover the surface.",true);
					station = new Station(2,0.3,0xFF0000,planets[1],230,0.005,0,"Kerensky Orbital Shipyard","3/4 human ships and a lot of ship equipment are made here.");
					break;
				case 333:
					homestar = new Star(1,0xFFFFAA,"Five Brothers","Planets here move in a unique spiral pattern, distance between them is always the same.");
					planets[0] = new Planet(7,0.3,0x666666,homestar,400,0.0005,0,"FB-A","First 'brother' is a small rocky planet near the star.",false);
					planets[1] = new Planet(7,0.3,0x6699CC,homestar,600,0.0005,1,"FB-B","This planet's minerals give it a strange blue scent.",false);
					planets[2] = new Planet(6,0.4,0xFFFFFF,homestar,800,0.0005,2,"FB-C","FB-C had a natural satellite, but seems like something brought it to the surface.",false);
					planets[3] = new Planet(3,1,0xCC9900,homestar,1100,0.0005,3,"Big Bro","Scientists think that this planet's gravity is responsible for the movement pattern of the system.",false);
					planets[4] = new Planet(8,0.2,0xDDDDFF,homestar,1400,0.0005,4,"FB-E","Cold and small planet found it's place on the outskirts.",false);
					break;
				case 477:
					homestar = new Star(2.2,0xFF3300,"Jonah","Enormous size of the star in this system attracts the scientists attention.");
					planets[0] = new Planet(7,0.06,0x663399,homestar,2000,0.0001,5,"Sentinel","Tiny planetoid, likely formed from an asteroid belt by the star's gravity.",false);
					station = new Station(1,0.4,0x0000FF,homestar,500,0.002,0,"Ermacorp SR","Started as a star research, but now it's labs are leased to anyone willing to pay.");
					break;
				case 525:
					homestar = new Star(0.5,0x0000FF,"Vala","This system was only recently discovered and has some potential.");
					planets[0] = new Planet(4,0.3,0xFF00FF,homestar,700,0.001,2,"Vala Prime","Small and heavy planet with extremely dense atmosphere. It's still unclear if it has solid or liquid surface.",false);
					planets[1] = new Planet(7,0.6,0x000000,homestar,1300,0.001,0,"Vala B","The planet's gravity is fairly low for it's size, which makes it excellent for mining resources.",true);
					break;
				case 66:
					homestar = new Star(1,0xFFFF88,"Fleming","One of the first discovered systems, this one once was the point of human interest.");
					planets[0] = new Planet(8,0.5,0xFF3300,homestar,800,0.001,0,"Ian's Hope","Once an unprofitable colony, it was almost abandoned after the discovery of Emerald Crown.",true);
					planets[1] = new Planet(7,0.3,0x006600,homestar,1200,0.0005,3,"Markab","Low gravity of the planet made it easy to mine here, but it's resources were quickly drained.",false);
					break;
				case 799:
					homestar = new Star(1.2,0x66FFCC,"Xintha","The place of first contact with another smart species.");
					planets[0] = new Planet(7,0.3,0x887766,homestar,600,0.0003,0,"Bindur","Most scientists agree that it serves like some kind of gravity anchor for The Warprail.",false);
					planets[1] = new Planet(2,0.6,0x0099FF,homestar,1300,0.0002,0.5,"Nimerus","Now an alien colony, it still has a lot of human settlements down there.",false);
					station = new Station(3,0.3,0xFFFFFF,planets[0],350,0.002,0,"The Warprail","Mysterious alien device. The war started when this machine opened path for aliens to the sector.");
					break;
				default:
					var deb = 0.8 + 0.2 * (key % 4);
					homestar = new Star(deb,0xFFFF66,"SM-"+String(key),"Unexplored star system. No detailed data available.");
					if(key%8 >= 5){
						deb = 0.05 + 0.1 * (key % 4);
						planets[0] = new Planet(7,deb,0x333300,homestar,200+key,0.001,0,"P"+String(key)+"-A","Small planet devoid of life. Pretty common, usually planets like this have nothing of value.",false);
					}
					if(key%9 == 2){
						var color;
						switch(key%4){
							case 0:
								color = 0x339966;
								break;
							case 1:
								color = 0x330066;
								break;
							case 2:
								color = 0x660000;
								break;
							default:
								color = 0x330066;
								break;
						}
						planets[1] = new Planet(4,1.2,color,homestar,800+0.5*key,0.0001,0.5,"P"+String(key)+"-B","Looks like this gas giant has pulled and destroyed most of other objects in the system.",false);
					}
					if((key > 900 || key%13 == 0) && key%9 != 2){
						planets[2] = new Planet(7,0.1,0xCC4477,homestar,800+key,0.0003,5,"P"+String(key)+"-C","Tiny planet devoid of life. It's unclear why it's color is so strange.",false);
					}
					if((key%8 < 2) && (key%50 > 45) && (key%9 != 2)){
						planets[3] = new Planet(8,0.4,0xAAAABB,homestar,1200 + 0.3*key,0.0001,2,"P"+String(key)+"-D","Lost on the outskirts of the system, the planet appears to be frozen.",false);
					}
					if(key%55 == 0){
						planets[4] = new Planet(0,0.2,0xFF0000,homestar,1200 + 0.3*key,0.0001,3.5,"P"+String(key)+"-E","This strange planet looks unfriendly, possibly has toxic atmosphere or surface.",false);
					}
					break;
			}
			addChild(homestar);
			var it:int = 5;
			while(it-- > 0){
				if(planets[it] == null){
					continue;
				}
				addChild(planets[it]);
			}
			if(station != null){
				addChild(station);
			}
		}
		
		function clearEventListeners(){
			hero.removeEventListener(MouseEvent.CLICK, onDC);
			removeEventListener(Event.ENTER_FRAME, enterFrameF);
			removeEventListener(MouseEvent.MOUSE_OVER,MouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT,MouseOut);

			
			var it:int = 5;
			while(it-- > 0){
				if(planets[it] == null){
					continue;
				}
				planets[it].removeEventListener(Event.ENTER_FRAME,enterFrameF);
			}
			
			if(station != null){
				station.removeEventListener(Event.ENTER_FRAME,enterFrameF);
			}
		}
		
		function onDC(e:MouseEvent){
			if(tooltip.visible){
				var tmp = tooltip.GetId();
				if(tmp >= 1000 && tmp <= 5999){
					// planet
					tmp -= 1000;
					tmp = tmp * 1000;
					tmp += systemId;
					dispatchEvent(new changeSceneEvent("changeScene","landed",tmp));
					trace("onDC " + tmp);
					return;
				} else if (tmp >= 6000){
					// station
					tmp += systemId;
					dispatchEvent(new changeSceneEvent("changeScene","landed",tmp));
					trace("onDC " + tmp);
					return;
				} else if(tmp < 1000){
					dispatchEvent(new changeSceneEvent("changeScene","starSystem",tmp));
					trace("onDC " + tmp);
					return;
				}
			}
		}
		
		public function makeHero(kX,kY,stts:Stats,slts:Slots,eqip:Vector.<equipItem>,raw:BitmapData){
			hero = new Starship(0, kX, kY, stts,slts,eqip,raw);
			hero.SetMovement(true);
			x = -kX + 400;
			y = -kY + 240;
			if(x > maxX){
				x = maxX;
			}
			if(x < minX){
				x = minX;
			}
			if(y > maxY){
				y = maxY;
			}
			if(y < minY){
				y = minY;
			}
			addChild(hero);
			flareEffectsToTop();
			hero.addEventListener(MouseEvent.CLICK,onDC);
		}
		
		public function ModifyTimeOffset(time:int){
			var it:int = 5;
			while(it-- > 0){
				if(planets[it] == null){
					continue;
				}
				planets[it].ModifyFI(time);
			}
			
			if(station != null){
				station.ModifyFI(time);
			}
		}
		
		function enterFrameF(e:Event){
			// if(Key.isDown(32) && hero.attackDelay <= 0){ // SPACE
		
			// }
			if(nmDscrTooltip.visible){
				nmDscrTooltip.x = mouseX + 16;
				nmDscrTooltip.y = mouseY + 16;
				if(nmDscrTooltip.x + x > 640){
					nmDscrTooltip.x = 640 - x;
				}
				if(nmDscrTooltip.y + y > 385){
					nmDscrTooltip.y = 385 - y;
				}
			}
			
			x+=int(speedX);	//scrolling
			y+=int(speedY);
			lensFlare.x = -1.1*(x - 400 - homestar.x);
			lensFlare.y = -1.1*(y - 240 - homestar.y);
			lensFlare.alpha = 1.2 - 0.002*lensFlare.distanceTo(homestar.x,homestar.y);
			flareA.x = 0.4*lensFlare.x;
			flareA.y = 0.4*lensFlare.y;
			flareA.alpha = 0.8*lensFlare.alpha;
			flareB.x = 0.8*lensFlare.x;
			flareB.y = 0.8*lensFlare.y;
			flareB.alpha = 0.5*lensFlare.alpha;
			flareC.x = 0.6*lensFlare.x;
			flareC.y = 0.6*lensFlare.y;
			flareC.alpha = 0.8*lensFlare.alpha;
			flareD.x = 1.5*lensFlare.x;
			flareD.y = 1.5*lensFlare.y;
			flareD.alpha = 0.3*lensFlare.alpha;
			speedX *= 0.9;
			speedY *= 0.9;
			if(stage.mouseX < 25) speedX += 1.5;
			if(stage.mouseY < 25) speedY += 1.5;
			if(stage.mouseX > 775) speedX -= 1.5;
			if(stage.mouseY > 455) speedY -= 1.5;
			if(x > maxX){
				x = maxX;
				speedX = 0;
			}
			if(x < minX){
				x = minX;
				speedX = 0;
			}
			if(y > maxY){
				y = maxY;
				speedY = 0;
			}
			if(y < minY){
				y = minY;
				speedY = 0;
			}
			dispatchEvent(new sceneMoveEvent("sceneMove",x,y));
				//end scrolling
			tooltip.visible = false;
			
			var iter:int = 5;
			while(iter-- > 0){
				if(planets[iter] == null){
					continue;
				}
				if(planets[iter].IsLandable() && planets[iter].distanceTo(hero.x,hero.y) < 64 && hero.GetMovement()){
					tooltip.SetText("to land");
					tooltip.SetId(1000 + iter);
					tooltip.x = hero.x;
					tooltip.y = hero.y;
					tooltip.visible = true;
				}
			}
			
			if(station != null && station.distanceTo(hero.x,hero.y) < 32 && hero.GetMovement()){
				tooltip.SetText("to dock");
				tooltip.SetId(6000);
				tooltip.x = hero.x;
				tooltip.y = hero.y;
				tooltip.visible = true;
			}
			
			var m:int;
			
			if(hero.x > 0.95 * maxX){
				m = systemId + 25;
				if(m < 1000){
					tooltip.SetText("to warp");
					tooltip.SetId(m);
					tooltip.x = hero.x;
					tooltip.y = hero.y;
					tooltip.visible = true;
				}
			}
			
			if(hero.x < 0.95 * (- maxX)){
				m = systemId - 25;
				if(m >= 0){
					tooltip.SetText("to warp");
					tooltip.SetId(m);
					tooltip.x = hero.x;
					tooltip.y = hero.y;
					tooltip.visible = true;
				}
			}
			
			if(hero.y > 0.95 * maxY){
				m = systemId + 1;
				if(m < 1000 && (m-1)%25 != 0){
					tooltip.SetText("to warp");
					tooltip.SetId(m);
					tooltip.x = hero.x;
					tooltip.y = hero.y;
					tooltip.visible = true;
				}
			}
			
			if(hero.y < 0.95 * (- maxY)){
				m = systemId - 1;
				if(m >= 0 && m%25 != 0){
					tooltip.SetText("to warp");
					tooltip.SetId(m);
					tooltip.x = hero.x;
					tooltip.y = hero.y;
					tooltip.visible = true;
				}
			}
			
		}
		
		
	}
	
}
