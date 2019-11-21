// By Josiah Ritchie <josiah@josiahritchie.com>
// For mounting a Panucatt X3 controller in holes for an Arduino Mega/RAMPS

///////////////
// Settings 
///////////////

// How thick should the walls of the radius be in mm?
standoff_wall_thickness = 3;  

// How big a hole should be in the middle of the Arduino Mega standoff?
standoff_inner_radius_am = 1; 

// How tall should the Arduino Mega standoffs be?
height_am = 3; 

// How big a hole should be in the middle of the standoff? (X3 hole is about 3.8)
standoff_inner_radius_x3 = 2.5; 

// How tall should the X3 standoffs be?
height_x3 = 15; 

// cable tie mount height
height = 7;

// cable tie mount width
width = 10;

// cable tie mount depth
depth = 3;

// cable tie mount wall width
wall_width = 3;

////////////////////
// Make the thing!
////////////////////

color("blue")x3_standoffs(height_x3,standoff_wall_thickness,standoff_inner_radius_x3);
translate([10,8,0])arduino_mega_standoffs(height_am,standoff_wall_thickness,standoff_inner_radius_am);

/*
// The cable tie mounts -bottom
translate([20,2,height])ctmount(height,width,depth,wall_width);
translate([40,2,height])ctmount(height,width,depth,wall_width);
translate([60,2,height])ctmount(height,width,depth,wall_width);
translate([80,2,height])ctmount(height,width,depth,wall_width);

// The cable tie mounts -top
translate([23,55,height])ctmount(height,width,depth,wall_width);
translate([47.5,55,height])ctmount(height,width,depth,wall_width);
translate([72,55,height])ctmount(height,width,depth,wall_width);
*/

//////////////////////////////
// Functions & Modules
//////////////////////////////

// Make a cable-tie mount
module ctmount(height,width,depth,wall_width) {

  outer_radius = width/2;
  inner_radius = width/2-wall_width;

  difference() {
  // Circle at top
  rotate(a=[0,90,90]) {
    difference() {
      cylinder(h=depth,r1=outer_radius,r2=outer_radius,$fn=20);
      cylinder(h=depth,r1=inner_radius,r2=inner_radius,$fn=20);
      translate([0,-2,0]) cube(size = [height,inner_radius*2,depth], center = false, $fn=20);
    }
  }
}
  // Sides
  rotate(a=[90,0,0])translate([-width/2,-height,-depth]) {
    cube(size = [wall_width,height,depth], center = false, $fn=20);
    translate([wall_width+(inner_radius*2),0,0]) {
      cube(size = [wall_width,height,depth], center = false, $fn=20);
    }
  }
}

// Make a basic standoff
module standoff(height,thickness,inner_radius) {
  
  // Inner radius + wall thickness = outer radius of the standoff
  outer_radius = inner_radius + thickness;

  // Make the standoff cylinder and remove the hole in the center
  difference() {
    cylinder(h=height,r1=outer_radius,r2=outer_radius,$fn=20);
    cylinder(h=height,r1=inner_radius,r2=inner_radius,$fn=20);
  }
}

// Make 4 standoffs and space them appropriately for an Arduino Mega
module arduino_mega_standoffs(up,out,in) {
  // Arduino Mega mounting holes are at [0,0],[81.5,0],[1,48],[75,48]
  bl = [0,0,0]; //bottomleft
  br = [81.5,0,0]; //bottomright
  tl = [1,48,0]; //topleft
  tr = [75,48,0]; //topright

  standoff(up,out,in);
  translate(tl)standoff(up,out,in);
  translate(br)standoff(up,out,in);
  translate(tr)standoff(up,out,in);

  // Support structure to connect posts for Arduino
  barbell_w_hole(tr,tl,6,6,230,230);
  barbell_w_hole(br,bl,6,6,240,240);
}

// make 4 standoffs and space them appropriately for a Panucatt X3
module x3_standoffs(up,out,in){
  bl = [0,0,0]; //bottomleft
  br = [101.6,0,0]; //bottomright
  tl = [0,64.3,0]; //topleft
  tr = [101.6,64.3,0]; //topright

  // X3 holes are in a square 4"x2.53" (101.6mm x 64.3mm) on center
  standoff(up,out,in);
  translate(br) standoff(up,out,in);
  translate(tr) standoff(up,out,in);
  translate(tl) standoff(up,out,in);

  // Support structure to connect posts
  $fn=100;
  linear_extrude (height=1.3)barbell([bl[0],bl[1]],[br[0],br[1]],6,6,2000,230);
  linear_extrude (height=1.3)barbell([tl[0],tl[1]],[tr[0],tr[1]],6,6,240,1500);
  linear_extrude (height=1.3)barbell([br[0],br[1]],[tr[0],tr[1]],6,6,150,150);
  linear_extrude (height=1.3)barbell([tl[0],tl[1]],[bl[0],bl[1]],6,6,150,150);
}

module barbell_w_hole (pA,pB,r1,r2,r3,r4)
{
  //pA is position of the first point in three coordinates
  //pB is position of the second point in three coordinates
  $fn=100;


  difference ()
  {
    linear_extrude(height=1.3)barbell([pA[0],pA[1]],[pB[0],pB[1]],r1,r2,r3,r4);
    translate(pA)cylinder(h=height_am,r=standoff_inner_radius_am);
    translate(pB)cylinder(h=height_am,r=standoff_inner_radius_am);
  }
}

// Below is directly from Thing #14742: http://www.thingiverse.com/thing:14742
// x1 and x2 are x,y coordinates.

module barbell (x1,x2,r1,r2,r3,r4) 
{
	x3=triangulate (x1,x2,r1+r3,r2+r3);
	x4=triangulate (x2,x1,r2+r4,r1+r4);
	render()
	difference ()
	{
		union()
		{
			translate(x1)
			circle (r=r1);
			translate(x2)
			circle(r=r2);
			polygon (points=[x1,x3,x2,x4]);
		}
		translate(x3)
		circle(r=r3,$fa=5);
		translate(x4)
		circle(r=r4,$fa=5);
	}
}

function triangulate (point1, point2, length1, length2) = 
point1 + 
length1*rotated(
atan2(point2[1]-point1[1],point2[0]-point1[0])+
angle(distance(point1,point2),length1,length2));

function distance(point1,point2)=
sqrt((point1[0]-point2[0])*(point1[0]-point2[0])+
(point1[1]-point2[1])*(point1[1]-point2[1]));

function angle(a,b,c) = acos((a*a+b*b-c*c)/(2*a*b)); 

function rotated(a)=[cos(a),sin(a),0];
