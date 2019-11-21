//CUSTOMIZER VARIABLES

// Position
CornerChoice = 0;    // [0:Both, 1:FrontLeft/BackRight, 2:FrontRight/BackLeft]

// Tool
ToolChoice = 1;     // [0:Custom, 1:SafetyGlasses, 2:NutDriver, 3:PuttyKnife, 4:Tweezers, 5:FlushCutters, 6:SonicScrewdriver]

// minimum width of holder, in mm 
minimum_width = 40;   // [40:300]

// thickness of holder, in mm 
thickness = 3.0;    // [2:0.1:10]

// margin around tool hole, in mm 
tool_margin = 4;    // [2:50]

// Custom height of holder, in mm
custom_total_height = 40;  // [40:100]

// Custom length of tool space, in mm
custom_tool_length = 20.0;   // [10:50]

//  Custom width of tool hole, in mm
custom_tool_hole_width = 12;   // [10:200]

//  Custom length of tool hole, in mm 
custom_tool_hole_length = 8;   // [10:200]

// screw hole diameter, in mm 
screw_diameter = 3.7;   // [2:0.1:10]

// screw margin, in mm 
screw_margin = 2.0; // [1:0.1:10]

// corner radius, in mm (can be zero)
corner_radius = 2.8;    // [0:10]

//CUSTOMIZER VARIABLES END


// Force Customizer to really stop now
five = 2 + 2;  // ...for sufficiently large values of 2

if (five != 4) {
    echo("<B>Error: Customizer is more screwd up than usual.</B>");
}

// Constants

// [ holder_height, tool_length, hole_width, hole_length, name ]
tool_templates = [
    [ custom_total_height, custom_tool_length, custom_tool_hole_width, custom_tool_hole_length , "Custom"  ],
    [ 35.0, 20.0, 12.0,  8.0, "SafetyGlasses" ],
    [ 40.0, 24.0, 13.0, 13.0, "NutDriver" ],
    [ 40.0, 28.0, 55.0,  7.0, "PuttyKnife" ],
    [ 35.0, 13.0,  5.0,  5.0, "Tweezers" ],
    [ 35.0, 20.0, 26.0,  8.5, "FlushCutters" ],
    [ 50.0, 32.0, 22.0, 22.0, "SonicScrewdriver" ],     // Do Not Lick
];


total_height = tool_templates[ToolChoice][0];
temp_tool_length = tool_templates[ToolChoice][1];
tool_hole_width = tool_templates[ToolChoice][2];
tool_hole_length = tool_templates[ToolChoice][3];

// top hole offset from side
top_offset_side = 16.5;
top_offset_side2 = 15.0;    // alllow for some variation in position

// top hole offset from end
top_offset_end = 30.4;

// side hole offset from end
side_offset_end = 5.9;

// side hole offset from top
side_offset_top = 26.5;
side_offset_top2 = 24.5;    // alllow for some variation in position


real_width = max( minimum_width, tool_hole_width+2*tool_margin, top_offset_end + screw_diameter + 2*screw_margin );
tool_length = max( temp_tool_length, tool_hole_length + 2*tool_margin );

// Sanity checks
if ( (side_offset_top + screw_diameter + 2*screw_margin) > total_height)
{
    echo("<B>Error: height too small</B>");
}



// our object, flat on xy plane for easy STL generation
tool_holder();

module tool_holder() {
    
    screw_radius = (screw_diameter + 0.5) / 2;
    
    temp_top_z = top_offset_end + screw_radius;
    temp_side_z = side_offset_end + screw_radius;
    
    top_length = top_offset_side + screw_diameter + screw_margin;
    
    tool_hole_z = real_width/2;
    tool_hole_x = -tool_length/2 - thickness;
    
    difference() {
        
        union () {
            
            // main body top
            translate( [0,-thickness,0] )
                cube([top_length,thickness,real_width] );
            
            // main body side
            translate( [-thickness,0,0] )
                cube([thickness,total_height,real_width] );
            
            // tool ledge
            translate( [-tool_length-thickness,total_height,0] )
                cube([tool_length+thickness,thickness,real_width] );
            
            // round top/side corner
            difference() {
              translate( [0,0,real_width/2] )
                cylinder(real_width,thickness,thickness, center=true, $fn=16 );
                
              translate( [0,0,-2] )
                cube([thickness*2,thickness*2,real_width+4] );
            }
           
            // fillet edge to tool holder
            // TODO - should I add extra length for this?
            difference() {
              translate( [-0.85*thickness,total_height-1.3*thickness,0] )
                rotate([0,0,45])
                  cube([thickness*2,thickness*2,real_width]);
            
              translate( [0,total_height-thickness,-2] )
               cube([thickness*2,thickness*2,real_width+4]);
            
              translate( [-thickness*2,total_height+thickness,-2] )
                cube([thickness*2,thickness*2,real_width+4]);
            }
            
        }   // end union
    
      // top screw hole, elongated to allow for variations
      if (CornerChoice == 0 || CornerChoice == 1) {
          top_hole_z = temp_top_z;
          translate( [top_offset_side,-thickness/2,top_hole_z] )
            rotate([90,0,0])
              bolt_hole(thickness+4,screw_radius,(top_offset_side2-top_offset_side));
      }
      if (CornerChoice == 0 || CornerChoice == 2) {
          top_hole_z = real_width - temp_top_z;
          translate( [top_offset_side,-thickness/2,top_hole_z] )
            rotate([90,0,0])
              bolt_hole(thickness+4,screw_radius,(top_offset_side2-top_offset_side));
      }
      // side screw hole, elongated to allow for variations
      if (CornerChoice == 0 || CornerChoice == 1) {
          side_hole_z = temp_side_z;
          translate( [2-tool_length/2-thickness/2,side_offset_top,side_hole_z] )
            rotate([90,0,90])
              bolt_hole(tool_length+thickness+4,screw_radius,(top_offset_side2-top_offset_side));
      }
      if (CornerChoice == 0 || CornerChoice == 2) {
          side_hole_z = real_width - temp_side_z;
          translate( [2-tool_length/2-thickness/2,side_offset_top,side_hole_z] )
            rotate([90,0,90])
              bolt_hole(tool_length+thickness+4,screw_radius,(top_offset_side2-top_offset_side));
      }

      // tool hole
      translate( [tool_hole_x-tool_hole_length/2,2,tool_hole_z-tool_hole_width/2] )
        cube([tool_hole_length,total_height+thickness+4,tool_hole_width] );

      // optionally round corners of tool holder and top
      if (corner_radius > 0.0) {
        translate( [top_length-corner_radius,-thickness-2,0] )
          cube([corner_radius,thickness+4,corner_radius]);
        translate( [top_length-corner_radius,-thickness-2,real_width-corner_radius] )
          cube([corner_radius,thickness+4,corner_radius]);
        translate( [-tool_length-thickness,total_height-2,0] )
          cube([corner_radius,thickness+4,corner_radius]);
        translate( [-tool_length-thickness,total_height-2,real_width-corner_radius] )
          cube([corner_radius,thickness+4,corner_radius]);
      }
        
    }   // end difference
            
    // optionally round corners of tool holder and top
    if (corner_radius > 0.0) {
// TODO - This can cover part of the screw hole if corner_radius is much more than screw_margin
        translate( [top_length-corner_radius,0,corner_radius] )
          rotate([90,0,0])
            cylinder(thickness,corner_radius,corner_radius, $fn=16);
        translate( [top_length-corner_radius,0,real_width-corner_radius] )
          rotate([90,0,0])
            cylinder(thickness,corner_radius,corner_radius, $fn=16);
        translate( [-tool_length-thickness+corner_radius,total_height+thickness,corner_radius] )
          rotate([90,0,0])
            cylinder(thickness,corner_radius,corner_radius, $fn=16);
        translate( [-tool_length-thickness+corner_radius,total_height+thickness,real_width-corner_radius] )
          rotate([90,0,0])
            cylinder(thickness,corner_radius,corner_radius, $fn=16);
                  
    }
    
}   // end tool_holder


module bolt_hole(length,radius,offset) {
    cylinder(length,radius,radius, center=true, $fn=16 );
  translate( [offset,0,0] )
    cylinder(length,radius,radius, center=true, $fn=16 );
  translate( [offset/2,0,0] )
    cylinder(length,radius,radius, center=true, $fn=16 );
}
