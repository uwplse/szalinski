//CUSTOMIZER VARIABLES

/* [Basic_Parameters] */

// number of magnets across the bar
magnet_count = 3;   // [2:20]

// magnet shape
magnet_square = 1;    // [0:circular, 1:square]

// magnet diameter, in mm
magnet_diameter = 6.0;    // [1.0:0.1:20.0]

// height of magnets, in mm
magnet_height = 3.0;    // [1.0:0.1:20.0]

// length of the bar, in mm
bar_length = 220;   // [50:500]

// bar height, in mm
bar_height = 5.0;   // [2:50]

// magnet distance from end of bar, in mm
end_offset = 7;  // [5:30]

// finger grip height, in mm
grip_height = 10;   // [10:50]

// finger grip length, in mm
grip_length = 50;    // [20:100]

// finger grip top width (can be zero), in mm
grip_top_width = 5.0;   // [0:10]

// width margin around magnets, in mm
magnet_margin = 2.0;    // [1:20]


//CUSTOMIZER VARIABLES END


// Sanity checks
if ( ((magnet_count * magnet_diameter) + end_offset) > bar_length )
{
    echo("<B>Error: bar length too small for magnets </B>");
}

if ( grip_length > bar_length )
{
    echo("<B>Error: bar length too small for finger grip </B>");
}



// our object, flat on xy plane for easy STL generation
paper_holder();


module paper_holder() {
    
    bar_width = magnet_diameter + 2*magnet_margin;
    real_bar_height = max( bar_height, magnet_height + magnet_margin );
    stength_width = bar_width / 3;
    strength_height = min( real_bar_height/2, grip_height );
    magnet_radius = magnet_diameter / 2;
    real_end_offset = max( end_offset, magnet_margin );
    grip_radius = max( grip_top_width, stength_width ) / 2;
    
    difference() {
        
        union () {
            
            // main body
            translate( [0,0, real_bar_height/2 ] )
                cube([bar_width,bar_length,real_bar_height], center=true );
            
            // strength bar across top
            translate( [0,0, real_bar_height + strength_height/2 ] )
                cube([stength_width,bar_length,strength_height], center=true );
            
            // finger grip in center
            translate( [0,0, grip_height/2 + real_bar_height ] )
                cube([stength_width,grip_length,grip_height], center=true );
            
            // finger grip top
            translate( [0,0, grip_height + real_bar_height - 0.7 * grip_radius] )
              rotate([90,0,0])
                cylinder(grip_length, grip_radius, grip_radius, center=true, $fn=8 );
            
            // finger grip fillet
           if (strength_height < grip_height) {
             translate( [0,-grip_length/2-grip_height/8, real_bar_height + strength_height + grip_height/8 ] )
                cube([stength_width,grip_height/4,grip_height/4], center=true );
             translate( [0,grip_length/2+grip_height/8, real_bar_height + strength_height + grip_height/8 ] )
                cube([stength_width,grip_height/4,grip_height/4], center=true );
           }
            
        }   // end union
    
        
    // trim sharp corners on ends
    translate([0,-bar_length/2,real_bar_height + strength_height])
      rotate([60,0,0])
        cube([bar_width+2,real_bar_height*2,real_bar_height], center=true );
    translate([0,bar_length/2,real_bar_height + strength_height])
      rotate([-60,0,0])
        cube([bar_width+2,real_bar_height*2,real_bar_height], center=true );
    
    
    // fillet finger grip
    if (strength_height < grip_height) {
      translate( [0,-grip_length/2 - grip_height/4, real_bar_height + strength_height + grip_height/4 ] )
        rotate([0,90,0])
          cylinder(stength_width+4,grip_height/4,grip_height/4, center=true, $fn=32 );
      translate( [0,grip_length/2 + grip_height/4, real_bar_height + strength_height + grip_height/4 ] )
        rotate([0,90,0])
          cylinder(stength_width+4,grip_height/4,grip_height/4, center=true, $fn=32 );
    }
    
        
    // magnet holes
    magnet_start = -bar_length/2 + real_end_offset;
    magnet_end = bar_length/2 - real_end_offset;
    magnet_spacing = (magnet_end - magnet_start) / (magnet_count-1);
    vis_offset = 2;
    
    for (k = [ 0 : 1 : (magnet_count-1) ]) {
        center = k * magnet_spacing + magnet_start;
        if (magnet_square) {
          translate([0,center,magnet_height/2 - vis_offset/2])
            cube([magnet_diameter,magnet_diameter,magnet_height+vis_offset], center=true );
        } else {
          translate([0,center,magnet_height/2 - vis_offset/2])
            cylinder(magnet_height+vis_offset,magnet_radius,magnet_radius, center=true );
        }
      } // end for k
    
    }   // end difference
    
}   // end paper_holder

