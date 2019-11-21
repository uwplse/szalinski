$fn=64;

h=12;

tol=0.4;

nut=[6.9+tol,6.9+tol,3+tol];
bolt=4+tol;

/// location of nut and direction of inserting
//nutZ=[0,5];
nutZ=[-5,-1+tol];

/////// profile 20x20
	prof=20;
	gap = 5.2;
	wall = 1.74;
	depth = 6.4;
	width1 = 4.6;
	width2 = 11.75;
	r1 = 1.5;
	r2 = 1;
/////// profile 20x20

not = 0.01;
inf=100;

///////////////////////////////////////


difference(){
	tr([h/2,0,wall/2],[0,-90,0]) linear_extrude(height=h){
		//profile2D();
		block();
	}
	
	r(0) union(){
		for(z=[nutZ[0]:nut.z/2:nutZ[1]]){
			t([0,0,-nut.z+z]) nutNegative(nut,bolt);
		}
		t([0,0,-nut.z+nutZ[1]]) nutNegative(nut,bolt);
	}
}

///////////////////////////////////////
module nut(size=[10,10,5],bolt=5){
	difference(){
		t([-size.x/2,-size.y/2,0]) cube(size);
		t([0,0,-size.z]) cylinder(d=bolt,h=3*size.z);
	}
}

module nutNegative(size=[10,10,5],bolt=5){
	t([-size.x/2,-size.y/2,0]) cube(size);
	t([0,0,-inf]) cylinder(d=bolt,h=2*inf);
}

module block(){
	t([-(prof/2-wall/2),0,0]){	
		hull(){
			for(y=[-1,1]) t([prof/2-wall-r2-tol,y*(width2/2-r2-tol)]) circle(r=r2);
			for(y=[-1,1]) t([prof/2-depth+r2+tol,y*(width1/2-tol)]) circle(r=r2);
		}
				
		t([prof/2-wall,0]) square([wall,gap-tol],center=true);
	}
}

module bolt(bolt=3, boltHead=6, boltPad=3, boltHeadL=10, boltL=30, nut=6.3, nutPad=5, nutL=4, nutR=0, sideCutL=20, sideCutSlot=4, layer1=0.2, layer2=0.2, tol=0.2, not=0.01){
	
	bottom=layer1>0?true:false;
	top=layer2>0?true:false;
	
	t([0,0,-boltL+not+boltPad]) cylinder(d=bolt+tol,h=boltL);

	t([0,0,boltPad-2*layer1]) difference(){
		cylinder(d=boltHead+tol,h=boltHeadL+2*layer1);
		
		//easy print bolt
		if(layer1>0){
			t([(bolt+tol)/2,-(boltHead+tol)/2,-not]) cube([(boltHead-bolt)/2,boltHead+tol,2*layer1+not]);
			t([-(boltHead+tol)/2,-(boltHead+tol)/2,-not]) cube([(boltHead-bolt)/2,boltHead+tol,2*layer1+not]);
			t([-(boltHead+tol)/2,-(boltHead+tol)/2,-not]) cube([boltHead+tol,(boltHead-bolt)/2,layer1+not]);
			t([-(boltHead+tol)/2,(bolt+tol)/2,-not]) cube([boltHead+tol,(boltHead-bolt)/2,layer1+not]);
		}
	}
	
	//nut
	if(nut>0 && nutL>0){
		rotate([0,0,nutR]) difference(){
			t([0,0,-nutPad-nutL-sideCutSlot-2*layer1]){
				cylinder(d=nut+tol,h=nutL+sideCutSlot+2*layer1+2*layer2,$fn=6);
				hull(){
					for(x=[0,sideCutL]) t([x,0,0]) cylinder(d=nut+tol,h=nutL+2*layer1,$fn=6);
				}
			}
		
		//easy print nut slot
		if(layer1>0){
				t([(bolt+tol)/2,-nut/2,-nutPad-nutL-sideCutSlot-2*layer1-not]) cube([sideCutL+nut+tol,nut,2*layer1+not]);
				t([-(bolt+tol)/2-nut,-nut/2,-nutPad-nutL-sideCutSlot-2*layer1-not]) cube([nut,nut,2*layer1+not]);
				t([-nut/2,-(bolt+tol)/2-nut,-nutPad-nutL-sideCutSlot-2*layer1-not]) cube([nut,nut,layer1+not]);
				t([-nut/2,+(bolt+tol)/2,-nutPad-nutL-sideCutSlot-2*layer1-not]) cube([nut,nut,layer1+not]);
			}				
		
		//easy print nut
		if(layer2>0){
				t([(bolt+tol)/2,-nut/2,-nutPad]) cube([nut,nut,2*layer2+not]);
				t([-(bolt+tol)/2-nut,-nut/2,-nutPad]) cube([nut,nut,2*layer2+not]);
				t([-nut/2,-(bolt+tol)/2-nut,-nutPad+layer2]) cube([nut,nut,layer2+not]);
				t([-nut/2,+(bolt+tol)/2,-nutPad+layer2]) cube([nut,nut,layer2+not]);
			}
		}
	}
}


///////////////////////////////////////

module t(v=[0,0,0]){translate(v) children();}
module r(a=[0,0,0],rp=[0,0,0]){translate(rp) rotate(a) translate(-rp) children();}
module tr(v=[0,0,0],a=[0,0,0],rp=[0,0,0]){t(v) r(a,rp) children();}
module rt(a=[0,0,0],rp=[0,0,0],v=[0,0,0]){r(a,rp) t(v) children();}
module u(){union() children();}
