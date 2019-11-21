plug_height=8;
plug_radius_small=11;
plug_radius_big=13;
lid_height=2;
lid_radius=14;
/* [Hidden] */
fn=240;

cylinder(r=lid_radius,h=lid_height,$fn=fn);

translate([0,0,lid_height])cylinder(r1=plug_radius_big,r2=plug_radius_small,h=plug_height,$fn=fn);


