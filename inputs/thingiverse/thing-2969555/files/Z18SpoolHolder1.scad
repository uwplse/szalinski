Bearing608zzThick = 8;
Bearing608zzDiameter = 22.5;
M8ThreadDiameter = 12;
XWallThick = 20;
YWallThick = 5;
ZWallThick = 3;

Z18plateThick = 4;
spoolHeight = 150;
part = "both"; // [left:left only,right:right only,both:left and right]

module bearingSupport(Bearing608zzThick, Bearing608zzDiameter, M8ThreadDiameter, XWallThick, YWallThick, ZWallThick)  {
    difference() {
        translate([-(XWallThick*2+Bearing608zzDiameter)/2, -(YWallThick*2+Bearing608zzThick)/2, 0]) {
            cube([XWallThick*2+Bearing608zzDiameter, YWallThick*2+Bearing608zzThick, ZWallThick + Bearing608zzDiameter*2/3]);
        }
        translate([0,0,ZWallThick+Bearing608zzDiameter/2]) {
            rotate([90,0,0]) {
                cylinder(r=Bearing608zzDiameter/2, h=Bearing608zzThick, $fn=50, center=true);
                cylinder(r=M8ThreadDiameter/2, h=Bearing608zzThick+YWallThick*2+2, $fn=50, center=true);
            }
        }
    }
}


module Z18clip(width, height, thick, Z18plateThick) {
    difference() {
        union() {
            translate([-(width)/2, -thick-Z18plateThick/2, 0]) {
                cube([width,thick,height]);
            }
            translate([-(width)/2, Z18plateThick/2, 0]) {
                cube([width,thick,height]);
            }
        }
        translate([0,-(thick*2+Z18plateThick+2)/2, height-32]) {
            rotate([-90,0,0]) {
                cylinder(h=thick*2+Z18plateThick+2, r=2, $fn=25);
            }
        }
    }

}

/*
 leftOrRight: 1 - left, (-1) - right
*/
module spoolHolder(leftOrRight) {
    difference() {
        translate([0,0,(XWallThick*2+Bearing608zzDiameter)/2*cos(45/2)-Z18plateThick/2*sin(45/2)]) {
            rotate([0,90,0]) {
                rotate([0,0,leftOrRight*45/2]) {
                    Z18clip(XWallThick*2+Bearing608zzDiameter, 45, 6, Z18plateThick);
                    translate([-(XWallThick*2+Bearing608zzDiameter)/2, -(6*2+Z18plateThick)/2, 45]) {
                        cube([XWallThick*2+Bearing608zzDiameter, 6*2+Z18plateThick, spoolHeight]);
                    }
                }
                rotate([0,0,(-leftOrRight)*45/2]) {
                    translate([0,0,45+spoolHeight]) {
                        bearingSupport(Bearing608zzThick, Bearing608zzDiameter, M8ThreadDiameter, XWallThick, YWallThick, ZWallThick);
                    }
                }
            }
        }
        translate([-300,-300,-300]) {
            cube([600,600,300]);
        }
    }
}

if (part == "left") {
    spoolHolder(-1);
} else if (part == "right") {
    spoolHolder(1);
} else if (part == "both") {
    translate([0, -(YWallThick*2+Bearing608zzThick)*1.5, 0]) {
        spoolHolder(1);
    }
    translate([0, +(YWallThick*2+Bearing608zzThick)*1.5, 0]) {
        spoolHolder(-1);
    }
}
