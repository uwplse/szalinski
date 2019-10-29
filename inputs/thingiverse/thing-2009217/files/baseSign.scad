// D&D Base w/Sign
// Created by Doug Kress
// First published on 2017-01-01.

// Use Wet erase markers to identify monsters in your battles.
/* [Options] */

// What would you like to create?
PrintOption = "both"; // [both:Both, base:Base Only, sign:SignOnly]

// select a size
BaseSize = 1;   // [0.75:Small, 1:Medium, 2:Large, 3:Huge, 4:Gargantuan, 6:Colossal]

// hight of sign (millimeters)
SignHeight = 10;

/* [Custom] */

// base size (in inches) - "Base Size" above will be ignored
Custom = 0;

printBase(PrintOption, Custom > 0 ? Custom : BaseSize);

module printBase(option, size) {
    if (option != "sign") {
        base(size * 25.4);
    }
    if (option != "base") {
        translate([0,-(SignHeight+5),0]) baseSign(size * 25.4);
    }
}

module base(baseSize)
{
    difference() {
        cube([baseSize, baseSize, 3]);
        union() {
        translate([baseSize/2, baseSize/2, 1])
            cylinder(r=baseSize/2*1.1 , h=3, $fn=50);
            
        offset = baseSize * 0.04;
        translate([offset*1.5, offset*1.5, 1])
            cylinder(r=offset, h=3, $fn=32);
        translate([baseSize-offset*1.5, offset*1.5, 1])
            cylinder(r=offset, h=3, $fn=32);
        }
    }
}


module signTab(baseSize, reverse)
{
    offset = baseSize * 0.0325;
    position = reverse ? baseSize * .2 - offset * 1.5 : offset * 1.5;
    cylPosition = reverse ? baseSize*.2 - baseSize/2-1 : baseSize/2+1;
    difference() {
        cube([baseSize*.2, baseSize*.2, 1]);
        translate([cylPosition,baseSize/2, -1])
            cylinder(r=baseSize/2*1.1 , h=3, $fn=50);
        
    }
    translate([position, baseSize*.15, 0])
        cylinder(r=offset, h=3, $fn=32);

}
module baseSign(baseSize)
{
    offset = baseSize * 0.035;
    cube([baseSize, SignHeight, 1]);
    rotate([75, 0, 0])  {
        translate([0,0.6,-2])
            signTab(baseSize, false);
        translate([baseSize-baseSize*.2,0.6,-2])
            signTab(baseSize, true);
   }         
}