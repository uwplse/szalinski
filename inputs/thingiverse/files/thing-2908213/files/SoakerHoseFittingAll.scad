// Which one would you like to see?
part = "fifth"; // [first:Single Outside (blue),second:Double Outside (red),third:Single Inside (green), fourth:Double Inside (orange), fifth:All]


// This is the ID of the fittings that go on the outside of the pipe
Outside_diameter_of_water_pipe_in_mm=20;// [2:.1:40]
// This is the OD of the fittings that go on the inside of the pipe or other fittings (like a tee or 90)
Inside_diameter_of_water_pipe_in_mm=20;// [8:.1:40]
Inside_diameter_of_soaker_hose_in_mm=10;// [5:.1:18]




print_part();

module print_part() {
	if (part == "first") {
		SO();
	} else if (part == "second") {
		DO();
	} else if (part == "third") {
		SI();
   } else if (part == "fourth") {
		DI();
   } else if (part == "fifth") {
		All();
	} 
}
module All() 
{
SO ();
DO ();
SI ();
DI ();
}


/*************************************
 
       Soaker hose attachment for
           outside of pipe

 Adjustable for water pipe & soaker hose 
           diameter and Tee

       Author: Lee J Brumfield

       This fits outside of a 
           1/2" PVC pipe
       ID is the same as 1/2"
             PVC pipe

 
      Enter the outside diameter of
     your water pipe & inside diameter 
        of your soaker hose here.
     
            Default is 21.8 &
            9mm respectively

*************************************/







/* [Hidden] */
// No changes below here
Tee="yes";// [yes,no]
ID=Inside_diameter_of_water_pipe_in_mm/2;
D1=Outside_diameter_of_water_pipe_in_mm/2;
D=Inside_diameter_of_soaker_hose_in_mm/2;


$fn=200;

module DO() 
{
color ("red")
{
translate([D1*2,0,0])
{
difference()
{
union()
{
translate([0,0,2.5])
rotate([0,0,0])
cylinder(h = 10, r = D1+2, center = true);
translate([8,0,14])
rotate([0,45,0])
cylinder(h = 20, r = D, center = true);
if (Tee == "yes")
translate([-8,0,14])
rotate([0,315,0])
cylinder(h = 20, r = D, center = true);
translate([15,0,21])
rotate([0,0,0])
sphere(r = D+.5, center = true);
if (Tee == "yes")
translate([-15,0,21])
rotate([0,0,0])
sphere( r = D+.5, center = true);
hull()
{
translate([0,0,8])
rotate([0,0,0])
cylinder(h = 1, r = D1+2, center = true);
translate([0,0,14])
rotate([0,0,0])
cylinder(h = 1, r = 2, center = true);
}

}

hull()
{
translate([0,0,8])
rotate([0,0,0])
cylinder(h = 1, r = D1, center = true);
translate([0,0,12])
rotate([0,0,0])
cylinder(h = 2, r = 2, center = true);
}
translate([0,0,0])
rotate([0,0,0])
cylinder(h = 15.01, r = D1, center = true);
translate([10,0,16])
rotate([0,45,0])
cylinder(h = 25, r = D-2, center = true);
if (Tee == "yes")
translate([-10,0,16])
rotate([0,315,0])
cylinder(h = 25, r = D-2, center = true);
if (Tee == "yes")
translate([-20.5,0,26.5])
rotate([0,315,0])
cube([20,20,10],center = true);
translate([20.5,0,26.5])
rotate([0,45,0])
cube([20,20,10],center = true);
}
}
}
}

/*************************************
 
       Soaker hose attachment for
           outside of pipe

      Adjustable for water pipe & 
         soaker hose diameter

       Author: Lee J Brumfield

       This fits outside of a 
           1/2" PVC pipe
       ID is the same as 1/2"
             PVC pipe

 
      Enter the outside diameter of
     your water pipe & inside diameter 
        of your soaker hose here.
     
            Default is 21.8 &
            9mm respectively

*************************************/


$fn=200;

module SO() 
{
color ("blue")
{
translate([-D1*2,0,0])
{
difference()
{
union()
{
translate([0,0,2.5])
rotate([0,0,0])
cylinder(h = 10, r = D1+2, center = true);
translate([0,0,14])
rotate([0,0,0])
cylinder(h = 20, r = D, center = true);
translate([0,0,24])
rotate([0,0,0])
sphere(r = D+.5, center = true);

hull()
{
translate([0,0,8])
rotate([0,0,0])
cylinder(h = 1, r = D1+2, center = true);
translate([0,0,14])
rotate([0,0,0])
cylinder(h = 1, r = 2, center = true);
}

}

hull()
{
translate([0,0,8])
rotate([0,0,0])
cylinder(h = 1, r = D1, center = true);
translate([0,0,12])
rotate([0,0,0])
cylinder(h = 2, r = 2, center = true);
}
translate([0,0,0])
rotate([0,0,0])
cylinder(h = 15.01, r = D1, center = true);
translate([0,0,16])
rotate([0,0,0])
cylinder(h = 25, r = D-2, center = true);
translate([0,0,31.5])
rotate([0,0,0])
cube([20,20,10],center = true);
}
}
}
}
/*************************************
 
       Soaker hose attachment for
           outside of pipe

      Adjustable for water pipe & 
         soaker hose diameter

       Author: Lee J Brumfield

       This fits outside of a 
           1/2" PVC pipe
       ID is the same as 1/2"
             PVC pipe

 
      Enter the outside diameter of
     your water pipe & inside diameter 
        of your soaker hose here.
     
            Default is 21.6 &
            9mm respectively

*************************************/
module SI() 
{
color ("green")
{
translate([D1*6,0,0])
{

difference()
{
union()
{
translate([0,0,2.5])
rotate([0,0,0])
cylinder(h = 10, r = ID, center = true);
translate([0,0,14])
rotate([0,0,0])
cylinder(h = 20, r = D, center = true);
translate([0,0,24])
rotate([0,0,0])
sphere(r = D+.5, center = true);

hull()
{
translate([0,0,8])
rotate([0,0,0])
cylinder(h = 1, r = ID, center = true);
translate([0,0,14])
rotate([0,0,0])
cylinder(h = 1, r = 2, center = true);
}

}

hull()
{
translate([0,0,8])
rotate([0,0,0])
cylinder(h = 1, r = ID-2, center = true);
translate([0,0,12])
rotate([0,0,0])
cylinder(h = 2, r = 2, center = true);
}
translate([0,0,0])
rotate([0,0,0])
cylinder(h = 15.01, r = ID-2, center = true);
translate([0,0,16])
rotate([0,0,0])
cylinder(h = 25, r = D-2, center = true);
translate([0,0,31.5])
rotate([0,0,0])
cube([20,20,10],center = true);
}
}
}
}
/*************************************
 
       Soaker hose attachment

 Adjustable for water pipe & soaker hose 
           diameter and Tee

       Author: Lee J Brumfield

       This fits inside of a 
          1/2" PVC fitting
       OD is the same as 1/2"
             PVC pipe

 
      Enter the outside diameter of
     your water pipe & inside diameter 
        of your soaker hose here.
     
            Default is 21.6 &
            9mm respectively

*************************************/


module DI() 
{
color ("orange")
{
translate([-D1*6,0,0])
{
difference()
{
union()
{
translate([0,0,0])
rotate([0,0,0])
cylinder(h = 15, r = ID, center = true);
translate([8,0,14])
rotate([0,45,0])
cylinder(h = 20, r = D, center = true);
if (Tee == "yes")
translate([-8,0,14])
rotate([0,315,0])
cylinder(h = 20, r = D, center = true);
translate([15,0,21])
rotate([0,0,0])
sphere(r = D+.5, center = true);
if (Tee == "yes")
translate([-15,0,21])
rotate([0,0,0])
sphere( r = D+.5, center = true);
hull()
{
translate([0,0,8])
rotate([0,0,0])
cylinder(h = 1, r = ID, center = true);
translate([0,0,14])
rotate([0,0,0])
cylinder(h = 1, r = 2, center = true);
}

}

hull()
{
translate([0,0,8])
rotate([0,0,0])
cylinder(h = 1, r = ID-3, center = true);
translate([0,0,12])
rotate([0,0,0])
cylinder(h = 2, r = 2, center = true);
}
translate([0,0,0])
rotate([0,0,0])
cylinder(h = 15.01, r = ID-3, center = true);
translate([10,0,16])
rotate([0,45,0])
cylinder(h = 25, r = D-2, center = true);
if (Tee == "yes")
translate([-10,0,16])
rotate([0,315,0])
cylinder(h = 25, r = D-2, center = true);
if (Tee == "yes")
translate([-20.5,0,26.5])
rotate([0,315,0])
cube([20,20,10],center = true);
translate([20.5,0,26.5])
rotate([0,45,0])
cube([20,20,10],center = true);
}
}
}
}