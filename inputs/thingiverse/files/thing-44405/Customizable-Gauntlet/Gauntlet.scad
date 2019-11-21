//Layout Assembed or For Print?
LayoutMode="Assembled"; //[Assembled,Print]
//How thick is your fattest finger?
FingerThick=22; //[15:30]
//How long is your longest finger from tip to knuckle?
FingerHeight=100; //[50:140]
//How wide is your hand at the Knuckles?
FingerWidth=85; //[50:100]
//How long is the back of your hand from your Knuckle to your Wrist?
PalmLength=80; //[50:140]
//How thick is your hand measured below your pinky?
HandThick=30; //[15:45]
//What wall thickness do you want?
WT=2; //[1:5]
//Right hand or Left hand?
Hand="Right"; //[Right,Left]
//How big do you want the Rivets to look
RivetSize=4; //[1:8]
//Make a fist (Not for STL export)?
FCA=0; //[0,20,40]
//FCA=$t*40; //Animated Finger Curl Angle
//Circle Resolution
CR=25; //[10:40]

module FingerLug(FT,FH,FW){
	difference(){
		union(){
			//Rounded Corners
			cylinder(h=FH/4+FT/2,r=FT/2+WT,$fn=CR);
			translate(v=[0,FW-FT,0]){cylinder(h=FH/4+FT/2,r=FT/2+WT,$fn=CR);}
			//Straight Edges
			translate(v=[-FT/2-WT,0,0]){cube([FT+WT*2,FW-FT,FH/4+FT/2]);}
			translate(v=[0,-FT/2-WT,0]){cube([FT/2+WT,FT/2+WT,FH/4+FT/2]);}
			translate(v=[0,FW-FT,0]){cube([FT/2+WT,FT/2+WT,FH/4+FT/2]);}
			//Locking Nubs
			translate(v=[FT/4+WT/2,-FT/2-WT,FT/4]){sphere(r=WT,$fn=CR);}
			translate(v=[FT/4+WT/2,-FT/2-WT,FH/4+FT/2-FT/4]){sphere(r=RivetSize,$fn=CR);}
			translate(v=[FT/4+WT/2,FW-FT/2+WT,FT/4]){sphere(r=WT,$fn=CR);}
			translate(v=[FT/4+WT/2,FW-FT/2+WT,FH/4+FT/2-FT/4]){sphere(r=RivetSize,$fn=CR);}
			//Guard
			translate(v=[-FT/2-WT*1.5,FT/2,FH/4]){rotate(a=[45,0,0]){cube([WT,FT/2,FT/2],center=true);}}
			translate(v=[-FT/2-WT*1.5,FW-FT*1.5,FH/4]){rotate(a=[45,0,0]){cube([WT,FT/2,FT/2],center=true);}}
			translate(v=[-FT/2-WT*2,0,FH/4-FT/2]){cube([WT,FW-FT,FT/2]);}
			translate(v=[-FT/2-WT*1.5,(FW-FT)/2,FH/4+FT/6]){cube([WT,(FW-FT*2),FT/3],center=true);}
			translate(v=[-FT/2-WT,(FW-FT)/2,FH/4-FT/2]){rotate(a=[0,45,0]){cube([WT*1.5,FW-FT,WT*1.5],center=true);}}
		}
		union(){
			//Rounded Cornders
			translate(v=[0,0,-0.5]){cylinder(h=FH/4+FT/2+1,r=FT/2,$fn=CR);}
			translate(v=[0,FW-FT,-0.5]){cylinder(h=FH/4+FT/2+1,r=FT/2,$fn=CR);}
			//Straigt Edges
			translate(v=[-FT/2,0,-0.5]){cube([FT+WT+1,FW-FT,FH/4+FT/2+1]);}
			translate(v=[0,-FT/2,-0.5]){cube([FT/2+WT+1,FT/2+1,FH/4+FT/2+1]);}
			translate(v=[0,FW-FT-1,-0.5]){cube([FT/2+WT+1,FT/2+1,FH/4+FT/2+1]);}
			//Guard
			translate(v=[-FingerThick/2-WT*1.1,-FingerThick/2-WT,FingerHeight/4]){cube([FingerThick/2+WT*1.1,FingerWidth+WT*2,FingerThick/2+0.5]);}
			/*Guard
			translate(v=[-FT/2-WT,-FT/2-WT,FH/4]){cube([FT/2+WT,FT/2+WT,FH/4+FT/2]);}
			translate(v=[-FT/2-WT,FW-FT,FH/4]){cube([FT/2+WT,FT/2+WT,FH/4+FT/2]);}
			translate(v=[-FT/2-WT/2,0,FH/4+FT/2]){rotate(a=[45,0,0]){cube(size=[WT*2,FT/1.5,FT/1.5],center=true);}}
			translate(v=[-FT/2-WT/2,FW-FT,FH/4+FT/2]){rotate(a=[45,0,0]){cube(size=[WT*2,FT/1.5,FT/1.5],center=true);}}
			*/
			//Locking Nubs
			translate(v=[FT/4+WT/2,-FT/2,FH/4+FT/2-FT/4]){sphere(r=WT,$fn=CR);}
			translate(v=[FT/4+WT/2,FW-FT/2,FH/4+FT/2-FT/4]){sphere(r=WT,$fn=CR);}
		}
	}
}
module FingerTip(FT,FH,FW){
	difference(){
		union(){
			//Finger Tip
			translate(v=[0,0,0]){cylinder(r=FT/2+WT,h=FH/4-FT/2,$fn=CR);}
			translate(v=[0,FW-FT,0]){cylinder(r=FT/2+WT,h=FH/4-FT/2,$fn=CR);}
			translate(v=[0,0,FH/4-FT/2]){rotate(a=[-90,0,0]){cylinder(r=FT/2+WT,h=FW-FT,$fn=CR);}}
			translate(v=[0,0,FH/4-FT/2]){sphere(r=FT/2+WT,$fn=CR);}
			translate(v=[0,FW-FT,FH/4-FT/2]){sphere(r=FT/2+WT,$fn=CR);}
			translate(v=[-(FT+WT*2)/2,0,0]){cube([FT+WT*2,FW-FT,FH/4-FT/2]);}
			//Snap lock block
			translate(v=[0,-FT/2-WT,0]){cube([FT/2+WT,FT/2+WT,FT/2]);}
			translate(v=[0,FW-FT,0]){cube([FT/2+WT,FT/2+WT,FT/2]);}
			//Snap lock pin
			translate(v=[FT/4+WT/2,-FT/2-WT,FT/4]){sphere(r=WT,$fn=CR);}
			translate(v=[FT/4+WT/2,FW-FT/2+WT,FT/4]){sphere(r=WT,$fn=CR);}
		}
		union(){
			translate(v=[0,0,-0.5]){cylinder(r=FT/2,h=FH/4-FT/2+0.5,$fn=CR);}
			translate(v=[0,FW-FT,-0.5]){cylinder(r=FT/2,h=FH/4-FT/2+0.5,$fn=CR);}
			translate(v=[0,0,FH/4-FT/2]){rotate(a=[-90,0,0]){cylinder(r=FT/2,h=FW-FT,$fn=CR);}}
			translate(v=[0,0,FH/4-FT/2]){sphere(r=FT/2,$fn=CR);}
			translate(v=[0,FW-FT,FH/4-FT/2]){sphere(r=FT/2,$fn=CR);}
			translate(v=[-FT/2,0,-0.5]){cube([FT,FW-FT,FH/4-FT/2+.5]);}
		}
	}
}
module BackHand(FT,FH,FW,HT,PL){
	difference(){
		union(){
			//Palm Clip
			translate(v=[0,-FT/2-WT*2,-FT/2]){cube([FT/2+WT,WT*2,FT]);}
			translate(v=[0,FW-FT/2,-FT/2]){cube([FT/2+WT,WT*2,FT]);}
			//translate(v=[FT/4+WT/2,-FT/2-WT,-FT/2]){rotate(a=[45,0,0]){cube([FT/2+WT,WT*1.5,WT*1.5],center=true);}}
			//translate(v=[FT/4+WT/2,FW-FT/2+WT,-FT/2]){rotate(a=[45,0,0]){cube([FT/2+WT,WT*1.5,WT*1.5],center=true);}}
			//Palm Rivet
			translate(v=[FT/4+WT/2,-FT/2-WT*2,FT/4]){sphere(r=RivetSize,$fn=CR);}
			translate(v=[FT/4+WT/2,FW-FT/2+WT*2,FT/4]){sphere(r=RivetSize,$fn=CR);}
			// Back of Hand Guard
			translate(v=[HT/2-FT/2,HT/2-FT/2,-PL]){cylinder(h=PL,r=HT/2+WT,$fn=CR);}
			translate(v=[HT/2-FT/2,FW-HT+WT*2,-PL]){cylinder(h=PL,r=HT/2+WT,$fn=CR);}
			translate(v=[-HT/2+WT,(HT-FT)/2,-PL]){cube([HT+WT*2,FW-HT+WT/2,PL]);}
			// Guard
			translate(v=[-FT/2-WT*1.5,FT/2,0]){rotate(a=[45,0,0]){cube([WT,FT/2,FT/2],center=true);}}
			translate(v=[-FT/2-WT*1.5,FW-FT*1.5,0]){rotate(a=[45,0,0]){cube([WT,FT/2,FT/2],center=true);}}
			translate(v=[-FT/2-WT*2,0,-FT/2]){cube([WT,FW-FT,FT/2]);}
			translate(v=[-FT/2-WT*1.5,(FW-FT)/2,FT/6]){cube([WT,(FW-FT*2),FT/3],center=true);}
			translate(v=[-FT/2-WT,(FW-FT)/2,-FT/2]){rotate(a=[0,45,0]){cube([WT*1.5,FW-FT,WT*1.5],center=true);}}
		}
		union(){
			// Wrist Nub
			translate(v=[FT/4+WT/2,-FT/2-WT,FT/4]){sphere(r=WT,$fn=CR);}
			translate(v=[FT/4+WT/2,FW-FT/2+WT,FT/4]){sphere(r=WT,$fn=CR);}
			translate(v=[-.25,-FT/2-WT,0]){cube([FT/2+WT+.5,WT+.5,FT/2+.5]);}
			translate(v=[-.25,FW-FT/2-.5,0]){cube([FT/2+WT+.5,WT+.5,FT/2+.5]);}
			// Back of Hand Guard
			translate(v=[HT/2-FT/2,HT/2-FT/2,-PL-.5]){cylinder(h=PL+1,r=HT/2,$fn=CR);}
			translate(v=[HT/2-FT/2,FW-HT+WT*2,-PL-.5]){cylinder(h=PL+1,r=HT/2,$fn=CR);}
			translate(v=[-HT/2+WT*2,(HT-FT)/2,-PL-.5]){cube([HT,FW-HT,PL+1]);}
			// Cut out Thumb
			//if(Hand=="Right"){
				translate(v=[-HT/2,-FT/2-WT*2,-FT/4]){rotate(a=[-135,0,0]){cube([HT/2+WT*2,HT,HT]);}}
				translate(v=[WT*1.5,-FT/2-WT*2,-FT/4]){rotate(a=[-135,0,0]){cube([HT/2+WT*2,HT*4,HT*4]);}}
				translate(v=[-FT/2-WT*1.5,HT*.7071-HT/2-HT*.75,-HT*.7071-FT/4-PL]){cube([HT/2+WT*2,HT*.75,PL]);}
			/*}else{
				translate(v=[-HT/2,FW-FT/2+WT*2,-FT/4]){rotate(a=[-135,0,0]){cube([HT/2+WT*2,HT,HT]);}}
				translate(v=[WT*1.5,FW-FT/2+WT*2,-FT/4]){rotate(a=[-135,0,0]){cube([HT/2+WT*2,HT*4,HT*4]);}}
				translate(v=[-FT/2-WT*1.5,FW-FT/2+WT*2-(HT)*.7071,-HT*.7071-FT/4-PL]){cube([HT/2+WT*2,HT*.75,PL]);}
			}*/
		}
	}
	// Thumb Guard
	translate(v=[-FT/2-WT,-FT/2-WT,-PL]){ThumbGuard(HT,PL);}
	/*if(Hand=="Right"){
		translate(v=[-FT/2-WT,-FT/2-WT,-PL]){ThumbGuard(HT,PL);}
	}else{
		translate(v=[-FT/2-WT,FW+WT+FT/2,-PL]){mirror([0,1,0]){ThumbGuard(HT,PL);}}
	}*/
}
module ThumbGuard(HT,PL){
	union(){
		difference(){
			union(){
				translate(v=[0,0,0]){cube([WT,HT,PL/2]);}
				translate(v=[0,HT,PL/2]){rotate(a=[135,0,0]){cube([WT,HT*1.75,HT*1.75]);}}
			}
			union(){
				translate(v=[-WT/2,-HT*1.75,0]){cube([WT*2,HT*1.75,PL]);}
			}
		}
		difference(){
			translate(v=[0,0,0]){rotate(a=[45,0,45]){cube([WT,((HT+PL/2)/2)*1.4142,((HT+PL/2)/2)*1.4142]);}}
			translate(v=[-HT,0,0]){cube([HT,HT,PL]);}
		}
	}
}


if(LayoutMode=="Assembled"){
	if(FCA==0){
		//Show 3 Joints and Tip straight
		color("red") FingerLug(FingerThick,FingerHeight,FingerWidth);
		translate(v=[0,WT,FingerHeight/4]){color("green") FingerLug(FingerThick,FingerHeight,FingerWidth-WT*2);}
		translate(v=[0,WT*2,FingerHeight/2]){color("blue") FingerLug(FingerThick,FingerHeight,FingerWidth-WT*4);}
		translate(v=[0,WT*3,FingerHeight-FingerHeight/4]){color("pink") FingerTip(FingerThick,FingerHeight,FingerWidth-WT*6);}
	} else{
		//Show 3 Joints and Tip partially closed
		translate(v=[FingerThick/4+WT/2,0,FingerThick/4]){
			rotate(a=[0,FCA,0]){translate(v=[-FingerThick/4-WT/2,0,-FingerThick/4]){
				color("red") FingerLug(FingerThick,FingerHeight,FingerWidth);}
			translate(v=[0,WT,FingerHeight/4]){
				rotate(a=[0,FCA,0]){translate(v=[-FingerThick/4-WT/2,0,-FingerThick/4]){
					color("green") FingerLug(FingerThick,FingerHeight,FingerWidth-WT*2);}
				translate(v=[0,WT,FingerHeight/4]){
					rotate(a=[0,FCA,0]){translate(v=[-FingerThick/4-WT/2,0,-FingerThick/4]){
						color("blue") FingerLug(FingerThick,FingerHeight,FingerWidth-WT*4);}
					translate(v=[0,WT,FingerHeight/4]){
						rotate(a=[0,FCA,0]){translate(v=[-FingerThick/4-WT/2,0,-FingerThick/4]){
							color("pink") FingerTip(FingerThick,FingerHeight,FingerWidth-WT*6);}}}}}}}}}
		}

	if(Hand=="Right"){
		BackHand(FingerThick,FingerHeight,FingerWidth,HandThick,PalmLength);
	}else{
		translate(v=[0,FingerWidth-FingerThick,0]){mirror([0,1,0]){BackHand(FingerThick,FingerHeight,FingerWidth,HandThick,PalmLength);}}
	}
}else{
	color("red") FingerLug(FingerThick,FingerHeight,FingerWidth);
	translate(v=[FingerThick+WT*4,WT,0]){color("green") FingerLug(FingerThick,FingerHeight,FingerWidth-WT*2);}
	translate(v=[(FingerThick+WT*4)*2,WT*2,0]){color("blue") FingerLug(FingerThick,FingerHeight,FingerWidth-WT*4);}
	translate(v=[(FingerThick+WT*4)*3,WT*3,0]){color("pink") FingerTip(FingerThick,FingerHeight,FingerWidth-WT*6);}
	if(Hand=="Right"){
		translate(v=[0,-HandThick-WT*4-RivetSize,PalmLength]){rotate(a=[0,0,-90]){BackHand(FingerThick,FingerHeight,FingerWidth,HandThick,PalmLength);}}
	}else{
		translate(v=[0,-HandThick-WT*4-RivetSize,PalmLength]){rotate(a=[0,0,90]){mirror([0,1,0]){BackHand(FingerThick,FingerHeight,FingerWidth,HandThick,PalmLength);}}}
	}
}