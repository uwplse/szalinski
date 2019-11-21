/* [Wheel Info] */
// Geneva Wheel radius
b = 20;
// slot quantity
n = 5;
// drive pin diameter
p = 3;
// allowed clearance
t = 0.65;
// height
height = 4;

/* [Platform Info] */
// axel width
axelDiameter = 5;
// platform margin
margin = 3;

/* [hidden] */
$fn = 200;
fudge = 0.005;
cutHeight = height + 2 * fudge;

c = b / cos(180 / n); // center distance
a = sqrt(pow(c, 2) - pow(b, 2)); // drive crank radius
s = a + b - c; //slot center length
w = p + t; // slot width
y = a - pow(p, 1.5); //stop arc radius
z = y - t; // stop disc radius
v = b * z / a; // clearance arc
dr = a + p ; // crank wheel diameter

// wheel
difference() {
    cylinder(r = b, h = height);
    
    translate([0,0,-fudge])
    cylinder(d = axelDiameter, h = cutHeight);
    
    for (i = [0:n-1]) {
        rotate([0,0,360/n*i]) {
            translate([c,0,-fudge])
            cylinder(r = y, h = cutHeight);
            
            rotate([0,0,360/(n*2)])
            hull() {
                translate([b,0,-fudge])
                cylinder(d = w, h = cutHeight);
                translate([b-s,0,-fudge])
                cylinder(d = w, h = cutHeight);    
            }
        }
    }
}

// crank
crankHandleWidth = 4;
translate([b+dr,0,0]) {
    difference() {
        union() {
            cylinder(r = dr, h = height);
            
            translate([0,0,height-fudge]) {
                translate([a,0,0])
                cylinder(d = p, h = height);
                
                difference() {
                    cylinder(r = z, h = height);
                    
                    translate([c,0,0])
                    cylinder(r = b+t, h = height+fudge);
                }
            }
        }
        
        gearDivots = floor(dr * 2 * 3.14 / (2 * w));
        for (i = [0:gearDivots-1]) {
            deg = 360 / gearDivots;
            rotate([0,0,deg*i+deg/2])
            translate([dr,0,-fudge])
            cylinder(d = w, h = cutHeight);
        }
        
        translate([0,0,-fudge])
        cylinder(d = axelDiameter, h = 2 * (height + fudge));
    }
}

// platform
wheelBase = b + margin;
crankBase = dr + margin;
translate([0,-b - max(wheelBase, crankBase) - 3,0]) {
    union() {
        hull() {
            cylinder(r = crankBase, h = height);
            
            translate([c,0,0])
            cylinder(r = wheelBase, h = height);
            
        }
        

        wheelPlatformRadius = c-dr-t+b/4;
        translate([c+b/4,0,0])
        cylinder(r = wheelPlatformRadius, h = 2*height);

        cylinder(d = axelDiameter-t, h = 3.5*height);
        
        translate([c,0,0])
        cylinder(d = axelDiameter-t, h = 3.5*height);
    }
}

//caps
capRadius = axelDiameter/2+2;
capTolerance = 0.25;
for (i = [0:1]) {
    translate([(2*capRadius+4)*i,b+3+capRadius,0]){
        difference() {
            cylinder(r = capRadius, h = height);
            translate([0,0,height/2])
            cylinder(d = axelDiameter-t+capTolerance, h = height);
        }
    }
}