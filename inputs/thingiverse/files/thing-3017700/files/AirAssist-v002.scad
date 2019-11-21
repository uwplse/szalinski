// Height of the blow Cone
coneheight=9;
// Hole in the Cone
coneholediameter = 5;
// Diameter of the Lasertube
diameterlaser=26.5;
// Height of the Lasertube
heightlaser=20;
// Wall thickness
wallthickness=1.5;
// Make the front thicker to accept the threaded insert
frontshift=2.5;

// Mounting hole distance from bottom of plate
heightmountinghole=10;
// Mounting hole diameter
diametermountinghole=6.0;

// Baseplate thickness
thicknessbaseplate=10;

// Fan opening - width
fanwidth=15;
// Fan opening - height
fanheight=20;
// Position of the fan mounting screwholes - X Position of first hole
fanmountx1=4;
// Position of the fan mounting screwholes - Y Position of first hole
fanmounty1=6.6+38;
// Position of the fan mounting screwholes - X Position of second hole
fanmountx2=4+43;
// Position of the fan mounting screwholes - Y Position of second hole
fanmounty2=6.6;
// Diameter of the fan mounting screwholes
fanmountdia=6;
// How much to shift the entire fan mount forward
shiftfan = 3;
// Thickness of the supporting wall
thicknesssupportwall=5;


union() {

  // Tube
  difference() {
    union() {
      cylinder(d=diameterlaser+2*wallthickness,h=heightlaser);
      translate([frontshift,0,0]) cylinder(d=diameterlaser+2*wallthickness,h=heightlaser);
    }
    cylinder(d=diameterlaser,h=heightlaser);
    translate([diameterlaser/4,0,heightmountinghole])
      rotate([0,90,0])
        cylinder(d=diametermountinghole,h=diameterlaser);
  }

  // Baseplate
   difference () {
    translate([-diameterlaser/2-wallthickness,-diameterlaser/2-wallthickness,-thicknessbaseplate])
      cube([diameterlaser+2*wallthickness+frontshift, diameterlaser+2*wallthickness + fanwidth + thicknesssupportwall, thicknessbaseplate]);
    translate([0,0,-thicknessbaseplate]) cylinder(d=diameterlaser,h=thicknessbaseplate);
    translate([shiftfan,0,0])
      translate([-diameterlaser/2,diameterlaser/2+wallthickness,-thicknessbaseplate/2]) cube([fanheight,fanwidth,thicknessbaseplate/2]);

    // Channel for airflow
      hull() {
        translate([shiftfan,0,0])
          translate([-diameterlaser/2,diameterlaser/2+wallthickness,-thicknessbaseplate*3/4]) cube([fanheight,fanwidth,thicknessbaseplate/2]);
        translate([0,0,-thicknessbaseplate*3/4]) cylinder(d=diameterlaser,h=thicknessbaseplate/2);
      }

    // Cutting away material to make room for the screws
    translate([-diameterlaser/2-wallthickness,diameterlaser/2+wallthickness+0.5*(fanwidth+thicknesssupportwall),-thicknessbaseplate])
      cube([shiftfan,0.5*(fanwidth+thicknesssupportwall),thicknessbaseplate]);

    // Chamfer to register the cone
    translate([0,0,-thicknessbaseplate])
      cylinder(d1=diameterlaser+wallthickness+0.2,d2=diameterlaser+0.2,h=thicknessbaseplate*0.25);

    // Rounding of the corners next to the tube (only for the look)
    difference () {
      translate([-diameterlaser/2-wallthickness,-diameterlaser/2-wallthickness,-thicknessbaseplate])
        cube([diameterlaser+2*wallthickness+frontshift, diameterlaser/2+wallthickness, thicknessbaseplate]);

      translate([0,0,-thicknessbaseplate]) union() {
        cylinder(d=diameterlaser+2*wallthickness,h=heightlaser);
        translate([frontshift,0,0]) cylinder(d=diameterlaser+2*wallthickness,h=heightlaser);
      }

    }

  }

  // Support wall
  wallheight = thicknessbaseplate + max(fanmounty1,fanmounty2) + wallthickness + fanmountdia;
  wallwidth = max(fanmountx1,fanmountx2) + 2 * wallthickness +fanmountdia;
  translate([shiftfan,0,0])
    translate([-diameterlaser/2-wallthickness,diameterlaser/2+wallthickness+fanwidth,-thicknessbaseplate])
      difference() {
        cube([wallwidth,thicknesssupportwall,wallheight]);
        translate([wallthickness+fanmountx1,thicknesssupportwall,thicknesssupportwall+fanmounty1+fanmountdia]) rotate([90,0,0]) cylinder(d=fanmountdia,h=thicknesssupportwall);
        translate([wallthickness+fanmountx2,thicknesssupportwall,thicknesssupportwall+fanmounty2+fanmountdia]) rotate([90,0,0]) cylinder(d=fanmountdia,h=thicknesssupportwall);
      }

}

// Cone
translate([0,-diameterlaser*1.5,coneheight-thicknessbaseplate])
difference() {
  union() {
    cylinder(d1=diameterlaser+wallthickness,d2=diameterlaser,h=thicknessbaseplate*0.25);
    translate([0,0,-coneheight]) cylinder(d1=coneholediameter+2*wallthickness,d2=diameterlaser+2*wallthickness,h=coneheight);
  }
  cylinder(d=diameterlaser,h=thicknessbaseplate*0.25);
  translate([0,0,-coneheight]) cylinder(d1=coneholediameter,d2=diameterlaser,h=coneheight);
}
