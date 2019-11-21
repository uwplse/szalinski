//
//  adapter to fit various size parasol tubes to various size
//  parasol bases
//
//  design by:
//      egil kvaleberg
//      28 may 2017
//
//  v1: original
//  v2: modified to provide more support if slot is wide
//

// crimp factor for material, approx 0.2% may work for PLA, ABS needs more, maybe as high as 1.5%
crimp_percent = 0.2;  

// inner diameter of adapter (which is outer dia of parasol tube)
innerdia = 38.0;

// outer diameter of adapter (which is inner dia of base tube)
outerdia = 56.5;

// top rim relative to outerdia
rim = 2.7; 

// adapter height below rim
height = 65.0; 

// general wall (assume 100% infill)
wall = 2.0;

// height of rim
rimwall = 5.0;

// width of slot in side, 0 if none
slot = 22.0;

// tolerance of fit
tol = 0.2;

fn=1*96;
d=1*0.1;
chamfer = wall*0.4;

a0 = asin((slot/2) / (innerdia/2));
echo(a0);
a1 = 360-2*a0;
nrib = max(5,ceil(a1*outerdia*3.14 / (360*4*wall)));
echo(nrib);

module add() {
    // rim
    cylinder(r1=outerdia/2+rim-chamfer, r2=outerdia/2+rim, h=chamfer, $fn=fn);
    translate([0,0,chamfer]) 
      cylinder(r=outerdia/2+rim, h=rimwall-chamfer, $fn=fn);
    // inner core
    cylinder(r=innerdia/2+wall, h=rimwall+height, $fn=fn);
    // ribs
    intersection () {
        union () {
            translate([0,0,-d]) 
              cylinder(r=outerdia/2-tol, h=d+rimwall+height-chamfer, $fn=fn);
            translate([0,0,rimwall+height-chamfer]) 
              cylinder(r1=outerdia/2-tol, r2=outerdia/2-tol-chamfer, h=chamfer+d, $fn=fn);
        }
        union () {
            for (a = [-1.5:1.0:nrib+0.5])
              rotate([0,0,a0 + a*a1/(nrib-1)]) 
                translate([0,-wall/2,0]) 
                  cube([outerdia/2,wall,rimwall+height]);
            for (s = [1,-1])
              translate([0,s*(slot/2+wall/2)-wall/2,0]) 
                cube([outerdia/2,wall,rimwall+height]);
        }
    }
}

module sub() {
    // inner core
    translate([0,0,-d]) 
      cylinder(r=innerdia/2+tol, h=d+rimwall+height+d, $fn=fn);
    translate([0,0,-d]) 
      cylinder(r1=innerdia/2+tol+chamfer, r2=innerdia/2+tol, h=d+chamfer, $fn=fn);
    // slot
    if (slot > 0) {
        translate([outerdia/2-2*rim,-slot/2,rimwall * 0.5]) 
          cube([(1+2)*rim,slot,rimwall+height+d]);
        translate([0,-slot/2,rimwall]) 
          cube([outerdia/2+rim,slot,height+d]);
    }
}

s0 = 1.0 + crimp_percent/100;
scale([s0,s0,s0])
difference () {
    add();
    sub();
}