$fn=64;

/* [Basic settings] */
// Table thickness (glass table ~8mm)
h=30;   // [1:0.1:40]
// length of the protection
w=125;     // [15:1:50]

// Both thickness of piece and ray of corners
ep=5;   // [1:0.1:5]
// Ray of the protection
r=5;    // [1:1:10]

thin=1; // [0: Thin, 1: Large]
center=1; //[0: no, 1:yes]
center_width=6; // in mm
center_length=75; // in mm

/* [Hidden] */
d = 0.707*(r-ep);

// Anyone knows how to compute this angle
// so the part is on the xy plane ???
alpha=0*thin*atan((r-d)/(w-d))/2;
r1=ep;   // when thin=1, ray of ends, must be >= ep

//translate([0,0,ep])
rotate([90,alpha,0])
    union () {
    difference()
    {
        part(h);
        if( center )
        {
            union() {
                translate([0,0,-h/2])
                    hole();
                translate([0,0,h/2])
                    hole();
            }
        }
        else
        {
            hole();
        }
    }

    if ( center )
    {
        center_mount();
    }        
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

module center_mount()
{
    translate([0,0,h/2+center_width/2])
    linear_extrude(height=center_width)
        polygon(
            [[0,0],[center_length,0],[0,center_length]]
        );
}