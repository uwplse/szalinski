hook_distance=15;
base_thickness=3;
base_height=30;
base_width=20;
fixing_hole=0;//[0:OFF,1:ON]
Sfn=30;

module Base()
{
resize([base_width,base_height,3])sphere(r=10,center=true,$fn=Sfn);
translate([0,0,-base_thickness/4])
{
resize([base_width,base_height,0])cylinder(base_thickness/2,r=10,center=true,$fn=Sfn);
}
}

module Hook()
{
difference() {
resize([base_width,base_height,hook_distance])sphere(r=10,center=true,$fn=Sfn);
translate([0,0,-hook_distance/2])
{
cube([base_width+1,base_height+1,hook_distance],center=true);
}
translate([0,base_height/2,hook_distance/2])
{
cube([base_width+1,base_height,hook_distance],center=true);
}


translate([0,0,-1])
{
rotate ([0,90,0]) 
resize([hook_distance,base_height/2,base_width])sphere (hook_distance,base_width, center = true, $fn=Sfn);
}


translate([-base_width/2-1,0,hook_distance/2])
{
resize([base_width,base_height,hook_distance])sphere(r=10,center=true,$fn=Sfn);
}
translate([base_width/2+1,0,hook_distance/2])
{
resize([base_width,base_height,hook_distance])sphere(r=10,center=true,$fn=Sfn);
}

}
}

module Hole()
{
if(fixing_hole > 0)
{
translate([0,base_height/5,1.5])
{

cylinder(base_thickness*2,d=fixing_hole,center=true,$fn=Sfn);
cylinder(h = fixing_hole, d1 = fixing_hole, d2 = fixing_hole*2, center = true,$fn=Sfn);

}
}
}

difference()
{
Base();
Hole();
}
Hook();



