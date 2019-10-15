
/* [Bottle] */

// diameter of bottle to be held (plus any extra spacing)
bottle_diam = 67.5;

// height of bottle holder
holder_height = 12;

// thickness of bottle holder
holder_thick = 3;

// thickness of holder bottom (0 for none)
holder_bottom_thick = 1;

// width of holder bottom lip (0 for none)
holder_bottom_lip = 5;


/* [Mount] */

// diameter of pole to be mounted to
mount_diam = 26.2;

// height of mount
mount_height = holder_height;

// thickness of mount
mount_thick = 3.5;

// width of wing for bolt
bracket_width = 13;

// thickness of wing
bracket_thick = 3.5;

// cut offset of wing to improve pole grip
bracket_offset = 1;

// offset from wing edge for bolt center
bolt_offset = 5.7;

// diameter of bolt
bolt_diam = 3.1;

// diameter of bolt washer
washer_diam = 9.8;


/* [Helpers] */

// generate build-platform corner helpers?
generate_holddown = 1; // [0:no, 1:yes]


////////////////////////////////////////////////////////////////////////

bottle_rad = bottle_diam/2;
mount_rad = mount_diam/2;
bolt_rad = bolt_diam/2;
washer_rad = washer_diam/2;

////////////////////////////////////////////////////////////////////////

holder();

translate([0, bottle_rad+max(holder_thick,mount_thick)+mount_rad, 0])
{
    mount();

    translate([0, mount_thick-bracket_offset, 0])
    rotate([0, 0, 180])
    mount();
}

////////////////////////////////////////////////////////////////////////

module holder()
{
    // base shape
    difference()
    {
        // outer ring
        cylinder(r=bottle_rad+holder_thick, h=holder_height, center=true);

        // cut out bottle
        cylinder(r=bottle_rad, h=holder_height+0.1, center=true);
    }

    // something to rest the bottle against?
    if(holder_bottom_thick > 0 && holder_bottom_lip > 0)
    {
        translate([0, 0, (holder_bottom_thick-holder_height)/2])
        difference()
        {
            cylinder(r=bottle_rad+0.1, h=holder_bottom_thick, center=true);

            cylinder(r=bottle_rad-holder_bottom_lip, h=holder_bottom_thick+0.1, center=true);
        }
    }
}

module mount()
{
    wing_off = mount_rad+bracket_width;
    holddown = 0.2;

    difference()
    {
        // base shape
        union()
        {
            // outer ring
            cylinder(r=mount_rad+mount_thick, h=mount_height, center=true);

            // wing
            translate([0, -bracket_thick/2-bracket_offset, 0])
            cube([mount_diam+bracket_width*2, bracket_thick, mount_height], center=true);
        }

        // cut out the pole
        cylinder(r=mount_rad, h=mount_height+0.1, center=true);

        // crop the wing/ring to inset that we selected
        translate([0, mount_diam-bracket_offset, 0])
        cube(mount_diam*2, center=true);

        // cut out two bolt holes
        for(i=[-1, 1])
        translate([i*(wing_off-bolt_offset), -bracket_thick/2-bracket_offset, 0])
        {
            // bolt itself
            rotate([90, 90, 0])
            cylinder(r=bolt_rad, h=bracket_thick*2, center=true);

            // cut into wall to fit washer
            translate([0, -bracket_thick, 0])
            rotate([90, 90, 0])
            cylinder(r=washer_rad, h=bracket_thick, center=true, $fn=12);
        }
    }

    // build platform helper?
    if(generate_holddown)
    {
        for(i=[-1, 1])
        translate([i*(wing_off), -bracket_thick/2-bracket_offset, -mount_height/2+holddown/2])
        cylinder(r=bracket_thick, h=holddown, center=true);
    }
}
