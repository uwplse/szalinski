
bottom_inset = 2;
bottom_thickness = 1.5;

inner_inset = -0.5;

top_inset = 0.5;
top_thickness = 1;
top_outer_radius = 1.5;
top_inner_radius = 0.75;

/* [Hidden] */
$fs = 0.01;


// Front-Plate
/*
color("DarkBlue",1) {
  //import("Small LCD.dxf");
  linear_extrude(height = 1.5)
  import("Large LCD.dxf");
}
*/

// Bezel
difference(){
  union() {
    translate([77.5-bottom_inset,12.5-bottom_inset,-bottom_thickness]) {
      cube([5+67+1+bottom_inset+bottom_inset,2 + 51 + 2.5+bottom_inset+bottom_inset,bottom_thickness]);
    }

    inner_radius = 2;
    translate([77.5-inner_inset+inner_radius,12.5-inner_inset+inner_radius,0]) {
      minkowski()
      {
        cylinder(h=1.5/2, r=inner_radius);
        cube([5+67+1+inner_inset+inner_inset-inner_radius-inner_radius,2 + 51 + 2.5+inner_inset+inner_inset-inner_radius-inner_radius,1.5/2]);
      }
    }

  
    translate([77.5-top_inset+top_outer_radius,12.5-top_inset+top_outer_radius,1.5]) {
      minkowski()
      {
        cylinder(h=top_thickness/2, r1=top_outer_radius, r2=top_inner_radius);
        cube([5+67+1+top_inset+top_inset-top_outer_radius-top_outer_radius,2 + 51 + 2.5+top_inset+top_inset-top_outer_radius-top_outer_radius,top_thickness/2]);
          
      }
    }
    
  }
  translate([77.5+5,12.5+2,-2]) {
    cube([67,51,20]);
  }
}
