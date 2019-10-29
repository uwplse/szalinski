$fn = 50;

// Thickness of walls
walls        = 5;

// height of entire mount
mount_h      = 27;

// radius of the shaft. Make it a little smaller than the actual radius.
shaft_r      = 17.5;

// width of cutout on side of shaft mount.
shaft_cutout = 30;

// number of accessories
accessory_n  = 2;

// radius of accessories. Make it a little larger than actual radius
accessory_r  = 18;

// thickness of the ears of the accessories.
ear_d        = 3;

// width of one ear
ear_w        = 2.1;

// width of locking tab on accessory
tab_w        = 21;

// height from bottom of mount for the locking tab
tab_h        = 0;

// thickness of the bar the tab will lock against
tab_th       = 3;


module shaft () {
    difference () {
        cylinder (h=mount_h, r=shaft_r+walls);
        translate ([0,0,-1]) cylinder (h=mount_h+2, r=shaft_r);
        translate ([-shaft_cutout/2,0,-1]) cube ([shaft_cutout, shaft_cutout, mount_h+2]);
    }
}

module accessory () {
   difference () {
        cylinder (h=mount_h, r=accessory_r+walls);
        translate ([0,0,-1]) cylinder (h=mount_h+2, r=accessory_r);
        translate ([-tab_w/2,0,tab_th]) cube ([tab_w, accessory_r+walls, mount_h+2]);
        translate ([-accessory_r-ear_w,-ear_d/2,-1]) cube ([2*(accessory_r+ear_w), ear_d, mount_h+2]);
        
      
   } 
}

shaft ();

tmp_r=shaft_r+accessory_r+walls;
angle_base=45;
angle_delta=270/(accessory_n+1);

for ( i = [1:accessory_n] ) { 
    angle = angle_base + i * angle_delta;
    translate ([tmp_r*sin(angle), tmp_r*cos(angle),0])
        rotate([0,0,-angle]) accessory ();
}

