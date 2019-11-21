// Parametric fan design by Jason Frazier (neveroddoreven)
// Remixed from non-parametric design by MiseryBot at http://www.thingiverse.com/thing:8063
// Case size selections inspired by https://en.wikipedia.org/wiki/Computer_fan

//=======================================================================================  
/* [Global] */
// Fan length/width in mm
$housing_side=60; // [8,17,20,25,30,35,38,40,45,50,60,70,80,90,92,100,110,120,130,140,150,250,360]
// Fan thickness in mm
$housing_height=25; // [5,7,10,15,20,25,30,38]
// Default 0.144, adjust based on housing size
$housing_mount_tab_thickness_ratio=$housing_height*0.144; // [0.1,0.12,0.144,0.2,0.25]
// Default 7
$fan_blade_count=7; // [1,2,3,4,5,6,7,8,9,10,11,12,13,15,17,19]
// Default 0.583333
$fan_blade_twist_ratio=0.58; // [0.145:0.145:1.45]
// Default right hand twist
$fan_blade_direction=-1; // [-1:Right hand twist, 1:Left hand twist]
// Default 0.525
$hub_diameter_to_housing_ratio=0.525; // [0.15:0.125:0.9]
//default 3.4 for an M3 screw, these values are a made-up WIP
$mount_hole_diameter=3.4; // [2.4:M2, 2.9:M2.5, 3.4:M3, 4.4:M4, 5.4:M5, 6.4:M6, 8.4:M8]

/* [Hidden] */
// leave these be unless you know what you're doing
$housing_inner_diameter=$housing_side*0.95;
$housing_corner_radii1=$housing_side*0.081667;
$housing_corner_radii2=$housing_side*0.083333;
$housing_corner_radii3=$housing_side*0.085;
$housing_corner_radii4=$housing_side*0.001667;
$housing_outer_diameter=$housing_side*1.066667;
$hub_diameter=$housing_side*$hub_diameter_to_housing_ratio;
$mount_hole_offset=$housing_side*0.416667;
$fan_blade_recess=0.5;
$fan_blade_twist=360/$fan_blade_count*$fan_blade_twist_ratio;
//$fn=60;  //Working
$fn=720;  //Show off

module fan_parametric()
  {
  difference()
    {
    linear_extrude(height=$housing_height, center = true, convexity = 4, twist = 0)
      difference()
        {
        //overall outside
        square([$housing_side,$housing_side],center=true);
        //main inside bore, less hub
        difference()
          {
          circle(r=$housing_inner_diameter/2,center=true);
          //hub. Just imagine the blades, OK?
          circle(r=$hub_diameter/2,center=true);
          }
        //Mounting holes
        translate([$mount_hole_offset,$mount_hole_offset]) circle(r=$mount_hole_diameter/2,h=$mount_hole_offset+0.2,center=true);
        translate([$mount_hole_offset,-$mount_hole_offset]) circle(r=$mount_hole_diameter/2,h=$mount_hole_offset+0.2,center=true);
        translate([-$mount_hole_offset,$mount_hole_offset]) circle(r=$mount_hole_diameter/2,h=$mount_hole_offset+0.2,center=true);
        translate([-$mount_hole_offset,-$mount_hole_offset]) circle(r=$mount_hole_diameter/2,h=$mount_hole_offset+0.2,center=true);
        //Outside Radii
        translate([$housing_side/2,$housing_side/2]) difference()
          {
          translate([-$housing_corner_radii1,-$housing_corner_radii1]) square([$housing_corner_radii3,$housing_corner_radii3]);
          translate([-$housing_corner_radii2,-$housing_corner_radii2]) circle(r=$housing_corner_radii2);
          }
        translate([$housing_side/2,-$housing_side/2]) difference()
          {
          translate([-$housing_corner_radii1,-$housing_corner_radii4]) square([$housing_corner_radii3,$housing_corner_radii3]);
          translate([-$housing_corner_radii2,$housing_corner_radii2]) circle(r=$housing_corner_radii2);
          }
        translate([-$housing_side/2,$housing_side/2]) difference()
          {
          translate([-$housing_corner_radii4,-$housing_corner_radii1]) square([$housing_corner_radii3,$housing_corner_radii3]);
          translate([$housing_corner_radii2,-$housing_corner_radii2]) circle(r=$housing_corner_radii2);
          }
        translate([-$housing_side/2,-$housing_side/2]) difference()
          {
          translate([-$housing_corner_radii4,-$housing_corner_radii4]) square([$housing_corner_radii2+$housing_corner_radii4,$housing_corner_radii2+$housing_corner_radii4]);
          translate([$housing_corner_radii2,$housing_corner_radii2]) circle(r=$housing_corner_radii2);
          }
      } //linear extrude and 2-d difference
    //Remove outside ring
    difference()
      {
      cylinder(r=$housing_outer_diameter,h=$housing_height-$housing_mount_tab_thickness_ratio-$housing_mount_tab_thickness_ratio,center=true);
      cylinder(r=$housing_outer_diameter/2,h=$housing_height-$housing_mount_tab_thickness_ratio-$housing_mount_tab_thickness_ratio+0.2,center=true);
      }      
    }// 3-d difference

    //Seven Blades
    linear_extrude(height=$housing_height-($fan_blade_recess*2), center = true, convexity = 4, twist = $fan_blade_twist*$fan_blade_direction)
      for(i=[0:$fan_blade_count-1])
        rotate((360*i)/$fan_blade_count)
          translate([0,-1.5/2]) #square([$housing_inner_diameter/2-0.75,1.5]);
  }
//=======================================================================================  
fan_parametric();
//=======================================================================================  
