//!OpenSCAD

//part -  0 for base, 1 for shade, 2 for both
part = 2;
//base diameter
base_diameter= 88;
//shade diameter
shade_diameter=108;
//shade overall height
overall_height = 150;
//base height
base_height = 50;
//base wall thickness
thick = 2;
//receptacle base thickness
base_thick = 15;
//receptacle base rim
base_rim = 4;
//grill to base height ratio
factor = 0.55;
//number of holes for grill
holes = 20;
//grill size
grill_size = 2.5;
//cylinder resolution or number of sides
sides = 60;

base_radius = base_diameter / 2;
shade_radius = shade_diameter / 2;
shade_height = overall_height - base_height;



if (part == 0) {
  base();
} else if (part == 1) {
  shade();
} else {
  union(){
    base();
    shade();
  }
}


module shade() {
  color([1,1,1]) {
    {
      $fn=sides;    //set sides to sides
      difference() {
        cylinder(r1=(shade_radius + thick), r2=(base_radius + thick), h=overall_height, center=false);

        translate([0, 0, shade_height]){
          cylinder(r1=(shade_radius + thick), r2=(shade_radius + thick), h=base_height+1, center=false);
        }
      }
    }
  }
}

module base() {
  color([0,0,1]) {
    {
      $fn=sides;    //set sides to sides
      difference() {
        union(){
          difference() {
            cylinder(r1=(shade_radius + thick), r2=(base_radius + thick), h=overall_height, center=false);

            cylinder(r1=(shade_radius + thick), r2=(shade_radius + thick), h=shade_height, center=false);
          }

            cylinder(r1=(shade_radius + (thick - 0.5)), r2=(base_radius + (thick - 0.5)), h=overall_height, center=false);

        }

        translate([0, 0, (thick * -1)]){
          cylinder(r1=shade_radius, r2=base_radius, h=overall_height, center=false);
          cylinder(r1=(shade_radius + thick), r2=(shade_radius + thick), h=(shade_height+thick - 3), center=false);
        }
        cylinder(r1=(base_radius - base_rim), r2=(base_radius - base_rim), h=overall_height+1, center=false);
        translate([0, 0, (overall_height - thick)]){
          intersection() {
            cube([base_thick, (base_radius * 2), 10], center=true);

            cylinder(r1=base_radius, r2=base_radius, h=10, center=false);

          }
        }
        for (i = [0 : abs(360 / holes) : 360]) {
          rotate([0, 0, i]){
            translate([0, 0, (shade_height + base_height * (factor + (1 - factor) / 2))]){
              rotate([0, 90, 0]){
                hull(){
                  cylinder(r1=grill_size, r2=grill_size, h=(shade_radius + thick), center=false);
                  translate([(base_height * factor), 0, 0]){
                    cylinder(r1=grill_size, r2=grill_size, h=(shade_radius + thick), center=false);
                  }
                }
              }
            }
          }
        }

      }
    }
  }
}

