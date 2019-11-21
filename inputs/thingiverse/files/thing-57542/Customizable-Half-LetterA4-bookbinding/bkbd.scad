//Customizable Half Letter/A4 bookbinding
//by avalonn

// include write.scad by HarlanDMii 
use<Write.scad>
include <write/Write.scad>


//	Paper size
// half letter=140 x 216 mm, A5=148 x 210 mm
a4m = 32.02;	// [32.02:A5,30:Half Letter]	

//	sheets thickness (15 is about 100 sheets)
x_m = 15;	//	[15:45]

xsu=x_m-1.6;
lt=x_m-9.6;
lta=lt/2;

// text on the binding back - Max : 27 letters
message = "Volume I";


// first part : key, to lock the bookbinding
rotate([0,0,90])translate([-50,-50,0])
{
	difference()
	{
		cube([24,2*a4m+83.95,3]);
		// 1st hole
		translate([11.13,a4m,-1])cube([1.74,4.9,5]);
		translate([10.03,a4m,1.5])cube([3.94,3.85,2]);
		translate([10.03,a4m+4.85,-1])cube([3.94,3.75,5]);
		translate([10.03,a4m+4.85,1.5]) rotate([79,0,0]) cube([3.94,3.75,4]);	
		// 2d hole
		translate([11.13,a4m+80.11,-1])cube([1.74,4.9,5]);
		translate([10.03,a4m+80.11,1.5])cube([3.94,3.85,2]);
		translate([10.03,a4m+4.85+80.11,-1])cube([3.94,3.75,5]);
		translate([10.03,a4m+4.85+80.11,1.5]) rotate([79,0,0]) cube([3.94,3.75,4]);
	}



// 2d part : flexible back
	translate([30,0,0])
	{

		difference()
		{
		cube([24,2*a4m+83.95,3]);
		translate([7.9,a4m,1.5])cube([8.2,3.85,2]);
		translate([10.03,a4m,-1])cube([3.95,3.85,5]);
		translate([7.9,a4m+80.11,1.5])cube([8.2,3.85,2]);
		translate([10.03,a4m+80.11,-1])cube([3.95,3.85,5]);
		}

		// curve part
		difference()
		{
		translate([24,0,0])cube([lt+6,2*a4m+83.95,1]);
		translate([24,-1,0.6]) rotate([0,-8,0]) cube([4,2*a4m+85.95,4]);
		translate([24+lt+6,-1,0.6]) rotate([0,-82,0]) cube([4,2*a4m+85.95,4]);
		translate([27,3,0.6]) cube([lt,2*a4m+77.95,4]);
		}

		difference()
		{
		translate([30+lt,0,0]) cube([24,2*a4m+83.95,0.6]);
		translate([40.03+lt,a4m,-1]) cube([3.85,3.95,2]);
		translate([40.03+lt,a4m+80.11,-1]) cube([3.85,3.95,2]);
		}
		// text on the binding back
		union() {
		translate([29.5+lta,4.5,.5]) rotate([0,0,90]) write(message,h=5,t=.6,space=1.5);
		}
	}
}
// axes
rotate([0,0,90])translate([-50,-100,0])
{
		difference()
		{
		cube([x_m,8,3.74]);
		translate([-.01,-.01,-.01])cube([xsu,2.14,4]);
		translate([-.01,5.87,-.01])cube([xsu,2.14,4]);
		translate([1.5,2.09,-.01])cube([1.73,1.1,4]);
		translate([1.5,4.87,-.01])cube([1.73,1.01,4]);
		}


		translate([0,20,0])difference()
		{
		cube([x_m,8,3.74]);
		translate([-.01,-.01,-.01])cube([xsu,2.14,4]);
		translate([-.01,5.87,-.01])cube([xsu,2.14,4]);
		translate([1.5,2.09,-.01])cube([1.73,1.1,4]);
		translate([1.5,4.87,-.01])cube([1.73,1.01,4]);
		}
}
