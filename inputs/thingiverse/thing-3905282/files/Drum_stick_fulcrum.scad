// OpenSCAD Drumstick Fulcrum Hold

// Finger Size
fs =22;

// Ring Width
rw = 10;

// Wiggle Room
wiggle = 1;

// Stick Diameter
d = 16;

// Constants

rt = 2;

// Defaults to Vic Firth 2Bs

// Finger Ring


difference(){
    union(){
        cylinder(h=d+wiggle+rt, d=fs+wiggle+rt, center=true);
        translate([d/2+fs/2+rt, 0, 0])rotate([90, 0, 0])
        cylinder(h=fs+wiggle+rt, d=d+wiggle+rt, center=true);
        translate([(fs+wiggle)/2, 0, 0])rotate([0, 90, 0])cylinder(h=rt, d=rw);
    }
    cylinder(h=d+wiggle+rt+2, d=fs+wiggle, center=true);
    translate([d/2+fs/2+rt, 0, 0])rotate([90, 0, 0])
    cylinder(h=fs+wiggle+rt+2, d=d+wiggle, center=true);
}

