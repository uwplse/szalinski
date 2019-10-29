$fn=50;
/*
Object Name: OpenSCAD earphone wrap for USB type-c
Author: Brian Khuu 2019

This is a design based from "iPhone 7 Earphone Wrap" by 80am33 https://www.thingiverse.com/thing:2161135

However it was redone to support a USB type-c plug instead. And also to be done in OpenSCAD to allow for easier modification by others in the future.

*/

/* [Earphone dimention specification] */

// Diameter of earphone handle
earphone_dia = 5;  

// Radius of cutout for headphone alignment
earphone_sit_r = 4;  

/* [Wrap Top/Bottom Cuts] */
uppercut  = 1;
bottomcut = 6;

/* [Wrap Spec] */

// Shell Thickness
shell_thickness = 1; 

// Seperation between wrapper earphone slots
sep = 15; 

/* calc h value based on wire estimated length 
est_wrap_count = 7; // Number of times you can wrap it around
est_hand_size = 65; // Size of your hand you are wrapping around
est_hand_thickness = 15; // Size of your hand you are wrapping around
desired_wrap_count = 15;

calc_wire_length = est_wrap_count*(2*est_hand_size+2*est_hand_thickness);
echo("<b>est wire length:</b>", calc_wire_length);

h = bottomcut + uppercut + (calc_wire_length/2)/desired_wrap_count;
*/

// Height of the earphone wrap
h = 60;

module typec_socket(outerdia, outerheight, sideshift, tol)
{
  typec_plugdia    = 2.5;
  typec_pluglength = 8.3;
  typec_plugdepth  = 6.5;
  plug_socket(
      typec_plugdia+tol, typec_pluglength+0.5+tol,typec_plugdepth+tol,
      outerdia, outerheight, outerdia/2 + sideshift+0.5+tol
    );
  
  echo("<b>usb type-c rim width:</b>", (outerdia - typec_plugdia)/2);
}

module plug_socket(plugdia, pluglength, plugdepth, outerdia, outerheight, sideshift)
{
  translate([0, -sideshift,0])
  difference()
  {
    union()
    {
      difference()
      {
        hull()
        {
          translate([0,(pluglength-plugdia)/2,0])
            cylinder(r = outerdia/2, outerheight);
          translate([0,-(pluglength-plugdia)/2,0])
            cylinder(r = outerdia/2, outerheight);
          
          /* Side Shift */
          translate([0,(pluglength-plugdia)/2 + sideshift,0])
            cylinder(r = outerdia/2, outerheight);
        }
      }
    }
    
    /* Socket Align cut */
    translate([0,0,outerheight])
      hull()
      {
        translate([0,(pluglength-plugdia)/2,0])
          cylinder(r=(outerdia/2), 1);
        translate([0,-(pluglength-plugdia)/2,0])
          cylinder(r=(outerdia/2), 1);
        translate([0,(pluglength-plugdia)/2,-1])
          cylinder(r=(plugdia/2), 1);
        translate([0,-(pluglength-plugdia)/2,-1])
          cylinder(r=(plugdia/2), 1);
      }

    /* Socket Cut */
    translate([0,0,outerheight-plugdepth])
      hull()
      {
        translate([0,(pluglength-plugdia)/2,0])
          cylinder(r=(plugdia/2), plugdepth+1);
        translate([0,-(pluglength-plugdia)/2,0])
          cylinder(r=(plugdia/2), plugdepth+1);
      }
    
    /* top wire wrap cut */
    difference()
    {
      hull()
      {
        translate([0,0,outerheight])
          cube( [outerdia+1, pluglength*2/3, 0.1], center=true);
        translate([0,0,outerheight-plugdepth+1])
          rotate([0,90,0])
            cylinder(r=1, outerdia, center=true);
      }
      
      if (0)
      rotate([0,0,180])
        translate([(outerheight+4)/2,0,(outerheight+2)/2])
          cube((outerheight+4), center=true); 
    }
  }
}

module earphone_wrap()
{
  total_case_radius = earphone_dia/2+shell_thickness;
  sidecut = earphone_dia + shell_thickness*2 + 1;

  calc_width = sep + total_case_radius*2;

  difference()
  {
    union()
    {
      translate([0,sep/2,0])
        cylinder(r = total_case_radius, h);
      translate([0,-sep/2,0])
        cylinder(r = total_case_radius, h);
      
      difference()
      {
        hull()
        {
          translate([0,sep/2,0])
            cylinder(r = total_case_radius, h);
          translate([0,-sep/2,0])
            cylinder(r = total_case_radius, h);
        }
        translate([(h+4)/2,0,(h+2)/2]) 
          cube((h+4), center=true); 

      }
      
      /* Socket */
      translate([0,-(sep + earphone_dia + shell_thickness*2)/2,0])
        typec_socket(
            earphone_dia+shell_thickness*2,
            10,
            (earphone_dia+shell_thickness*2)/2,
            0.1
          );
    }
    
    /* Earphone Hole */
    translate([0,sep/2,-1])
      cylinder(r=earphone_dia/2, h+2);
    translate([0,-sep/2,-1])
      cylinder(r=earphone_dia/2, h+2);
  
    /* Split Cut */
    hull()
    {
      translate([0,sep/2,-1])
        cylinder(r=earphone_dia/4, h+2);
      translate([0,-sep/2,-1])
        cylinder(r=earphone_dia/4, h+2);
    }
    
    /* bottom wire wrap cut */
    hull()
    {
      translate([0,0, bottomcut -sep/5 ])
        rotate([0,90,0])
          cylinder(r=sep/5, sidecut, center=true);
      cube( [sidecut, sep, 0.1], center=true);
    }
    
    /* top wire wrap cut */ 
    hull()
    {
      translate([0,0,h])
        cube( [sidecut, sep*2/3, 0.1], center=true);
      translate([0,0,h - uppercut + sep/5])
        rotate([0,90,0])
          cylinder(r=sep/5, sidecut, center=true);
    }
    
    /* earphone sit cut */
    translate([0,calc_width/2,h-1+earphone_sit_r/2])
      rotate([0,90,0])
        cylinder(r=earphone_sit_r, sidecut, center=true);
    translate([0,-calc_width/2,h-1+earphone_sit_r/2])
      rotate([0,90,0])
        cylinder(r=earphone_sit_r, sidecut, center=true);
  }
}


earphone_wrap();
xtotal = shell_thickness*2+earphone_dia;
echo("<b>x total:</b>", xtotal);
echo("<b>h:</b>", h);
