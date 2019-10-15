/*TODO:
    1. add coin/thumbnail notch for easy box opening
    2. separate base thicknes parameter - for heavier base with thinner walls
    3. convex slot (easy fit)
    4. separate slot height gap (close/seamless fit)
*/


/*[main size]*/
width = 70;
depth = 70;
height = 22;
shell = 4;
outer_radius = 6;
inner_radius = 8;

/*[slot]*/
//includes tray height
slot_height = 4; 
slot_width = 2;


/*[lid]*/
// 0 to disable lid generation
lid_height=12;
//adjust gap to fit the lid
gap = 0.85;

//main box
difference(){
    rounded_box(width, depth, height, outer_radius);
    translate([shell, shell, shell]) rounded_box(width-shell*2, depth-shell*2, height-shell, inner_radius);
}


//slot
if (lid_height != 0) {

    difference(){
        translate([slot_width, slot_width,0]) rounded_box(width-slot_width*2,    depth-slot_width*2, height+slot_height, inner_radius);
        translate([shell, shell, shell+slot_height]) rounded_box(width-shell*2,    depth-shell*2, height-shell, inner_radius);

    }

    //lid
    translate([width*1.5,0,0]){
        difference(){
            rounded_box(width, depth, lid_height, outer_radius);
            translate([shell, shell, shell]) rounded_box(width-shell*2, depth-shell*2, height-shell, inner_radius);
            translate([slot_width-gap, slot_width-gap,2*inner_radius+(lid_height-slot_height)]) 
            mirror([0,0,1]) 
            rounded_box(width-(slot_width-gap)*2, depth-(slot_width-gap)*2, 2*inner_radius, inner_radius);       
        }
    }
}

module rounded_box(w, d, h, r) { 
        //vertical edges
        translate([r,r,r]) mcylinder(h-r, r=r);
        translate([w-r,r,r]) mcylinder(h-r, r=r);
        translate([w-r,d-r,r]) mcylinder(h-r, r=r);
        translate([r,d-r,r]) mcylinder(h-r, r=r);
        
        //inner part hollow
        translate([r,0,r]) cube([w-r*2, d, h-r]);
        translate([0,r,r]) cube([w, d-r*2, h-r]);
    
        //corners
        translate([r, r, r]) msphere(r=r);
        translate([w-r, r, r]) msphere(r=r);
        translate([w-r, d-r, r]) msphere(r=r);   
        translate([r, d-r, r]) msphere(r=r); 
    
        //bottom edges
        translate([r,r,r]) rotate([0,90,0]) half_cylinder(w-r*2, r=r);
        translate([r, d-r, r]) rotate([0,90,0]) rotate([0,0,90]) mcylinder(w-r*2, r=r);      
        translate([r, r, r]) rotate([-90,0,0]) rotate([0,0,180]) mcylinder(d-r*2, r=r);
        translate([w-r, r, r]) rotate([-90,0,0]) rotate([0,0,180]) mcylinder(d-r*2, r=r);
    
        translate([r, r, 0]) cube([w-r*2, d-r*2, h]);    
}

module msphere(r) {
    sphere(r, $fn=50); 
}

module mcylinder(h, r) {
    cylinder(h, r=r, $fn=50); 
}

module half_cylinder(h, r) {
   difference(){
        mcylinder(h, r=r);
        translate([-r,0,0])cube([r*2*2, r*2, h]);
   }  
} 

