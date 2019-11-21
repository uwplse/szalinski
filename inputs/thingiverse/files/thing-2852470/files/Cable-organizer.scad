//the stregth of the grabber(play around with it!) Higher values, the stronger is the connection
Grabber_strength = 1.5;
// Length of the holder in mm
Length = 10;
// Diameter of the cable in mm
Diameter_of_the_cable = 10;
// Thickness ofthe plasti in mm(2 mm is a good value)
Plastic_thickness = 2;
// Number of cables you have(it must be a round number not a 5,7 and so on). Just round it up!
Number_of_cables = 4;
for (i = [0 : abs(1) : Number_of_cables / 2 - 1]) {
  translate([0, ((Diameter_of_the_cable + Plastic_thickness) * i), 0]){
    difference() {
      cube([((Diameter_of_the_cable * 2 + Plastic_thickness) + Diameter_of_the_cable / Grabber_strength), (Diameter_of_the_cable + Plastic_thickness), Length], center=true);

      translate([Diameter_of_the_cable, 0, 0]){
        {
          $fn=50;    //set sides to 50
          cylinder(r1=(Diameter_of_the_cable / 2), r2=(Diameter_of_the_cable / 2), h=10, center=true);
        }
      }
      translate([(Diameter_of_the_cable * -1), 0, 0]){
        {
          $fn=50;    //set sides to 50
          cylinder(r1=(Diameter_of_the_cable / 2), r2=(Diameter_of_the_cable / 2), h=10, center=true);
        }
      }
    }
  }
}
