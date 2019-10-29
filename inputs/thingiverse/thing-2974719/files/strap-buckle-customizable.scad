// strap buckle customizable
// speedo goggles w=10.3 d=1.9 h=1.8

strap_width=10.3; // mm
strap_depth=1.9; // mm

total_width=strap_depth*2+strap_depth*2+strap_depth*1.5+strap_depth*2+strap_depth*2;
total_depth=strap_width+5;
total_height=1.8; // mm
t=0.2*1; // tolerance for holes

intersection()
{
    difference()
    {
        // main buckle block
        cube([total_width,total_depth,total_height], center=true);
        // holes for strap
        translate([strap_depth*1.75,0,0])
            cube([strap_depth*2+t,strap_width+t,total_height+t],center=true);
        translate([-strap_depth*1.75,0,0])
            cube([strap_depth*2+t,strap_width+t,total_height+t],center=true);
    }
    
    // intersection to shape rounded borders with two spheres
    translate([pow(total_depth,1.2)-total_width/2,0,0])
        sphere(pow(total_depth,1.2),$fn=50);
    translate([-pow(total_depth,1.2)+total_width/2,0,0])
        sphere(pow(total_depth,1.2),$fn=50);
}
