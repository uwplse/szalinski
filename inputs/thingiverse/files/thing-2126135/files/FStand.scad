// Width
width=66;

// Height
height=115;

// Depth
depth=7;

// Solid Body
solidB=false;

// Solid Foot
solidF=true;

//[Hidden]
flong=90;
ftall=20;

module base(){
	ww=(width/2)-2;
	hh=height+ftall-2;
	difference(){
		hull(){
			translate([-width/2,height+ftall,0])
			cylinder(h=depth/2,r=4,$fn=50);
			translate([width/2,height+ftall,0])
			cylinder(h=depth/2,r=4,$fn=50);
			translate([-width/2,0,0])
			cylinder(h=depth,r1=4,r2=1,$fn=50);
			translate([width/2,0,0])
			cylinder(h=depth,r1=4,r2=1,$fn=50);
		}
		pie(ftall,-15);
		if (!solidF)
			hull(){
				translate([-ww,ftall-11,0])
				cylinder(h=depth,r=2,$fn=50);
				translate([ww,ftall-11,0])
				cylinder(h=depth,r=2,$fn=50);
				translate([-ww,2,0])
				cylinder(h=depth,r=2,$fn=50);
				translate([ww,2,0])
				cylinder(h=depth,r=2,$fn=50);
			}
		if (!solidB)
			hull(){
				translate([-ww,ftall+11,0])
				cylinder(h=depth,r=2,$fn=50);
				translate([ww,ftall+11,0])
				cylinder(h=depth,r=2,$fn=50);
				translate([-ww,hh,0])
				cylinder(h=depth,r=2,$fn=50);
				translate([ww,hh,0])
				cylinder(h=depth,r=2,$fn=50);
			}
		
	}
}

module pie(hh,z){
	ww=(width/2)-5;
	hull(){
	translate([-ww,hh,z])
	cylinder(h=flong,r1=5,r2=1,$fn=50);
	translate([ww,hh,z])
	cylinder(h=flong,r1=5,r2=1,$fn=50);
	}
}

base();
pie(-15,0);