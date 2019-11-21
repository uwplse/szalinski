// Which one would you like to see?
part = "first"; // [first:Fan Barrel,second:Fan Blades,third:Base Stem,fourth:Base]

//Resolution of the curves.(Higher = more polygons and higher load time)
$fn = 30;
numberOfBlades = 6;
// In millimeters
lengthOfBlades = 125;
// In millimeters
widthOfBlades = 30;
// In millimeters
thicknessOfBlades = 2;
// In degrees
angleOfBlades = 25;
// Height of the center cylinder
heightOfBarrel = 15;
// Diameter of the center cylinder
diameterOfBarrel = 50;

print_part();
module print_part() {
	if (part == "first") {
		fanBarrel();
	} else if (part == "second") {
		fanBlades();
	} else if (part == "third") {
		baseStem();
	} else {
		base();
	}
}


// Fan Barrel
module fanBarrel(){
    difference(){
        cylinder( d = diameterOfBarrel, h = heightOfBarrel );
        union(){
            translate([0,0,-1]){
                cylinder( d = 8, h = heightOfBarrel + 2 );
            }
            for( i = [ 1 : numberOfBlades ] ){
                rotate(a = [90, 0, i * (360/numberOfBlades)]){
                    translate([0,heightOfBarrel/2,0]){
                        rotate(a = [0,0,angleOfBlades]){
                            translate([-2.5,0,diameterOfBarrel / 4]){
                                
                                union(){
                                    translate([0,-2.5,0]){
                                        cube([5, 5, diameterOfBarrel / 4 + 2]);
                                    }
                                    cylinder( d = 5, h = diameterOfBarrel / 4 + 2 );
                                    translate([5,0,0]){
                                        cylinder( d = 5, h = diameterOfBarrel / 4 + 2 );
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
// Fan Blades
module fanBlades(){
    union(){
        cube([lengthOfBlades,widthOfBlades,thicknessOfBlades]);
        cube([4,widthOfBlades,5]);
        translate([2,(widthOfBlades/2)-2.5,2.5]){
            union(){
                rotate(a = [0,-90,0]){ rotate([0,0,90]){
                    translate([0,-2.5,0]){
                        cube([5, 5, diameterOfBarrel / 4 + 2]);
                    }
                    cylinder( d = 5, h = diameterOfBarrel / 4 + 2 );
                    translate([5,0,0]){
                        cylinder( d = 5, h = diameterOfBarrel / 4 + 2 );
                    }
                }}
            }
        }
    }
}
// Base Stem
module baseStem(){
    union(){
        cube([lengthOfBlades * 1.3,8,8]);
        translate([lengthOfBlades * 1.3 - 4,0,0]){
            cube([4,heightOfBarrel + 50,4]);
        }
        translate([lengthOfBlades * 1.3 - 4,heightOfBarrel + 49,0]){
            cube([7,4,4]);
        }
        difference(){
            translate([lengthOfBlades * 1.3 - (100 / sqrt(2)),-40,0]){
                rotate(a = [0,0,-45]){
                    cube([4,100,4]);
                }
            }
            translate([0,-100,-1]){
                cube([lengthOfBlades * 1.3,100,10]);
            }
        }
    }
}
// Base
module base(){
    difference(){
        cube([heightOfBarrel + 68,lengthOfBlades*1.5,10]);
        translate([4,(lengthOfBlades*1.5)/2,-1]){
            cube([8,8,12]);
        }
    }
}