// TODO - hollow for SLA printing?

// Number of columns
columns = 6;   // [1:1:100]

// Number of rows
rows = 6;   // [1:1:100]

// item diameter (plus a little margin), in mm
diam = 13.5;    // [1:0.1:100]
// Sharpee = 12.5mm base, 13.1mm cap, 82mm length of base           Was 12.7!
// fountain pens = 11.8 - 12.5mm, 70-85mm length of base
// Cameo pens = 13.9mm (uncovered) - 15.5mm (covered), 36mm length covered, 16.5mm cap, 17.7mm flanges (16mm hole, >2 mm walls)

// Minimum Depth of holders, in mm
depth = 50; // [1:1:100]

// Wall thickness, in mm
wall_thickness = 2.0;    // [0.5:0.1:20]

// Vertical step height per row (can be zero), in mm
rowVStep = 3.0;  // [0:0.1:50]

// Vertical step height per col (can be zero), in mm
colVStep = 2.0;  // [0:0.1:50]

// Thickness of bottom layer, in mm
base_height = 1.5;  // [0:0.1:40]

// Outset of base (can be zero), in mm
base_outset = 0.0;    // [0:0.1:50]

// Stagger rows, boolean
stagger = 1;     // [0:false, 1:true]

// Add drain holes (must for SLA), boolean
drainHoles = 1;     // [0:false, 1:true]

// Drain diameter, in mm
drainDiameter = 2.0;    // [0.2:0.1:10]

// Number of sides for the cylinders
quality = 100;  // [ 50:Draft, 100:Medium, 250:High, 600:Extreme, 2000:Insane ]



outer_diameter = diam + 2*wall_thickness;
outer_radius = outer_diameter/2;
inner_diameter = diam;
inner_radius = inner_diameter/2;

hypot = diam + wall_thickness;
vstep = hypot*sin(60);
hoffset = hypot*cos(60);
//echo("hoffset = ", hoffset, " rowHalf = ", inner_radius+wall_thickness/2 );   // they should be equal
rowStep = ( (stagger == 1) ? vstep : (diam + wall_thickness) );
colStep = diam + wall_thickness;

fullSize = [ columns*colStep+wall_thickness+2*base_outset+((stagger == 1)?hoffset:0),
             rows*rowStep+wall_thickness+2*base_outset+((stagger == 1)?wall_thickness:0),
             base_height+depth+((rows-1)*rowVStep)+((columns-1)*colVStep) ];

echo( "holder size is ", fullSize );

difference() {

    for (y = [0:(rows-1)]) {
      odd = ((y % 2) == 1);
      offset = (stagger && odd) ? hoffset : 0;
       
      for (x = [0:(columns-1)]) {
        translate([x*colStep+offset,y*rowStep,0])
            difference() {
              union () {
                cylinder( (y*rowVStep)+(x*colVStep)+depth+base_height, outer_radius, outer_radius, $fn=quality );
                // optional base outset
                if (base_outset > 0) {
                  cylinder( base_height, outer_radius+base_outset, outer_radius+base_outset, $fn=quality );
                }
                // fill small gaps if staggered
                if (stagger && y < (rows-1) ) {
                    if (x < (columns-1)) {
                      translate([hoffset,rowStep-inner_radius-wall_thickness,0]) 
                        cylinder( (y*rowVStep)+(x*colVStep)+depth+base_height, wall_thickness/2, wall_thickness/2, $fn=30 );
                    }
                    if ( ((odd==true) && (x < (columns-1))) || ((odd==false) && (x > 0)) ) {
                      translate([0,outer_radius,0]) 
                        cylinder( (y*rowVStep)+(x*colVStep)+depth+base_height, wall_thickness/2, wall_thickness/2, $fn=30 );
                    }
                }
              }  // end union
              translate([0,0,base_height])
                cylinder((y*rowVStep)+(x*colVStep)+depth+base_height+2, inner_radius,inner_radius, $fn=quality );
            } // end difference
      }   // end column
    }   // end row
    
    
    if (drainHoles) {
      drainRadius = drainDiameter/2;
      drainOffset = inner_radius/2;
      
      for (y = [0:(rows-1)]) {
        translate([-outer_radius-base_outset,y*rowStep,base_height+drainRadius])
          rotate([0,90,0])
            cylinder(fullSize[0]+2, drainRadius,drainRadius, $fn=50);
      }
      
      for (x = [0:(columns)]) {
        if (stagger) {
          translate([x*colStep+drainOffset,-outer_radius-base_outset-1,base_height+drainRadius])
            rotate([-90,0,0])
              cylinder(fullSize[1]+2, drainRadius,drainRadius, $fn=50);
          translate([x*colStep-drainOffset,-outer_radius-base_outset-1,base_height+drainRadius])
            rotate([-90,0,0])
              cylinder(fullSize[1]+2, drainRadius,drainRadius, $fn=50);
        } else {
          translate([x*colStep,-outer_radius-base_outset,base_height+drainRadius])
            rotate([-90,0,0])
              cylinder(fullSize[1]+2, drainRadius,drainRadius, $fn=50);
        }
      }   // end column
        
    }  // end drain holes

}   // end difference