/* GNU GPL */
/* [Size] */
// Size of the shell
CUBE_SIZE = [20, 23, 10];
// Size of the peg which goes into the printer
PEG_SIZE  = [13.1, 9.8, 3.2];
// Size of USB socket
USB_SIZE = [10.9, 7.7];

module parameters_stop(){}

/*
DELTA is used to sink an object into the parent object to remediate
non-manifoldness which exists because of rounding errors.
*/
DELTA = 0.01;

/* Just aliases for indices. */
X = 0;
Y = 1;
Z = 2;

REAL_USB = [USB_SIZE[0], USB_SIZE[1], CUBE_SIZE[Z] + PEG_SIZE[Z] + DELTA * 2];

$fn = 100;

/* Utility modules */
function bit_get(num, bitpos) = floor(num / pow(2, bitpos)) % 2;

module rounded_cube(dim, r, r2=undef)
{
    hull() for(i = [0 : 3])
    {
	X_bit = bit_get(i, 0);
	Y = bit_get(i, 1);
	OFF = r2==undef ? r : max(r, r2);

	translate([dim[0] * X_bit + pow(-1, X_bit) * OFF, dim[1] * Y + pow(-1, Y) * OFF, -DELTA])
	{
	    if(r2==undef)
	    {
		cylinder(r=r, h=dim[2] + DELTA * 2);
	    } else {
		cylinder(r1=r, r2 = r2, h=dim[2] + DELTA * 2);
	    }
	}
    }
}

module center_at(outer, inner)
{
    translate([(outer[0] - inner[0]) / 2, (outer[1] - inner[1]) / 2, 0])
    {
	children();
    }
}

module up(what)
{
    translate([0, 0, what])
    {
	children();
    }
}

module down(what)
{
    translate([0, 0, -what])
    {
	children();
    }
}

module above(what)
{
    up(what[Z] - DELTA)
    {
	children();
    }
}

/* Real object 'meat'. */
module usb_hole(dim, r)
{
    H = dim[2] + DELTA * 2;

    down(DELTA) hull()
    {
	translate([             0,          0, 0]) cube([r * 2, r * 2, H]);
	translate([dim[0] - r * 2,          0, 0]) cube([r * 2, r * 2, H]);
	translate([         0 + r, dim[1] - r, 0]) cylinder(r=r, h=H);
	translate([    dim[0] - r, dim[1] - r, 0]) cylinder(r=r, h=H);
    }
}

module usb_holder()
{
    difference()
    {
	union()
	{
	    rounded_cube(CUBE_SIZE, 1, r2=3);
	    above(CUBE_SIZE) center_at(CUBE_SIZE, PEG_SIZE) rounded_cube(PEG_SIZE, 1, r2=0.8);
	}
	down(DELTA) center_at(CUBE_SIZE, REAL_USB) usb_hole(REAL_USB, 2);
    }
}

usb_holder();
