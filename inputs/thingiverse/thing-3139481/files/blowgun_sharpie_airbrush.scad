set_screw_dia=5.5;
radius=5;
$fn=50;

sharpie_hole_dia=17; //sized for Sharpie fine tip on small end
sharpie_hole_length=23; //sized for Sharpie chisel tip on lg end
sharpie_hole_depth=26;
sharpie_cube_width=25;
sharpie_cube_length=30;
sharpie_cube_height=27;
sharpie_points=[[radius,radius,0],[sharpie_cube_width-radius,radius,0],[radius,sharpie_cube_length-radius],[sharpie_cube_width-radius,sharpie_cube_length-radius,0]];


blowgun_hole_dia_lg=13;
blowgun_hole_dia_sm=10;
blowgun_hole_depth=33;
blowgun_cube_width=30;
blowgun_cube_length=30;
blowgun_cube_height=27;
blowgun_notch_width=4.5;
blowgun_points=[[radius,radius,0],[blowgun_cube_width-radius,radius,0],[radius,blowgun_cube_length-radius],[blowgun_cube_width-radius,blowgun_cube_length-radius,0]];

sharpie_blowgun_angle=45;

difference(){
solid_part();
holes();
}

module solid_part(){
hull(){
//sharpie cube
translate([0,blowgun_cube_length-radius,0])
rotate([0,0,sharpie_blowgun_angle])
hull(){
for (a=[0:3])
translate(sharpie_points[a])
cylinder(r=radius,h=sharpie_cube_height);
}

//blowgun cube
hull(){
for (a=[0:3])
translate(blowgun_points[a])
cylinder(r=radius,h=blowgun_cube_height);
}
}
}

module holes(){
//sharpie holes
translate([-15,blowgun_cube_length-radius+cos(sharpie_blowgun_angle)*sharpie_cube_length/2-radius-2,sharpie_cube_height/2])
rotate([0,90,sharpie_blowgun_angle])
cylinder(d=sharpie_hole_dia,h=sharpie_cube_width+15);
translate([-15,blowgun_cube_length-radius+cos(sharpie_blowgun_angle)*sharpie_cube_length/2-radius-2+(sharpie_hole_length-sharpie_hole_dia),sharpie_cube_height/2])
rotate([0,90,sharpie_blowgun_angle])
cylinder(d=sharpie_hole_dia,h=sharpie_cube_width+15);

translate([sin(sharpie_blowgun_angle)*sharpie_cube_width/2,blowgun_cube_length-radius+15,sharpie_cube_height/2])
rotate([-90,0,sharpie_blowgun_angle])
cylinder(d=set_screw_dia,h=sharpie_cube_width/2+20);


//blowgun hole
translate([-10,blowgun_cube_length/2,blowgun_cube_height/2])
rotate([0,90,0])
cylinder(d=blowgun_hole_dia_sm,h=blowgun_cube_width/4+10);
translate([blowgun_cube_width/4,blowgun_cube_length/2,blowgun_cube_height/2])
rotate([0,90,0])
cylinder(d=blowgun_hole_dia_lg,h=blowgun_cube_width/2+10);

translate([blowgun_cube_width/2,-10,blowgun_cube_height/2])
rotate([-90,0,0])
cylinder(d=set_screw_dia,h=blowgun_cube_length/2+10);

//blowgun notch
translate([blowgun_cube_width/2,blowgun_cube_width/2-blowgun_notch_width/2,0])
cube([blowgun_cube_width/2,blowgun_notch_width,blowgun_cube_height]);
}