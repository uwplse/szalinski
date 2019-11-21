adapt1 = 6;  //radius to adapt
h1 = 12; //effector clamp h
ridgeh = 3;
h2 = 5; //middle h
h3 = 10; //adapted h
tight = 1.2;
ridge = 1.2;
wall = 2;
adapt2 = 9;  //radius of adapted cilinter
screw = 2 + 0.25; //M3 screw

innerSize = adapt1-wall;

difference() {

rotate_extrude(convexity = 10, $fn = 100)
{
    rotate([0, 0, 90])
    polygon(points = [ [0, innerSize], [h1, innerSize], [h1, innerSize+wall + ridge],
    [h1 - ridgeh, innerSize+wall+ridge], [h1- ridgeh, innerSize+wall], [ridgeh, innerSize+wall],
   [ridgeh, innerSize+wall+ridge], [0, innerSize+wall+ridge] ]);

    rotate([0, 0, 90])
    polygon(points = [ [h1, innerSize], [h1+h2, adapt2],
    [h1+h2, adapt2 + wall], [h1, innerSize+wall] ]);

    rotate([0, 0, 90])
    polygon(points = [ [h1+h2, adapt2], [h1+h2+h3, adapt2],
    [h1+h2+h3, adapt2 + wall], [h1+h2, adapt2+wall] ]);
}

//cut tightning slot
translate([adapt2-tight, -tight/2, h1+h2])
{
cube([wall*2, tight, h3]);
}
}

//tightening flanges

translate([adapt2 + screw + wall, tight/2, h1+h2+h3-(screw+wall)/2])
rotate([90,0,180])
{
difference(){
    translate ([0,0,0]) {
    cylinder(r=(screw+wall)/2, h=wall,$fn=36);  // cylinder
    translate([wall,0,wall/2])
    cube([screw+wall/2, screw+wall, wall], center = true);  // cylinder
    }
    cylinder(r=(screw)/2, h=wall,$fn=36);  // cylinder
}
}

translate([adapt2 + screw + wall, -wall-tight/2, h1+h2+h3-(screw+wall)/2])
rotate([90,0,180])
{
difference(){
    translate ([0,0,0]) {
    cylinder(r=(screw+wall)/2, h=wall,$fn=36);  // cylinder
    translate([wall,0,wall/2])
    cube([screw+wall/2, screw+wall, wall], center = true);  // cylinder
    }
    cylinder(r=(screw)/2, h=wall,$fn=36);  // cylinder
}
}

