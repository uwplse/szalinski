/*[ Main properties of distance piece ] */
// inner diameter
inner_diameter = 25;
// outer diameter
outer_diameter = 30;
// width
width = 7;
/*[ Splitting of the distance piece ] */
// which angle should one piece have?
angle_of_one_piece = 30;
// which gap do you want between start and end of distance piece (in degrees)
angle_of_gap = 3;
// what is the clearance between the chain parts
clearance_between_parts = 0.10;

$fn=60;  // set to higher value for better rendering quality. But 60 should do for most purposes

// determine how many pieces we need (plus additional residual piece to fill the gap to 360°)

residual_piece = 360%angle_of_one_piece; // first have a look if there's some residual by division by the angle of one piece

effective_pieces = (360-residual_piece)/angle_of_one_piece; // and calculate the number of "full" pieces

radius_between_inner_and_outer = inner_diameter/2+(outer_diameter-inner_diameter)/4;

// calculate the linear offset between wo chain segments
linear_offset = sqrt(pow(radius_between_inner_and_outer*(1-cos(angle_of_one_piece)),2) + pow(radius_between_inner_and_outer*sin(angle_of_one_piece),2));

rotate([0,-90,0]) {

// now start painting the distance piece
rotate([0,0,-90+(180-angle_of_one_piece)/2])  // rotate it to point in direction Y-axis
translate([-(inner_diameter/2+(outer_diameter-inner_diameter)/4),0,0]) // translate it to start at [0,0,0]
chainpiece(angle_of_one_piece,false,true); // start with a chainpiece which has no startconnector

if(residual_piece == 0) {
    // when no residual by division by the angles of the pieces then the last piece is one of the effective pieces
    if(effective_pieces>2) {
    for (i = [1:effective_pieces-2]) {
      translate([0,linear_offset*i,0])
      rotate([0,0,-90+(180-angle_of_one_piece)/2]) // rotate it to point in direction Y-axis
      translate([-(inner_diameter/2+(outer_diameter-inner_diameter)/4),0,0]) // translate it to start at [0,0,0]
      chainpiece(angle_of_one_piece,true,true);
    }
    }
    
    // draw the final part    
    translate([0,linear_offset*(effective_pieces-1),0])
    rotate([0,0,-90+(180-angle_of_one_piece)/2]) // rotate it to point in direction Y-axis
    translate([-(inner_diameter/2+(outer_diameter-inner_diameter)/4),0,0]) // translate it to start at [0,0,0]    
    chainpiece(angle_of_one_piece-angle_of_gap,true,false);
    
    }
else {  // some different residual part is necessary
    
for (i = [1:effective_pieces-1]) {
      translate([0,linear_offset*i,0])
      rotate([0,0,-90+(180-angle_of_one_piece)/2]) // rotate it to point in direction Y-axis
      translate([-(inner_diameter/2+(outer_diameter-inner_diameter)/4),0,0]) // translate it to start at [0,0,0]
      chainpiece(angle_of_one_piece,true,true);
    }

// draw the final part    
translate([0,linear_offset*(effective_pieces),0])
rotate([0,0,-90+(180-(residual_piece-angle_of_gap))/2]) // rotate it to point in direction Y-axis
translate([-(inner_diameter/2+(outer_diameter-inner_diameter)/4),0,0]) // translate it to start at [0,0,0]
chainpiece(residual_piece-angle_of_gap,true,false);
}
}
// module to draw one distance part with/without connectors
module chainpiece(angle=90,startconnector=true, endconnector=true) {

union() {
   // this is the connector pin of the startconnector. If no startconnector is necessary, we omit it
   if(startconnector) {
    translate([(outer_diameter-inner_diameter)/4.0+inner_diameter/2.0,0,0]) {
    cylinder(r=(outer_diameter-inner_diameter)/8.0, 3.0*width/4.0, center=true);
    }
    }

difference() {

union() {

if(endconnector) {
// this adds the round part of the end connector (no cutaways so far)
rotate([0,0,angle])
translate([(outer_diameter-inner_diameter)/4.0+inner_diameter/2.0,0,0]) {
  cylinder(r=(outer_diameter-inner_diameter)/4.0, width, center=true);
}
}

if(startconnector) {
// this adds the round part of the startconnector
translate([(outer_diameter-inner_diameter)/4.0+inner_diameter/2.0,0,0]) {
cylinder(r=(outer_diameter-inner_diameter)/4.0, width/2.0, center=true);
}
}
  
    
difference() {  // generate a fraction of a ring

  // generate the main ring
  difference() {  // cut out the cylinder ring (inner ring from outer ring)
    cylinder(r=outer_diameter/2.0, width, center=true);
    cylinder(r=inner_diameter/2.0, width*1.1, center=true);
  }

  // generate the cutaways
  union() { // this union of two big cubes cuts away a pie from the ring above
  translate([0,-outer_diameter*0.55,0])
  cube([outer_diameter*1.1,outer_diameter*1.1,width*1.1],center=true);
  rotate([0,0,angle])
  translate([0,outer_diameter*0.55,0])
  cube([outer_diameter*1.1,outer_diameter*1.1,width*1.1],center = true);
  }

}
}
// subtract the clearance we need for the chain elements
union() {

if(endconnector) {
    rotate([0,0,angle])
translate([(outer_diameter-inner_diameter)/4.0+inner_diameter/2.0,0,0]) {
cylinder(r=(outer_diameter-inner_diameter)/4.0+clearance_between_parts, width/2.0+2.0*clearance_between_parts, center=true);
}
}

if(startconnector) { // the two cutaways of the startconnector
translate([(outer_diameter-inner_diameter)/4.0+inner_diameter/2.0,0,3*width/8.0]) {
cylinder(r=(outer_diameter-inner_diameter)/4.0+clearance_between_parts, width/4.0+clearance_between_parts, center=true);
}

translate([(outer_diameter-inner_diameter)/4.0+inner_diameter/2.0,0,-3*width/8.0]) {
cylinder(r=(outer_diameter-inner_diameter)/4.0+clearance_between_parts, width/4.0+clearance_between_parts, center=true);
}
}

if(endconnector) { // space for the pin at endconnector's position to fit the startconnector pin of the net piece
    rotate([0,0,angle])
translate([(outer_diameter-inner_diameter)/4.0+inner_diameter/2.0,0,0]) {
cylinder(r=(outer_diameter-inner_diameter)/8.0+clearance_between_parts, 3.0*width/4.0+2.0*clearance_between_parts, center=true);
}
}

    }

}
}
}



/* Johann Schuster, 29 October 2019, Version 0.02
   Added rotation by 90 degree to make the result ready for printing without manual rotation */
