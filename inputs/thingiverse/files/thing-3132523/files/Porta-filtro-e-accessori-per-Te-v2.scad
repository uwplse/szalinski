$fn=108;

Vase_radius=64;
Recess_into_vase=5;
Stirrer_holder_radius=7.5;
Pressing_tool_holder_radius=2.75;
Filter_holder_radius=29;
Filter_holder_height=35;

difference()
{
union()
{
//Porta filtro
difference()
{
union()
{
    translate([0,0,0])
cylinder(r=Filter_holder_radius+4,h=Filter_holder_height);
}
translate([0,0,-1])
cylinder(r=Filter_holder_radius,h=Filter_holder_height+10);    
}

//Porta mescolino
rotate([0,0,-30])
difference()
{
union()
{
    translate([Vase_radius,0,0])
cylinder(r=Stirrer_holder_radius+4,h=Filter_holder_height);
}
translate([Vase_radius,0,0])
cylinder(r=Stirrer_holder_radius,h=Filter_holder_height+30);    
}

//Porta pressatore
difference()
{
union()
{
    translate([0,Vase_radius,0])
cylinder(r=Pressing_tool_holder_radius+4,h=Filter_holder_height);
}
translate([0,Vase_radius,0])
cylinder(r=Pressing_tool_holder_radius,h=Filter_holder_height+30);    
}

//Traversine
difference()
    {
    union()
        {
        translate([-2.5,0,0])    
        rotate([0,0,0])
        cube([5,Vase_radius,Filter_holder_height]);
        rotate([0,0,120])
        translate([-2.5,0,0])
        cube([5,Vase_radius,Filter_holder_height]);
        rotate([0,0,240])
        translate([-2.5,0,0])    
        cube([5,Vase_radius,Filter_holder_height]);
        }
    translate([0,0,-1])
        cylinder(r=Filter_holder_radius,h=100);
    translate([0,0,Filter_holder_height])
    rotate_extrude(angle=360)
        translate([Filter_holder_radius*2+3,0,0])
        circle(r=Filter_holder_radius);
    }

//Sfere
translate([0,Vase_radius,0])    
sphere(10);
rotate([0,0,120])
translate([0,Vase_radius,0])    
sphere(10);
rotate([0,0,240])
translate([0,Vase_radius,0])    
sphere(10);


}


translate([0,0,-10])
cube([200,200,20],center=true);

rotate_extrude(angle=360)
translate([Vase_radius,0,0])
circle(r=4);
}

translate([0,0,35])
rotate_extrude(angle=360)
translate([Filter_holder_radius+2,0,0])
circle(r=2);

rotate([0,0,-30])
translate([Vase_radius,0,35])
rotate_extrude(angle=360)
translate([Stirrer_holder_radius+2,0,0])
circle(r=2);

translate([0,Vase_radius,35])
rotate_extrude(angle=360)
translate([Pressing_tool_holder_radius+2,0,0])
circle(r=2);

union()
        {
        translate([-1,0,0])    
        rotate([0,0,0])
        cube([2,Filter_holder_radius+1,8]);
        rotate([0,0,120])
        translate([-1,0,0])
        cube([2,Filter_holder_radius+1,8]);
        rotate([0,0,240])
        translate([-1,0,0])    
        cube([2,Filter_holder_radius+1,8]);
        }