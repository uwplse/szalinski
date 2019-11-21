// - Wrist Joint to Elbow Crease (mm) (Default = 210)
ForearmLen = 210; //[150:380]
// - Upper Forearm Circumference (mm) (85%) (Default = 194)
UpForearmCircum = 194; //[110:360]
// - Bot Forearm Circumference (mm) (15%) (Default = 142)
BotForearmCircum = 142; //[110:360]
// - Device Thickness (mm) (Default = 5)
Thickness = 5; //[4,5,6]
// - Tube Diameter (mm)
TubeDiameter = 2; //[1.5,2,2.5]

/* [Hidden] */
//Select Device Length of Forearm (70% Default)
ForearmPerc = 0.7;
//Device sits on 15% to 85%
DeviceLength = ForearmLen * ForearmPerc;

//Percent Upper Part wraps arounf Forearm
UpForearmPerc = .42;
UpDeviceWidth = UpForearmCircum * UpForearmPerc;

//Percent Bottom Part wraps around Forearm
BotForearmPerc = .33;
BotDeviceWidth = BotForearmCircum * BotForearmPerc;

module Forearm(){
    translate ([0,0,Thickness / 2])
    linear_extrude (height = Thickness, center = true, convexity = 10, rotate = 0, twist = 0, slices = 20, scale = 1.0)
    polygon(points = [
    [(-1 * (UpDeviceWidth * 0.5)),(0 + DeviceLength / 2)], //Top Left
    [(UpDeviceWidth * 0.5),(0 + DeviceLength / 2)], //Top Right
    [(BotDeviceWidth * 0.5), (0 - DeviceLength / 2)], //Bottom Right
    [(-1 * (BotDeviceWidth * 0.5)), (0 - DeviceLength / 2)] //Bottom Left
    ],
    paths = [[0,1,2,3]]);
}

module Tube(){
    if (ForearmLen < 250){CircOff =10;
        rotate_extrude(convexity = 10)
        translate([((DeviceLength / 2) + CircOff - 15), Thickness / 2, 0])
        circle(r = (TubeDiameter / 2), $fn = 100);
    } 
    else { CircOff = 0;
        rotate_extrude(convexity = 10)
        translate([((DeviceLength / 2) + CircOff - 15), Thickness / 2, 0])
        circle(r = (TubeDiameter / 2), $fn = 100);
    }
}


module rightSlots(){
    x2 = (UpDeviceWidth * 0.5);
    x1 = (BotDeviceWidth * 0.5);
    y2 = (0 + DeviceLength / 2);
    y1 = (0 - DeviceLength / 2);
    RAngle = atan2((y2-y1), (x2-x1));
    
    rotate([0,0,270 + RAngle])
    for (slotOff = [-DeviceLength * 0.4: 30 : DeviceLength *0.25  ]){
        translate([BotDeviceWidth * 0.5, slotOff, -Thickness / 2])
        union(){
                cube([4.5,20, Thickness + 30]);
                translate([2.25, 0, 0]) cylinder(r = 2.25, h = Thickness + 30);
                translate([2.25, 20, 0]) cylinder(r = 2.25, h = Thickness + 30);
        }
    }
}

module leftSlots(){
    x2 = (-UpDeviceWidth * 0.5);
    x1 = (-BotDeviceWidth * 0.5);
    y2 = (0 - DeviceLength / 2);
    y1 = (0 + DeviceLength / 2);
    LAngle = atan2((y2-y1), (x2-x1));
    
    rotate([0,0,270 - LAngle])
    for (slotOff = [-DeviceLength * 0.4  : 30: DeviceLength * 0.25]){
        translate([-BotDeviceWidth * 0.55, slotOff, -Thickness / 2])
        union(){
                cube([4.5,20, Thickness + 30]);
                translate([2.25, 0, 0]) cylinder(r = 2.25, h = Thickness + 30);
                translate([2.25, 20, 0]) cylinder(r = 2.25, h = Thickness + 30);
        }
    }
}

difference(){
    Forearm();
    rightSlots();
    leftSlots();
    difference(){
        Tube();
        translate( [-150, -300, 0]) cube(300);
    }
    
       
}
    
