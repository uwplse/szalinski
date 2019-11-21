/* parametric Delta vase inspired by 
   http://www.thingiverse.com/thing:150482
   from the original design by Mart van Schijndel

   generaised to n sides

   Each side is constructed by hulling spheres positioned 
   at the corners of the plane of the face.  Three of the
   points are straightforward to position but the fourth
   needs to be placed so that the bottom edge is parallel
   to the top edge,
*/
 
// length of top edge
top=40;
// length of bottom edge
bottom=20;
// height of vase
height=50;
// wall thickness
thickness=1;
// number of sides
nsides=3;

module side(angle,top,bottom,height,thickness) {
   hull() {
        translate([top,0,height]) sphere(thickness);  
        rotate([0,0,angle])
            translate([top,0,height]) sphere(thickness);
        translate([0,0,0]) sphere(thickness);
        rotate([0,0,angle+(180-angle)/2])
            translate([bottom,0,0]) sphere(thickness);
    }
}

module delta_vase(nsides,top,bottom,height,thickness) {
    assign(angle=360/nsides)
    for (i = [0:nsides-1])
      rotate([0,0,i*angle])
         side(angle,top,bottom,height,thickness);
}

module ground(size=50) {
   translate([0,0,-size]) cube(2*size,center=true);
}

$fn=15;

difference()  {
  delta_vase(nsides,top,bottom,height,thickness);
  ground();
}