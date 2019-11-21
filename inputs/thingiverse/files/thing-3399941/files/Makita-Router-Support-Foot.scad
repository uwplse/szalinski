//
// Design by: MrFuzzy 
// License: CC BY-NC 3.0
// Router support foot 
//  - Fits into guide holder of Makita RT0700 router
//  - Can be used with adapter for other routers (and brands) 
// 

// width of foot / guide holder opening
w = 25;

// length of foot
l = 70;

// foot: wall thickness
thn = 8;

// screw diameter: added 0.4 to adjust for printer cut-out precision. Adjust to cut-out precision of your printer
d_screw = 6.4;

// screw head diameter: 10mm (hex head), 12mm (Makita lock screw). Added 0.4 to adjust for printer cut-out precision. Set according to precision of your printe
d_screw_head = 12.4;

// thickness of screw head
thn_head = 4;

// length of shoe
l_shoe = 100;

// shoe thickness
thn_shoe = 5;


foot();
foot_base();
shoe();


module foot() {
    difference() {
        cube([l, w, thn]);
              
        translate([10, w/2-d_screw/2, 0])
            cube([l-20, d_screw, thn]); 

        translate([10-d_screw_head/2, w/2-d_screw_head/2, 0])
            cube([l-20+d_screw_head, d_screw_head, thn_head]); 
        
    }
}


module foot_base() {
    
    d_base = thn * 0.5;
    translate([l+1,-d_base,0])
    mirror([1,0,0]) {
        hull() {
            cube([1, w+d_base*2,thn+d_base]);
            translate([0,d_base,0])
                cube([d_base,w,thn]);
        }
    }
}

module shoe() {
    translate([0, w/2, 0])
    linear_extrude(thn*2)
    polygon(points = [[l, -l_shoe/2], [l, l_shoe/2], 
                      [l+thn_shoe, l_shoe/2-thn_shoe], [l+thn_shoe, -l_shoe/2+thn_shoe]]);
}

