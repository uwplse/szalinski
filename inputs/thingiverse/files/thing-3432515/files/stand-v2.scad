// OpenSCAD file to create custom sized/configured phone or tablet stand.
//
// preview[view:south east, tilt:top diagonal]
//
// Created May 29th, 2018 by Allan M. Estes
// First upload to Thingiverse Feb. 16th, 2019
//
// to do:
//   allow interior corner fillets to be scalled
//
// Last modified Feb. 16th, 2019

orientation = 1; // [1:for viewing,0:for printing]
// - how thick the base, back and face will be.
thick = 4;
// - overall width of stand.
stand_width  = 50;
// (base dimensions are width x base_length x thick)
base_length  = 63;  // outside measure
// (back dimensions are width x back_length x thick)
back_length = 67;  // back outside measure
// - zero degrees is folded flat against base, ninety is vertical.
back_angle  = 62;  // [1:179]
// (face/front dimensions are width x face_length x thick)
face_length  = 53;  // face outside measure
// - zero degrees is horizontal, negative ninety is hanging vertically.
face_angle  = -68;  // [-90:0]

// - device rests on ledge, it should equal or excced device thickness
ledge = 7;  // inside measure
// - creates opening in ledge (for charge cable, etc.), 0 to disable
ledge_gap_length = 22;
// - gap position: >0 moves gap left of stand center, <0 moves right
ledge_gap_offset = 0;

// - size of notch at end/edge of ledge (headphone plug, speaker, etc.), 0 for none, >0 on left end, <0 on right end
ledge_edge_slot_length = 9;
ledge_edge_slot_width = 3.5;
ledge_edge_slot_pos = 0;    // [1:back of ledge,0:center of ledge,-1:front_of ledge]

// - opening in back and face (depending on angles and sizes) of stand
arch_width  = 22;        // must be narrower than width
arch_height = 33;       // must be larger than or equal to arch_width

// - internal fill at bends.
fillet = 2; // [1:minumum, 2:light, 3:medium, 4:heavy, 5:maximum]

module dummy(x) {
}

$fn=24;

lip = 2.5;  //outside measure

ledge_thick = thick * .75;
ledge_edge_slot_pct = min(ledge,ledge_edge_slot_width)/ledge;

width = stand_width;
base  = base_length-thick*1.5;
back = back_length-thick*2;
face  = face_length-thick-ledge_thick/2;

base_back_angle = back_angle;
back_face_angle =  180+face_angle-back_angle;

orient_x   = orientation ? width/2 : -base/2;
orient_y   = orientation ? base_length/2 : -sin(back_angle)*back_length/2;
orient_rot = orientation ? 90 : 0;

//  Start of Code...

module fold(angle,radius,hgt) {
foo = min(angle,90)/90 * fillet;
thy = radius*foo/sin(angle/2);
hy = radius*foo*1.1/sin(angle/2);
hi = radius*foo*1.1*cos(angle/2);
ry = radius*1.1/sin(angle/2);
ri = radius*1.1*cos(angle/2);
x = hi/tan(angle/2);
    // fillet
    difference(){
        translate([(thy-hy),0,0]) linear_extrude(height=hgt) polygon([[0,0],[x,hi],[hy,0],[x,-hi]]);
    
        translate([thy,0,-.1])
        cylinder(r=radius*foo,h=hgt+.2);
    }
    // rounding
    difference(){
        cylinder(r=radius,h=hgt);
        translate([0,0,-.1]) linear_extrude(height=hgt+.2) polygon([[0,0],[ri,ry],[ry,ry],[ry,-ry],[ri,-ry]]);
    }
}


module ledge_slots() {
    if (ledge_gap_length>0) translate([thick,-.1,width/2+ledge_gap_offset-ledge_gap_length/2])
    cube([ledge+thick,lip*4+.1,ledge_gap_length]);

    if (ledge_edge_slot_length>0) translate([ledge/2+thick+((1-ledge_edge_slot_pct)*ledge/2*ledge_edge_slot_pos),-.1,width-ledge_edge_slot_length/2]) {
        rotate([-90,90,0])
        cylinder(d=ledge*ledge_edge_slot_pct,h=ledge_thick+.2);
        translate([-ledge/2*ledge_edge_slot_pct,0,0])
        cube([ledge*ledge_edge_slot_pct,ledge_thick+.2,ledge_edge_slot_length]);
    }

    if (ledge_edge_slot_length<0) translate([ledge/2+thick+((ledge_edge_slot_pct)*ledge/2*ledge_edge_slot_pos),-.1,-ledge_edge_slot_length-ledge/2]) {
        rotate([-90,90,0])
        cylinder(d=ledge*ledge_edge_slot_pct,h=ledge_thick+.2);
        translate([-ledge/2*ledge_edge_slot_pct,0,ledge_edge_slot_length])
        cube([ledge*ledge_edge_slot_pct,ledge_thick+.2,-ledge_edge_slot_length]);
    }
}


translate([orient_x,orient_y,0]) rotate([orient_rot,0,-orient_rot])  // position for display or printing
difference() {
    union() {
        //base/back rounding&fillet
        translate([0,thick,0]) rotate(base_back_angle/2,0,0) fold(base_back_angle,thick,width);
        //base front rounding
        translate([base,thick/2,0])
        cylinder(d=thick,h=width);
        //base
        cube([base,thick,width]);
        
        translate([0,thick,0]) rotate([0,0,base_back_angle-90]) {
            //back
            translate([-thick,0,0]) cube([thick,back,width]);
        
            translate([0,back,0]) rotate([0,0,back_face_angle]) translate([0,-face,0]) {
                //face/back rounding&fillet
                translate([0,face,0]) rotate([0,0,-90-back_face_angle/2]) fold(back_face_angle,thick,width);
                //face
                cube([thick,face,width]);

                translate([0,-ledge_thick/2,0]) difference() { // ledge w/holes) & lip
                    union() {
                        translate([ledge_thick/2,0,0]) {
                            //ledge
                            cube([ledge+thick,ledge_thick,width]);
                            //face+ledge rounding
                            translate([0,ledge_thick/2,0])
                            cylinder(d=ledge_thick,h=width);
                        }
                        translate([ledge+thick+ledge_thick/2,ledge_thick/2,0]){
                            //lip
                            translate([-ledge_thick/2,0,0])
                            cube([ledge_thick,lip+(ledge_thick/2),width]);
                            //ledge+lip rounding
                            cylinder(d=ledge_thick,h=width);
                            //lip rounding
                            translate([0,lip+(ledge_thick/2),0])
                            cylinder(d=ledge_thick,h=width);
                        }
                    }
                    ledge_slots();
                }
            }
        }
    }
    //through hole
    translate([-base,thick+.01,(width-arch_width)/2])
    union(){
        cube([base*2.5,arch_height-arch_width/2,arch_width]);
        translate([0,arch_height-arch_width/2,arch_width/2])
        rotate([0,90,0])
        cylinder(d=arch_width,h=base*2.5);
    }
}