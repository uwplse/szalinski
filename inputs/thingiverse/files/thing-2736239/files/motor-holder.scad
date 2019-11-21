// Holder type
motorHolderType = "corner"; // [simple, corner, half]
// Distance between motor sides
motorSize = 42.6;
// Distance between motor corners
motorEdge = 50.6;
// Wall thickness
gripWidth = 8;
// Holder width
gripHeight = 21;
// Distance between holder arm's
gripHole = 3; // [0.1:0.1:10]
backstayScrewThickness = 5;
backstayScrewHeight = 10;
backstayBaseThickness = 5;
backstayBaseHeight = 5;
backstayBaseLength = 52.6;
backstayBaseSlopeLength = 7;
backstayBaseSlopeHeight = 0;
// Screw hole's diameter
screwHoleDiameter = 3.2;
// Screw hole's definition
$fn=25;

function cornerSize(size1, size2) = sqrt(2*pow((((sqrt(2)*size1)-size2)/2),2));

module motorHolderShape(
    motorHolderType="simple",
    motorSize=42.2,
    motorEdge=50.2,
    gripWidth=5,
    gripHeight=21,
    gripHole=15
) {
    corner = cornerSize(motorSize, motorEdge);
    linear_extrude(height=gripHeight)
        difference() {
            square(size=motorSize+gripWidth, center=true);
            intersection() {
                square(size=motorSize, center=true);
                translate([0, 0])
                    rotate([0, 0, 45])
                        square(size=motorEdge, center=true);
            }
            if (motorHolderType=="corner") {
                translate([corner+(gripWidth/2), corner+(gripWidth/2)])
                    difference() {
                        square(size=motorSize+gripWidth, center=true);
                        square(size=motorSize+gripWidth-(2*gripHole), center=true);
                    }
            } else if (motorHolderType=="simple") {
                translate([0, motorSize/2])
                    square(size=[gripHole, motorEdge], center=true);
            } else {
                translate([0, 0])
                    square(size=[motorEdge, gripHole], center=true);
            }
        }
}

module slope(
    thickness=5,
    height=25,
    length=7,
    endHeight=5
) {
    points =  [
        [0, 0, 0],
        [thickness, 0, 0],
        [thickness, 0, length],
        [0, 0, length],
        [0, height, 0],
        [thickness, height, 0],
        [thickness, endHeight, length],
        [0, endHeight, length]
    ];

    faces = endHeight>0 ? [
        [2, 1, 0],
        [3, 2, 0],
        [1, 5, 4],
        [0, 1, 4],
        [5, 6, 7],
        [4, 5, 7],
        [2, 6, 5],
        [1, 2, 5],
        [3, 7, 6],
        [2, 3, 6],
        [0, 4, 7],
        [3, 0, 7]
    ] : [
        [2, 1, 0],
        [3, 2, 0],
        [1, 5, 4],
        [0, 1, 4],
        [5, 6, 7],
        [4, 5, 7],
        [4, 3, 0],
        [5, 1, 2]
    ];

    polyhedron(points = points, faces  = faces);
}

module backstay(
    thickness=5,
    width=42.2,
    height=25,
    length=20,
    slopeLength=7,
    slopeHeight=5
) {
    union() {
        cube(size=[width, height, thickness]);

        cube(size=[thickness, height, length-slopeLength]);

        translate([width-thickness, 0, 0])
            cube(size=[thickness, height, length-slopeLength]);

        if (slopeLength>0) {
            translate([0, 0, length-slopeLength])
                slope(
                    thickness=thickness,
                    height=height,
                    length=slopeLength,
                    endHeight=slopeHeight
               );

            translate([width-thickness, 0, length-slopeLength])
                slope(
                    thickness=thickness,
                    height=height,
                    length=slopeLength,
                    endHeight=slopeHeight
               );
        }
    }
}

module simpleSupports(
    motorSize = 42.6,
    motorEdge = 50.6,
    gripWidth = 8,
    gripHeight = 21,
    gripHole = 5,
    backstayScrewThickness = 5,
    backstayScrewHeight = 10,
    backstayBaseThickness = 5,
    backstayBaseHeight = 5,
    backstayBaseLength = 52.6,
    backstayBaseSlopeLength = 7,
    backstayBaseSlopeHeight = 0,
    screwHoleDiameter = 3.2,
) {
    corner = cornerSize(motorSize, motorEdge);

    rotate([0, 270, 0])
        translate([0, (motorSize+gripWidth)/2, gripHole/2])
            backstay(
                thickness=backstayScrewThickness,
                width=gripHeight,
                height=backstayScrewHeight,
                length=corner+(gripWidth/2),
                slopeLength=corner+(gripWidth/2)-backstayScrewThickness,
                slopeHeight=2
            );

    rotate([0, 90, 0])
        translate([-gripHeight, (motorSize+gripWidth)/2, gripHole/2])
            backstay(
                thickness=backstayScrewThickness,
                width=gripHeight,
                height=backstayScrewHeight,
                length=corner+(gripWidth/2),
                slopeLength=corner+(gripWidth/2)-backstayScrewThickness,
                slopeHeight=2
            );

    rotate([180, 90, 0])
        translate([-gripHeight, (motorSize+gripWidth)/2, -(motorSize+gripWidth)/2])
            backstay(
                thickness=backstayBaseThickness,
                width=gripHeight,
                height=backstayBaseHeight,
                length=backstayBaseLength,
                slopeLength=backstayBaseSlopeLength,
                slopeHeight=backstayBaseSlopeHeight
            );
}

module cornerSupports(
    motorSize = 42.6,
    motorEdge = 50.6,
    gripWidth = 8,
    gripHeight = 21,
    gripHole = 5,
    backstayScrewThickness = 5,
    backstayScrewHeight = 10,
    backstayBaseThickness = 5,
    backstayBaseHeight = 5,
    backstayBaseLength = 35,
    backstayBaseSlopeLength = 10,
    backstayBaseSlopeHeight = 2,
    screwHoleDiameter = 3.2,
) {
    corner = cornerSize(motorSize, motorEdge);

    rotate([0, 270, 0])
        translate([0, (motorSize+gripWidth)/2, (motorSize/2)-corner])
            backstay(
                thickness=backstayScrewThickness,
                width=gripHeight,
                height=backstayScrewHeight,
                length=corner+(gripWidth/2),
                slopeLength=corner+(gripWidth/2)-backstayScrewThickness,
                slopeHeight=2
            );

    rotate([0, 90, 0])
        translate([-gripHeight, (motorSize+gripWidth)/2, corner+gripHole-motorSize/2])
            backstay(
                thickness=backstayScrewThickness,
                width=gripHeight,
                height=backstayScrewHeight,
                length=corner+(gripWidth/2),
                slopeLength=corner+(gripWidth/2)-backstayScrewThickness,
                slopeHeight=2
            );

    rotate([0, 270, 270])
        translate([0, (motorSize+gripWidth)/2, corner+gripHole-motorSize/2])
            backstay(
                thickness=backstayScrewThickness,
                width=gripHeight,
                height=backstayScrewHeight,
                length=corner+(gripWidth/2),
                slopeLength=corner+(gripWidth/2)-backstayScrewThickness,
                slopeHeight=2
            );

    rotate([0, 90, 270])
        translate([-gripHeight, (motorSize+gripWidth)/2, (motorSize/2)-corner])
            backstay(
                thickness=backstayScrewThickness,
                width=gripHeight,
                height=backstayScrewHeight,
                length=corner+(gripWidth/2),
                slopeLength=0,
                slopeHeight=2
            );

    rotate([270, 90, 0])
        translate([-gripHeight, (motorSize+gripWidth)/2, -(motorSize+gripWidth)/2])
            backstay(
                thickness=backstayBaseThickness,
                width=gripHeight,
                height=backstayBaseHeight,
                length=backstayBaseLength,
                slopeLength=backstayBaseSlopeLength,
                slopeHeight=backstayBaseSlopeHeight
            );

}

module halfSupports(
    motorSize = 42.6,
    motorEdge = 50.6,
    gripWidth = 8,
    gripHeight = 21,
    gripHole = 5,
    backstayScrewThickness = 5,
    backstayScrewHeight = 10,
    backstayBaseThickness = 5,
    backstayBaseHeight = 5,
    backstayBaseLength = 35,
    backstayBaseSlopeLength = 10,
    backstayBaseSlopeHeight = 2,
    screwHoleDiameter = 3.2,
) {
    corner = cornerSize(motorSize, motorEdge);

    rotate([90, 270, 0])
        translate([0, (motorSize+gripWidth)/2, gripHole/2])
            backstay(
                thickness=backstayScrewThickness,
                width=gripHeight,
                height=backstayScrewHeight,
                length=corner+(gripWidth/2),
                slopeLength=corner+(gripWidth/2)-backstayScrewThickness,
                slopeHeight=2
            );

    rotate([-90, 90, 0])
        translate([-gripHeight, (motorSize+gripWidth)/2, gripHole/2])
            backstay(
                thickness=backstayScrewThickness,
                width=gripHeight,
                height=backstayScrewHeight,
                length=corner+(gripWidth/2),
                slopeLength=corner+(gripWidth/2)-backstayScrewThickness,
                slopeHeight=2
            );

    rotate([0, 270, 270])
        translate([0, (motorSize+gripWidth)/2, gripHole/2])
            backstay(
                thickness=backstayScrewThickness,
                width=gripHeight,
                height=backstayScrewHeight,
                length=corner+(gripWidth/2),
                slopeLength=corner+(gripWidth/2)-backstayScrewThickness,
                slopeHeight=2
            );

    rotate([0, 90, 270])
        translate([-gripHeight, (motorSize+gripWidth)/2, gripHole/2])
            backstay(
                thickness=backstayScrewThickness,
                width=gripHeight,
                height=backstayScrewHeight,
                length=corner+(gripWidth/2),
                slopeLength=corner+(gripWidth/2)-backstayScrewThickness,
                slopeHeight=2
            );

}

module screwHoles(
    motorHolderType = "simple",
    motorSize = 42.6,
    gripWidth = 8,
    gripHeight = 21,
    backstayScrewHeight = 10,
    screwHoleDiameter = 3.2,
) {
    difference() {
        children();

        rotate([0, 90, 0])
            translate([
                -gripHeight/2,
                (motorSize+gripWidth+backstayScrewHeight)/2,
                -(gripHeight+gripWidth)
            ])
                cylinder(d=screwHoleDiameter, h=motorSize);

        rotate([90, 0, 0])
            translate([
                (motorSize+gripWidth+backstayScrewHeight)/2,
                gripHeight/2,
                -motorSize/2
            ])
                cylinder(d=screwHoleDiameter, h=motorSize);

        if (motorHolderType == "half") {
            rotate([90, 0, 0])
                translate([
                    -(motorSize+gripWidth+backstayScrewHeight)/2,
                    gripHeight/2,
                    -motorSize/2
                ])
                    cylinder(d=screwHoleDiameter, h=motorSize);
        }
    }
}

module centerCoords(
    motorHolderType = "simple",
    motorSize = 42.6,
    gripWidth = 8,
    gripHeight = 21,
    backstayScrewHeight = 10,
    backstayBaseHeight = 5,
    backstayBaseLength = 35,
    backstayBaseSlopeHeight = 2,
    center = false
) {
    if (motorHolderType == "simple") {
        let(extraLeft = max(0, (backstayBaseLength-(motorSize+gripWidth)))) {
            if (center == true) {
                translate([
                    extraLeft/2,
                    (max(backstayBaseHeight,backstayBaseSlopeHeight)-backstayScrewHeight)/2,
                    -gripHeight/2
                ])
                    children();
            } else {
                translate([
                    ((motorSize+gripWidth)/2)+extraLeft,
                    ((motorSize+gripWidth)/2)+backstayBaseHeight,
                    0
                ])
                    children();
            }
        }
    } else if (motorHolderType == "corner") {
        if (center == true) {
            translate([
                (max(backstayBaseHeight, backstayBaseSlopeHeight)-backstayScrewHeight)/2,
                -backstayScrewHeight/2,
                -gripHeight/2
            ])
                children();
        } else {
            translate([
                ((motorSize+gripWidth)/2)+backstayBaseHeight,
                (motorSize+gripWidth)/2,
                0
            ])
                children();
        }
    } else if (motorHolderType == "half") {
        if (center == true) {
            translate([0, 0, -gripHeight/2])
                children();
        } else {
            translate([
                (motorSize+gripWidth)/2+backstayScrewHeight,
                (motorSize+gripWidth)/2,
                0
            ])
                children();
        }
    } else {
        children();
    }
}

module motorHolder(
    motorHolderType = "simple",
    motorSize = 42.6,
    motorEdge = 50.6,
    gripWidth = 8,
    gripHeight = 21,
    gripHole = 5,
    backstayScrewThickness = 5,
    backstayScrewHeight = 10,
    backstayBaseThickness = 5,
    backstayBaseHeight = 5,
    backstayBaseLength = 35,
    backstayBaseSlopeLength = 10,
    backstayBaseSlopeHeight = 2,
    screwHoleDiameter = 3.2,
    center = false
) {
    centerCoords(
        motorHolderType = motorHolderType,
        motorSize = motorSize,
        gripWidth = gripWidth,
        gripHeight = gripHeight,
        backstayScrewHeight = backstayScrewHeight,
        backstayBaseHeight = backstayBaseHeight,
        backstayBaseLength = backstayBaseLength,
        backstayBaseSlopeHeight = backstayBaseSlopeHeight,
        center = center
    ) {
        screwHoles(
            motorHolderType = motorHolderType,
            motorSize = motorSize,
            gripWidth = gripWidth,
            gripHeight = gripHeight,
            backstayScrewHeight = backstayScrewHeight,
            screwHoleDiameter = screwHoleDiameter
        ) {
            union () {
                motorHolderShape(
                    motorHolderType = motorHolderType,
                    motorSize = motorSize,
                    motorEdge = motorEdge,
                    gripWidth = gripWidth,
                    gripHeight = gripHeight,
                    gripHole = gripHole
                );

                if (motorHolderType == "simple") {
                    simpleSupports(
                        motorSize = motorSize,
                        motorEdge = motorEdge,
                        gripWidth = gripWidth,
                        gripHeight = gripHeight,
                        gripHole = gripHole,
                        backstayScrewThickness = backstayScrewThickness,
                        backstayScrewHeight = backstayScrewHeight,
                        backstayBaseThickness = backstayBaseThickness,
                        backstayBaseHeight = backstayBaseHeight,
                        backstayBaseLength = backstayBaseLength,
                        backstayBaseSlopeLength = backstayBaseSlopeLength,
                        backstayBaseSlopeHeight = backstayBaseSlopeHeight,
                        screwHoleDiameter = screwHoleDiameter
                    );
                } else if (motorHolderType == "corner") {
                    cornerSupports(
                        motorHolderType = motorHolderType,
                        motorSize = motorSize,
                        motorEdge = motorEdge,
                        gripWidth = gripWidth,
                        gripHeight = gripHeight,
                        gripHole = gripHole,
                        backstayScrewThickness = backstayScrewThickness,
                        backstayScrewHeight = backstayScrewHeight,
                        backstayBaseThickness = backstayBaseThickness,
                        backstayBaseHeight = backstayBaseHeight,
                        backstayBaseLength = backstayBaseLength,
                        backstayBaseSlopeLength = backstayBaseSlopeLength,
                        backstayBaseSlopeHeight = backstayBaseSlopeHeight,
                        screwHoleDiameter = screwHoleDiameter
                    );
                } else if (motorHolderType == "half") {
                    halfSupports(
                        motorHolderType = motorHolderType,
                        motorSize = motorSize,
                        motorEdge = motorEdge,
                        gripWidth = gripWidth,
                        gripHeight = gripHeight,
                        gripHole = gripHole,
                        backstayScrewThickness = backstayScrewThickness,
                        backstayScrewHeight = backstayScrewHeight,
                        backstayBaseThickness = backstayBaseThickness,
                        backstayBaseHeight = backstayBaseHeight,
                        backstayBaseLength = backstayBaseLength,
                        backstayBaseSlopeLength = backstayBaseSlopeLength,
                        backstayBaseSlopeHeight = backstayBaseSlopeHeight,
                        screwHoleDiameter = screwHoleDiameter
                    );
                }
            }
        }
    }
}

motorHolder(
    motorHolderType = motorHolderType,
    motorSize = motorSize,
    motorEdge = motorEdge,
    gripWidth = gripWidth,
    gripHeight = gripHeight,
    gripHole = gripHole,
    backstayScrewThickness = backstayScrewThickness,
    backstayScrewHeight = backstayScrewHeight,
    backstayBaseThickness = backstayBaseThickness,
    backstayBaseHeight = backstayBaseHeight,
    backstayBaseLength = backstayBaseLength,
    backstayBaseSlopeLength = backstayBaseSlopeLength,
    backstayBaseSlopeHeight = backstayBaseSlopeHeight,
    screwHoleDiameter = screwHoleDiameter,
    center = false
);