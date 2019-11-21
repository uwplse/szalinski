// Customisable interlocking slotted crates
// Hussein Suleman
// 7 April 2019

// Height of the crate
height = 20;

// Width of the crate (0=use item diameter/width)
width = 0;

// Length of the crate
length = 100;

// wall thickness
wall = 1.5;

// item diameter (AA=14.5, AAA=10.5, AAAA=8.3, C=26.2, D=34.2, 0=no round inserts) 
item_diameter = 14.5;

// item width (9V=26.5, 0=no rectangular inserts)
item_width = 0;

// item length (9V=17.5, 0=no rectangular inserts)
item_length = 0;

// minimum distance between slots
sep = 1.5;

// create rounded box with recessed inner surfaces
module roundbox (w, h, d, top, bottom, left, right, rimr, base, item_diameter, item_width, item_length, sep, tolerance)
{
   translate ([rimr, rimr, 0])
      difference () {
         minkowski() {
	         cube([w-(2*rimr),h-(2*rimr),d-1]);
	         cylinder(h=1, d=2*rimr);
         }
         if (item_diameter == 0 && item_width == 0) // single area recessed
            translate ([left,top,base]) minkowski() {
	            cube([w-(2*rimr)-left-right,h-(2*rimr)-top-bottom,d-base]);
	            cylinder(h=1, d=2*rimr);
            }
         else if (item_diameter == 0) // rectangle recesses
         {
            inner_width = w - left - right;
            inner_length = h - top - bottom;
            i_width = item_width + tolerance;
            i_length = item_length + tolerance;
            inserts = floor ((inner_length - i_length) / (i_length + sep)) + 1;
            length_spacing = (inner_length - (i_length * inserts)) / (inserts+1);
            width_spacing = (inner_width - i_width) / 2;        
            for (i=[1:inserts])
               translate ([left+width_spacing-rimr,top+(length_spacing*i)+(i_length*(i-1))-rimr,base]) 
                  cube ([i_width, i_length, h]);
         }   
         else // round recesses
         {
            inner_width = w - left - right;
            inner_length = h - top - bottom;
            i_diameter = item_diameter + tolerance;
            inserts = floor ((inner_length - i_diameter) / (i_diameter + sep)) + 1;
            length_spacing = (inner_length - (i_diameter * inserts)) / (inserts+1);
            width_spacing = (inner_width - i_diameter) / 2;        
            for (i=[1:inserts])
               translate ([left+i_diameter/2+width_spacing-rimr,top+i_diameter/2+(length_spacing*i)+(i_diameter*(i-1))-rimr,base]) 
                  cylinder (h=h, d=i_diameter);
         }
      }
}

// create lugs for connecting boxes
module lug_male (width, depth, height) {
   difference () {
      translate ([0,-width/2,0]) cube ([depth, width, height]);
      translate ([0,-width/2+depth,0]) rotate ([0,0,45]) translate ([-depth,-width/2,0]) cube ([depth, width, height+10]);
      translate ([0,width/2-depth,0]) rotate ([0,0,-45]) translate ([-depth,-width/2,0]) cube ([depth, width, height+10]);
   }
}

module lug_female (width, depth, height) {
   lug_male (width+2.5, depth+0.5, height);
}

module make_crate (height, width, length, wall, item_diameter, item_width, item_length, sep) {
   // more parameters
   floors = 1.5;
   radius = 2;
   tolerance = 0.8;
   lug = 1.5;
   $fn=100;
   
   // determine wall sizes
   left_wall = wall;
   right_wall = (wall > lug + 1.5) ? wall : lug + 1.5;
   
   // resize/adjust dimensions if necessary
   box_width = (width==0) ? 
                   (item_diameter==0 ? 
                      (item_width==0 ?
                         10 + left_wall + right_wall :
                         item_width + left_wall + right_wall + tolerance) : 
                      item_diameter + left_wall + right_wall + tolerance) : 
                   (item_diameter==0 ? 
                      (item_width==0 ?
                         width - lug :
                         max (width - lug, item_width + left_wall + right_wall + tolerance)) : 
                      max (width - lug, item_diameter + left_wall + right_wall + tolerance));
   box_length = length;
   box_height = (height > floors) ? height : floors+1;
   
   difference () {
      roundbox (box_width, box_length, box_height, wall, wall, left_wall, right_wall, radius, floors, item_diameter, item_width, item_length, sep, tolerance);
      translate ([box_width+0.01,0.2*length,-1]) rotate ([0,0,180]) lug_female (10, lug, box_height+2);
      translate ([box_width+0.01,length-0.2*length,-1]) rotate ([0,0,180]) lug_female (10, lug, box_height+2);
   }
   translate ([0,0.2*length,0]) rotate ([0,0,180]) lug_male (10, lug, box_height);
   translate ([0,length-0.2*length,0]) rotate ([0,0,180]) lug_male (10, lug, box_height);
}

make_crate (height, width, length, wall, item_diameter, item_width, item_length, sep);

// AAA battery
//translate ([0,0,0]) make_crate (20, 0, 120, 1.5, 10.5, 0, 0, 1.5);
// AA battery
//translate ([18.5,0,0]) make_crate (20, 0, 120, 1.5, 14.5, 0, 0, 1.5);
// C battery
//translate ([41,0,0]) make_crate (20, 0, 120, 1.5, 26.2, 0, 0, 1.5);
// D battery
//translate ([75.5,0,0]) make_crate (20, 0, 120, 1.5, 34.2, 0, 0, 1.5);
// 9V battery
//translate ([118,0,0]) make_crate (20, 0, 120, 1.5, 0, 17.5, 26.5, 1.5);
// open crate
//translate ([0,0,0]) make_crate (30, 35, 100, 1.5, 0, 0, 0, 1.5);
// square slots
//translate ([36,0,0]) make_crate (30, 35, 100, 1.5, 0, 27, 27, 1.5);
// round slots
//translate ([72,0,0]) make_crate (30, 35, 100, 1.5, 27, 0, 0, 1.5);


