// Knob builder

// Select style of knob - use minimal for a quick test fit
knob_style = "round"; // [minimal,round,crank]

// Measure shaft diameter (in millimeters) using calipers where it is NOT flattened. Ryobi drill press: 14.26; RepRapDiscount knob: 6.02
shaft_diameter = 6.02;

// Measure shaft diameter (in millimeters) where it IS flattened. Ryobi drill press: 12.77; RepRapDiscount knob: 4.47
shaft_flattened = 4.47;

// Shaft penetration into knob (in millimeters). Measure the height of the stem which is clear of obstacles. Ryobi drill press: 20; RepRapDiscount knob: 7
shaft_penetration = 7;

// Printer hole shrink - nearly all printer / slicer setups will have a multiplier that needs to be applied to the diameter of any hole so it will tightly fit a precisely machined part. 1.02 means 2% is added to hole dimensions to account for shrinking
hole_shrink = shaft_flattened < 6 ? 1.10 : (shaft_flattened < 10 ? 1.06 : 1.02);

// Knob height (ignored for crank); small, medium or large relative to style, custom in mm (advanced)
knob_height = "medium"; //[small,medium,large,xlarge,custom]

// If custom specified, this is the knob height in mm, otherwise this is ignored
knob_height_custom = 0;

/*[round]*/
// For all round knobs, height of stem in mm (0 to disable) (usually needed only if clearance above surface is needed)
round_knob_stem_height = 0;

// If non-zero, the flange width is added to the radius as a percentage of radius
round_knob_flange_width = 0.2; // 0 to disable, 0.6 for a wide flange, 0.2 for a narrow flange

// Pointer type
round_knob_pointer_type = "none"; //[none,vane,raisedarrow,teardrop,speedboat]

// Pointer angle (in degrees) with respect to flat part of shaft
round_knob_pointer_angle = 0; // 0 degrees if flat part is on top, 180 if flat part is on bottom

// Ratio of knob top diameter to knob bottom diameter
round_knob_top_ratio = 0.8;

// Groove depth or 0 for smooth
round_knob_groove_depth = 0.025; // Groove depth as portion of knob width; 0 to disable, max=0.2

round_knob_groove_angle = 6.8; // Groove angle in degrees

/*[crank]*/
// Crank shaft outside diameter as a multiple of metal shaft diameter
crank_shaft_multiplier = 2.2;

// Crank shaft length - keep this short normally, longer shafts put more stress on the crank
crank_shaft_length = 80;

// Crank wheel diameter as a multiple of metal shaft diameter
crank_wheel_multiplier = 7.5;

// Crank wheel type
crank_wheel_type = "spoke4"; //[solid,daisy4,daisy6,spoke4]

// Print handle, handle + retainer, or no handle
crank_print_handle = "handleretainer"; //[handle,handleretainer,retainer,none]

// Crank handle length
crank_handle_length = 90;

// Crank handle diameter
crank_handle_diameter = 20;

// Crank connector bolt shaft diameter - 5 for #6, 5.5 for M4
crank_bolt_diameter = 5;

// Crank connector hex nut flat-to-flat width (7.9mm for #6, 7.2mm for M4)
crank_nut_flat_width = 7.9;

/*[hidden]*/
shaft_length = shaft_penetration;
min_height = min(shaft_diameter, shaft_penetration);
normal_height = max(shaft_diameter, shaft_penetration);

if (knob_height == "small") build_knob( min_height * 1.35 );
if (knob_height == "medium") build_knob( max(18,normal_height * 1.5) );
if (knob_height == "large") build_knob( max(30,normal_height * 2) );
if (knob_height == "xlarge") build_knob( max(50,normal_height * 3) );
if (knob_height == "custom" && knob_height_custom > 0) build_knob( knob_height_custom );

module build_knob( height )
{
  if (knob_style == "minimal") build_minimal_knob( height );
  else if (knob_style == "crank") build_crank( height );
  else if (knob_style == "round" || knob_style == "graduated" || knob_style == "knurled") build_round_knob( height );
  else echo( "Unknown style ", knob_style );
}

module build_minimal_knob( height )
{
  echo( "Building minimal knob with height", height, "shrink factor", hole_shrink );
  difference() {
	create_minimal_knob( height );
   create_shaft();
  }
}

module build_round_knob( height )
{
  echo( "Building ", knob_style, " knob with height", height, " and stem height", round_knob_stem_height, "shrink factor", hole_shrink );
  // If knob has a stem ("mushroom" style) rotate so stem is up
  if (round_knob_stem_height > 0)
  {
	translate([0,0,height+round_knob_stem_height]) rotate([180,0,0])
	difference()
	{
		create_round_knob( height );
		create_shaft();
	}
  }
  else
  difference()
  {
	 create_round_knob( height );
	 create_shaft();
  }
}

module create_round_knob( height )
{
  assign( width = height * 1.5 )
  {
	 echo( "Round knob width", width, " height", height );
	 rotate([0,0,round_knob_pointer_angle+270]) translate([0,0,round_knob_stem_height+height]) create_knob_pointer(width,height);
	 translate([0,0,round_knob_stem_height]) create_grooved_knob(width,height);
	 if (round_knob_stem_height > 0)
	 {
		cylinder( r=shaft_diameter * 1.5 / 2, h=round_knob_stem_height, center=false, $fn = 90 );
	 }
  }
}

module create_knob_pointer( width, height )
{
  if (round_knob_pointer_type == "vane")
  {
   assign(woff = width * 0.6) difference()
	{
		translate([0,-woff,-height]) cube(size=[1,width*1.2,height], center=false);
		translate([0,-woff*1.1,-height/5]) rotate([-6,0,0]) cube(size=[2,width*1.8,height], center=false);
		translate([0,width*0.7,-height]) rotate([5,0,0]) cube(size=[1,width*1.5,height], center=false);
	}
  }
  if (round_knob_pointer_type == "raisedarrow")
  {
		translate([0,-width*1.15/2,-height*0.8]) create_arrow( width * 1.2, width / 6, height );
  }
  // This needs to be an impression...
  if (round_knob_pointer_type == "sunkenarrow")
  {
  }
  if (round_knob_pointer_type == "teardrop")
  {
		translate([0,0,-height*0.8]) create_teardrop( width * 1.2, width / 10, width / 5, height * 0.9 );
  }
  if (round_knob_pointer_type == "speedboat")
  {
		translate([0,0,-height*0.8]) create_speedboat( width * 1.2, width / 8, width / 4, height * 0.9 );
  }
}

module create_teardrop( length, pointwidth, largewidth, height )
{
  hull()
  {
	translate([0,-length/2,0]) cylinder( r1=pointwidth*0.5, r2=pointwidth*0.43, h=height, center=false, $fn = 24 );
	translate([0,length/2,0]) cylinder( r1=largewidth*0.75, r2=largewidth*0.45, h=height, center=false, $fn = 48 );
  } 
}

module create_speedboat( length, pointwidth, largewidth, height )
{
  hull()
  {
	translate([0,-length/2,0]) cylinder( r1=pointwidth*0.5, r2=pointwidth*0.43, h=height, center=false, $fn = 24 );
	intersection()
	{
		translate([length*0.5/2,0,0]) cylinder(r1=length/2, r2=length*0.9/2, h=height, center=false, $fn=72);
		translate([-length*0.5/2,0,0]) cylinder(r1=length/2, r2=length*0.9/2, h=height, center=false, $fn=72);
		translate([0,length*0.3/2,0,0]) cylinder(r1=length/2, r2=length*0.9/2, h=height, center=false, $fn=72);
	}
	translate([0,length*0.8/2,0]) cylinder( r=largewidth*1.3/2, h=height, center=false, $fn=72 );
  }
}

module create_arrow( length, width, height )
{
	// Head
	assign( wdiag = sqrt(width*width+width*width) )
   {
   translate([-wdiag/2,0,0]) difference()
	{
		rotate([0,0,-45]) cube(size=[width,width,height], center=false);
		// trim point
		translate([wdiag/2,-wdiag/2,0]) rotate([0,0,120]) cube(size=[width*1.3,width*1.3,height], center=false);
		translate([wdiag/2,-wdiag/2,0]) rotate([0,0,330]) cube(size=[width*1.3,width*1.3,height], center=false);
		//translate([-width/2,wdiag*0.75,0]) cube(size=[width,width,height], center=false);
	}
	// Shaft
	translate([-width*0.75/2,wdiag*0.25,0]) cube(size=[width*0.75,length-width/2,height*0.9], center=false);
	// Tail
	translate([-width/2,(wdiag+height)*1.2,0]) difference()
	{
		cube(size=[width,width,height*0.9], center=false);
		translate([width*1.75/2,0,0]) rotate([0,0,-45]) cube(size=[width,width,height], center=false);
		translate([-width*1.15/2,-width*1.4/2,0]) rotate([0,0,45]) cube(size=[width,width,height], center=false);
		// Rear notch of tail
		translate([-wdiag*0.3/2,wdiag*0.9,0]) rotate([0,0,-45]) cube(size=[width,width,height], center=false);
	}
   }
}

module create_grooved_knob( width, height )
{
  difference()
  {
    cylinder( r1=width/2, r2=width*round_knob_top_ratio/2, h=height, center=false, $fn = 90 );
	 knob_grooves( width, height );
  }
  // Add optional flange. Flange needs to have more pitch than
  // we'd like for stylistic purposes, but a steeper flange pitch
  // makes it easier to manage overhang if we flip the knob over
  if (round_knob_flange_width > 0) assign( flange_base_radius = (width + width * round_knob_flange_width) / 2, flange_base_height = max(1,round_knob_flange_width * 2), flange_height = round_knob_flange_width * width / 4 )
  {
	 cylinder( r = flange_base_radius, h=flange_base_height, $fn = 72, center=false );
	 translate([0,0,flange_base_height]) cylinder( r1 = flange_base_radius, r2 = width / 2, h=flange_height, $fn = 72 );
  }
}

module knob_grooves( width, height )
{
  // Calculate integral number of grooves based on groove depth
  if (round_knob_groove_depth > 0)
  assign( groove_depth = width * round_knob_groove_depth )
  assign( circumf = width * 3.141592653, groove_diameter = groove_depth * 2 )
  assign( int_grooves = floor(circumf / groove_diameter / 3) )
  assign( dpergroove = 360 / int_grooves )
  for (d = [1 : int_grooves])
  {
	//echo( "Groove ", d, "/", int_grooves, " deg=", (d-1) * dpergroove );
	rotate([0,0,(d-1)*dpergroove]) rotate([0,-round_knob_groove_angle,0]) translate([width/2,0,0]) cylinder(h=height, r=groove_depth, center=false, $fn = 24 );
  }
}

module build_crank( height )
{
  assign( crank_shaft_diameter = shaft_diameter * crank_shaft_multiplier, crank_wheel_diameter = shaft_diameter * crank_wheel_multiplier )
  {
    echo( "Building crank shaft diameter", crank_shaft_diameter, " shaft length", crank_shaft_length, " wheel diameter", crank_wheel_diameter );
    translate([0,0,crank_shaft_length + shaft_diameter]) rotate([180,0,0]) difference()
    {
		create_crank_shaft( crank_shaft_diameter, crank_wheel_diameter );
	   create_shaft();
    }
	 // Optional piece: handle
	 if (crank_print_handle == "handle" || crank_print_handle == "handleretainer")
	 {
		translate( [crank_wheel_diameter * 0.45, crank_wheel_diameter * 0.45, 0] ) create_crank_handle();
	 }
	 // Optional piece: handle retainer
	 if (crank_print_handle == "retainer" || crank_print_handle == "handleretainer")
	 {
		translate( [crank_wheel_diameter * -0.42, crank_wheel_diameter * 0.42, 0] ) create_crank_handle_retainer();
	 }
  }
}

module create_crank_shaft(crank_shaft_diameter, crank_wheel_diameter)
{
  union()
  {
    cylinder( r = crank_shaft_diameter / 2, h = crank_shaft_length, center = false, $fn = 45 );
	 translate([0,0,crank_shaft_length]) create_crank_wheel( crank_shaft_diameter, crank_wheel_diameter );
  }
}

module create_crank_wheel( crank_shaft_diameter, crank_wheel_diameter )
{
  assign( center_ring_inside_diameter = crank_shaft_diameter * 1.4, center_ring_outside_diameter = crank_wheel_diameter - crank_bolt_diameter * 6) assign( center_ring_width = (center_ring_outside_diameter - center_ring_inside_diameter) / 2 ) union()
  {
	 difference()
	 {
		cylinder( r = crank_wheel_diameter / 2, h = shaft_diameter, center = false, $fn = 90 );
	   translate([crank_wheel_diameter / 2 - crank_bolt_diameter * 1.75, 0, 0]) cylinder( r = (crank_bolt_diameter * hole_shrink) / 2, h = shaft_diameter, center = false, $fn = 72 );
		// Remove center ring for daisy spoked wheels
		if (crank_wheel_type == "daisy4" || crank_wheel_type == "daisy6")
		difference()
		{
			echo( "Crank wheel ", crank_wheel_type, " center ring ID=", center_ring_inside_diameter, " center ring OD=", center_ring_outside_diameter );
			cylinder( r = center_ring_outside_diameter/2, h = shaft_diameter, center = false, $fn = 90 );
			cylinder( r = center_ring_inside_diameter/2, h = shaft_diameter, center = false, $fn = 90 );
		}
	   // Remove cutouts for spoked wheel
		if (crank_wheel_type == "spoke4")
		difference()
		{
			cylinder( r = center_ring_outside_diameter / 2, h = shaft_diameter, center = false, $fn = 90 );
			cube( size=[center_ring_outside_diameter, shaft_diameter, shaft_diameter * 2], center = true );
			cube( size=[shaft_diameter, center_ring_outside_diameter, shaft_diameter * 2], center = true );
		}
	 } // Solid wheel minus bolt hole
	 // Add daisy spokes
	 if (crank_wheel_type == "daisy4" || crank_wheel_type == "daisy6")
	 assign( center_ring_avg_radius = (center_ring_outside_diameter + center_ring_inside_diameter) / 4 )
	 {
		translate([center_ring_avg_radius,0,0]) daisy( center_ring_width );
		translate([-center_ring_avg_radius,0,0]) daisy( center_ring_width );
		if (crank_wheel_type == "daisy4")
		{
			translate([0,center_ring_avg_radius,0]) daisy( center_ring_width );
			translate([0,-center_ring_avg_radius,0]) daisy( center_ring_width );
		}
		else
		assign( xoff = center_ring_avg_radius * cos(60), yoff = center_ring_avg_radius * sin(60) )
		{
			translate([xoff,yoff,0]) daisy( center_ring_width );
			translate([-xoff,yoff,0]) daisy( center_ring_width );
			translate([xoff,-yoff,0]) daisy( center_ring_width );
			translate([-xoff,-yoff,0]) daisy( center_ring_width );
		}
	 }
	 // Add hub for normal spokes
	 if (crank_wheel_type == "spoke4")
	 {
		cylinder( r = crank_shaft_diameter * 1.2 / 2, h = shaft_diameter, center=false, $fn = 90 );
	 }
  } // Adding back in spokes, etc
}

module daisy( daisy_width )
{
	difference()
	{
		cylinder( r = daisy_width * 1.18 / 2, h = shaft_diameter, center=false, $fn = 90 );
		cylinder( r = daisy_width * 0.52 / 2, h = shaft_diameter, center=false, $fn = 90 );
	}
}

module create_crank_handle()
{
  difference()
  {
  union()
  {
	 difference()
	 {
	   cylinder( r = crank_handle_diameter / 2, h = crank_handle_length, center = false, $fn = 72 );
		cylinder( r = crank_handle_diameter * 0.75 / 2, h = crank_handle_length, center = false, $fn = 72 );
	 } // hollow cylinder
	 // Add solid bottom
	 cylinder( r = crank_handle_diameter / 2, h = crank_handle_diameter / 2, center = false, $fn = 72 );
	/* Not sure why I thought this was necessary...
	 translate([0,0,crank_handle_diameter * 0.75 / 2]) difference()
	 {
		sphere( r = crank_handle_diameter * 0.75 / 2, $fn = 50 );
	   translate([0,0,crank_handle_diameter * 0.75 /2]) cube( size = crank_handle_diameter, center = true );
	 } // hemisphere (bottom half of sphere)
	*/
  } // hollow cylinder with hemisphere set in bottom
  // Create beveled cut out with generous clearance for crank handle retainer
  cylinder( r1 = crank_handle_diameter / 2 * 0.56, r2 = crank_handle_diameter / 2 * 0.75, h = crank_handle_diameter / 2, center = false, $fn = 72 );
  } // difference
}

module create_crank_handle_retainer()
{
  assign( leg = crank_nut_flat_width * tan(60), outdiameter = crank_nut_flat_width / 2 / cos(60) )
  difference()
  {
	 cylinder( r1 = /*outdiameter * 1.2 / 2*/ crank_handle_diameter * 0.50 / 2, r2 = crank_handle_diameter * 0.69 / 2, h = crank_handle_diameter / 2, center = false, $fn = 72 );
	 translate([0,0,7]) cylinder( r = outdiameter * 1.3, h = crank_handle_diameter, center = false, $fn = 72 );
    translate([0,0,5]) hexnut( crank_nut_flat_width, 2 );
	 cylinder( r = crank_bolt_diameter * hole_shrink / 2, h = crank_handle_diameter, center = false, $fn = 72 );
  }
}

// Create knob using specified height guideline
// with base centered at z offset 0
module create_minimal_knob( height )
{
  assign( cube_size_w = max(shaft_diameter * 1.5, height * 1.25), cube_size_h = height * 1.25 )
  {
	 echo( "Minimal cube_size", cube_size_w, "x", cube_size_h );
	 translate([0,0,cube_size_h*1.01/2]) cube(size=[cube_size_w, cube_size_w, cube_size_h], center=true);
  }
}

module create_shaft()
{
  assign(shaft_top = shaft_diameter * 0.1, shaft_radius = shaft_diameter / 2, dome_r = cos(60) * shaft_diameter * 0.1, dome_offset = sin(60) * shaft_diameter * 0.1) difference() {
   union() {
    // Create the actual shaft, padded to accommodate hole shrinkage
    cylinder( r=(shaft_diameter * hole_shrink) / 2, h=shaft_length, center=false, $fn = 90 );
    // Create a tapered cap to avoid bridging
    translate([0,0,shaft_length]) cylinder( r1=(shaft_diameter * hole_shrink)/2, r2=shaft_top, h=3, $fn = 90 );
	 // Dome the top of the cap to further avoid bridging
	 translate([0,0,shaft_length+3-dome_offset * shaft_top / dome_r]) sphere( r=shaft_top * shaft_top / dome_r, $fn = 40 );
   }
   // Chop off part of the shaft to create the flattened part
   translate( [shaft_flattened * hole_shrink, 0, shaft_length/2] ) cube( size = [shaft_diameter * hole_shrink, shaft_diameter * hole_shrink, shaft_length], center=true );
  }
}

// Create a hex nut (trap) with specified flat-to-flat width
module hexnut( width, height )
{
  // width is the in-diameter of the hexagon
  // in-diameter * tan(60) = leg length
  // out-diameter = width / cos(60)
  assign( leg = width / tan(60), outdiameter = width / 2 / cos(60) )
  {
	echo( "hexnut leg=", leg, ", width=", width, ", outdiameter=", outdiameter, ", height=", height );
   scale([hole_shrink,hole_shrink,1]) polyhedron(
	  points = [
		[0,0,0], [leg,0,0], [leg/2,width/2,0], [-leg/2,width/2,0], [-leg,0,0], [-leg/2,-width/2,0], [leg/2,-width/2,0], // 0-6
	   [0,0,height], [leg,0,height], [leg/2,width/2,height], [-leg/2,width/2,height], [-leg,0,height], [-leg/2,-width/2,height], [leg/2,-width/2,height] // 7-13
	  ],
	  triangles = [
		[0,2,1], [1,2,9], [1,9,8], [8,9,7],
		[0,3,2], [2,3,10], [2,10,9], [9,10,7],
		[0,4,3], [3,4,11], [3,11,10], [10,11,7],
		[0,5,4], [4,5,12], [4,12,11], [11,12,7],
		[0,6,5], [5,6,13], [5,13,12], [12,13,7],
		[0,1,6], [6,1,8], [6,8,13], [13,8,7]
	  ]
   );
  }
}
