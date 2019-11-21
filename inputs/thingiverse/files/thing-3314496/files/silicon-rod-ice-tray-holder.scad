// Silicon Square Ice Tray Holder
// This helps stiffen up a silicon ice tray, so it can be placed into the fridge more easily.
// Author: Brian Khuu (2018)
tol = 2; //mm

/* Tray Holder Spec */
tray_holder_thickness = 1;// Thickness of this object
tray_holder_cell_count = 7; // Number of cells to hold up

/* Silicon Tray Spec */
gap_l = 10; // Gap Above Each Cell (mm)
gap_w = 7;  // Gap Between Cells (mm)
ice_w = 17; // Ice Cell Width (mm)
ice_l = 75; // Ice Cell Length (mm)
ice_h = 20; // Ice Cell Height (mm)
silicon_thickness= 3; // Silicon Thickness (mm)

/* Reference Model Enable/Disable */
enable_reference_model = false;
if(enable_reference_model)
translate([0,0,silicon_thickness])
union()
{
  // Ice Hole
  for(i = [0:1:3])
    %translate([i*(ice_w+gap_w),0,-ice_h/2])  cube([ice_w, ice_l, ice_h], center=true);

  // Gap Check
  for(i = [-1:1:3])
    %translate([i*(ice_w+gap_w) + (ice_w+gap_w)/2,0,silicon_thickness/2]) color([0.5,0.5,1]) cube([gap_w, ice_l,silicon_thickness], center=true);
  
  // Side
  %translate([30,ice_l/2+gap_l/2,silicon_thickness/2]) color([0.5,0.5,1]) cube([100, gap_l, silicon_thickness], center=true);
  %translate([30,-(ice_l/2+gap_l/2),silicon_thickness/2]) color([0.5,0.5,1]) cube([100, gap_l, silicon_thickness], center=true);
}

module ice_holder_shape(i)
{ 
  translate([i*(ice_w+gap_w)+(ice_w+gap_w)/2,0,0])
  linear_extrude(height = tray_holder_thickness)
    offset(delta=gap_w/2)
      square([ice_w, ice_l], center=true);
}

module ice_holder_hole(i)
{ 
  translate([i*(ice_w+gap_w)+(ice_w+gap_w)/2,0,-1])
  linear_extrude(height = tray_holder_thickness+2)
    offset(tol)
      square([ice_w, ice_l], center=true);
}

module ice_holder(count)
{
  union()
  {
    // Holder
    difference()
    {
      union()
      {
        // Body
        for ( i = [0:1:count-1] )
          ice_holder_shape(i);
        
        // Side
        translate([count*(ice_w+gap_w)/2, ice_l/2+gap_l/2, tray_holder_thickness/2]) 
          cube([count*(ice_w+gap_w), gap_l+tray_holder_thickness*2, tray_holder_thickness], center=true);
        translate([count*(ice_w+gap_w)/2, -(ice_l/2+gap_l/2), tray_holder_thickness/2]) 
          cube([count*(ice_w+gap_w), gap_l+tray_holder_thickness*2, tray_holder_thickness], center=true);
      }
      for ( i = [0:1:count] )
        ice_holder_hole(i);
    }
    
    // Handle
    translate([0,(ice_l)/2+gap_l,0])
      union()
      {
        translate([0,tray_holder_thickness/2,2*silicon_thickness], $fn=40)
          rotate([0,90,0])
            cylinder(count*(ice_w+gap_w),r=tray_holder_thickness*4/3);
        cube([count*(ice_w+gap_w),tray_holder_thickness,2*silicon_thickness]);
      }
    translate([0,-((ice_l)/2+gap_l)-tray_holder_thickness,0])
      union()
      {
        translate([0,tray_holder_thickness/2,2*silicon_thickness], $fn=40)
          rotate([0,90,0])
            cylinder(count*(ice_w+gap_w),r=tray_holder_thickness*4/3);
        cube([count*(ice_w+gap_w),tray_holder_thickness,2*silicon_thickness]);
      }
  }
}

ice_holder(tray_holder_cell_count);