// preview[view:south, tilt:top]

// Select part to render
part = "all"; // [stand:Stand,rings:Rings,all:Stand and rings,test:Test]

// Number of rings
ring_count = 5; // [3:1:9]

// Height/thickness of rings
ring_h = 5; // [3:1:10]

// Radius of smallest ring
ring_r_min = 8.5; // [7:.5:15]

// Radius of biggest ring
ring_r_max = 18; // [12:.5:30]

// Radius of ring hole.
ring_hole_r = 3.5;  // [2:.1:10]

// Fillet radius for rings and pins
fillet_r = 1.5; // [0:.1:2]

// Thickness of base
base_t = 4; // [3:.5:10]

// Fillet radius of base
base_r = 3; // [0:1:20]

// Distance betw biggest ring and base edge
base_ext = 1.6; // [0:.1:10]

// Number of pins
pin_count = 3;// [3:1:6]

// Gap between pins and rings
pin_gap = .3; // [.2:.05:1]


/* [Detail] */
// Fillet detail for rings and pins
fillet_fn = 32; //[4:2:64]

// Ring lathe detail
ring_fn = 128; //[4:2:256]

// Base fillet detail
base_fn = 32; //[4:2:64]

/* [Hidden] */

// Pin lathe detail
pin_fn = ring_fn; //64; // [4, 8, 16, 32, 64, 128]

// Pin radius
pin_r = ring_hole_r - pin_gap; 

// Pin height
pin_h = ring_h*ring_count + ring_h;

// Check that smallest ring diameter is bigger than the hole
ring_r0 = max(ring_r_min, ring_hole_r+1);

// Check that fillet rad isn't too big to cause problems
fillet = min(fillet_r, ring_h/2, pin_r, 
    (ring_r0-pin_r-pin_gap-.001)/2);

if(part == "stand") {
    stand();
} else
if(part == "rings") {
    rings();
} else
if(part == "all") {
    rings();
    translate([0, -ring_r_max*2-base_ext-5, base_t])
    stand();
} else
if(part == "test") {
    stand();
    tower();
    //towers();
}

module rings() {
    m = 5;
    cols = pin_count;
    for(i=[0: ring_count-1]) {
        r = floor(i / cols);
        c = i % cols;
        translate([(ring_r_max*2+m)*c-m/2, (ring_r_max*2+m*0)*r, 0])
        ring(r_out=ring_rad(i), r_in=ring_hole_r, 
            r_fil=fillet, h=ring_h, fn=ring_fn, 
            fil_fn=fillet_fn);
    }
}

module stand() {
    fil = min(ring_r_max+base_ext-.001, base_r);
    dx = 2*(ring_r_max * pin_count - fil + base_ext);
    dy = 2*(ring_r_max + base_ext - fil);
    
    for(i=[0:pin_count-1]) {
        translate([ring_r_max*2*i, 0, 0])
        pin(r=pin_r, h=pin_h, r_fil=fillet, fn=pin_fn, fil_fn=fillet_fn);
    }
    
    translate([-dy/2, -dy/2, -base_t])
    linear_extrude(base_t)
    offset(r=fil, $fn=base_fn)
    square([dx, dy]);
}

module pin(r, h, r_fil, fn, fil_fn) {
    fil = min(r_fil, r);
    
    rotate_extrude($fn=fn) 
    {
        difference() {
            square([r+fil, h-fil]);
            
            translate([r+fil, fil])
            circle(r=fil, $fn=fil_fn);

            translate([r, fil])
            square([fil*2, h]);
        }
        
        difference() {
            translate([r-fil, h-fil])
            circle(r=fil, $fn=fil_fn); 
     
            translate([-fil*2, 0])
            square([fil*2, h]);
        }
        
        translate([0, h-fil])
        square([r-fil, fil]);
    }
}

module ring(r_in, r_out, r_fil, h, fn, fil_fn) {
    fil = min(r_fil, h/2-.001);
    
    rotate_extrude($fn=fn, angle=180*2)
    translate([fil+r_in, fil])
    offset(r=fil, $fn=fil_fn)
    square([r_out-fil*2-r_in, h-fil*2]);
}


function ring_rad(n) =
    ring_r_max - 
    n*(ring_r_max-ring_r0)/(ring_count-1);


module tower() {
    for(i=[0: ring_count-1]) {
        translate([0, 0, ring_h*i])
        ring(r_in=ring_hole_r, r_out=ring_rad(i), 
            r_fil=fillet, h=ring_h, fn=ring_fn, 
            fil_fn=fillet_fn);
    }
}

module towers() {
    for(i=[0:pin_count-1]) {
        translate([ring_r_max*2*i, 0, 0])
        tower();
    }
}
