pole_radius = 20;
Material_thickness = 3;
holder_radius = 15;
height = 10;
linear_extrude( height=height, twist=0, scale=[1, 1], center=false){
  union(){
    difference() {
      difference() {
        circle(r=(pole_radius + Material_thickness));

        circle(r=pole_radius);
      }

      square([1000, 1000], center=false);
    }
    translate([0, ((holder_radius * 2 + Material_thickness) + (pole_radius - holder_radius))-0.2, 0]){
      rotate([0, 0, 180]){
        difference() {
          difference() {
            circle(r=(holder_radius + Material_thickness));

            circle(r=holder_radius);
          }

          square([1000, 1000], center=false);
        }
      }
    }
  }
}