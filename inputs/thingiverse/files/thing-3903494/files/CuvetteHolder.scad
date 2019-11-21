// TODO - hollow for SLA printing?  Not easy.
// 10x10 largest for 200mm FDM printer
// 5x2 largest for 120x70mm SLA   (5x3 no outset - cuts it too close)

// Number of columns
columns = 5;   // [1:1:100]

// Number of rows
rows = 4;   // [1:1:100]

// item diameter (plus a little margin), in mm
diam = 13.3;    // [1:0.1:100]
// standard = 12.5, but some run large: 12.75) and don't want it too tight -- 13.0 was too small for FDM errors

// Minimum Depth of holders, in mm
depth = 20; // [1:1:100]

// Wall thickness, in mm
wall_thickness = 5.0;    // [0.5:0.1:20]

// Thickness of bottom layer, in mm
base_height = 1.5;  // [0:0.1:40]

// Outset of base (can be zero), in mm
base_outset = 4.0;    // [0:0.1:50]

// Stagger rows, boolean
stagger = 1;     // [0:false, 1:true]

// Add drain holes (must for SLA, reduces vacuum), boolean
drainHoles = 1;     // [0:false, 1:true]

// Drain diameter, in mm
drainDiameter = 2.0;    // [0.2:0.1:10]



outer_diameter = diam + 2*wall_thickness;
outer_radius = outer_diameter/2;
inner_diameter = diam;
inner_radius = inner_diameter/2;

hypot = diam + wall_thickness;
vstep = hypot;
hoffset = hypot/3;
rowStep = ( (stagger == 1) ? vstep : (diam + wall_thickness) );
colStep = diam + wall_thickness;

fullSize = [ columns*colStep+wall_thickness+2*base_outset+((stagger == 1)?hoffset:0),
             rows*rowStep+wall_thickness+2*base_outset+((stagger == 1)?wall_thickness:0),
             base_height+depth ];

echo( "holder size is ", fullSize );

difference() {

    for (y = [0:(rows-1)]) {
      odd = ((y % 2) == 1);
      offset = (stagger && odd) ? hoffset : 0;
      
      for (x = [0:(columns-1)]) {
        translate([x*colStep+offset,y*rowStep,0])
            difference() {
              union () {
                translate([-outer_diameter/2,-outer_diameter/2,base_height])
                    cube( [outer_diameter,outer_diameter,depth+base_height]);
                // base and optional base outset -- could do this per-row instead
                translate([-(outer_diameter+2*base_outset)/2,-(outer_diameter+2*base_outset)/2,0])
                    cube( [outer_diameter+2*base_outset,outer_diameter+2*base_outset,base_height]  );
              }  // end union
              translate([-inner_diameter/2,-inner_diameter/2,base_height])
                cube( [inner_diameter,inner_diameter,depth+base_height+2] );
            } // end difference
      }   // end column
    }   // end row
    
    
    if (drainHoles) {
      drainRadius = drainDiameter/2;
      drainOffset = inner_radius/2;
      
      for (y = [0:(rows-1)]) {
        translate([-outer_radius-base_outset,y*rowStep,base_height+drainRadius])
          rotate([0,90,0])
            cylinder(fullSize[0]+2, drainRadius,drainRadius, $fn=20);
      }
      
      for (x = [0:(columns)]) {
        if (stagger) {
          translate([x*colStep+drainOffset,-outer_radius-base_outset-1,base_height+drainRadius])
            rotate([-90,0,0])
              cylinder(fullSize[1]+2, drainRadius,drainRadius, $fn=20);
        } else {
          translate([x*colStep,-outer_radius-base_outset,base_height+drainRadius])
            rotate([-90,0,0])
              cylinder(fullSize[1]+2, drainRadius,drainRadius, $fn=20);
        }
      }   // end column
        
    }  // end drain holes

}   // end difference