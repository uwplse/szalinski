$fn = 50;
module body()
{
difference () 
{
cylinder(20,r=7.5);
cylinder(20,r=2.8);
}
}
difference () 
{
    body();
translate([5,0,15]) cylinder(5,r=1.6);
}