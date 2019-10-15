Bead_Diameter=3;
Gap_Between_Beads=.8;
Beads_Count = 4;
/* [Hidden] */
// Design Object(s)
blindCordConnector(Bead_Diameter, Gap_Between_Beads, Beads_Count);

// Entire Connector
module blindCordConnector(Bead_Diameter=3, Gap_Between_Beads=1.1, Beads_Count=3)
{
  $fn=35;
  distance = Bead_Diameter+Gap_Between_Beads;
  housingWidth = 1.7*Bead_Diameter;
  //rotate( [180,0,180]) 
  difference() {
    halfLog(housingWidth,Beads_Count,distance);
    cordHole(Bead_Diameter,Beads_Count,distance);
    }
}

// Hole for String and Beads
module cordHole(Bead_Diameter,Beads_Count,distance)
{
    translate([-distance, 0, .5*Bead_Diameter]) 
      hull() { 
        sphere(d=.25*Bead_Diameter); 
        translate([distance*(Beads_Count+1),0,0]) sphere(d=.25*Bead_Diameter);
        translate([0,0,Bead_Diameter]) sphere(d=.25*Bead_Diameter); 
        translate([distance*(Beads_Count+1),0,Bead_Diameter]) sphere(d=.25*Bead_Diameter);
          
  }
    for(i=[-1:Beads_Count])
      translate([i*(distance), 0, .8*Bead_Diameter]) sphere(d = 1.2*Bead_Diameter);
}

// Case After Halving
module halfLog(housingWidth,Beads_Count,distance)
{
  difference() {
    translate([0, 0, housingWidth/2]) hull() {
        sphere(d = housingWidth);
        translate([(Beads_Count-1)*distance, 0, 0]) sphere(d = housingWidth);
        }
        translate([-distance, -.5*housingWidth,3*housingWidth/4]) 
      cube(size = [distance*(Beads_Count+1), housingWidth, housingWidth/4]);
  } 
}

