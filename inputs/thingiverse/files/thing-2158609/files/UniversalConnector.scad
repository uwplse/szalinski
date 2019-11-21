//Customizable Universal Joint Script
//By Bram Vaessen, 2017

/* [Hole for motor shaft] */
//The length of the (hole for the) motorshaft.
motorShaftLength=10; 
//The the diameter of the motorshaft
motorShaftDiameter=4; 
//The distance of the cutoff of the motorshaft from the perimeter of the shaft
motorShaftNudgeDist=0.7;
//The printing tolerance fot the motorshaft hole
motorShaftTolerance=0.1;

/* [Hole for the axis] */
//The length of the hole for the axis
axisHoleLength=10;
//The diameter for the hole for the axis
axisHoleDiameter=4;
//The tolerance for the hole for the axis
axisHoleTolerance=0.0;

/* [The connector] */
//the diameter of the connector (make larger than motor and axis diameters)
connectorDiameter=15;
//The tolerance between the connector (suggested: 0.5 to 1 times layer heigth of your print)
connectorTolerance=0.1;

/* [Screw holes for fasteners] */
//Wether to make holes for fasteren screws
useScrewHoles=1; //[1:Yes, 0:No]
//The diameter of the screwholes
screwHoleDiameter=2.5;
//The tolerance for the screwholes
screwHoleTolerance=-0.1;



MotorConnector();

module CenterCube(size)
{
    translate([0,0,size[2]/2]) cube(size, center=true);
}

module Donut(r1, r2)
{
    rotate([90,0,0])
        rotate_extrude(, $fn=64)
            translate([r1,0,0]) circle(r=r2, $fn=32);
}

module Con(height, r1, r2)
{
    difference()
    {
        union()
        {
            translate([0,0,height+r1]) Donut(r1, r2);
            hull()
            {
                translate([0,0,height+r1])
                intersection()
                {
                    Donut(r1, r2);
                    translate([0,0,-r1-r2]) CenterCube([(r1+r2)*2+1, r2*2+1, r2*2]);
                }
                cylinder(r=r1+r2, h=height, $fn=64);
            }

        }
        if (useScrewHoles)
            translate([0,0,height/2]) rotate([0,90,0])
                cylinder(r=screwHoleDiameter/2+screwHoleTolerance, 
                         h=(r1+r2)*3, center=true, $fn=64);
    }
}


module MotorConnector()
{
    r1 = connectorDiameter/3;
    r2 = connectorDiameter/6-connectorTolerance;
    
    motorSideHeight = motorShaftLength+2;
    motorShaftRadius = motorShaftDiameter/2+motorShaftTolerance;
    motorShaftNudgeOffset = motorShaftRadius-motorShaftNudgeDist+motorShaftTolerance*2;
    
    axisSideHeight = axisHoleLength+2;
    axisHoleRadius = axisHoleDiameter/2+axisHoleTolerance;
    
    
    difference()
    {
        Con(motorSideHeight,r1,r2);
        translate([0,0,-1]) difference()
        {
            cylinder(r=motorShaftRadius, h=motorShaftLength+2, $fn=32);
            translate([motorShaftNudgeOffset,-5,0]) cube([10,10,motorShaftLength+2]); 
        }
    }
    z=motorSideHeight+r1*2+r2-connectorTolerance+axisSideHeight+r1-r2+connectorTolerance;
    translate([0,0,z])  rotate([180,0,90])
    {
        difference()
        {
            Con(axisSideHeight,r1,r2);
            translate([0,0,-1]) cylinder(r=axisHoleRadius, h=axisSideHeight+2, $fn=32);
        }
    }
}