module heart_shape(size) {
      union() {
        square(size,size);
        translate([size/2,size,0]) circle(size/2);
        translate([size,size/2,0]) circle(size/2);
    }
}

module heart(size,thickness,height) {
   linear_extrude(height=height) 
          minkowski() {
               heart_shape(size);
               circle(thickness+0.1);
        }
}

module heart_box(size,height,thickness,clearance) {
    difference() {
         heart(size,thickness + clearance,height);
         translate([0,0,thickness])  heart(size,clearance,height);
    }
}
 
module heart_lid(size,thickness,depth,clearance) {
  union()  {
        heart(size,thickness+clearance,thickness);
        translate([0,0,thickness]) heart(size,0, depth); 
  }
}
 
module heart_thing(size,height,thickness,depth,clearance) {
    union() {
       heart_box(size,height,thickness,clearance);
      rotate([180,0,90]) translate ([0,0,- 2 * height ])  // to fit over box to check
          heart_lid(size,thickness,depth,clearance);
  }
}

module prism(l, w, h)
{
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module foot()
{
    translate([0, 0, 0]) rotate([0, 0, 90]) prism(20, 16, 7);// foot triangle
    translate([-16, 0, 7]) rotate([0, 25, 0]) cube([3, 20, 5]);// foot holder
}

$fn=50;
union()
{
    translate([-16, -40, 0]) cube([80, 80, 4]);// square base
    translate([0, -40, 4]) foot();
    translate([0, 20, 4]) foot();
    difference()
    {
        rotate([0, -30, 0]) translate([0, 0, -50]) rotate([0, 0, -45])
            linear_extrude(height=125) heart_shape(50);
        union()
        {
            translate([0, -250, -500]) cube([500, 500, 500]);// truncate down heart
            translate([0, 0, 4]) union()
            {
                rotate([0, 25-90, 0]) translate([55, 35, -10.5]) rotate([0, 0, -90])
                    linear_extrude(height=11.0) text("Me You", size=15);
                rotate([0, 25, 0]) translate([-500, -250, -250]) cube([500, 500, 500]);
            }
        }
    }
}
