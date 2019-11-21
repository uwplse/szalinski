use <write.scad>

//(mm)
Height = 55;

// (mm)
Diameter = 70;

// (mm)
WallThickness = 2;

// Make a round pot?
RoundPlanter = "No"; // [Yes, No]

//If not round then how many sides?
PlanterSides = 5;

// Pick from one of the three sizes.
SaucerHeight = "Large"; // [Small, Medium, Large]

roundRes = 300 * 1;
userRes = 10 * 1;
/* error checking */
h4 = Height == 0 ? 20 : abs(Height);
radius = Diameter == 0 ? 20 : abs(Diameter / 2);
wT = WallThickness == 0 ? 2 : abs(WallThickness);
resHack = RoundPlanter == "Yes" ? roundRes : PlanterSides;
res = resHack == 0 ? 4 : abs(resHack);

sHeight_Hold = SaucerHeight == "Small" ? 0.1 : 0.15;
sHeight = SaucerHeight == "Large" ? 0.2 : sHeight_Hold;

offset = 3 * 1;
baseR = 10 * 1;

h2 = (h4 * sHeight) + wT;
h3 = h2 + (offset * 0.5) + wT;
h1 = h3 - offset - wT;
r1 = radius - offset - wT;

maxRes = 16 * 1;

faceOS = 0.01 * 1;
faceOS2 = faceOS * 2;
drainH_Hold = (h1 - 2) * 1.414;

drainH = drainH_Hold < 5 ? 5 : drainH_Hold;

iCount= res<=maxRes ? res : 4;

union(){
base();
taper();
top();
drain();
}

module drain(){
	difference(){
		cylinder(h = h1, r1 = r1, r2 = r1, $fn = res);
	
		translate([0,0,-faceOS]) 
			cylinder(h = h1 + faceOS2, r1 = r1 - wT, r2 = r1 - wT, $fn = res);
   	
		for( i = [1:iCount]){
			rotate([90,0,(360/iCount) * (i + ((iCount - 2) % 4) * 0.25) ]) 
				translate([0,(-.707*drainH),0]) 
					rotate([0,0,45]) 
						cube([drainH,drainH,r1]);}
	}
}

module base(){
	difference(){
		cylinder(h = h2, r1 = radius, r2 = radius, $fn = res);

		translate([0,0,wT]) 
			cylinder(h = h2+.1, r1 = radius - wT, r2 = radius - wT, $fn = res);}
}


module top(){
	difference(){
		translate([0,0,h3]) 
			cylinder(h = h4 - h3, r1 = radius, r2 = radius, $fn = res);

		translate([0,0,h3-.1]) 
			cylinder(h = (h4 - h3) + 1.1, r1 = radius - wT, r2 = radius - wT, $fn = res);}
}

module taper(){
	translate([0,0,h1]) difference(){
		cylinder(h = h3 - h1, r1 = r1, r2 = radius,$fn = res);

		cylinder(h = h3 - h1, r1 = r1 - wT, r2 = radius - wT, $fn = res);
		translate([0,0,h3 - h1 - faceOS]) 
			cylinder(h = 1, r1 = radius - wT, r2 = radius - wT, $fn = res);
		translate([0,0,-faceOS]) 
			cylinder(h = faceOS2, r1 = r1 - wT, r2 = r1 - wT, $fn = res);}
}




