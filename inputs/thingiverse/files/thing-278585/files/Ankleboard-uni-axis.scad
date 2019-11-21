r=150; //Radius of Hemisphere
a=10; //Screw Diameter
b=16; //Screw nut Diameter
x=20; //Nut Depth

ankle_board_uni();

module ankle_board_uni(){
difference(){
rotate([90,0,0])cylinder(h=2*r*.9,r=r, center=true, $fn=200);
translate([0,0,(r+5)/-2])cube([r*2.3,r*2.3,r+5],center = true);
translate([0,0,-2])cylinder(r+5,(a+1)/2,(a+1)/2);
translate([0,0,r-(r-x)])hexagon(r+5,(b+1)/2);
}
}

module reg_polygon(sides,radius)
{
  function dia(r) = sqrt(pow(r*2,2)/2);  //sqrt((r*2^2)/2) if only we had an exponention op
  if(sides<2) square([radius,0]);
  if(sides==3) triangle(radius);
  if(sides==4) square([dia(radius),dia(radius)],center=true);
  if(sides>4) circle(r=radius,$fn=sides);
}

module hexagonf(radius)
{
  reg_polygon(6,radius);
}

module hexagon(height,radius) 
{
  linear_extrude(height=height) hexagonf(radius);
}
