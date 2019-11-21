// Parametric Radial Bearing 
// By Antyos

/* [Rings] */

// Inside radius (mm)
inner_radius = 20;
// Total height of bearing (mm)
height = 7.5;
// Width of the rings (mm)
width = 4;
// Radius of the curve of the outside of the rings (mm)
ring_fillet = 2.5;
// Resolution of rings 
ring_resolution = 100;

/* [Bearings ] */

// Number of bearings - Make sure you have enough (mm)
bearing_count = 24;
// Radius of the balls (mm)
bearing_radius = 3;
// Distance between balls and rings (mm)
bearing_tolerance = 0.125;
// Generate support for the bearings
bearing_support = 2; // [1:Ring, 2:Columns, 0:None]
//The resolution of the bearings
bearing_resolution = 50;

module createFillet(){ // Create the fillets
    translate([-ring_fillet/2,-ring_fillet/2,0])
    difference(){ // Create square with arc
        square(ring_fillet); // Create square
        circle(ring_fillet, $fn=ring_resolution); // Create circle to remove
      
        }
}
// Creates the pattern to be revolved for the ring
module ring_tile(){
    difference(){
        translate([0,width/2,0])square([height, width], center = true); //main body
        union(){ // Make cut outs
    translate([ring_fillet/2+(height/2-ring_fillet),ring_fillet/2,0]) rotate([0,0,270])createFillet();// Move fillet into position
            
    mirror(0,1,0)translate([ring_fillet/2+(height/2-ring_fillet),ring_fillet/2,0]) rotate([0,0,270])createFillet(); // Move other fillet into position
           
    translate([0,width+bearing_radius/2+bearing_tolerance,0])circle(r=bearing_radius+bearing_tolerance, $fn=ring_resolution/4); // Bearing chanel 
        }
  }
}

// Creates both rings
module createRings(){
 rotate([0,0,90])translate([0,inner_radius,0]){ //move rings into position
         ring_tile(); // Create inner ring
    mirror([0,1,0])translate([0,-(width*2+bearing_radius+bearing_tolerance*4),0])ring_tile(); // Create outer ring seperated from the inner ring
         }
}

module support(support_type){
		if (support_type == 1) // Support type = Ring
				difference(){ // Create the circle
        circle(r = inner_radius+width+bearing_radius *0.75+bearing_tolerance*4); // Circle
        circle(r = inner_radius+width+bearing_radius*0.25); // Hole in the middle
    }

    if (support_type == 2) // Support type = Columns
for(i = [0 : bearing_count]){ // Create collumn under every bearing 
    rotate(i* 360 / bearing_count, [0,0,1]) // Get angle of bearing
    translate([inner_radius+width+(bearing_radius/2)+bearing_tolerance*2,0,0]) // Move circle into position
    circle(bearing_radius/2.5, $fn=bearing_resolution); // Generate collumn (circle)
}

}

rotate_extrude($fn=ring_resolution) createRings(); // Create the rings

for(i = [0 : bearing_count]){ // Create all the ball bearings
    rotate(i* 360 / bearing_count, [0,0,1]) // Get angle of bearing
    translate([inner_radius+width+(bearing_radius/2)+bearing_tolerance*2,0,0]) // Move bearing into position
    sphere(bearing_radius, $fn=bearing_resolution); // Generate bearing
}

translate([0,0,-height/2]) //move to base of bearing
linear_extrude(height = (height/2 - bearing_radius)) //extrude to bearing base to support them
support(bearing_support);