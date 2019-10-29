// Generic storage blocks
// Hussein Suleman
// 28 March 2018

// Height of the box
height = 33;

// Width of the box
width = 42;

// Length of the box
length = 45;

// Wall thickness
wall = 1;

// Floor thickness
floors = 1;

// Corner radius
radius = 3;

// create rounded box with recessed inner surface
module roundbox (w, h, d, rimw, rimr, base)
{
    difference () {
       union () {
          translate ([0,rimr,0]) cube ([w,h-(2*rimr),d]);
          translate ([rimr,0,0]) cube ([w-(2*rimr),h,d]);
          translate ([rimr,rimr,0]) cylinder (r=rimr,h=d,$fn=50);
          translate ([rimr,h-rimr,0]) cylinder (r=rimr,h=d,$fn=50);
          translate ([w-rimr,rimr,0]) cylinder (r=rimr,h=d,$fn=50);
          translate ([w-rimr,h-rimr,0]) cylinder (r=rimr,h=d,$fn=50);
       }
          translate ([rimw,rimr,base]) cube ([w-(2*rimw),h-(2*rimr),d-base+1]);
          translate ([rimr,rimw,base]) cube ([w-(2*rimr),h-(2*rimw),d-base+1]);
          translate ([rimr,rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=50);
          translate ([rimr,h-rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=50);
          translate ([w-rimr,rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=50);
          translate ([w-rimr,h-rimr,base]) cylinder (r=rimr-rimw,h=d-base+1,$fn=50);
       
    }
}

roundbox (width, length, height, wall, radius, floors);

