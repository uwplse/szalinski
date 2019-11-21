// Quality
$fn=180*1;

// Weight in grams
WEIGHT = 15;

// Wall thickness in mm
WALL = 1.5;

// Inner diameter -- multiplied by 1 to hide in customizer
ID = 38.5*1;

// Height per gram, in mm/g
HPG = 38.5/15;

// Inner Height
IH = WEIGHT * HPG;

// Outer Height
OH = IH + WALL;

// Outer Diameter
OD = ID + WALL * 2;

difference () {
    cylinder (h=OH, d=OD);
    translate([0,0,WALL]) cylinder (h=OH, d=ID);
    translate([0,0,-0.7]) linear_extrude(height=1) mirror([1,0,0]) text(str(WEIGHT), size=20, halign="center", valign="center");
}
