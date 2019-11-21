//CUSTOMIZER VARIABLES

// Number of wires of the ribbon cable
wire_count = 40; //  [0:100]

// Width of the ribbon cable, mm
wire_width = 20; //  [0:200]

// Depth of the clip, mm
clip_depth = 15; //  [0:30]

// Top thickness, mm
top_thickness = 1.2; //  [0:10]

// Bottom thickness, mm
bottom_thickness = 4; // [0:10]

wire_tol = 0.1; //  [0:.01:1]

// Screw shaft diameter, mm
screw_diam = 3.2;

// Screw head diameter, mm
screw_head_diam = 7.5;

// Screw head depth, mm
screw_head_depth = 3.4;


//CUSTOMIZER VARIABLES END


module ribbonCableClip(wireCount, cableWidth, depth)
{
  wireSpacing = cableWidth / wireCount;
  wireDiameter = wireSpacing*(1 + wire_tol);
  wireToothSpace = sqrt(wireDiameter*wireDiameter - wireSpacing*wireSpacing);
  wireToothDepth = (wireDiameter - wireToothSpace)/2;
  total_thickness = top_thickness + bottom_thickness + wireDiameter;
  
    translate([0,0,clip_depth/2]) {
    
  difference()
  {
    union()
    {
        translate([0, wireDiameter/4+top_thickness/2, 0]) {
          cube([cableWidth, wireDiameter/2+top_thickness, depth], center=true);
        }
        translate([0, -wireDiameter/4-bottom_thickness/2, 0]) {
          cube([cableWidth, wireDiameter/2+bottom_thickness, depth], center=true);
        }
      translate([-cableWidth/2,(top_thickness-bottom_thickness)/2,0]) {
          cylinder(d=wireDiameter+top_thickness+bottom_thickness, h=depth, center=true, $fn=50);
      }
      translate([(cableWidth)/2,wireToothSpace/2+(wireToothDepth+top_thickness)/2,0]) {
          cylinder(d=wireToothDepth+top_thickness, h=depth, center=true, $fn=50);
      }
      translate([(cableWidth)/2,-(wireToothSpace/2+(wireToothDepth+bottom_thickness)/2),0]) {
          cylinder(d=wireToothDepth+bottom_thickness, h=depth, center=true, $fn=50);
      }
    }

    union() {
        for(i=[0:1:wireCount-1])
        {
          translate([(wireSpacing-cableWidth)/2+i*wireSpacing,0,0]) cylinder(d=wireDiameter, h=depth+2, center=true, $fn=25);
        }
        
        rotate(a = [-90,0,0]) {
            cylinder(d=screw_diam, h=4*(2*total_thickness), center = true, $fn=50);
            cylinder(d=screw_head_diam*1.2, h=2*(2*total_thickness), center = false, $fn=50);
            translate([0, 0, -wireDiameter/2]) {
                cylinder(d=screw_head_diam, h=2*(2*total_thickness), center = false, $fn=50);
            }
            translate([0, 0, -screw_head_depth-wireDiameter/2]) {
                cylinder(h=screw_head_depth*1.01, r1=screw_diam/2, r2=screw_head_diam/2, center=false, $fn=25);            
            }
        }
    
    }
  }
  }
}

// Ribbon cable with 18 wires a width of 22.7mm
//ribbonCableClip(18, 22.7, 10);



ribbonCableClip(wire_count, wire_width, clip_depth);
