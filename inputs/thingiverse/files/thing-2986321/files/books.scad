/* [Parameters] */
width = 8;
height = 14;
thickness = 4;

/* [Hidden] */
$fn = 32;
cover_thick = 0.8;
cover_height = 0.8;
ring_thick = 0.4;

// preview[view:north east, tilt:top diagonal]

module ring(w,h,t) {
    scale([0.8,1,1])
    
    difference() {
        rotate_extrude(convexity = 10)
        translate([(t/2-ring_thick), 0, 0])
        circle(r = ring_thick, $fn = 100);
        
        translate([w/2,0,0])
        cube([w,t*2,h*2], center=true);
    }
}



module covers(w,h,t) {

    translate([-w/2,0,h*0.5+ring_thick])    
    ring(w,h,t);

    translate([-w/2,0,h*0.3])    
    ring(w,h,t);

    
    translate([-w/2,0,(h*-0.5)+ring_thick])    
    ring(w,h,t);
    
    difference() {
        translate([-w/2,0,cover_height/2])
        scale([0.7,1,1])
        cylinder(r=t*0.51, h=h+cover_height, center=true);

        translate([-w/2,0,cover_height])
        scale([0.7,1,2])
        cylinder(r=(t*0.51-cover_thick), h=h*2, center=true);
        
        cube([w, t, h*2], center=true);

    }
        
    translate([0,(t-cover_thick)*-0.51 ,(cover_height/2)])
    cube([w,cover_thick,(h+cover_height)], center=true);
    
    translate([0,(t-cover_thick)*0.51 ,(cover_height/2)])
    cube([w,cover_thick,(h+cover_height)], center=true);

}


module pages(w, h, t) {
    translate([-w/2,0,0])
    scale([0.7,1,1])
    cylinder(r=t/2, h=h, center=true);
    
    difference() {
        cube([w, t, h], center=true);

        translate([w/2,0,0])
        scale([0.4,1,1])
        cylinder(r=t/2, h=h*2, center=true); 
    }
}




module book(w, h, t) {
    union() {
    color([1,1,1])
    pages(w,h,t);
    
    color([0.627, 0.423, 0.054])
    covers(w,h,t);
    }
}




book(width, height, thickness);