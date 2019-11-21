//!OpenSCAD

// you need both!
Item = "Pot";//[Pot,Tree]

/*[Tree]*/

//number of brenches
levels = 5; 
// length of the first segment in mm
len = 50; 
// thickness of the first segment
thickness = 5; 
//heigh of thewhle tree
height = 5;
//a random number wich determines the position of the trees
random_number = 6;//[-100000,100000]

/*[Pot Settings]*/
// length of the shaft for the tree in mm
shaft_deepness = 10;
// legth of the sides of the base of the tree in mm
y_side_length_of_your_tree = 3.5;
x_side_length_of_your_tree = 3.5;
// base radius of the pot in mm
Base_radius = 12.5;
//Top radius in mm
top_torus_radius = 3;
//height of the pot in mm
height_pot = 20;
/*[Hidden]*/
identity = [ [ 1, 0, 0, 0 ], [ 0, 1, 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];

rcnt = 1000;
random = rands(0, 1, rcnt, random_number);

function rnd(s, e, r) = random[r % rcnt] * (e - s) + s;

// generate 4x4 translation matrix
function mt(x, y) = [ [ 1, 0, 0, x ], [ 0, 1, 0, y ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];

// generate 4x4 rotation matrix around Z axis
function mr(a) = [ [ cos(a), -sin(a), 0, 0 ], [ sin(a), cos(a), 0, 0 ], [ 0, 0, 1, 0 ], [ 0, 0, 0, 1 ] ];

module tree(length, thickness, count, m = identity, r = 1) {
    color([0, 1 - (0.8 / levels * count), 0])
        multmatrix(m)
            square([thickness, length]);

    if (count > 0) {
        tree(rnd(0.6, 0.8, r) * length, 0.8 * thickness, count - 1, m * mt(0, length) * mr(rnd(20, 35, r + 1)), 8 * r);
        tree(rnd(0.6, 0.8, r + 1) * length, 0.8 * thickness, count - 1, m * mt(0, length) * mr(-rnd(20, 35, r + 3)), 8 * r + 4);
    }
}
if (Item == "Pot"){
difference() {
  union(){
    {
      $fn=50;    //set sides to 50
      linear_extrude( height=height_pot, twist=0, scale=[1.2, 1.2], center=false){
        circle(r=Base_radius);
      }
    }
    translate([0, 0, height_pot]){
      scale([1.2, 1.2, 1]){
        // torus
        rotate_extrude($fn=50) {
          translate([(Base_radius - top_torus_radius), 0, 0]) {
            circle(r=top_torus_radius, $fn=50);
          }
        }
      }
    }
  }

  translate([0, 0, (height - shaft_deepness) + 50]){
    cube([x_side_length_of_your_tree, y_side_length_of_your_tree, 100], center=true);
  }
}
}
else{



linear_extrude(height = height){
    tree(len, thickness, levels);
}}