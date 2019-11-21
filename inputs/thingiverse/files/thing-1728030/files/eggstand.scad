//Title: Stone egg and sphere stand
//Author: Alex English - ProtoParadigm
//Date: 8/19/16
//License: Creative Commons - Share Alike - Attribution

//Notes: This is a stand for stone eggs and spheres. It's crazy simple, I'd love to see someone do something more artistic.

IN=25.4*1; //multiplication by 1 to prevent customizer from presenting this as a configurable value

//The diameter of the sphere, or the approximate diameter of the base of the egg (inches)
sphere_diameter = 3;
sd = IN*sphere_diameter;

//Inside diameter - how wide should the inside hole be (inches)?
inside_diameter = 1.25;
id=IN*inside_diameter;

//Outside Diameter - How much wider than the inside should the outside be (inches)?
outside_diameter = 0.5;
od=id+IN*outside_diameter;

//Height - How tall should the stand be (inches)?
height = 1;
h=IN*height;

difference()
{
    linear_extrude(height=h, twist=33) circle(d=od,$fn=7);
    translate([0, 0, -1]) cylinder(d=id, h=h+2);
    translate([0, 0, sd/2+h-h/4]) sphere(d=sd);
}