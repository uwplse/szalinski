//how wide you want window to be open i.e the width of your bit of wood
windowOpeningDistance=80; 
//at what depth can we start transitioning into pipe connection
openingDepth=50; //min/max: [10:100]
//thickness of walls
t=1;	
//umm the diameter of your pipe...
pipeDiameter=100;
//offest of pipe opening based on window opening
pipeOffset=15;	//min/max: [0:100]
//how long to take to change from pipe to window slot shape
taperLength=50;	//min/max: [10:100]	
//length that pipe attches to
pipeConnectLength=20;	
//set this to be a bit bigger than the diameter of the head of your screws
lip=5;
//diameter of holes for screws
screwHoleDia=2;

z=openingDepth; 
x=windowOpeningDistance-(2*lip);
y=(PI/4)*((pow(pipeDiameter,2)/x)-x); //height it must be based on x to = surface area of pipe opening i.e no air flow restriction

union(){
translate([0,-y/2,-z/2])
difference(){
	hull(){
		cylinder(r=x/2, h=z, center=true);
		translate([0,y,0]) cylinder(r=x/2, h=z, center=true);
	}
	
	hull(){
		cylinder(r=x/2-t, h=z+t, center=true);
		translate([0,y,0]) cylinder(r=x/2-t, h=z, center=true);
	}
}

translate([0,0,t/2])
difference(){
	hull(){
		translate([0,-y/2,0])
		hull(){
			cylinder(r=x/2, h=t, center=true);
			translate([0,y,0]) cylinder(r=x/2, h=t, center=true);
		}
		translate([pipeOffset,0,taperLength])
		cylinder(r=pipeDiameter/2,h=t,center=true);
	}
	hull(){
		translate([0,-y/2,])
		hull(){
			cylinder(r=x/2-t, h=t, center=true);
			translate([0,y,0]) cylinder(r=x/2-t, h=t, center=true);
		}
		translate([pipeOffset,0,taperLength])
		cylinder(r=pipeDiameter/2-t,h=t,center=true);
	}
}

translate([pipeOffset,0,taperLength])
difference(){
cylinder(r=pipeDiameter/2,h=pipeConnectLength);
cylinder(r=pipeDiameter/2-t,h=pipeConnectLength);
}

translate([0,-y/2,-z])
difference(){
	hull(){
		cylinder(r=x/2+lip, h=t, center=true);
		translate([0,y,0]) cylinder(r=x/2+lip, h=t, center=true);
	}
	
	hull(){
		cylinder(r=x/2-t, h=t, center=true);
		translate([0,y,0]) cylinder(r=x/2-t, h=t, center=true);
	}

    for(j=[0:1]){
        for(i=[-1,1]){
            translate([x*i/2+lip*i/2,y*j,0])
            cylinder(d=screwHoleDia,h=2*t,center=true);
            

        }
        translate([0,y*j+x*(2*j-1)/2+lip*(2*j-1)/2,0])
        cylinder(d=screwHoleDia,h=2*t,center=true);
    }

}

}
