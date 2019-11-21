// Modification and fixes to http://www.thingiverse.com/thing:30491

// TODO - separate bolt and nut sizes for rail and rod clamps?

//CUSTOMIZER VARIABLES

/* [Basic_Parameters] */

// Support rod diameter, in mm
rod_diameter= 8.0;  // [3:0.1:40]

// Bolt diameter, in mm
bolt_diameter= 3.0;    // [2:0.1:20]

// Nut diameter, in mm
nut_diameter= 6.0;  // [3:0.1:40]

// Nut thickness, in mm
nut_thickness= 2.8;  // [2:0.1:30]

/* [Extra_Features_for_Strength] */

// rod clamp width margin, in mm
clamp_margin= 5;   // [3:30]

// margin to support the rod in xy, in mm
rod_margin= 7; // [3:30]

// margin to support the rod in z, in mm
depth_margin= 5;   // [3:30]

// Openbeam size, in mm
openrail_size= 15;   // [10:50]

//CUSTOMIZER VARIABLES END


// how much extra space to allow in nut trap
nut_space_factor = 1.2;


// Sanity checks
if( rod_diameter <= 0 || bolt_diameter <= 0 
    || nut_diameter <= 0 || nut_thickness <= 0 )
{
    echo("<B>Error: Missing important parameters</B>");
}

if(nut_diameter<=bolt_diameter)
{
    echo("<B>Error: Nut size too small for bolt</B>");
}

// z depth
main_depth= max( 10, max(rod_diameter,bolt_diameter,nut_diameter)+depth_margin );

nut_trap_len = nut_thickness*nut_space_factor;

// our object, translated to be flat on xy plane for easy STL generation
translate([0,0,main_depth/2])
    optics_rail();

module optics_rail(){
        
    main_width= (openrail_size+1)+(rod_diameter+rod_margin)+clamp_margin+nut_thickness;
    main_height= (openrail_size+1)+(nut_trap_len+clamp_margin);
    bolt_rad= (bolt_diameter+1)/2;  // this should be sorta loose
    rod_rad= (rod_diameter+0.5)/2;  // should be almost tight
    rod_x= ((openrail_size+1)/2)+(rod_rad+1) + rod_margin/2;
    nut_x= rod_x + rod_rad + (clamp_margin/2);

    difference(){

        // the main block
        translate([(main_width-openrail_size)/2,-(main_height/2)+(openrail_size/2),0])
            cube([main_width,main_height,main_depth],center = true);
    
        // subtract the space used by the openbeam
        openrail_model();
    
        // nut and bolt hole for attaching to beam
        trap_y = -(main_height-((openrail_size+1)/2)) + nut_trap_len + clamp_margin/2;
        translate([0,trap_y,0])
            rotate([0,0,0])
                nuttrap();
        translate([0,-3,0])
          rotate([90,0,0])
            cylinder(100,bolt_rad,bolt_rad);
    
        // nut and bolt hole for clamping the rod
        trap2_y = -(main_height-(openrail_size/2)) + (nut_diameter+1)/2 + clamp_margin/2;
        translate([nut_x,trap2_y,0]) 
            rotate([0,0,90])
                nuttrap();
        translate([rod_x,trap2_y,0])
            rotate([0,90,0])
                cylinder(100,bolt_rad,bolt_rad);
    
        // the support rod
        #translate([rod_x,0,0])
            rotate([90,0,0])
               cylinder(main_height+10,rod_rad,rod_rad);
    }
}


module openrail_model(){
  difference(){
    cube([openrail_size, openrail_size, main_depth+5], center = true);
   translate([openrail_size/3,0,0])
      cube([openrail_size/3,bolt_diameter,main_depth+2], center = true);
  }
}

module hexagon(height,radius) 
{
  linear_extrude(height=height)
    circle(r=radius,$fn=6);
}

module nuttrap(){
  translate([0,-nut_trap_len/2,main_depth/2])
    cube([nut_diameter,nut_trap_len,main_depth],center =true);
  rotate([90,360/12,0]) // so point is down, trapped by straight sides
    hexagon(nut_trap_len,(nut_diameter+1)/2);
}
