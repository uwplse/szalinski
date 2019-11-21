fh=31;      // rubber foot internal height
fd=31;      // rubber foot internal diameter
td=22.4;    // tube external diameter
fn=60;      // redering fineness

difference()
{
    minkowski()
    {
        cylinder(d=td,h=fh-(31-22.4),$fn=fn);
        sphere(d=(fd-td),$fn=fn);
    };
    translate([0,0,(fd-td)/2])
    cylinder(d=td,h=fh,$fn=fn);
};