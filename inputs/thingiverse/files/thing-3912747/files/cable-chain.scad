$fn=64;

// Width in mm
LinkWidth = 30 ; 
// Heigth in mm
LinkHeight = 20 ; 
// Vertical Separator count
SeparatorCount= 0 ; //[0:10]
SnapHinge1= 2 ; //[1:Hinge/Snapper,2:Snapper/Snapper]

/* [Advanced] */
// in mm 0=Auto
Wall = 0 ; 
AdditionalBottomStrength = 0 ;
// in mm
LinkClearance= 0.3 ;
// in mm 0=Auto
SnapperWidth= 0 ;
// in mm
SnapperClearance= 0.2 ;
// Edge or Pin(for limiting the angle)
EdgePin= 2 ; //[0:Edge,1:Pin,2:edge and pin ]
// Degree of freedom between two links
DegreeFreedom= 45 ;
PinOffset= 0 ;

bolt=3+.3;
maxPrintAngle=60;

not=0.001;
/////////////////////////////////////////////////////


carrier(LinkWidth,LinkHeight,Wall,LinkClearance,SnapperWidth,SnapHinge1,SnapperClearance,SeparatorCount,EdgePin,AdditionalBottomStrength,DegreeFreedom,PinOffset,0,0);

t([0,1.5*LinkWidth,0]) carrier(LinkWidth,LinkHeight,Wall,LinkClearance,SnapperWidth,SnapHinge1,SnapperClearance,SeparatorCount,EdgePin,AdditionalBottomStrength,DegreeFreedom,PinOffset,1,0);

t([0,3*LinkWidth,0]) carrier(LinkWidth,LinkHeight,Wall,LinkClearance,SnapperWidth,SnapHinge1,SnapperClearance,SeparatorCount,EdgePin,AdditionalBottomStrength,DegreeFreedom,PinOffset,0,1);

rt([0,180,0],v=[-LinkWidth+15,-10,-Wall]) 
snapper(LinkWidth,LinkHeight,Wall,LinkClearance,SnapperWidth,SnapHinge1,SnapperClearance,SeparatorCount,EdgePin,AdditionalBottomStrength,DegreeFreedom,PinOffset);

/////////////////////////////////////////////////////


module carrier(linkWidth,linkHeight,wall,linkClearance,snapperWidth,snapHinge1,snapperClearance,separatorCount,edgePin,additionalBottomStrength,degreeFreedom,pinOffset,first,last){


	snapperWidth=snapperWidth ? snapperWidth : linkHeight/2;
	bottomWidth=snapperWidth; //if snapperwidth < max width
	linkLength=snapperWidth+linkHeight*2;
	volume=linkLength*linkWidth*linkHeight;
	wall= wall ? wall : 1+pow(volume,1/3)/30;
	echo ("material: ",wall);

	degree=degreeFreedom+wall/((PI*(linkHeight-(wall+linkClearance)))/360); //+((PI*linkHeight)/360)*wall);
	echo( volume, pow(volume,1/3),1+pow(volume,1/3)/30);
	echo(degree);

	module snapperNegative(){
		//Schließer oben DREHPUNKT
		t([wall, -not, linkHeight-wall]) cube([snapperWidth-wall*2, linkWidth+2*not, wall+not]);
		
		//Scharnier 
		if(snapHinge1==1){ //
			t([wall, linkWidth-wall*2-not, linkHeight-wall*2]) cube([snapperWidth-wall*2,wall*2+2*not, wall+not]);
			t([0, linkWidth-wall, linkHeight-wall-wall/4]) cube([snapperWidth,wall+not, wall/2]);
			
			for(x=[0,snapperWidth-wall])	tr([x-not, linkWidth-wall, linkHeight-wall],[0, 90, 0]) cylinder(h=wall+0.5, r=wall/2+0.2);
		}
			
		//schnapper 1
		if(snapHinge1==3){ //
			t([wall/2, 0, linkHeight-wall*3]) cube([snapperWidth-wall, wall, wall*2]);
			t([snapperWidth/3, 0, linkHeight-wall*3.5]) cube([snapperWidth/3, wall, wall/2]);
		}
			
		//schnapper 2
		if(snapHinge1==1||snapHinge1==2){ //
			t([wall/2, -not, linkHeight-wall*3]) cube([snapperWidth-wall, wall+not, wall*3+not]);
			t([wall/2, wall-not, linkHeight-wall*3]) cube([snapperWidth-wall, wall/2+not, wall]);
			t([snapperWidth/3, -not, linkHeight-wall*3.5]) cube([snapperWidth/3, wall*1.5+not, wall/2+not]);
		}
		
		if(snapHinge1==2){ //
			t([wall/2, linkWidth-wall+not, linkHeight-wall*3]) cube([snapperWidth-wall, wall+not, wall*3+not]);
			t([wall/2, linkWidth-wall*1.5+not, linkHeight-wall*3]) cube([snapperWidth-wall, wall/2+not, wall]);	
			t([snapperWidth/3, linkWidth-wall*1.5+not, linkHeight-wall*3.5]) cube([snapperWidth/3, wall*1.5+not, wall/2+not]);
		}
	}
	
	module deck(long=false){
		// Grundplatte
		if(long){
			t([-linkHeight/2, wall, 0]) cube([linkHeight+snapperWidth, linkWidth-wall*2, wall+additionalBottomStrength]);
		} else {
			t([0, wall+linkClearance/2, 0]) cube([bottomWidth+linkHeight/2, linkWidth-wall*2-linkClearance, wall+additionalBottomStrength]);
		}
		// Trennstege
		if(separatorCount>=1){
			for(i=[wall+(linkWidth-4*wall)/(separatorCount+1)+wall/(separatorCount+1):(linkWidth-4*wall)/(separatorCount+1)+wall/(separatorCount+1):linkWidth-3*wall]){
				echo(i);
				difference() {
					t([0, i, 0]) cube([snapperWidth, wall, linkHeight]);
					t([wall, 0, linkHeight-wall]) cube([snapperWidth-wall*2, linkWidth, wall+1]);
				}
			}
		}
	}
	
	module innen(cuts=true){
		b=cuts?1:0;
		
		difference(){
			for(y=[wall,linkWidth-wall*2]) t([0, y, 0]) cube([b*linkHeight/2+snapperWidth, wall, linkHeight]);
			
			if(cuts) for(y=[wall+linkClearance/2,linkWidth]) {
				tr([snapperWidth+linkHeight/2, y, linkHeight/2],[90, 0, 0]) cylinder(h=wall+linkClearance/2, r=linkHeight/2+linkClearance/2);
				tr([snapperWidth+linkHeight/2, y, linkHeight/2],[0,-degreeFreedom,180])cube([linkHeight/2, wall+linkClearance/2, linkHeight]);
				tr([snapperWidth+linkHeight/2, y, linkHeight/2],[0,160,180])cube([linkHeight/2, wall+linkClearance/2, linkHeight]);
			}
		}
	}
	
	module aussen(holes=true,cuts=true){
		difference(){
			for(y=[0,linkWidth-wall]) t([-linkHeight/2, y, 0]) cube([linkHeight+snapperWidth, wall, linkHeight]);
			
			if(holes) tr([-linkHeight/2, -not, linkHeight/2],[-90, 0, 0]) cylinder(h=2*linkWidth+4*wall, r=linkHeight/4+linkClearance);
			
			if(cuts){
				tr([snapperWidth+linkHeight/2, linkWidth+0.5, linkHeight/2],[90, 0, 0]) cylinder(h=linkWidth+1, r=linkHeight/2+linkClearance/2);

				for(y=[wall+linkClearance/2,linkWidth]){
					tr([snapperWidth+linkHeight/2, y, linkHeight/2],[0,-degreeFreedom,180])cube([linkHeight/2, wall+linkClearance/2, linkHeight]);
					tr([snapperWidth+linkHeight/2, y, linkHeight/2],[0,160,180]) cube([linkHeight/2, wall+linkClearance/2, linkHeight]);
				}
			}
		}
	}
	
	module schnapperVorne(){
		difference(){
			for(y=[wall,linkWidth]) tr([-linkHeight/2, y, linkHeight/2],[90, 0, 0]) cylinder(h=wall, r=linkHeight/2);		
			for(y=[wall+1,linkWidth+1]) tr([-linkHeight/2, y, linkHeight/2],[90, 0, 0]) cylinder(h=100, r=linkHeight/4+linkClearance);
			for(b=[0,1]) tr([-linkHeight, b*linkWidth+wall/4-b*wall/2, linkHeight/4,],[0, 0, 20+b*230]) cube([linkHeight/2,linkHeight/2,linkHeight]);
		}
	}

	module schnapperHinten(){
		difference(){
			for(y=[wall*2,linkWidth-wall-snapperClearance/2]) tr([snapperWidth+linkHeight/2, y, linkHeight/2],[90,0,0]) cylinder(h=wall-snapperClearance/2, r=linkHeight/2);

			for(y=[wall+linkClearance/2,linkWidth]) tr([snapperWidth+linkHeight/2, y, linkHeight/2],[90,0,0]) cylinder(h=wall+linkClearance/2, r=linkHeight/2+linkClearance/2);
		}
	}
	
	module cylinders(){
		for(b=[0,1]) tr([snapperWidth+linkHeight/2, (1-b)*wall+linkClearance/2 + b*(linkWidth-wall-linkClearance-not), linkHeight/2],[90, b*180, b*180]) difference(){
			cylinder(h=wall+linkClearance/2, r=linkHeight/4);

			//for easier printing
			r([0,0,b*180]) tr([-linkHeight/4,-linkHeight/4,0],[maxPrintAngle,0,0]) cube([linkHeight/2,linkHeight/2,wall]);
			
			//enhancement for clipping together
			tr([-(wall)+linkHeight/4,-linkHeight/4,wall*1.8],[0,45,0])cube([linkHeight/2,linkHeight/2,wall]);
		}
	}

	module cutOutForPin(){
		for(y=[wall*2,linkWidth-wall]) tr([snapperWidth+linkHeight/2, y, linkHeight/2],[90, 0, 0]) intersection(){
			t([0,0,-not]) difference(){
				u(){
					cylinder(h=wall+1, r=linkHeight/2+not);
					t([-linkHeight/2,0,0]) cube([linkHeight/2,linkHeight/2,wall+1]);
				}
				cylinder(h=wall+1, d=linkHeight-(wall+linkClearance/2)*2);
			}
			
			t([0,0,-not]) difference(){
				u(){
					cube([linkHeight,linkHeight,wall+1]);
					t([-wall-1,0,0]) cube([wall+1,linkHeight,wall+1]);
				}
				tr([0,0,0],[0,0,degree]) cube([linkHeight,linkHeight,wall+1]);
			}
		}
	}
	
	module pin(){
		for(y=[linkWidth-wall*2,wall]) t([-wall+linkClearance/2, y, linkHeight/2+linkClearance/2+pinOffset]) cube([wall-linkClearance/2, wall, wall-linkClearance]);
	}
	
	module drehschutzEcken(){
		if(edgePin==0 || edgePin==2){
			t([snapperWidth+linkHeight/2, linkWidth-wall*2, 0]) cube([linkHeight/2, wall-linkClearance/2, linkHeight/2]);
			t([snapperWidth+linkHeight/2, wall+linkClearance/2, 0]) cube([linkHeight/2, wall-linkClearance/2, linkHeight/2]);
		}
	}
	
	////////////////////////////////////////////////
	
	difference(){
		u(){
			deck(first);
			innen(!last);
			aussen(!first,!last);
			if(!first) schnapperVorne();
			if(!last){
				schnapperHinten();	
				cylinders();
				drehschutzEcken();
			}
			if (edgePin==1 || edgePin==2) if(!first) pin();
		}
		if(edgePin==1 || edgePin==2) cutOutForPin();
		snapperNegative();
		if(first){
			t([-linkHeight/4,linkWidth/2,-wall]) cylinder(d=bolt,h=3*wall);
			for(y=[2*wall,linkWidth+wall]) t([-linkHeight/4,y,linkHeight/2]) r([90,0,0]) cylinder(d=bolt,h=3*wall);
		}
		if(last){
			t([snapperWidth+linkHeight/4,linkWidth/2,-wall]) cylinder(d=bolt,h=3*wall);
			for(y=[3*wall,linkWidth+wall]) t([snapperWidth+linkHeight/4,y,linkHeight/2]) r([90,0,0]) cylinder(d=bolt,h=4*wall);
		}
	}
}


module snapper(linkWidth,linkHeight,wall,linkClearance,snapperWidth,snapHinge1,snapperClearance,separatorCount,edgePin,additionalBottomStrength,degreeFreedom,pinOffset){

	snapperWidth=snapperWidth ? snapperWidth : linkHeight/2;
	linkLength=snapperWidth+linkHeight*2;
	volume=linkLength*linkWidth*linkHeight;
	wall= wall ? wall : 1+pow(volume,1/3)/30;
	echo ("material: ",wall);

	degree=degreeFreedom+wall/((PI*(linkHeight-(wall+linkClearance)))/360); //+((PI*linkHeight)/360)*wall);
	echo( volume, pow(volume,1/3),1+pow(volume,1/3)/30);
	echo(degree);

	//Schließer oben
	{
		difference() { //untere Platte vom Schließer Schleppkette
			u(){
				r([0, 0, -90]) cube([snapperWidth, linkWidth, wall]);
				//hinge
				if(snapHinge1==1) tr([wall, 0, 0],[90, 0, 0]) cylinder(h=snapperWidth, r=wall);
				if(snapHinge1==1||snapHinge1==2){
					tr([linkWidth,-wall/2-snapperClearance/2, -wall*2],[90, 0, -90]) cube([snapperWidth-wall-snapperClearance,wall*3, wall]);

					tr([linkWidth-wall,-wall/2-snapperClearance/2, -wall*1.5-snapperClearance],[0, 90, -90]) cylinder(h=snapperWidth-wall-snapperClearance, r=wall/2-snapperClearance);
				}

				if(snapHinge1==2){
					tr([wall,-wall/2-snapperClearance/2, -wall*2],[90, 0, -90]) cube([snapperWidth-wall-snapperClearance,wall*3, wall]);
					
					tr([wall,-wall/2-snapperClearance/2, -wall*1.5-snapperClearance],[0, 90, -90]) cylinder(h=snapperWidth-wall-snapperClearance, r=wall/2-snapperClearance);
	 
				}
			}
			
			if(snapHinge1==1){//hinge
				tr([wall*2+snapperClearance*3, -snapperWidth-0.1, -wall],[0, 0, 90]) cube([wall+0.1, wall*2.5, wall*3]); // seite wo stab
				
				tr([wall*2+snapperClearance*3, -wall-0.1, -wall],[0, 0, 90]) cube([wall+0.1+not, wall*2.5, wall*3]); // seite wo stab
			}
			
			if(snapHinge1==1||snapHinge1==2){
				for(y=[-snapperWidth-not,-wall-snapperClearance/2]) t([linkWidth-wall*2-snapperClearance/2, y, -wall]) cube([wall+snapperClearance, wall+snapperClearance/2+not, 3*wall]);
				
				for(y=[-snapperWidth-not,-wall/2-snapperClearance/2]) t([linkWidth-wall, y, -wall]) cube([wall+snapperClearance/2, wall/2+snapperClearance/2+not, 3*wall]);			
			}
			
			if(snapHinge1==2){
				for(y=[-snapperWidth-not,-wall-snapperClearance/2]) t([wall-snapperClearance/2, y, -wall]) cube([wall+snapperClearance, wall+snapperClearance/2+not, 3*wall]);
				
				for(y=[-snapperWidth-not,-wall/2-snapperClearance/2]) t([-not, y, -wall]) cube([wall+snapperClearance/2, wall/2+snapperClearance/2+not, 3*wall]); // 
			}

			//Seperator
			if(separatorCount>=1){
				for(i=[wall+(linkWidth-4*wall)/(separatorCount+1)+wall/(separatorCount+1):(linkWidth-4*wall)/(separatorCount+1)+wall/(separatorCount+1):linkWidth-3*wall]){
					
					echo(i);
					t([i-snapperClearance/2, -wall-snapperClearance/2, 0]) cube([wall+snapperClearance, wall+snapperClearance/2, wall]);
					t([i-snapperClearance/2, -snapperWidth, 0]) cube([wall+snapperClearance, wall+snapperClearance/2, wall]);
				}
			}
		}

		//Stab des Schließers
		if(snapHinge1==1){ //hinge
			difference() {
				tr([wall,0,0],[90, 0, 0]) cylinder(h=snapperWidth, r=wall/2-0.1);
				
				for(x=[-wall/4,wall/2])	tr([wall+x,-snapperWidth-not, -wall/2],[0, 0, 90]) cube([snapperWidth+2*not, wall/4, wall]); // seite wo stab / Abtrennung zum einschieben
			}
		}
	}
}

/////////////////////////////////////////////////////

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
