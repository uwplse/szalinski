// configurable thumbscrew - 2016 Tim Deagan
// Default values are for an M6 bolt

/* [Bolt Dimensions] */
// = the width across parallel sides of the bolt hex head
hex_w = 10;
// = the thickness of the bolt hex head
hex_h = 4.24;
// = the diameter of the bolt's shaft
bolt_dia = 6;

/* [Thumbscrew parameters] */
// = the extra space factor for the holes
slack = 1.05;
// = the size of the thumbscrew in relation to the hex bolt head (hex_w)
t_size = 2;
//= the number of protrusions
bumps = 6;
// = ratio of the diameter of the bump to the hex head size (2 = x2)
bump_dia = 1;
// = how tall the shaft is as a ratio of the hex head height
shaft_h = 1.25;
// = polygon resolution of the rendering (100 = high, 20 = low)
$fn = 100;

//utility params
bump_rad = (hex_w * bump_dia)/2;
bolt_rad = bolt_dia/2;

difference(){
    union(){
        cylinder(h=hex_h+2,r=(hex_w * t_size)*.85 );

        translate([0,0,hex_h+2])
            cylinder(h=(hex_h*shaft_h)+2,r1=hex_w *.8 , r2=bolt_rad +3);
             
        
        for(turn=[0:360/bumps:360]){
            rotate([0,0,turn])
                union(){
                    translate([0,(hex_w * t_size)/2,(hex_h+2)/2])
                        cube([bump_rad*2,hex_w*t_size,hex_h + 2],true);
                    
                    translate([0,(hex_w * t_size),0])
                        cylinder(r1=bump_rad,r2=bump_rad,h=hex_h+2);
                }
        }
    }

    translate([0,0,hex_h-.02])
        cylinder(r1=(hex_w/2)*1.05,r2=bolt_rad,h=hex_h+.02);
    
    translate([0,0,-.01])
        scale([slack,slack,1])
            target_bolt(100);

    }

module target_bolt(len){
    union(){
        translate([0,0,hex_h/2])
            hexagon(hex_w,hex_h);
          
        translate([0,0,hex_h]) 
            cylinder(h=len,r=bolt_rad * slack);
    }
}

// from MCAD
// size is the XY plane size, height in Z
module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}
