
//////////////DICHIARAZIONI///////////////////////

//flange width
L=30;
// Element width
Sp=22;
// Roundness
$fn=60; 

////////////////////


module angolare()
difference()
{
union()
{
cube([15,Sp,10]);
translate([6,Sp/2,-1])cylinder(2,6,6);
translate([6,Sp/2,-5])cylinder(4,4.2,4.6);

}
translate([6,Sp/2,-6])cylinder(17,3.1,3.1);
translate([6,Sp/2,8])rotate([0,0,30])cylinder(4,6,6,$fn=6);
}
module angolare1()
difference()
{
union()
{
cube([15,Sp,10]);
translate([6,Sp/2,-1])cylinder(2,6,6);
translate([6,Sp/2,-5])cylinder(4,4.2,4.6);

}
translate([6,Sp/2,-6])cylinder(17,3.1,3.1);
}

translate([L,0,0])rotate([0,-45,0])angolare();
translate([0,Sp,0])rotate([0,-45,180])angolare1();


hull()//corpo centrale
{
cube([L,Sp,1]);
translate([7,0,6])cube([L/2+1,Sp,1]);
}



























