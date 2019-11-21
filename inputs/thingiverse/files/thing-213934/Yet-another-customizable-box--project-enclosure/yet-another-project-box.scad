// http://www.thingiverse.com/thing:213934

// ================ variables

//CUSTOMIZER VARIABLES

/* [Main] */

// in mm
x_width=100;

// in mm
y_width=200;

// in mm
height=50;

// Wall thickness in mm
thickness=2; // [1:10]

// Corner roundover in mm (0=sharp corner)
radius=5; // [0:50]

// Generate the box
do_box=1; // [0:no,1:yes]

// Generate a lid
do_lid=1; // [0:no,1:yes]

// height in mm
lid_thickness=5;

//CUSTOMIZER VARIABLES END

// Screw pilot hole size
screw_pilot=1.125*1;

// Screw hole size
screw_hole=2.5*1;

// Whether you want the screw countersunk
screw_countersink=0*1;

// =============== calculated variables
lid_height=min(height/4,lid_thickness);
corner_radius=min(radius,x_width/2,y_width/2);
xadj=x_width-(corner_radius*2);
yadj=y_width-(corner_radius*2);
snugfit=0.5/2;

// =============== program

// ---- The box
if(do_box==1) translate([-((x_width/2+1)*do_lid),0,height/2-thickness]) difference() {

union() {
minkowski() // main body
{
 cube([xadj,yadj,height-lid_height],center=true);
 cylinder(r=corner_radius,h=height-lid_height);
}

translate([0,0,lid_height-thickness]) minkowski() // main body overlap
{
 cube([xadj-thickness,yadj-thickness,height-(thickness*2)],center=true);
 cylinder(r=corner_radius,h=height);
}
}

translate([0,0,thickness*2]) minkowski() // inside area
{
 cube([xadj-((thickness+snugfit)*2),yadj-((thickness+snugfit)*2),height],center=true);
 cylinder(r=corner_radius,h=height);
}

};

// ---- The lid
if(do_lid==1) translate([(x_width/2+1)*do_box,0,lid_height/2]) {

difference() {
minkowski() // main body
{
 cube([xadj,yadj,lid_height],center=true);
 cylinder(r=corner_radius,h=lid_height);
}

translate([0,0,thickness]) minkowski() // inside area
{
 cube([xadj-(thickness-snugfit),yadj-(thickness-snugfit),lid_height],center=true);
 cylinder(r=corner_radius,h=lid_height);
}
}

};

