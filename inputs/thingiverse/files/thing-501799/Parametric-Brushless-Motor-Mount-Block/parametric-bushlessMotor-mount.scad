//Parametric brushless_motor mount.
//Oktay Gülmez, 15/10/2014.
//GNU_GPL_V3.

//Parameters:
printerLine_width=0.6;
mountHoles_width=23;
mountHoles_height=23;
mountHoles_diameter=3;
mount_lenght=19;
down_angle=0;
right_angle=0;
corner_radius=3.5;

viewSmooter=8;

mountHoles_radius=mountHoles_diameter/2+printerLine_width/2;

$fn=mountHoles_radius*viewSmooter;

difference(){
  union(){
    minkowski(){
     translate([corner_radius,corner_radius,0]) cube([mountHoles_width,mountHoles_height,mount_lenght+5]);
       cylinder(r=corner_radius, $fn=corner_radius*viewSmooter);
    }
  }
 translate([(2*corner_radius+mountHoles_width)/2,(2*corner_radius+mountHoles_height)/2,0]) cylinder(h=mount_lenght+10, r=mountHoles_width/2.5, $fn=(mountHoles_width/2.5)*viewSmooter);
 
 translate([(2*corner_radius+mountHoles_width)/2,-mountHoles_width/5,mount_lenght/2]) rotate([-120,0,0]) cylinder(h=mount_lenght+10, r=mountHoles_width/4, $fn=(mountHoles_width/4)*viewSmooter);

 translate([corner_radius,corner_radius,0]) cylinder(h=mount_lenght+10, r=mountHoles_radius);
 translate([corner_radius+mountHoles_width,corner_radius,0]) cylinder(h=mount_lenght+10, r=mountHoles_radius);
 translate([corner_radius,corner_radius+mountHoles_height,0]) cylinder(h=mount_lenght+10, r=mountHoles_radius);
 translate([corner_radius+mountHoles_width,corner_radius+mountHoles_height,0]) cylinder(h=mount_lenght+10, r=mountHoles_radius);

 translate([0,0,mount_lenght]) rotate([down_angle,-right_angle,0]) cube([mountHoles_width+3*corner_radius,mountHoles_height+3*corner_radius,10]);
}
