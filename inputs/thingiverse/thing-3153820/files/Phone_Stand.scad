

stand_width = 80;
stand_length = 165;
stand_thickness = 8.5;
stand_foot_thickness = 5;
stand_foot_length = 28.5;
stand_head_length = 65;

slot_width = 10;
slot_length = 22;

thru_hole_dia = 83;
shoulder_hole_dia = 86;
shoulder_hole_depth = 3.5;
ring_dia = 93;

slot_length_t = slot_length+thru_hole_dia/2;

footing_cut_rotation = -20;

tol = 0.05;
oversizing = 100;
curve_detail = 4;
curve_detail_base = 64;

translate([0,0,93/2]) rotate([0,90,0]) difference(){
    union(){
        translate([0,0,0]) cube([stand_width,stand_length,stand_thickness],center=true);
        translate([0,(stand_length-stand_thickness)/2,(-stand_head_length+stand_thickness)/2]) cube([stand_width,stand_thickness,stand_head_length],center=true);
        translate([0,(-stand_length+stand_foot_thickness)/2,(stand_foot_length-stand_thickness)/2]) cube([stand_width,stand_foot_thickness,stand_foot_length],center=true);
        cylinder(h=stand_thickness,d=ring_dia,$fn=curve_detail*curve_detail_base,center=true);
    }
    cylinder(h=stand_thickness+tol,d=thru_hole_dia,$fn=curve_detail*curve_detail_base,center=true);
    translate([0,0,(stand_thickness-(shoulder_hole_depth-tol)/2)/2]) cylinder(h=shoulder_hole_depth +tol,d=shoulder_hole_dia,$fn=curve_detail*curve_detail_base,center=true);
    difference(){
        translate([0,stand_length/2,stand_thickness/2]) cube([stand_width+tol,stand_thickness*2,stand_thickness*2],center=true);
        translate([0,(stand_length/2-stand_thickness),-stand_thickness/2]) rotate([0,90,0]) cylinder(h=stand_width+tol,d=stand_thickness*2,$fn=curve_detail*(curve_detail_base/2),center=true);
    }
        rotate([footing_cut_rotation,0,0]) translate([0,0,-(stand_length+oversizing)/2-stand_head_length/2+4]) cube([stand_length+oversizing,stand_length+oversizing,stand_length+oversizing],center=true);
        translate([0,-slot_length_t/2,0]) cube([slot_width,slot_length_t,stand_thickness+tol],center=true);
    difference(){
        translate([stand_width/2,(-stand_length+stand_foot_thickness)/2,stand_foot_length-stand_thickness/2]) cube([stand_foot_thickness*2,stand_foot_thickness+tol/2,stand_foot_thickness*2],center=true);
        translate([stand_width/2-stand_foot_thickness,(-stand_length+stand_foot_thickness)/2,stand_foot_length-stand_thickness/2-stand_foot_thickness]) rotate([90,0,0]) cylinder(h=stand_foot_thickness+tol,d=stand_foot_thickness*2,$fn=curve_detail*(curve_detail_base)/2,center=true);
    }
    difference(){
        translate([-stand_width/2,(-stand_length+stand_foot_thickness)/2,stand_foot_length-stand_thickness/2]) cube([stand_foot_thickness*2,stand_foot_thickness+tol/2,stand_foot_thickness*2],center=true);
        translate([-stand_width/2+stand_foot_thickness,(-stand_length+stand_foot_thickness)/2,stand_foot_length-stand_thickness/2-stand_foot_thickness]) rotate([90,0,0]) cylinder(h=stand_foot_thickness+tol,d=stand_foot_thickness*2,$fn=curve_detail*(curve_detail_base)/2,center=true);
    }
}

