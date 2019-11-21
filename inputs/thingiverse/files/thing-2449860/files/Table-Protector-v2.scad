$fn=64;

/* [Basic settings] */
// Table thickness (glass table ~8mm)
h=8;   // [1:0.1:40]
// length of the protection
w=20;     // [15:1:50]

// Both thickness of piece and ray of corners
ep=1;   // [1:0.1:5]
// Ray of the protection
r=5;    // [1:1:10]

thin=1; // [0: Thin, 1: Large]

/* [Hidden] */
d = 0.707*(r-ep);

// Anyone knows how to compute this angle
// so the part is on the xy plane ???
alpha=0*thin*atan((r-d)/(w-d))/2;
r1=1;   // when thin=1, ray of ends, must be >= ep

//translate([0,0,ep])
rotate([90,alpha,0])
difference()
{
    part(h);
    hole();
}

module part()
{
    hull()
    {
        translate([d,d]) double_sph(r);
        if (thin)
        {
            translate([w,0,0]) double_sph(r1);
            translate([0,w,0]) double_sph(r1);
        }
        else
        {
            translate([w,d,0]) double_sph(r);
            translate([d,w,0]) double_sph(r);
        }
    }
}

module double_sph(r)
{
    dd=0.707*(r-ep);
    translate([0,0,h+ep-dd]) sphere(r=r);
    translate([0,0,ep+dd]) sphere(r=r);
}

module hole()
{
    translate([0,0,ep])
    linear_extrude(height=h)
        polygon(
            [[0,0],[w*10,0],[0,w*10]]
        );
}