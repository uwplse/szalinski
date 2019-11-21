// NOTE - some SLA resins shrink after curing, so measure actual prints before using as rulers!

//CUSTOMIZER VARIABLES

/* [Basic_Parameters] */

// number of items horizontally
horizontal = 2;  // [1:16]

// number of items vertically
vertical = 2;  // [1:16]

// diameter of each item, in mm
diameter = 20;  // [10:100]

// space between each item, in mm
space = 2;  // [0.1:0.1:10]

// depth of base, in mm
base_thickness = 1.0;  // [0.1:0.1:10]

// depth of text, rulers, and markers, in mm
detail_thickness = 1.0;  // [0.1:0.1:10]

// spacing of ruler marks (low rez printers need more spacing), in mm
ruler_spacing = 2;   // [1:10]
// 2mm min for FDM, but some SLA can do 1mm with 0.5mm walls


// use text for identification, boolean
use_text = 1;    // [0:false, 1:true]

// starting letter, for printing multiple sheets
letter_start = 0;   // [0:100]

// use ruler marks, boolean
use_rulers = 1;    // [0:false, 1:true]

// add markers and ruler on edges, boolean
use_side_markers = 1;   // [0:false, 1:true]


// number of connectors between each item to make a sheet (SLA may need more connectors)
sprue= 1;   // [0:20]

// connection thickness, in mm
sprue_thickness= 1.0;  // [0.1:0.1:10]


// minimum wall/feature size for some picky printers, in mm
wall_minimum = 0.7; // [0.2:0.1:2.0]
// some SLA and FDM can do 0.5mm, but SLS nylon needs 0.7mm


//CUSTOMIZER VARIABLES END



// Sanity checks
if ( ruler_spacing <= wall_minimum)
{
    echo("<B>Error: ruler marks run together</B>");
}

if ( (sprue*2) > (diameter - 2))
{
    echo("<B>Error: too many sprue for size</B>");
}


// our object, flat on xy plane for easy STL generation
fiducials();


module fiducials() {
    
    spacing = diameter + space;
    radius = diameter / 2;
    inner_square_side = diameter / sqrt(2.0);
    inner_square_radius = inner_square_side / 2;
    
    sprue_depth = min( base_thickness, sprue_thickness );
    sprue_overlap = diameter; // be safe
    sprue_overlap_half = sprue_overlap / 2;

    square_width = max( 1.0, wall_minimum );
    mark_length = max( 1.0, wall_minimum );

    // side marker feature size, in mm
    side_marker_size = diameter / 21;   // 1.2mm, diameter / 21  ??     TODO - helpful if this was a known value!
    fudge_spacing = diameter / 25;
    
    
    for (y = [ 0 : 1 : (vertical-1) ]) {
      for (x = [ 0 : 1 : (horizontal-1) ]) {
        
        // create sprue as needed
        if (sprue > 0) {
            if (x > 0) {
                for (n = [ 0 : 1 : (sprue-1) ]) {
                    d = (n%2) * 2 - 1; 
                    o = ceil( n / 2 );
                    yoff = d * o * (1 + sprue_thickness );
                    translate([x*spacing-radius-space-sprue_overlap_half,y*spacing-yoff-sprue_thickness/2,0])
                        cube([space+sprue_overlap,sprue_thickness,sprue_depth]);
                }
            }
            if (y > 0) {
                for (n = [ 0 : 1 : (sprue-1) ]) {
                    d = (n%2) * 2 - 1; 
                    o = ceil( n / 2 );
                    xoff = d * o * (1 + sprue_thickness );
                    translate([x*spacing-xoff-sprue_thickness/2,y*spacing-radius-space-sprue_overlap_half,0])
                        cube([sprue_thickness,space+sprue_overlap,sprue_depth]);
                }
            }
        }   // end sprue


        // body/base
        translate([x*spacing, y*spacing, 0])
            cylinder(base_thickness, radius, radius, $fn=120);
        
        // two sides of inscribed square, with ruler marks
 color("red")
        {
        square_side = inner_square_side;
        translate([x*spacing-inner_square_radius,y*spacing-inner_square_radius,base_thickness])
            cube([square_width,square_side,detail_thickness] );
        translate([x*spacing-square_side/2,y*spacing+inner_square_radius-1,base_thickness])
            cube([square_side,square_width,detail_thickness] );
        }

color("red")
        if (use_rulers) {
            // ruler marks horizontal
            yy_end = y*spacing + inner_square_radius - 1 - (mark_length/2);
            ruler1_start = -inner_square_radius + square_width;
            ruler1_end = inner_square_radius;
            for (k = [ ruler1_start : ruler_spacing : ruler1_end ]) {
                translate([x*spacing+k,yy_end,base_thickness+detail_thickness/2])
                    cube([wall_minimum,mark_length,detail_thickness], center=true );
            }
            
            // ruler marks vertical
            xx_start = x*spacing - inner_square_radius + square_width + (mark_length/2);
            ruler2_start = -inner_square_radius;
            ruler2_end = inner_square_radius - 1;
            ruler2_spacing = ruler_spacing;  // minimum resolvable on FDM
            for (k = [ ruler2_end : -ruler_spacing : ruler2_start ]) {
                translate([xx_start,y*spacing+k,base_thickness+detail_thickness/2])
                    cube([mark_length,wall_minimum,detail_thickness], center=true );
            }
        }   // end use rulers


        // text or squares marking center
 color("green")
        if (use_text) {
            // number/letter from list
            index = (y * horizontal + x + letter_start) % letter_count;
            translate([x*spacing+fudge_spacing,y*spacing-fudge_spacing,base_thickness])
                linear_extrude(detail_thickness)
                    text(letters[index],
                         size=inner_square_side - 5*fudge_spacing,  // W, Q runs into sides, j, y may run into bottom details
                         font="Liberation Mono", // "Liberation Sans" "Bitstream Vera Sans" -- both have ambiguous 0,O and I,l
                         halign="center",
                         valign="center");
       } else {
           width = inner_square_side / 3;
           translate([x*spacing-width/2,y*spacing-width/2,base_thickness+detail_thickness/2])
               cube([width,width,detail_thickness], center=true );
           translate([x*spacing+width/2,y*spacing+width/2,base_thickness+detail_thickness/2])
               cube([width,width,detail_thickness], center=true );
       }

 
 color("yellow")
        if (use_side_markers) {
            
            edge_offset = ((radius + inner_square_radius) / 2);
            
            // one triangle
            translate([x*spacing,y*spacing+edge_offset,base_thickness+detail_thickness/2])
                cylinder(1, side_marker_size, side_marker_size, center=true, $fn=3 );
            
            // two cylinders
            translate([x*spacing+edge_offset,y*spacing-1.5*side_marker_size,base_thickness+detail_thickness/2])
                cylinder(1, side_marker_size, side_marker_size, center=true, $fn=32 );
            translate([x*spacing+edge_offset,y*spacing+1.5*side_marker_size,base_thickness+detail_thickness/2])
                cylinder(1, side_marker_size, side_marker_size, center=true, $fn=32 );
            
            // 3 squares
            translate([x*spacing-edge_offset,y*spacing,base_thickness+detail_thickness/2])
                cube([side_marker_size,side_marker_size,detail_thickness], center=true );
            translate([x*spacing-edge_offset,y*spacing-2*side_marker_size,base_thickness+detail_thickness/2])
                cube([side_marker_size,side_marker_size,detail_thickness], center=true );
            translate([x*spacing-edge_offset,y*spacing+2*side_marker_size,base_thickness+detail_thickness/2])
                cube([side_marker_size,side_marker_size,detail_thickness], center=true );
    
            // mm ruler
            ruler_start = ceil(-inner_square_radius) + 2;
            ruler_end = floor(inner_square_radius) - 2;
            for (k = [ ruler_start : ruler_spacing : ruler_end ]) {
               translate([x*spacing+k,y*spacing-inner_square_radius-(mark_length/2),base_thickness+detail_thickness/2])
                   cube([wall_minimum,mark_length,detail_thickness], center=true );
            }
       
        }   // end optional side markers

      } // end X loop
    } // end Y loop
}



// most other punctuation is not as distinct
// "[", "]", "{", "}", run into top and bottom edges
letters = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", 
            "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
            "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
            "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "?", ";",
            "!", "@", "#", "$", "%", "^", "&", "~", "*", "=", "+", "\\", "/", "<", ">" ];
letter_count = len( letters );


