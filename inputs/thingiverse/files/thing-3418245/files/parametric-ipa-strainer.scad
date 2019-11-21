// all units in mm

/* [Dimensions] */
// the length of the strainer (mm)
length = 110;
// the width of the strainer (mm)
width = 110;
// the total height (mm - from top to bottom)
height = 85;

// the number of handles
handles_count = 2; // [1,2,3,4]


/* [Strainer] */

// the thickness of the strainer's grid (mm)
bt_thick = 2;

// the radius of the rounded corners of the grid (mm)
bt_rad = 15;

// the size (distance between centers) of the hexagons (mm)
hexa_size = 6;

// The thickness of the borders and handles (mm)
brd_thick = 2;

// the thickness of the hexagons (mm)
hexa_thick = 0.8;

// The height of the border above the grid (mm)
brd_height = 10;

/* [Handles] */
// the size of the handles (mm - at top)
handle_top_size = 20;

// the size of the handles (mm - at bottom)
handle_bottom_size = 30;

// the radius of the handle rounded corners (mm)
handle_corner_radius = 10;

// Are the handle split ?
handle_hole = 1; // [0: No; 1: Yes]

// the size of the split handle's arms (mm - at the top)
handle_border_size_top = 10;

// the size of the split handle's arms (mm - at the bottom)
handle_border_size_bottom = 15;

/* [hidden] */
$fn=64;
COS_60 = 1/2;
SIN_60 = sqrt(3)/2;

brd_height2 = bt_thick + brd_height;
handle_thinning = handle_top_size / handle_bottom_size;
 
arm_length = height - brd_thick;


union() {
  ground();
  for(i = [0 : handles_count - 1])
    intersection() {        
      scale([(abs(1.5-i)-1)*2,(i%2)*2-1,1])
        arm();
    }
}


module arm() {
  *translate([0,0,arm_length/2]) cube([length, width, arm_length], center=true);
  
  difference() {
    intersection() {    
     hollow_rounded();
      
     translate([length, width, 0]/2)
       difference() {
       pseudo_pyramid(arm_length+brd_thick,
          handle_top_size,
          handle_bottom_size,
          handle_corner_radius);
         scale(handle_hole)
         pseudo_pyramid(arm_length+brd_thick,
          handle_top_size - handle_border_size_top,
          handle_bottom_size - handle_border_size_bottom,
          handle_corner_radius);
       }      
    }      
    translate([0,0, brd_height2/2-1])
      cube([length, width, brd_height2+1],center=true);
  }  
}

module hollow_rounded() { 
  size = [length, width, arm_length+brd_thick+bt_rad]; 
  translate([0,0,-brd_thick - bt_rad]) 
    difference() {
      rounded_cube(size, bt_rad, bt_rad);
      translate([0,0,brd_thick]) 
        rounded_cube(size-[2,2,2]*brd_thick, bt_rad, bt_rad);
    }
}
    

module ground() {
  difference() {
    rounded_cube([length-brd_thick*2, width-brd_thick*2, bt_thick], bt_rad-brd_thick, 0);
    hexa_ground();
  }
  
  L = (bt_rad * 2 + brd_height2);
  intersection() {
    translate([0,0, brd_height2/2]) cube([length, width, brd_height2],center=true);

    translate([0,0,-L]) difference() {
      rounded_cube([length, width, L * 2], bt_rad, bt_rad);
      translate([0,0,brd_thick]) 
        rounded_cube([length, width, L * 2]-[2,2,2]*brd_thick, bt_rad, bt_rad);
    }
  }
*  difference() {
    rounded_cube([length, width, brd_height2], bt_rad, 0);
    translate([0,0,-0.5])
    rounded_cube([length-brd_thick*2, brd_height2-brd_thick*2, brd_height2+1], bt_rad-brd_thick, 0);
  }
}


module hexa_ground() {
  DX = (COS_60+1) * hexa_size;
  DY = SIN_60 * hexa_size;
  
  
  translate([-length/2, -width/2, 0])  
    for( x = [0 : ceil(length / DX)] )
      for( y = [0 : ceil(width / DY)] ) {
        translate([x * DX, y * DY, -0.5])
          hexa_prism(hexa_size - hexa_thick / sin(60), bt_thick + 1);
        
        translate([(x + 0.5) * DX, (y + 0.5) * DY, -0.5])
          hexa_prism(hexa_size - hexa_thick / sin(60), bt_thick + 1);
      }
}

module hexa_prism(size, height) {
    cylinder(d=size, h=height, $fn=6);
}

module rounded_cube(size, radiusXY, radiusZ) {
    radii = [radiusXY, radiusXY, radiusZ];
    translate(radii-[size[0], size[1], 0] / 2)
      minkowski() {
        cube(size - radii * 2);
        scale(radii) sphere(r=1);
      }
}

module pseudo_pyramid(height, top_size, bottom_size, radius) {
    rotate([0,0,45]) translate([1,0,0]*-top_size/2)
      linear_extrude(height=height, scale=top_size/bottom_size)
        offset(radius)
          square(bottom_size*sqrt(2)-radius*2,center=true);
}


function lerp(x,a,b) = (1-x) * a + x * b;