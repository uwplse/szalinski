
build_base();

/*[Global]*/
quality = 10;   //[10:10:120]

/*[Base]*/
screw_hole = 1;      //[1:yes,0:no]
base_screw_hole_offset = 8;
base_thickness = 8;
base_top_radius = 7;
base_smoothing = 4;

/*[Arm]*/
shoulder_radius = 10;
shoulder_offset = -10;
upper_arm_length = 35;
elbow_radius = 5;
elbow_offset = 0;
//Set to 0 if you don't want the end hook
fore_arm_length = 7;
fist_radius = 3;
//Set equal to Elbow Offset if you don't want the end hook
fist_offset = 5;

/*[Screw]*/
screw_shaft_radius = 1.7;
screw_head_radius = 3.5;
screw_head_depth = 3;

/* [Hidden] */

base_z = base_thickness - base_smoothing;
arm_len = upper_arm_length + base_thickness;
knob2_z = fore_arm_length + base_thickness + upper_arm_length;

module serial_hull()
  {
    // let i be the index of each of our children, but the last one
    for(i=[0:$children-2])
      hull() // we then create a hull between child i and i+1
      {
        children(i); // use child() in older versions of Openscad!
        children(i+1); // this shape is i in the next iteration!
      }
  }


module arm(){
    serial_hull(){
        translate([shoulder_offset,0,0]) scale([1,2,1]) cylinder(r=shoulder_radius,h=0.01,$fn=quality);
        translate([elbow_offset,0,arm_len]) scale([1,1.5,1]) sphere(r=elbow_radius,$fn=quality);
        translate([fist_offset,0,knob2_z]) scale([1,1,1]) sphere(r=fist_radius,$fn=quality);
    }
    
}

module base(){
    hull(){
        difference(){
            arm();
            translate([0,0,50+base_z + base_smoothing]) cube(size=100,center=true);
        }
        difference(){
            minkowski(){
                    translate([base_screw_hole_offset,0,0]) scale([1,1,1]) cylinder(r = base_top_radius, h=base_z,$fn=quality);
                sphere(r=base_smoothing,$fn=quality/2);
            }
            translate([0,0,-50]) cube(size=100,center=true);
        }
    }
}

module build_base(){
    arm();
    difference(){
        base();
        if(screw_hole==1){
            translate([base_screw_hole_offset,0,0]) cylinder(r=screw_shaft_radius,h = arm_len,$fn=30,center=true);
            translate([base_screw_hole_offset,0,base_z+base_smoothing-screw_head_depth]) cylinder(r=screw_head_radius,h=arm_len,$fn=30,center=false);
        }
    }
}
