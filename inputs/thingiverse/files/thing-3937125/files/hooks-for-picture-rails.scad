$fn=50;
/*
    Parametric Hooks For Picture Rails
    By Brian Khuu (2019)
    
    Many old houses still have picture rails that you can hang pictures or clocks on. This allow you to print a picture rail hook that fits exactly your picture rail. Just measure the diameter of your rail and specify the hook depth you requre.
    
*/


/* [Picture Rail Spec] */
// Centered Hook mode (Requires support but is easier to mount)
centeredHook=false;
// Diameter of picture rail 
dia=21;
// Mount thickness
thickness=4;
// Mount Width
width=30;
// Standoff of the mount away from the wall
standoff=0.5;

/* [Picture Rail Spec] */
// Hook Diameter
hookdia=10;
// Hook Flange
hookflange=3;
// Hook Width
hookwidth=4;

// Calc
hookspacing=dia;

difference()
{
    translate([dia,0,0])
    union()
    {
        // Mount
        translate([-dia/2,0,0])
        difference()
        {
            cylinder(r=dia/2+thickness, h=width);
            translate([0,-dia/2,-1])
                cube([dia,dia/2,width+2]);
        }
        if (!centeredHook)
        { /* Off centered hooks for no support required printing */
            // Hook
            translate([0,0,0])
            hull()
            {
                translate([thickness/2,0,0])
                    cylinder(r=thickness/2, h=width);
                translate([thickness/2,-hookspacing,0])
                    cylinder(r=thickness/2, h=hookwidth);
            }
            translate([hookdia/2+thickness,-hookspacing, hookwidth/2])
                difference()
                {
                    cylinder(r=hookdia/2+thickness, h=hookwidth, center=true);
                    translate([0,0,0])
                        cylinder(r=hookdia/2, h=hookwidth+2, center=true);
                    translate([0,hookdia/2,0])
                        cube([hookdia,hookdia,hookwidth+2], center=true);
                    translate([hookdia/2,hookdia/2,0])
                        cube([hookdia,hookdia,hookwidth+2], center=true);
                }
            translate([hookdia/2+thickness,-hookspacing, 0])
                hull()
                {
                    translate([hookdia/2+thickness/2,0,0])
                        cylinder(r=thickness/2, h=hookwidth);

                    translate([hookdia/2+thickness/2+hookflange,+hookflange,0])
                        cylinder(r=thickness/2, h=hookwidth);
                }
        }
        else
        { /* Centered Hook (Support required) */
            // Hook
            translate([0,0,0])
            hull()
            {
                translate([thickness/2,0,0])
                    cylinder(r=thickness/2, h=width);
                translate([thickness/2,-hookspacing, width/2-hookwidth/2])
                    cylinder(r=thickness/2, h=hookwidth);
            }
            translate([hookdia/2+thickness,-hookspacing, width/2])
                difference()
                {
                    cylinder(r=hookdia/2+thickness, h=hookwidth, center=true);
                    translate([0,0,0])
                        cylinder(r=hookdia/2, h=hookwidth+2, center=true);
                    translate([0,hookdia/2,0])
                        cube([hookdia,hookdia,hookwidth+2], center=true);
                    translate([hookdia/2,hookdia/2,0])
                        cube([hookdia,hookdia,hookwidth+2], center=true);
                }
            translate([hookdia/2+thickness,-hookspacing, width/2-hookwidth/2])
                hull()
                {
                    translate([hookdia/2+thickness/2,0,0])
                        cylinder(r=thickness/2, h=hookwidth);

                    translate([hookdia/2+thickness/2+hookflange,+hookflange,0])
                        cylinder(r=thickness/2, h=hookwidth);
                }
        }

    }
    translate([0,0,(width)/2])
    union()
    {
        // Wall Model
        translate([dia-0.001,0,-(width+2)/2])
            hull()
            {
                translate([-dia/2,0,0])
                    cylinder(r=dia/2, h=width+2);
                translate([-dia/2,-dia-10,0])
                    cylinder(r=dia/2, h=width+2);
            }
        translate([-1000+standoff,-(1000)/2,-(width+2)/2])
            cube([1000,1000,width+2]);
    }
}