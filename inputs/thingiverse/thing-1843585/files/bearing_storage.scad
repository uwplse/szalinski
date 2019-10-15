// storage containers for ball bearings

         count = 0; inner = 1; outer = 2; width = 3; label = 4;
// bearing = [ 8,         8,        22,        7,       "608"];
   bearing = [12,         8,        16,        5,       "688"];
// bearing = [11,         6,        11,        4,       "694"];
// bearing = [12,         6,        10,        3,       "MR106"];
// bearing = [11,         5,        11,        5,       "685"];
// bearing = [21,         5,         8,        2,       "MR85"];
// bearing = [11,         4,         8,        3,       "MR84"];
// bearing = [10,         4,         7,        2.5,     "MR74"];
// bearing = [21,         4,         7,        2,       "MR74"];
// bearing = [11,         3,        10,        4,       "623"];
// bearing = [11,         3,         8,        4,       "693"];
// bearing = [11,         3,         6,        2.5,     "MR63"];
// bearing = [11,         2,         5,        2.5,     "MR52"];

// "label" field is meant to be written as text on containers.
// Code is present and enabled, looks good when rendered but doesn't print nicely vertically.
// Therefore this feature isn't used by default.
// change emboss to +0.3 or -0.3 to have text stick out or get punched in by 0.3mm
emboss = 0;									// set to 0 for no inscription
										// negative to punch (impress) labels
										// positive to emboss (stick out) labels
										// increase wall strength if impress

// loosely fit bearings by changing container diameter
slack       = 1.2;

// more tightly fit lid by increasing diameter
fit         = 0.10;
base        = 0.9;
wall        = 0.8;

height      = base+bearing[count]*bearing[width];

hub_outer   = (bearing[inner]-slack)/2;
hub_inner   = hub_outer-wall;

rim_inner   = (bearing[outer]+slack)/2;
rim_outer   = rim_inner+wall;

lid_inner   = rim_outer+fit/2;
lid_outer   = lid_inner+wall;
lid_height  = rim_outer+base;


suppress_spire = 0+1.4;								// no center spire if narrower than that
little = 0+0.01;
spacing = 0+5;
$fn = 0+90;

if (height+base > 65)  echo ("WARNING: too long for organiser drawers");



// ------ placement ------
translate([rim_outer+lid_outer+spacing, 0, 0])
lid();
case();



// ------ from library ------
// include <pipe.scad>
module pipe(length, inner, outer)  {
   difference()  {
      cylinder(length, r=outer);
      translate([0, 0, -little/2])
      cylinder(length+little, r=inner);
   }
}



// ------ storage case ------
module case()  {
   module wrap_text(text, size, length, emboss)  {				// negative emboss is impress
      if (emboss)  {
         intersection()  {							// impress or emboss text
            translate([-size/2, -size/2, 0])
            rotate([0, 270, 0])
            linear_extrude(size)
            text(text, size=size);						// generate and place label text
            if (emboss < 0)  {
               pipe(length, size+emboss-little, size+little/2);			// keep only recessed text
            } else {
               pipe(length, size-little/2, size+emboss+little);			// keep only embossed text
            }
         }
      }
   }
   cylinder(base, r=rim_outer);							// base
   if (emboss > 0)  wrap_text(bearing[label], rim_outer,  height, emboss);	// text, charsize, length, protrude/recess
   difference()  {
      pipe(height, rim_inner, rim_outer);					// outer cylinder
      if (emboss < 0) wrap_text(bearing[label], rim_outer, height, emboss);
   }
   if (hub_outer >= suppress_spire ) pipe(height, hub_inner, hub_outer);	// suppress central spire if too thin
}



// ------ lid ------
module lid()  {
   cylinder(base, r=lid_outer);							// lid base
   pipe(lid_height, lid_inner, lid_outer);					// lid
}
