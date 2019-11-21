wall=4;

dia=150;


all();

module all()
{
    // pot itself
    difference()
    {
        sphere(d=dia, $fn=200);
        sphere(d=dia-2*wall, $fn=200);
        translate([-dia/2,-dia/2,-dia/2-dia/3]) cube([dia,dia,dia/2]);
        translate([-dia/2,-dia/2,dia/3]) cube([dia,dia,dia/2]);
        cylinder(r=sqrt(dia/2*dia/2-dia/3*dia/3)-wall, h=dia/2+0.001, $fn=200);
    }
    
    // the bottom
    intersection()
    {
        sphere(d=dia);
        translate([0,0,-dia/3]) cylinder(d=dia, h=wall);
    }
    
    // the upper rim
    rotate_extrude($fn=200) translate([sqrt(dia/2*dia/2-dia/3*dia/3)-wall/4,dia/3+wall/2]) circle(d=2.5*wall, $fn=50);
    
    // the hooks
    rotate([90,0,0])
    difference()
    {
        hull()
        {
            translate([-dia/2, dia/4,-wall]) cylinder(d=dia/5, h=2*wall, $fn=50);
            translate([ dia/2, dia/4,-wall]) cylinder(d=dia/5, h=2*wall, $fn=50);
            translate([-dia/4,-dia/3,-wall]) cube([dia/2,1,2*wall]);
        }
        translate([-dia/2, dia/4,-wall-0.001]) cylinder(d=dia/10, h=2*wall+0.002);
        translate([ dia/2, dia/4,-wall-0.001]) cylinder(d=dia/10, h=2*wall+0.002);
        sphere(d=dia-wall);
    }
    
}
