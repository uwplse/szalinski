// Extruded profile witdh
Size = 20;
// Corner's angle
Angle = 90; // [5:175]
// Length of one side
Length1 = 30;
// Length of the other side
Length2 = 30;
// Number of screw holes in one side
Screws1 = 1;
// Number of screw holes in the other side
Screws2 = 1;
// Thickness of the sides
ThicknessSide = 5;
// Thickness of the laterals
ThicknessLateral = 4;
// Space between guide chunk's
NutSize = 10;
// Diameter of the screw holes
Metric = 4.2;
// Number of profile sections
Sections = 1;
// Distance between rail and piece
RailOffset = 0; // [0:0.01:1]
// Extra distance between piece and rail's head
RailHeightReduction = 0; // [-0.5:0.01:1.5]
// Extra height of rail connector
RailConnectorExtra = 0; // [-1:0.01:1]
// Height removed from profile rail
RailCut = 0.91;
// Width shrink of profile rail
RailShrink = 0.99;

$fn = 64;

module vSlot(
    railOffset=0,
    railHeightReduction=0,
    railConnectorExtra=0,
    railCut=0,
    railShrink=1,
) {
    basePoints = [
        //[-2.00,  4.50],
        [0.00+railOffset,  4.50],
        [1.80+railOffset+railConnectorExtra,  2.78],
        [1.80+railOffset+railConnectorExtra,  5.50],
        [3.44+railOffset+railConnectorExtra-railHeightReduction,  5.50],
        [6.10+railOffset+railConnectorExtra-railHeightReduction,  2.84],
        [6.10+railOffset+railConnectorExtra-railHeightReduction,  0.21],
        [6.31+railOffset+railConnectorExtra-railHeightReduction,  0.00],
        [6.10+railOffset+railConnectorExtra-railHeightReduction, -0.21],
        [6.10+railOffset+railConnectorExtra-railHeightReduction, -2.84],
        [3.44+railOffset+railConnectorExtra-railHeightReduction, -5.50],
        [1.80+railOffset+railConnectorExtra, -5.50],
        [1.80+railOffset+railConnectorExtra, -2.78],
        [0.00+railOffset, -4.50],
        //[-2.00, -4.50],
    ];
    points = railOffset == 0 ? basePoints : concat([[0.00, 4.50]], basePoints, [[0.00, -4.50]]);

    scale([1, railShrink])
        difference() {
            polygon(points);

            translate([((3/2)*(6.31+railOffset+railConnectorExtra-railHeightReduction))-railCut, 0])
                square([6.31+railOffset+railConnectorExtra-railHeightReduction, 11], true);
        }
}

module triangle(angle=90, length1=30, length2=30)
{
    polygon([
        [0, 0],
        [length1, 0],
        [cos(angle)*length2, sin(angle)*length2],
    ]);
}

module body(
    angle=90,
    length1=30,
    length2=30,
    thicknessSide=5,
    thicknessLateral=4,
    size=20,
    sections=1,
) {
    if (sections > 1)
    {
        translate([0, 0, -0.5*(sections-1)*size])
            for(s = [0:max(0,sections-1)])
            {
                translate([0, 0, s*size])
                    body(
                        angle=angle,
                        length1=length1,
                        length2=length2,
                        thicknessSide=thicknessSide,
                        thicknessLateral=thicknessLateral,
                        size=size,
                        sections=1
                    );
            }
    } else {
        translate([0, 0, -size/2])
            difference()
            {
                linear_extrude(height=size)
                    triangle(angle=angle, length1=length1, length2=length2);

                translate([(1/tan(angle/2))*thicknessSide, thicknessSide, thicknessLateral])
                    linear_extrude(height=size-(2*thicknessLateral))
                        triangle(angle=angle, length1=length1, length2=length2);
            }
    }
}

module railAngled(
    angle=90,
    length=30,
    size=20,
    railOffset=0,
    railHeightReduction=0,
    railConnectorExtra=0,
    railCut=0,
    railShrink=1,
) {
    difference()
    {
        rotate([90, 0, 90+angle])
            translate([0, 0, -length])
                linear_extrude(height=3*length)
                    vSlot(
                        railOffset=railOffset,
                        railHeightReduction=railHeightReduction,
                        railConnectorExtra=railConnectorExtra,
                        railCut=railCut,
                        railShrink=railShrink
                    );

        translate([0, -length, 0])
            cube([length*3, length*2, size], true);
    }
}

module railStraight(
    length=30,
    size=20,
    railOffset=0,
    railHeightReduction=0,
    railConnectorExtra=0,
    railCut=0,
    railShrink=1,
) {
    rotate([90, 0, 270])
        translate([0, 0, -2*length])
            linear_extrude(height=3*length)
                vSlot(
                    railOffset=railOffset,
                    railHeightReduction=railHeightReduction,
                    railConnectorExtra=railConnectorExtra,
                    railCut=railCut,
                    railShrink=railShrink
                );
}

module bodyWithRails(
    size=20,
    angle=90,
    length1=30,
    length2=30,
    thicknessSide=5,
    thicknessLateral=4,
    sections=1,
    railOffset=0,
    railHeightReduction=0,
    railConnectorExtra=0,
    railCut=0,
    railShrink=1,
) {
    union()
    {
        body(
            angle=angle,
            length1=length1,
            length2=length2,
            thicknessSide=thicknessSide,
            thicknessLateral=thicknessLateral,
            size=size,
            sections=sections
        );

        translate([0, 0, -0.5*(sections-1)*size])
            for(s = [0:max(0,sections-1)])
            {
                translate([0, 0, s*size])
                {
                    railAngled(
                        angle=angle,
                        length=length2,
                        size=size,
                        railOffset=railOffset,
                        railHeightReduction=railHeightReduction,
                        railConnectorExtra=railConnectorExtra,
                        railCut = railCut,
                        railShrink = railShrink
                    );

                    railStraight(
                        length=length1,
                        size=size,
                        railOffset=railOffset,
                        railHeightReduction=railHeightReduction,
                        railConnectorExtra=railConnectorExtra,
                        railCut = railCut,
                        railShrink = railShrink
                    );
                }
            }
    }
}

module printPosition(angle, alpha, hypotenuse) {
    translate([0, 0, (1/tan(angle/2))*(hypotenuse/2)])
        rotate([-alpha, 0, 0])
            rotate([0, 90, 0])
                children();
}

module VSlotConnector(
    size=20,
    angle=90,
    length1=30,
    length2=30,
    thicknessSide=5,
    thicknessLateral=4,
    screws1=1,
    screws2=1,
    nutSize=15,
    metric=4,
    sections=1,
    railOffset=0,
    railHeightReduction=0,
    railConnectorExtra=0,
    railCut=0,
    railShrink=1,
) {
    hypotenuse = sqrt((length1*length1)+(length2*length2)-(2*length1*length2*cos(angle)));
    alpha = 90-acos(((length1*length1)+(hypotenuse*hypotenuse)-(length2*length2))/(2*length1*hypotenuse));
    maxLength = length1*length2;
    fullSize = size*sections;

    printPosition(angle=angle, alpha=alpha, hypotenuse=hypotenuse)
        difference()
        {
            bodyWithRails(
                angle=angle,
                length1=length1,
                length2=length2,
                thicknessSide=thicknessSide,
                thicknessLateral=thicknessLateral,
                size=size,
                sections=sections,
                railOffset=railOffset,
                railHeightReduction=railHeightReduction,
                railConnectorExtra=railConnectorExtra,
                railCut = railCut,
                railShrink = railShrink
            );

            // Cut base
            translate([length1, 0, 0])
                rotate([0, 0, alpha])
                    translate([maxLength/2, 0, 0])
                        cube([maxLength, maxLength, fullSize], true);

            // Cut top
            translate([-((6.31-railCut)*cos(90-angle)), 0, 0])
                rotate([0, 0, angle/2])
                    translate([(-maxLength/2), 0, 0])
                        cube([maxLength, maxLength, fullSize], true);

            // Nut Straight
            for (i = [1:screws1])
                translate([(i*length1)/(screws1+1), -4, 0])
                    cube([nutSize, 8, fullSize], true);
            
            // Nut Angled
            for (i = [1:screws2])
                rotate([0, 0, angle])
                    translate([(i*length2)/(screws2+1), 4, 0])
                        cube([nutSize, 8, fullSize], true);

            // Screws
            translate([0, 0, -0.5*(sections-1)*size])
                for(s = [0:max(0,sections-1)])
                {
                    translate([0, 0, s*size])
                    {
                        // Screw Straight
                        for (i = [1:screws1])
                            rotate([90, 0, 0])
                                translate([(i*length1)/(screws1+1), 0, -(0.1+thicknessSide)])
                                    cylinder(h=thicknessSide+0.2, d=metric);
                        
                        // Screw Angled
                        for (i = [1:screws2])
                            rotate([0, 90, angle-90])
                                translate([0, (i*length2)/(screws2+1), -0.1])
                                    cylinder(h=thicknessSide+0.2, d=metric);
                    }
                }
        }
}

VSlotConnector(
    size = Size,
    angle = Angle,
    length1 = Length1,
    length2 = Length2,
    thicknessSide = ThicknessSide,
    thicknessLateral = ThicknessLateral,
    screws1 = Screws1,
    screws2 = Screws2,
    nutSize = NutSize,
    metric = Metric,
    sections = Sections,
    railOffset = RailOffset,
    railHeightReduction = RailHeightReduction,
    railConnectorExtra = RailConnectorExtra,
    railCut = RailCut,
    railShrink = RailShrink
);
