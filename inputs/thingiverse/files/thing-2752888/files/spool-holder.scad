Spooler_Diameter = 200;
Bearing_Diameter = 25;
Bearing_Thickness = 10;
Washer_Size = 3;
Washer_Thickness = 2;
Bearing_Curb = 5;
Corner = 3;
Aperture = 55; // [15:1:100]
ExtraHeight = 5;
Wall_Thickness = 4;
Axis_Metric = 4;
Axis_Type = "hexagon"; // ["hexagon", "circle"]
Pins = true;
Pin_Diameter = 3;
Pin_Tolerance = 0.1;
Pin_Length_Extra = -4;

$fn=100;

bearingRadius = (Bearing_Diameter/2)+Bearing_Curb;

bearingPositionX = sin(Aperture/2)*0.5*(Spooler_Diameter+Bearing_Diameter);
bearingPositionY = cos(Aperture/2)*0.5*(Spooler_Diameter+Bearing_Diameter);

minPos = max(bearingPositionY+bearingRadius,Spooler_Diameter/2)+ExtraHeight;

translate([0, -minPos, 0]) union() {
    holder();
    pin(tolerance=0);

    mirror([1, 0, 0]) difference () {
        holder();
        pin(tolerance=Pin_Tolerance);
    }
}

module pin(tolerance = 0) {
    if (Pins) {
        translate([bearingPositionX, bearingPositionY+bearingRadius+(ExtraHeight/2), Wall_Thickness-Pin_Length_Extra])
            cylinder(h=((Washer_Thickness+Pin_Length_Extra)*2)+Bearing_Thickness, d=Pin_Diameter+tolerance);
    }
}

module holder() {
    union() {

        difference() {
            linear_extrude(height=Wall_Thickness+Washer_Thickness+(Bearing_Thickness/2)) {
                shape();
            }
            translate([-(bearingPositionX+Bearing_Diameter+Bearing_Curb), -Spooler_Diameter, Wall_Thickness])
                cube(size=[2*(bearingPositionX+Bearing_Diameter+Bearing_Curb), Spooler_Diameter+minPos-ExtraHeight, Wall_Thickness+Washer_Thickness+Bearing_Thickness]);
        }

        translate([bearingPositionX, bearingPositionY, Wall_Thickness])
            bearingAxis();
    }
}

module bearingAxis() {
    metricDef = Axis_Type == "hexagon" ? 6 : $fn;
    divisor = Axis_Type == "hexagon" ? sqrt(3) : 2;

    cylinder(r=(Axis_Metric+Washer_Size)/divisor, h=Washer_Thickness, $fn=metricDef);
    translate([0, 0, Washer_Thickness])
        cylinder(r=Axis_Metric/divisor, h=Bearing_Thickness/2, $fn=metricDef);
}

module corners() {
    if (Corner > 0) {
        translate([bearingPositionX+bearingRadius-Corner, minPos-Corner])
            circle(r=Corner);
        translate([bearingPositionX-bearingRadius+Corner, minPos-Corner])
            circle(r=Corner);
    } else {
        l = Bearing_Diameter/10;
        translate([bearingPositionX+bearingRadius, minPos-l])
            square(size=[l, l]);
        translate([bearingPositionX-bearingRadius-l, minPos-l])
            square(size=[l, l]);
    }
}

module shape() {
    difference() {
        union() {
            hull() {
                translate([bearingPositionX, bearingPositionY])
                    circle(r=bearingRadius);
                corners();
            }
        translate([0, bearingPositionY-(bearingRadius*cos(Aperture/2))])
            square([bearingPositionX, minPos+(bearingRadius*(cos(Aperture/2)))-bearingPositionY]);
        }
        circle(r=(Spooler_Diameter/2)-Bearing_Curb);
    }
}

