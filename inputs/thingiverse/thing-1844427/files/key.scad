///////////////////
///  PARAMETERS ///
///////////////////


key_code = [3,3,4,3,1,2,2,1]; // this is the key code


///////////////////////////////////////////////////////////


MM_PER_IN = 25.4;

$fa=0.5; // default minimum facet angle is now 0.5
$fs=0.5; // default minimum facet size is now 0.5 mm

// All units in inches then converted to mm

// Key Head
key_head_width                = 1       * MM_PER_IN;
key_head_length               = 1       * MM_PER_IN;
key_head_height               = 0.25    * MM_PER_IN;
key_head_radius               = 0.25    * MM_PER_IN;

// Key Blade
blade_height                  = 0.115   * MM_PER_IN;
blade_width                   = 0.320   * MM_PER_IN;
blade_length                  = 1.70    * MM_PER_IN;

// Guide Groove in Side of Key Blade
side_groove_offset_from_head  = 1.1     * MM_PER_IN;
side_groove_depth             = 0.05    * MM_PER_IN;
side_groove_width             = 0.03    * MM_PER_IN;
side_groove_taper_radius      = 0.75    * MM_PER_IN;

// Key Stop - wider area at top of key blade
key_stop_offset               = 0.04    * MM_PER_IN;
key_stop_height               = 0.250   * MM_PER_IN;

// Cuts
cut_depth                     = 0.044   * MM_PER_IN; // depth of cut
cut_r                         = 0.120/2 * MM_PER_IN; // radius of cutter
cut_spacing                   = 0.118   * MM_PER_IN; // spacing between cuts
cut_positions                 = [ 0.150 * MM_PER_IN, // 1
                                  0.126 * MM_PER_IN, // 2
                                  0.102 * MM_PER_IN, // 3
                                  0.079 * MM_PER_IN  // 4 
                                ]; // these are the cuts according to the key data sheet
cut_insets                    = [ cut_spacing * 8,
                                  cut_spacing * 7,
                                  cut_spacing * 6,
                                  cut_spacing * 5,
                                  cut_spacing * 4,
                                  cut_spacing * 3,
                                  cut_spacing * 2,
                                  cut_spacing * 1
                                ] ;



//////////////////////////
///  FUNCTIONS/MODULES ///
//////////////////////////


module rounded_cir(w,l,h,r){
  // Creates a cube with the x-y edges rounded
  // Parameters:
  // w - width of cube
  // l - length of cube
  // h - height of cube
  // r - radius of rounded edges
  translate([-w/2,0,0])
  union()
  {
    translate([(-w/2+r), (-l/2+r), 0]) cylinder(r=r,h=h, center=true);
    translate([(w/2-r), (-l/2+r), 0])  cylinder(r=r,h=h, center=true);
    translate([(-w/2+r), (l/2-r), 0])  cylinder(r=r,h=h, center=true);
    translate([(w/2-r), (l/2-r), 0])   cylinder(r=r,h=h, center=true);
    cube([w-2*r,l,h], center=true); // space left inside
    cube([w,l-2*r,h], center=true); // and in the other way
  }
}

module key_cuts(rotation){
  // Creates cuts in key blade - made to be subtracted
  // parameters - rotation coordinates
  rotate(rotation)
    union(){

      // Make all blade cuts
      for(i=[0:1:6]){
        hull(){
          c1_code = key_code[i];
          c1_pos = cut_insets[i];
          c1_depth = cut_positions[c1_code-1];

          c2_code = key_code[i+1];
          c2_pos = cut_insets[i+1];
          c2_depth = cut_positions[c2_code-1];

          translate([blade_length-c1_pos,+blade_width/2-cut_r-c1_depth, blade_height/2-cut_depth]) cylinder(r=cut_r,h=blade_height, $fn=100);
          translate([blade_length-c2_pos,+blade_width/2-cut_r-c2_depth, blade_height/2-cut_depth]) cylinder(r=cut_r,h=blade_height, $fn=100);
        }    
      }
        // Cut entry way in blade
        translate([blade_length-3,-2,blade_height/2-cut_depth]) rotate([0,0,30]) cube([10,3,10]);
        translate([blade_length-3,-cut_r*2+blade_width/2-cut_positions[0],blade_height/2-cut_depth]) rotate([0,0,0]) cube([10,cut_r*2,10]);
  }
}


///////////////////////
///  MODEL CREATION ///
///////////////////////


// Create hey head
rounded_cir(  w=key_head_width, 
              l=key_head_length, 
              h=key_head_height, 
              r=key_head_radius );


// Key Blade
side_groove_offset = blade_length-side_groove_offset_from_head; // where to start cube cut - distance from key head
difference(){
  union(){
    // create key blade base
    translate([0,-blade_width/2,-blade_height/2]) 
      cube([blade_length,blade_width,blade_height]);
    // create key stop
    translate([0,-blade_width/2-key_stop_offset,-blade_height/2]) 
      cube([side_groove_offset,blade_width+key_stop_offset*2,blade_height]);
  }
  // cut side grove guide slots - one cut for each side
  translate([side_groove_offset,-blade_width*1.5+side_groove_width,blade_height/2-side_groove_depth]) 
    cube([blade_length,blade_width,blade_height]); // make cube same size as blade to use for cutting
  translate([side_groove_offset,blade_width/2-side_groove_width,-blade_height*1.5+side_groove_depth]) 
    cube([blade_length,blade_width,blade_height]); // make cube same size as blade to use for cutting

  // cut side groove taper on each side
  translate([side_groove_offset,-blade_width/2+side_groove_width,side_groove_taper_radius]) rotate([90,0,0])  cylinder(r=side_groove_taper_radius,h=side_groove_width*4);
  translate([side_groove_offset,side_groove_width*4+blade_width/2-side_groove_width,-side_groove_taper_radius]) rotate([90,0,0])  cylinder(r=side_groove_taper_radius,h=side_groove_width*4);
  // make cuts in blade
  key_cuts([0,0,0]);
  key_cuts([180,0,0]);
  }

