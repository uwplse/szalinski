// Overall knob length (GoPro standard=35, GoPro short=25)
knobh = 35; // [45,35,25,12]

// Number of points on knob
nknob = 4; // [1,2,3,4] 

// Outside diameter of gripping area. If you mess with this, you
// won't be able to use a standard wrench, and you might have clearance
// problems under the camera case or againt mounts.
gripd = 20;

// Height of lobes
griph = 10;

// Number of knobs with extended grips areas.
// This allows more torque/better grip, but it won't clear
// the camera body on anything less than a 45mm knob, and on shorter
// knobs you may not even be able to clear the mount body.
npknob = 0; // [0,1,2,3,4]

// Size multiplier for extended grip lobes
pknob = 1.5; // [1.5,2,2.5]

// Diameter of tip of each lobe
lobed = 7;

// Length of bolt... needs to be able to extend approx 19mm, so anything
// less than 25mm is probably not going to work.
m5len = 25;

/* [Hidden] */

m5d = 6;
m5head = 10;   // a bit of fudging going on here

$fn = 36;

// Main shaft diameter... basically the bolt head plus three shells
// at 0.4mm.
md = m5head+(1.2*2);

mirror([0,0,1])
difference() {
   union() {
      cylinder(d=md,h=knobh);
      for(n=[0:nknob]) {
         a = n * (360/nknob);
         rotate([0,0,a])
         hull() {
            cylinder(d=md,h=griph);
            translate([((n<npknob)?pknob:1)*(gripd-lobed)/2,0,2])
               sphere(d=lobed);
         }
      }
   }
   translate([0,0,-0.01]) union() {
      difference() {
         rotate([0,0,30]) cylinder(d=m5head,h=knobh-(m5len-19),$fn=6);
         for(a=[0:120:359]) {
            rotate([0,0,a])
               translate([m5head/2.2,0,knobh-(m5len-19)-m5d/2])
                  scale([1,1,m5d]) sphere(d=1);
         }
      }
      cylinder(d=m5d,h=knobh+2);
      translate([0,0,-lobed+0.1]) cylinder(d=gripd*pknob,h=lobed);
   }
}
