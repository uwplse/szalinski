//How many slots wide do you want
clubs_wide = 3; //[1:1:9]
//How many clubs fit in one slots
clubs_thick = 1; //[1:1:2]
//What is the diameter of the bulb on your club
bulb_diameter = 92; //[60:.5:100]
//How thick is the handle near the knob
handle_diameter = 23.5; //[5:.5:40]
//How thick the knob on your clubs are
knob_diameter = 34; //[20:.5:40]
//How thick do you want the bracket to be (16mm recomended)
bracket_thickness = 16; //[10:.5:40]
$fn = 30;

//Mounting (add some a couple millimeters to ensure an easy fit)
screw_head_diameter = 8.5; //[1:.5:10]
screw_head_Thickness = 3.5; //[1:.25:10]
screw_diameter = 5; //[1:.25:10]

module bracket(){
  translate([-(bulb_diameter*clubs_wide)/2,0,0])
    difference(){
      union(){
        cube([bulb_diameter*clubs_wide,bulb_diameter*clubs_thick,bracket_thickness]);
        translate([0,0,bracket_thickness])
          cube([bulb_diameter*clubs_wide,bracket_thickness,(bulb_diameter/2)-bracket_thickness]);
        for(h = [0:bulb_diameter:bulb_diameter*(clubs_wide-2)])
          translate([bulb_diameter+h,bracket_thickness,bracket_thickness])
            support();
      }
      //cuts out the holes that the clubs fit in
      union(){
        for(i = [0:bulb_diameter:bulb_diameter*(clubs_thick-1)])
          for(j = [0:bulb_diameter:bulb_diameter*(clubs_wide-1)])
            translate([bulb_diameter/2+j,bulb_diameter/2+i,0])
              union(){
                cylinder(r = handle_diameter/2+2, h = bracket_thickness+.1);
                translate([0,0,bracket_thickness/2])
                  cylinder(r = knob_diameter/2+2, h = bracket_thickness/2+.1);
              }
        //cuts the slots so the clubs can slide in
        for(k = [0:bulb_diameter:bulb_diameter*(clubs_wide-1)]){
          translate([bulb_diameter/2+k,bulb_diameter/2+(bulb_diameter*clubs_thick)/2,bracket_thickness/2])
            cube([handle_diameter+2,bulb_diameter*clubs_thick,bracket_thickness+.1],center = true);
        translate([k,0,0])
          mountingHoles();
        }
      }
    }
}
//generates triangle supports
module support(){
  cylinderRadius = .001;
  rotate([0,90,0]) hull(){
    cylinder(r = cylinderRadius, h = handle_diameter/2, center = true);
    translate([-(bulb_diameter/2-bracket_thickness),0,0])
      cylinder(r = cylinderRadius, h = handle_diameter/2, center = true);
    translate([0,(bulb_diameter*clubs_thick)-bracket_thickness,0])
      cylinder(r = cylinderRadius, h = handle_diameter/2, center = true);
  }
}
module mountingHoles(){
  translate([bulb_diameter/2,screw_head_Thickness*2,bulb_diameter/4]) rotate([0,-90,90]){
    hull(){
      cylinder(r = screw_head_diameter/2, h = screw_head_Thickness);
      translate([screw_head_diameter,0,0])
        cylinder(r = screw_head_diameter/2, h = screw_head_Thickness);
    }
    translate([0,0,screw_head_Thickness]) hull(){
      cylinder(r = screw_head_diameter/2, h = screw_head_Thickness+1);
      translate([screw_head_diameter,0,0])
        cylinder(r = screw_diameter/2, h = screw_head_Thickness+1);
    }
  }

}

  bracket();
