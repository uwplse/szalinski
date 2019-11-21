use <write/Write.scad>;

//What coin do you want?
value="1"; //[1,5,10,25,50]

/* [Hidden] */
$fn=100;
if (value=="1")
{
difference()
{
cylinder(r=9.5,h=3);
translate([0,0,-1])cylinder(r=9.5*.9,h=2);
translate([0,0,2]) cylinder(r=9.5*.9,h=2);
}

translate([0,0,.5])rotate ([180,0,0]) write("1",h=12.5, center=true);
translate([.3,0,.5])rotate ([180,0,0]) write("1",h=12.5, center=true);

translate([0,0,2.5]) write("1",h=12.5, center=true);
translate([.3,0,2.5]) write("1",h=12.5, center=true);
}

if (value=="5")
{
difference()
{
cylinder(r=10.5,h=3);
translate([0,0,-1])cylinder(r=10.5*.9,h=2);
translate([0,0,2]) cylinder(r=10.5*.9,h=2);
}

translate([0,0,.5])rotate ([180,0,0]) write("5",h=12.5, center=true);
translate([.3,.3,.5])rotate ([180,0,0]) write("5",h=12.5, center=true);
translate([0,0,2.5]) write("5",h=12.5, center=true);
translate([0.3,.3,2.5]) write("5",h=12.5, center=true);
}

if (value=="10")
{
difference()
{
cylinder(r=8.5,h=3);
translate([0,0,-1])cylinder(r=8.5*.9,h=2);
translate([0,0,2]) cylinder(r=8.5*.9,h=2);
}

translate([0,0,.5])rotate ([180,0,0]) write("10",h=8.5, center=true);
translate([0.4,0,.5])rotate ([180,0,0]) write("10",h=8.5, center=true);
translate([0,0,2.5]) write("10",h=8.5, center=true);
translate([0.4,0,2.5]) write("10",h=8.5, center=true);
}

if (value=="25")
{
difference()
{
cylinder(r=12,h=3);
translate([0,0,-1])cylinder(r=12*.9,h=2);
translate([0,0,2]) cylinder(r=12*.9,h=2);
}

translate([0,0,.5])rotate ([180,0,0]) write("25",h=12, center=true);
translate([.5,0,.5])rotate ([180,0,0]) write("25",h=12, center=true);
translate([0,0,2.5]) write("25",h=12, center=true);
translate([.5,0,2.5]) write("25",h=12, center=true);
}

if (value=="50")
{
difference()
{
cylinder(r=15,h=3);
translate([0,0,-1])cylinder(r=15*.9,h=2);
translate([0,0,2]) cylinder(r=15*.9,h=2);
}
translate([0,0,.5])rotate ([180,0,0]) write("50",h=15, center=true);
translate([.7,0,.5])rotate ([180,0,0]) write("50",h=15, center=true);
translate([0,0,2.5]) write("50",h=15, center=true);
translate([.7,0,2.5]) write("50",h=15, center=true);
}