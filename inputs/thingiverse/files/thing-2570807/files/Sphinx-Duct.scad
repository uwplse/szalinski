//slice() dimensions
height7 = 15;       //depth
depth7 = 7;         //height
radius7 = 44;       //outer radius
degrees7 = 180;

//translate([-39,0,50]) rotate([90,0,0]) cylinder(d=3,h=25,$fn=30); //measuring rod
union() {
    translate([0, -5, 46.5]) rotate([0,0,0]) properlySpaced();   //Duct Receivers
    translate([0,0,0]) rotate([0,0,0]) hoopDuct();
    translate([0,0,0]) rotate([0,0,0]) leftTaper();
    translate([0,0,0]) rotate([0,0,0]) rightTaper();
}
module rightTaper() {
    difference(){
        hull() {
            translate([39,-17.8,12]) rotate([41,359.5,0]) cylinder(d=1,h=47,$fn=30); //BR
            translate([27.4,-14.58,12]) rotate([43.3,347.5,0]) cylinder(d=1,h=49,$fn=30); //BL
            translate([31,-1.05,12]) rotate([26,342,0]) cylinder(d=1,h=41,$fn=30); //TL
            translate([42.65,-4.17,12]) rotate([22,354,0]) cylinder(d=1,h=38.6,$fn=30); //TR
        }
        hull() {
            translate([37.7,-14.5,11]) rotate([40.5,358,0]) cylinder(d=.5,h=48,$fn=30); //BR
            translate([29.6,-12.3,11]) rotate([42.1,348,0]) cylinder(d=.5,h=50,$fn=30); //BL
            translate([32.4,-3.2,11]) rotate([26,344,0]) cylinder(d=.5,h=70,$fn=30); //TL
            translate([40.4,-5.4,11]) rotate([24,355,0]) cylinder(d=.5,h=70,$fn=30); //TR
        }
    }
}
module leftTaper() {
    difference(){
        hull() {
            translate([-39,-17.7,12]) rotate([41,1,0]) cylinder(d=1,h=47,$fn=30); //BL
            translate([-27.4,-14.6,12]) rotate([43,13,0]) cylinder(d=1,h=49,$fn=30); //BR
            translate([-42.6,-4.15,12]) rotate([22,6,0]) cylinder(d=1,h=38,$fn=30); //TL
            translate([-31,-1.05,12]) rotate([26,19,0]) cylinder(d=1,h=41,$fn=30); //TR
        }
        hull() {
            translate([-37.7,-14.4,11]) rotate([41,2,0]) cylinder(d=.5,h=70,$fn=30); //BL
            translate([-29.7,-12.4,11]) rotate([41.5,13,0]) cylinder(d=.5,h=70,$fn=30); //BR
            translate([-40.35,-5.4,11]) rotate([23,6,0]) cylinder(d=.5,h=70,$fn=30); //TL
            translate([-32.3,-3.25,11]) rotate([26,17,0]) cylinder(d=.5,h=70,$fn=30); //TR
        }
    }
}
module jets() {
    for(a = [15 : 30 : 360])
    rotate(a) translate([31, 0, 0]) rotate([0,340,0]) cylinder(d=6, h=1.5, $fn=30);
}
module hoopDuct() {
    union() {
        difference() {
            translate([0,0,0]) rotate([0,0,0]) outerRing();
            translate([0,0,1.5]) rotate([0,0,0]) innerRing();
            translate([0, 0, 1.75]) rotate([0,0,0]) jets();
            rotate([0,0,75]) translate([0,-36.25,5.5]) airEntry();
            rotate([0,0,285]) translate([0,-36.25,5.5]) airEntry();
            slice(); // the missing piece
        }
            rotate([0,0,75]) translate([0,-36.25,7]) leg();  //Right
            rotate([0,0,285]) translate([0,-36.25,7]) leg();  //Left
        endcap();  
    }
}
module airEntry() {
    minkowski() {
        translate([0,0,0]) rotate([0,0,0]) cube([12,6.5,1.5], center=true);  //Leg entry
        translate([0,0,0]) rotate([0,0,0]) cylinder(d=3,h=1.5,$fn=30);
    }
}
module endcap() {
    translate([30,-1,0]) cube([13,1,7]);
    translate([-43,-1,0]) cube([13,1,7]);
}
module outerRing() {
    rotate_extrude($fn = 100)
    translate([30, 0, 0]) square([13,7]);
}
module innerRing() {
    rotate_extrude($fn = 100)
    translate([31.5, 0, 1.5]) square([10,4]);
}
module slice() {
    translate([0,-.5,0]) rotate([0,0,270]) arc();
}
module ductReceivers() {
    difference() {
        translate([0,-4.5,0]) cube([20.5,29.5,7]);
        translate([2,0,0]) cube([16.4,25,7]);
        translate([0,20.25,3.5]) rotate([0,90,0]) cylinder(d=3.3,h=21,$fn=30);  //12.25+8
        translate([0,4.25,3.5]) rotate([0,90,0]) cylinder(d=3.3,h=21,$fn=30);  //12.25-8
    }
}
module properlySpaced() {
    translate([19,-40,0]) rotate([0,0,0]) ductReceivers();
    translate([-39,-40,0]) rotate([0,0,0]) ductReceivers();
}
module leg() {
linear_extrude(height=5)
minkowski() {
    difference() {
            translate([0,0,0]) rotate([0,0,0]) square([14,12], center=true);
            translate([0,0,0]) rotate([0,0,0]) square([11,9], center=true);
        }
        translate([0,0,0])circle(d=1,$fn=12, center=true);
    }
}
module arc() {
    render() {
        difference() {
                // Outer ring
        rotate_extrude($fn = 100) translate([radius7 - height7, 0, 0]) square([height7,depth7]);           
                // Cut half off
        translate([0,-(radius7+1),-.5]) cube ([radius7+1,(radius7+1)*2,depth7+1]);           
                // Cover the other half as necessary
        rotate([0,0,180-degrees7]) translate([0,-(radius7+1),-.5]) 
        cube ([radius7+1,(radius7+1)*2,depth7+1]);           
        }
    }
}
module twisted() {
linear_extrude(height = 15, convexity = 30, twist = 57, $fn=100)
minkowski() {
    difference() {
            translate([0,0,0]) rotate([0,0,0]) square([12,14]);
            translate([1.5,1.5,0]) rotate([0,0,0]) square([9,11]);
        }
        translate([-.5,-.5,0])circle(d=1,$fn=12);
    }
}
