
module imac_shape(h = 5)
{
//iMac 5K
//w1 = 6; w2 = w1 + 9.5; 

// Apple Thunderbold Display 27"
w1 = 22; w2 = w1 + 6.5;

linear_extrude(height = h, center = true, convexity = 10)
polygon(points = [[0,0],[w1,0],[w2,18],[0,18]], paths = [[0,1,2,3]], convexity = 2);
}


module cover(){
difference(){
$fn=50;
minkowski() {
 intersection(){
  imac_shape(20);
  translate([7,7,0])cube([58, 18, 15], center=true);
 }
sphere(1.7);
}
imac_shape(20);
}
}

module 8bit_heart() {
      difference(){
        square([7,7],center=true);
        translate ([-3.5, 2.5, 0]) square(1);
        translate ([2.5, 2.5, 0]) square(1);
        translate ([-0.5, 2.5, 0]) square(1);
        translate ([-3.5, -3.5, 0]) square([1, 3]);
        translate ([-2.5, -3.5, 0]) square([1, 2]);
        translate ([-1.5, -3.5, 0]) square([1, 1]);
        translate ([2.5, -3.5, 0]) square([1, 3]);
        translate ([1.5, -3.5, 0]) square([1, 2]);
        translate ([0.5, -3.5, 0]) square([1, 1]);
      }
      
}




module apple_cover(){

    rotate([90,0,180])cover();
    scale(1.7) rotate([-90,0,90]) translate([0,-4.7,-2]) linear_extrude(height = 1.5) 8bit_heart();
}


rotate([-90,0,-90]) apple_cover();


