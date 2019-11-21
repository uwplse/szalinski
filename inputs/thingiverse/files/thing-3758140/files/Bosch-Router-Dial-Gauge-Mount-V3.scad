/************** BEST VIEWED IN A CODE EDITOR 80 COLUMNS WIDE *******************
*
* Bosch Router Dial Gauge Mount
* Benjamen Johnson <workshop.electronsmith.com>
* 20190712
* Version 3
* openSCAD Version:2015.03-2
*******************************************************************************/
// Diameter of the router body
inner_dia = 71;

// Wall thickness of the mounting ring
ring_wall_thickness = 7;

// Height of the entire mount
ring_height = 15;

// Width of the gap in the ring
ring_gap = 10;

// Thickness of bolt tabs (You want enough meat to bury the bolt head)
tab_wall_thickness = 10;

// Length of bolt tabs (measured from inner diameter of ring)
tab_length = 35;

// Diameter of the bolt shaft
bolt_dia = 7;

// Bolt head point to point measurement
bolt_head_pt_to_pt = 12.8;

// Thickness of the mounting tab on the gauge
gauge_tab_gap = 6.5;

// Calculate the outer diameter of the ring
outer_dia = inner_dia+2*ring_wall_thickness;

union(){
    // make the notched ring
    linear_extrude(height = ring_height, center=true, convexity=10,$fn=200)
        difference(){
            circle(d=outer_dia,center=true);
            circle(d=inner_dia,center=true);
            translate([(inner_dia+ring_wall_thickness)/2,0])square([inner_dia/2, ring_gap],center=true);
        } //end difference
        
    //make tabs for tightening
    translate([(inner_dia+tab_length)/2,(ring_gap+tab_wall_thickness)/2])tab(nut=true);
    translate([(inner_dia+tab_length)/2,-(ring_gap+tab_wall_thickness)/2])tab(nut=false);
        
    //make tabs for gauge mount
    translate([(gauge_tab_gap+tab_wall_thickness)/2,-(inner_dia+tab_length)/2]) rotate([0,0,-90])tab(nut=true);
    translate([-(gauge_tab_gap+tab_wall_thickness)/2,-(inner_dia+tab_length)/2]) rotate([0,0,-90]) tab(nut=false);
}// end union


module tab(nut){
    difference(){
        tombstone(tab_length, tab_wall_thickness,ring_height);
        translate([tab_length/2-bolt_head_pt_to_pt/2-2,0])rotate([90,0,0])cylinder(d=bolt_dia, h=tab_wall_thickness*2,center=true,$fn=50);
        if (nut)
            translate([tab_length/2-bolt_head_pt_to_pt/2-2,tab_wall_thickness/2,0])rotate([90,0,0])cylinder(d=bolt_head_pt_to_pt, h=tab_wall_thickness,center=true,$fn=6);
    } //end difference
} // end module

// module for making the tombstone shape (rectangle with rounded end)
module tombstone(l,w,h){
    union(){
        translate([-h/4,0,0])cube([l-h/2, w, h],center=true);
        translate([(l-h)/2,0,0])rotate([90,0,0])cylinder(d=h,h=w,center=true,$fn=100);
    } //end union
} // end module
