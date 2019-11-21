// Robot DC-motor: sensor keyesIR - holder

// Vertical part.
h_vert = 40;
w_vert = 11;
d_vert =  3;

// Internal diameter of nut.
id_nut = 3.3;

// Out diameter of nut.
od_nut = 7;

// Height of nut.
h_nut = 4;

// Length and diameter of screws.
len_screw = 20;
dia_screw = 3.3;

// Horizontal part.
h_horiz = 10;
w_horiz = 11;
d_horiz =  20;

// Width of chassis.
w_chassis = 3.2;

// Vertical hole.
h_vhole = h_vert - 2*id_nut - (h_horiz - w_chassis)/2;
w_vhole = id_nut;
d_vhole =  10;

// Width of chassis.
w_chassis = 3.2;

// Horizontal hole.
h_hhole = w_chassis;
w_hhole = w_horiz+1;
d_hhole = d_horiz;

// Block of nut.
h_nut_hole = (h_horiz - w_chassis)/2 + 1;
w_nut_hole = w_horiz+1;
d_nut_hole = od_nut;


module solid_part() {
  union() {
// Vertical part.
    translate([h_vert/2, 0, d_vert/2])
      cube([h_vert, w_vert, d_vert], center = true);
    
// Horizontal part.
    translate([0, 0, d_horiz/2])
      cube([h_horiz, w_horiz, d_horiz], center = true);
  }    
}    

module  holes() {
    
  union() {    
// Vertical hole.
    translate([h_vhole/2 + id_nut + (h_horiz - w_chassis)/2, 0, d_vhole/2 - 0.5])  
      cube([h_vhole, w_vhole, d_vhole], center = true);
    translate([(h_vhole/2 + (h_horiz - w_chassis)/2-d_vhole-w_vhole/2),0,0])
        cylinder(r=w_vhole/2, h=d_vhole, center=true, $fn = 50);
    translate([(h_vhole/2 + (h_horiz - w_chassis)/2+d_vhole+w_vhole/2+ id_nut*2),0,0])
        cylinder(r=w_vhole/2, h=d_vhole, center=true, $fn = 50); 
     
    translate([0,w_vert/2,d_vert*2+4])
      rotate([45,0,0])
        cube([6,6,6]);
    translate([0,-w_vert/2,d_vert*2+4])
      rotate([45,0,0])
        cube([6,6,6]);
    
// Horizontal hole.
    translate([0, 0, d_horiz/2 + d_vert])
      cube([h_hhole, w_hhole, d_hhole], center = true);  

// Block of nut.
    translate([(h_horiz - w_chassis)/2, 0, d_horiz/2 + d_nut_hole])
      cube([h_nut_hole, w_nut_hole, d_nut_hole], center = true);  

// Screw hole.
    translate([0, 0, d_horiz/2 + d_nut_hole])
      rotate(a=[0,90,0])      
        cylinder(h = len_screw, r1 = dia_screw/2, r2 = dia_screw/2, $fn = 8, center = true);      
        

// Nut hole.
    translate([-h_nut/2, 0, d_horiz/2 + d_nut_hole])
      rotate(a=[ 0, 90, 0])      
        cylinder(h = h_nut, r1 = od_nut/2, r2 = od_nut/2, $fn = 6, center = true);      
  }      

}

difference() {
  solid_part();
  holes();  
} 