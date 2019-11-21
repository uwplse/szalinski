//Choose a polygon with an odd number of sides
sides = 3; //[3:2:19]
//The radius of the polygon that will be the base of the shape
poly_r = 10;
2D_or_3D = "3D";// [3D, 2D]
//Thickness of the 2D option
2D_Thickness = 4;
//Resolution
$fn = 100;

show();

/* [Hidden] */

/* Construction Varables */
/*****special creds to Clayton for helping me figure this out
      when I was severely overthinking it.*****/
//length of the side of polygon
side_length = 2*poly_r*sin(180/sides);
//apothem of polygon
apothem = poly_r*cos(180/sides);
//the radius of the arc centered opposite point
r = sqrt(pow(poly_r + apothem, 2) + pow(side_length/2, 2));
//width of rectangle that intersects desired portion of arc
width = r - (poly_r + apothem);

module show(){
  if(2D_or_3D == "2D")
    linear_extrude(height = 2D_Thickness)
      cross_section();
  else
    rotate([0,180,0])
      rotate_extrude()
        rotate(-90)
          intersection(){
            cross_section();
            translate([0, r/2, 0])
              square([2*r, r], center = true);
          }
}
//creates cross section of the solid before either revolving or extruding
module cross_section(){
  //This hull was added to make sure everything was connected
  hull(){
    circle(r = poly_r, $fn = sides);
    for(i = [0 : 360/sides : 360])
      rotate(i)
        translate([-apothem, 0, 0])
          rounded_edges();
  }
}
//creates rounded edges that will sit on the sides of the polygon
module rounded_edges(){
  intersection(){
    translate([(poly_r + apothem), 0, 0])
      circle(r = r);
    translate([-width/2, 0, 0])
      square([width, r+1], center = true);
  }
}
