$fn=32;

box_x=189.5;
box_y=43;
box_z=20;
wall=0.4*3;
z_offset=2;
module vga(xl=14.0,xh=16.5,y=8.5,d=2){
    translate([-25/2,y/2,0])circle(d=4);
    translate([+25/2,y/2,0])circle(d=4);
    translate([-xh/2,d/2,0])hull(){
        translate([0,y,0])circle(d=d);
        translate([xh,y,0])circle(d=d);
        translate([xh-(xh-xl)*0.5,0,0])circle(d=d);
        translate([(xh-xl)*0.5,0,0])circle(d=d);
        
    }
}
module one_hole(sx,sy=0){
    translate([sx,sy,0])children();
}
module holes(){
    one_hole(14.1-9.9/2)square([9.9,10.8]);
    one_hole(40,6.2-8.2/2)vga();
    one_hole(67-13/2)square([13,6.1]);
  //тюльпанчики  
    one_hole(97,6.8)circle(d=8.3);
    one_hole(97+14,6.8)circle(d=8.3);
    one_hole(97-14,6.8)circle(d=8.3);
    
    one_hole(124,7)circle(d=6);
    one_hole(133.8,7)circle(d=6);
    one_hole(153-14.5/2)square([14.5,7]);
    
    one_hole(181,6.5)circle(d=9);
}
module uho(){
   difference(){
    hull(){
        cylinder(d=7,h=3);
        translate([-3,-3,box_z/2])cube([0.01,6,0.01]);
       translate([-3,-3,0])cube([0.01,6,0.01]);
   }
        cylinder(d=3,h=100);
        translate([0,0,2])cylinder(d=5.5,h=100);
   }
   translate([0,0,2-0.2])cylinder(d=3,h=0.2);
}
module uhos(){
//vga();
translate([-3,-2,3])rotate([-90,180,0])uho();
translate([-3,-2,box_y+wall*2-3])rotate([-90,180,0])uho();
translate([box_x+wall*2+3,-2,box_y+wall*2-3])rotate([-90,180,0])mirror([1,0,0])uho();
translate([box_x+wall*2+3,-2,3])rotate([-90,180,0])mirror([1,0,0])uho();

}
module corner_strongeners(){
    translate([wall,0,wall])rotate([-90,0,0])cylinder(d=wall*2,h=box_z-wall*2);
    translate([wall+box_x,0,wall])rotate([-90,0,0])cylinder(d=wall*2,h=box_z-wall*2);
    translate([wall+box_x,0,wall+box_y])rotate([-90,0,0])cylinder(d=wall*2,h=box_z-wall*2);
    translate([wall,0,wall+box_y])rotate([-90,0,0])cylinder(d=wall*2,h=box_z-wall*2);


    
}


module plate_fixators(fd=6.5){
    difference(){
        union(){
            translate([wall+3,z_offset,wall+18])rotate([-90,0,0])cylinder(d=fd,h=box_z-wall-z_offset-2);
            translate([wall+3,z_offset,wall+39])rotate([-90,0,0])cylinder(d=fd,h=box_z-wall-z_offset-2);
            translate([wall+143.5,z_offset,wall+39])rotate([-90,0,0])cylinder(d=fd,h=box_z-wall-z_offset-2);
            translate([wall+143.5,z_offset,wall+18])rotate([-90,0,0])cylinder(d=fd,h=box_z-wall-z_offset-2);
            hull(){
                translate([wall+3,z_offset+2,wall+18])rotate([-90,0,0])cylinder(d=fd,h=box_z-wall-z_offset-2);
                translate([wall+3,z_offset+2,wall+39])rotate([-90,0,0])cylinder(d=fd,h=box_z-wall-z_offset-2);
            }
            hull(){
                translate([wall+143.5,z_offset+2,wall+18])rotate([-90,0,0])cylinder(d=fd,h=box_z-wall-z_offset-2);
                translate([wall+143.5,z_offset+2,wall+39])rotate([-90,0,0])cylinder(d=fd,h=box_z-wall-z_offset-2);
            }
        }
        union(){
            translate([wall+3,0,wall+18])rotate([-90,0,0])cylinder(d=2.5,h=box_z-wall);
            translate([wall+3,0,wall+39])rotate([-90,0,0])cylinder(d=2.5,h=box_z-wall);
            translate([wall+143.5,0,wall+39])rotate([-90,0,0])cylinder(d=2.5,h=box_z-wall);
            translate([wall+143.5,0,wall+18])rotate([-90,0,0])cylinder(d=2.5,h=box_z-wall);
        }
    }
}
uhos();
corner_strongeners();
plate_fixators();



difference(){
    translate([0,-2,0])cube([box_x+wall*2,box_z+wall,box_y+wall*2]);
    translate([0,z_offset,-0.01])linear_extrude(20)holes();
    translate([wall,-2.1,wall])cube([box_x,box_z,box_y]);
}
