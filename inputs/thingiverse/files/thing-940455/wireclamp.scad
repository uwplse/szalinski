$fn = 0;

enable_angledtabs = 1;  // [0,1]
enable_ledge = 1;  // [0,1]
clamp_height = 9;  // [0:200]
clamp_length = 8; // [0:200]
clamp_width = 15; // [0:200]
//clamp_depth = 10;  // how deep into the part the gap proceeds
clamp_gap_depth = 7;  // [2:190]
slot_gap = 2;  // [2:190]
plate_thickness = 8.5; // [2:190]
screw_hole_diam = 3.7;  // [1:20]
screw_hole_depth = 4;  // [0:20]
screw_recess_diam = 6.1; // [0:20]
wiretab_angle = 90;  // [-270:270]
nut_type = 6; // [4:6]
wire_diam = 9.2; // [1:40]

hinged_pole_clamp(
clamp_width=clamp_width,
  depth = 10,
  length = clamp_length + 1,
  gap=clamp_gap_depth,
  height=clamp_height,
  hole_diam=screw_hole_diam,
  hole_recess_diam=screw_recess_diam,
  wirediam=wire_diam,
  nut_type=nut_type
  );


module hinged_pole_clamp(
    depth,
    length,
    gap,
    height,
    hole_diam,
    clamp_width,
    hole_recess_diam,
    wirediam,
    horiz_tab_angle=40,
    horiz_thick=3,
    nut_type=6
){
  hinge_fill_x = depth; //hardcoded to fit the hinge footprint
  hinge_fill_y = length;
  hinge_fill_z = height;
  hole_gap = gap;
  hole_r = hole_diam/2;
  pole_r = clamp_width/2;
  hole_recess_r = hole_recess_diam/2;
    

  wire_r = wirediam/2;

  half_space = 0; // gap between the two halfs
  half_width = clamp_width * 1.2;
  half_depth = clamp_width * 0.6;
    union(){
      difference(){
          
          //back portion
        hull(){
           

//square portion
          translate([hinge_fill_x,-1 ,0])
              cube(size=[half_width*0.8, length, hinge_fill_z]);

//ledge
            if (enable_ledge == 1)
            {
          translate([hinge_fill_x,0-(clamp_width/2)+(horiz_thick)-(wire_r),height/2])
            pole_with_tabs_neg(
              width=half_width*0.8,
              pole_r=wire_r,
              pole_thick=horiz_thick,
              hole_diam=screw_hole_diam,
              tab=false,
              tab_angle=horiz_tab_angle);
            }
        }


        // wire hole
        translate([
            hinge_fill_x-(clamp_width*0.1),
            0-(clamp_width/2)+(horiz_thick)-(wire_r),
            height/2])
          pole_with_tabs_neg(
            width=half_width*0.9,
            pole_r=wire_r,
            pole_thick=horiz_thick,
            hole_diam=screw_hole_diam,
            tab=true,
            tab_angle=horiz_tab_angle);
        echo(( depth + (clamp_width / 2 ) - (plate_thickness /2) ));
        // plate slot
        //translate([ ((hinge_fill_x * 2)), length / 2 - clamp_gap +.25 ,hinge_fill_x + 1]) 
        //translate([ (clamp_width / 2 + (plate_thickness * 2)) + 2, length / 2 - clamp_gap_depth +.25 ,height  + 10  ]) 
            translate([ ( depth + (clamp_width / 2 ) - (plate_thickness /2)), (length - clamp_gap_depth),height  + 10  ]) 
            rotate(a=90, v=[0,1,0]) 
            cube(size=[height + 20, hole_gap, plate_thickness]);
            
        //screw hole
            translate([0, length - screw_hole_depth,height/2])
            rotate(a=90, v=[0,1,0])
            cylinder(h=hinge_fill_x * 4, r=hole_diam/2);

      }


        // the hole and fin
      translate([
          hinge_fill_x,
          0-(clamp_width/2)+(horiz_thick)-(wire_r),
          height/2])
        pole_with_tabs(
          width=half_width*0.8,
          pole_r=wire_r,
          pole_thick=horiz_thick,
          hole_diam=screw_hole_diam,
          hole_recess_diam=screw_recess_diam,
          nut_type=nut_type,
          tab_angle=horiz_tab_angle);

    }
}



//*********************************************************

module pole_with_tabs_neg(width, pole_r, pole_thick, hole_diam, tab=false, tab_angle=0, gap=1){
  rotate(a=90, v=[0,1,0]){
    cylinder(h=width, r=pole_r+pole_thick);
  }

  if(tab==true){
    // screw hole in tab
    rotate(a=tab_angle, v=[1,0,0])
      translate([width/2,
                 0,
                 pole_r+(pole_thick)+hole_diam ]) {
        // tab gap
        cube([width*1.1, gap, (hole_diam*2)+(pole_thick*3)], center=true);
      }
  }
}


module pole_with_tabs(width, pole_r, pole_thick, hole_diam, hole_recess_diam, nut_type=6, tab_angle=0, gap=1){
  hole_r = hole_diam/2;
  difference(){
    union(){
      rotate(a=90, v=[0,1,0]){
        cylinder(h=width, r=(pole_r+pole_thick)*1.01);
      }

      // tab block
      hull(){
          
          //angled tab sides
          if (enable_angledtabs == 1){
            rotate(a=90, v=[0,1,0]){
              cylinder(h=width, r=(pole_r+pole_thick)*1.01);
            }
          }
        
        //tab
        rotate(a=wiretab_angle, v=[1,0,0])
          translate([width/2, 0, ((hole_recess_diam)+(pole_thick*2)+pole_r)/2]){
            cube([
              hole_recess_diam,
              (pole_thick*2)+5,
              (hole_recess_diam)+(pole_thick*2)+pole_r],
              center=true);
          }
        }
    }

    // pole hole
    translate([0-(width*0.5), 0, 0])
      rotate(a=90, v=[0,1,0]){
        cylinder(h=width*2.0, r=pole_r);
      }

    // screw hole in tab
    rotate(a=wiretab_angle, v=[1,0,0])
      translate([width/2,
                 0,
                 pole_r+(pole_thick)+(hole_recess_diam/2) ]) {

        // screw hole
        rotate(a=90, v=[1,0,0]){
          cylinder(h=pole_r*3, r=hole_r, center=true);

          //screw recesses
          translate([0, 0, 0+(pole_r/2)+(pole_thick+gap)]){
            cylinder(h=pole_r, r=hole_recess_diam/2, center=true);
          }
          
          // nut recess
          translate([0, 0, 0-(pole_r/2)-(pole_thick+gap)]){
            cylinder(h=pole_r, r=hole_recess_diam/2, center=true, $fn=nut_type);
          }
        }

        // tab gap
        cube([width*1.1, slot_gap, (hole_recess_diam*2)+(pole_thick*3)], center=true);
      }
  }

}
