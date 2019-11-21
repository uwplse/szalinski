//Base Diameter (in inches)
large_diameter_in_inches = 2.5;

//Top Diameter (in inches)
top_diameter_in_inches = 0.1875;

//Cone Height (in inches)
height_in_inches = 4.5;

rad1=large_diameter_in_inches*25.4/2;
rad2=top_diameter_in_inches*25.4/2;

hgt=height_in_inches*25.4;

cylinder(h=hgt, r1=rad1, r2=rad2, center=false,$fn = 120);