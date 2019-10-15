/* [Spacer] */

//spacer outer diameter
outer_diameter=22;

//spacer inner diameter
inner_diameter=8;

//spacer width (including profil shift)
spacer_width=3;

//profil shift width(in % of spacer width)
profil_shift_width=0.35;//[0:0.05:1]

//profil shift thickness
profil_shift_thickness=2;


/* [Optional Screw Lead] */
//Set option
option=1; //[1:yes,-1:no]

//bearing width
bearing_width=7;

//screw diameter
screw_diameter=4;

/* [Fine Tunning] */
//tolerance (XY compensation)
tolerance=0.1;

//definition
definition=100;//[50:low,100:medium,150:high]


/////////////////////
$fn=definition;

module spacer() {
difference() {
union() {
cylinder(d=outer_diameter-2*tolerance,h=spacer_width*(1 - profil_shift_width));
cylinder(d=inner_diameter + 2*profil_shift_thickness - 2*tolerance, h=spacer_width);
cylinder(d=inner_diameter - 2*tolerance, h=spacer_width + bearing_width/2 - 0.5);
}

if(option==1){
translate([0,0,-1]) cylinder(d=screw_diameter + 2*tolerance, h=spacer_width + bearing_width +2);
}
else {
translate([0,0,-1]) cylinder(d=inner_diameter + 2*tolerance, h=spacer_width + bearing_width +2);
}
}
}



spacer();
