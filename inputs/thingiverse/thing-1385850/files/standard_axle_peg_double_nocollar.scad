l=150;
w=22;
h=20;
t=1;
g=20;
peg_number_x=5;
peg_number_y=2;
$fn=50;



tolerance=0.1;
indent_hole_radius=6.5; 
thickness=2;
axle_radius=2.8; //3
axle_length=20;

spacer_height=0; //Collar



translate([0,-g*2,0])
difference()
{
//tack indent
difference()
{
rotate([0,0,180])
hull()
{translate([0,-g,0])
cylinder(r=axle_radius+1,h=2*t); //h/5 originally

cylinder(r=indent_hole_radius+thickness,h=2*t);}
//lip
translate([0,0,t])
cylinder(r=indent_hole_radius+tolerance,h=h);
}
//hole
translate([0,0,-h/2])
cylinder(r=1.5,h=w+5);
}


module peg ()
{
translate([0,-g*2,0])
difference()
{
//tack indent
difference()
{
rotate([0,0,180])
hull()
{translate([0,-g,0])
cylinder(r=axle_radius+1,h=2*t); //h/5 originally

cylinder(r=indent_hole_radius+thickness,h=2*t);}
//lip
translate([0,0,t])
cylinder(r=indent_hole_radius+tolerance,h=h);
}
//hole
translate([0,0,-h/2])
cylinder(r=1.5,h=w+5);
}

difference()
{
//tack indent
difference()
{
hull()
{translate([0,-g,0])
cylinder(r=axle_radius+1,h=2*t); //h/5 originally
cylinder(r=indent_hole_radius+thickness,h=2*t);}
//lip
translate([0,0,t])
cylinder(r=indent_hole_radius+tolerance,h=h);
}
//hole
translate([0,0,-h/2])
cylinder(r=1.5,h=w+5);
}




translate([0,-g,0])
cylinder(r=axle_radius-tolerance,h=axle_length); //h/5 originally


translate([0,-g,0])
cylinder(r=axle_radius+1,h=spacer_height+thickness);

}


for (i=[0:peg_number_x-1], j=[0:peg_number_y-1])
{
translate([indent_hole_radius*4*i, g*3*j, 0])
peg();

}



