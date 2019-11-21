//Make sure that the thickness of the spool wall is thinner then the combine sum of half of the number of bearings times the bearing width.

//Width in mm
Spool_width=51; // [30:200]
//Width in mm
Bearing_width=5; // [5:1:20]
//The number of bearings are split equal on each side of the spacer:
Number_of_bearings=4; // [2:2:8]
A=10*1;
B=3*1;
Spacer_width=(Spool_width+2)-(Number_of_bearings*Bearing_width)-(2*B);
//Total length of the threaded rod in mm
Rod_length=(Spacer_width);

difference()
  {
      cylinder(r=12/2, h=Spacer_width);
      translate([0,0,-1])
      cylinder(r=8.5/2, h=Spacer_width+2);
  }