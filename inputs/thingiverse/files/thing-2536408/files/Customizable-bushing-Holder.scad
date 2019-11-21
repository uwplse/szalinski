bearing_diameter = 15;
bearing_length = 24;
mounting_hole_dia = 3;
tap_tolerance = 0.5;
pad_thickness = 3;
pad_length = 12;
holder_thickness = 3;
screw_tab_length = 5;
Screw_plates_length = screw_tab_length+holder_thickness;
Screw_plates_thickness = 2;
/* [Hidden] */
precision = 360;
module holder(b_d, b_l, m_h_d, t_t, p_t, h_t, p){
    difference(){
        cylinder(h=b_l,d=b_d+h_t,$fn=p);
        cylinder(h=b_l,d=b_d,$fn=p);
        translate([-(holder_thickness),-b_d/2-holder_thickness,0])cube([holder_thickness*2, holder_thickness*2, b_l]);
    }
}
module base(p_t, p_l, b_l, b_d, m_h_d, t_t, p, h_t){
    difference(){
        union(){
            cube([p_l+(b_d/2), p_t, b_l]);
            translate([-p_l-(b_d/2),0,0])cube([p_l+(b_d/2), p_t, b_l]);
        }
        translate([0,-(b_d+h_t)/2+p_t,0])cylinder(h=b_l,d=b_d+h_t,$fn=p);
       translate([p_l,p_t+0.5,b_l*1/4])rotate([90,0,0])cylinder(h=p_t+1, d= m_h_d-t_t, $fn=precision);
    translate([p_l,p_t+0.5,b_l*3/4])rotate([90,0,0])cylinder(h=p_t+1, d= m_h_d-t_t, $fn=precision);
        translate([-p_l,p_t+0.5,b_l*1/4])rotate([90,0,0])cylinder(h=p_t+1, d= m_h_d-t_t, $fn=precision);
    translate([-p_l,p_t+0.5,b_l*3/4])rotate([90,0,0])cylinder(h=p_t+1, d= m_h_d-t_t, $fn=precision);
    }
    
}
module screwtab(b_d, b_l, m_h_d, t_t, p_t, h_t, p, s_l, s_t){
    difference(){        
            translate([h_t,-s_l-(b_d)/2+h_t,b_l/4])cube([s_t,s_l,b_l/2]);
        translate([0,-b_d/2-s_l/2+(m_h_d-t_t)/2,b_l/2])rotate([0,90,0])cylinder(h=s_l+150,d=m_h_d-t_t,$fn=precision);
        difference(){
            cylinder(h=b_l,d=b_d+h_t,$fn=p);
            cylinder(h=b_l,d=b_d,$fn=p);
            translate([-(holder_thickness),-b_d/2-holder_thickness,0])cube([holder_thickness*2, holder_thickness*2, b_l]);
        }
            cylinder(h=b_l,d=b_d,$fn=p);
            translate([-(holder_thickness),-b_d/2-holder_thickness,0])cube([holder_thickness*2, holder_thickness*2, b_l]);    
    }
     
    difference(){
            translate([-h_t-s_t,-s_l-(b_d)/2+h_t,b_l/4])cube([s_t,s_l,b_l/2]);
        translate([-s_l,-b_d/2-s_l/2+(m_h_d-t_t)/2,b_l/2])rotate([0,90,0])cylinder(h=s_l+150,d=m_h_d-t_t,$fn=precision);
            difference(){
            cylinder(h=b_l,d=b_d+h_t,$fn=p);
            cylinder(h=b_l,d=b_d,$fn=p);
            translate([-(holder_thickness),-b_d/2-holder_thickness,0])cube([holder_thickness*2, holder_thickness*2, b_l]);
                
        }
            cylinder(h=b_l,d=b_d,$fn=p);
            translate([-(holder_thickness),-b_d/2-holder_thickness,0])cube([holder_thickness*2, holder_thickness*2, b_l]);       
    }
}

module final_product(bearing_diameter, bearing_length, mounting_hole_dia, tap_tolerance, pad_length, pad_thickness, holder_thickness, precision, Screw_plates_length, Screw_plates_thickness){
    translate([0,-(bearing_diameter+holder_thickness)/2+pad_thickness,0])holder(bearing_diameter, bearing_length, mounting_hole_dia, tap_tolerance, pad_thickness, holder_thickness, precision);
    base(pad_thickness, pad_length, bearing_length, bearing_diameter, mounting_hole_dia, tap_tolerance, precision, holder_thickness);
    translate([0,-bearing_diameter/2+holder_thickness/2,0])screwtab(bearing_diameter, bearing_length, mounting_hole_dia, tap_tolerance, pad_thickness, holder_thickness, precision, Screw_plates_length, Screw_plates_thickness);
}

final_product(bearing_diameter, bearing_length, mounting_hole_dia, tap_tolerance, pad_length, pad_thickness, holder_thickness, precision, Screw_plates_length, Screw_plates_thickness);