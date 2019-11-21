Stem_Length=100;
Stem_Width=5;
Stem_Thickness=3;
Stem_Curve_Length=30;
Hinge_Pin_Diameter=1.75;
Hinge_Width=6;
Hinge_Length=5;
Hinge_Thickness=5;
Slider_Thickness=4;
Tube_Diameter=11;
Tube_Inner_Diameter=8;
Tube_Compressed_Thickness=1.2;
Tube_Compressed_Width=18;
Tube_Holder_Wall_Thickness=3;
Outlet_Tube_Inner_Diameter=3;
$fn=50;


//Plug();

//End_Cap();

//Slider();

Stem();

//Tube_Holder();

module Complete_Syringe(){
translate([30,(Tube_Diameter/3+Tube_Holder_Wall_Thickness),(Tube_Diameter/3+Tube_Holder_Wall_Thickness)])
rotate([90,0,90])
Slider();

translate([0,(Tube_Diameter/3+Tube_Holder_Wall_Thickness),(Tube_Diameter/3+Tube_Holder_Wall_Thickness)])
rotate([90,0,90])
End_Thing();

translate([0,Tube_Diameter/2+Tube_Holder_Wall_Thickness-2,Tube_Diameter/2+Tube_Holder_Wall_Thickness-2])rotate([0,0,90])Tube_Holder();

}


module End_Stop_Plug(){

difference(){

	union(){

		cylinder(2.5, Tube_Inner_Diameter/2+.5, Tube_Inner_Diameter/2+1);

		translate([0,0,2.5])
			cylinder(2.5, Tube_Inner_Diameter/2+.5, Tube_Inner_Diameter/2+1);
	}

	translate([Tube_Inner_Diameter/2+1,0,-1])
		cylinder(7, 1.5, 1.5);

	translate([Tube_Inner_Diameter/-2-1,0,-1])
		cylinder(7, 1.5, 1.5);

}

}
module End_Cap(){

difference(){

	cylinder(5, Tube_Diameter/2+Tube_Holder_Wall_Thickness*2, Tube_Diameter/2+Tube_Holder_Wall_Thickness*2);

	difference(){	
	
		translate([0,0,-1])		
			cylinder(7, Tube_Diameter/2+Tube_Holder_Wall_Thickness, Tube_Diameter/2+Tube_Holder_Wall_Thickness);

		hull(){
		
			translate([0,(Tube_Compressed_Thickness/-2+-Slider_Thickness)+Tube_Diameter,(Tube_Diameter+Tube_Holder_Wall_Thickness*2+2)/-2])
				cylinder(Tube_Diameter+Tube_Holder_Wall_Thickness*2+2, Tube_Compressed_Thickness/2+Slider_Thickness-.5, Tube_Compressed_Thickness/2+Slider_Thickness-.5);

			translate([0,(Tube_Compressed_Thickness/2+Slider_Thickness)-Tube_Diameter,(Tube_Diameter+Tube_Holder_Wall_Thickness*2+2)/-2])


				cylinder(Tube_Diameter+Tube_Holder_Wall_Thickness*2+2-.5, Tube_Compressed_Thickness/2+Slider_Thickness, Tube_Compressed_Thickness/2+Slider_Thickness-.5);

		} 

	}

	translate([0,0,-1])
		cylinder(7,Tube_Diameter/2+1, Tube_Diameter/2+1);
		
}

	translate([0,0,3])
		rotate([0,0,0])
			rotate_extrude(convexity = 10)
				translate([Tube_Diameter/2+Tube_Holder_Wall_Thickness, 0, 0])
					circle(r = .5, $fn = 100);

}

module Plug(){

difference(){

	union(){

		cylinder(2.5, Tube_Inner_Diameter/2+.5, Tube_Inner_Diameter/2+1.25);

		translate([0,0,2.5])
			cylinder(2.5, Tube_Inner_Diameter/2+.5, Tube_Inner_Diameter/2+1.25);

		translate([0,0,5])
			cylinder(2.5, Outlet_Tube_Inner_Diameter/2+1, Outlet_Tube_Inner_Diameter/2+.5);

		translate([0,0,7.5])
			cylinder(2.5, Outlet_Tube_Inner_Diameter/2+1, Outlet_Tube_Inner_Diameter/2+.5);

}

	translate([0,0,-1])
		cylinder(12,Outlet_Tube_Inner_Diameter/2-.5,Outlet_Tube_Inner_Diameter/2-.5);

	translate([0,0,-1])
		cylinder(6, Tube_Inner_Diameter/2-.5, Outlet_Tube_Inner_Diameter/2-.5);

}
}

module Slider()
{
scale([1.05,1.05,1])
difference()
	{

	cylinder(h = Slider_Thickness, r = Tube_Diameter/2+Tube_Holder_Wall_Thickness+Slider_Thickness);

	translate([0,0,-1])
		cylinder(h = Slider_Thickness+2, r = Tube_Diameter/2+Tube_Holder_Wall_Thickness);
	}

hull()
	{

	translate([Tube_Compressed_Thickness+Slider_Thickness/4,
				 Tube_Diameter/2+Tube_Holder_Wall_Thickness+1, 
				 Slider_Thickness/4])
		rotate([90,0,0])
			cylinder(h = Tube_Diameter+Tube_Holder_Wall_Thickness*2+2, r = Slider_Thickness/4); 

	translate([Tube_Compressed_Thickness+Slider_Thickness/4,
				 Tube_Diameter/2+Tube_Holder_Wall_Thickness+1, 
				 Slider_Thickness-(Slider_Thickness/4)])
		rotate([90,0,0])
			cylinder(h = Tube_Diameter+Tube_Holder_Wall_Thickness*2+2, r = Slider_Thickness/4); 
	}

hull()
	{
	translate([-Tube_Compressed_Thickness+Slider_Thickness/-4,
				 Tube_Diameter/2+Tube_Holder_Wall_Thickness+1, 
				 Slider_Thickness/4])
		rotate([90,0,0])
			cylinder(h = Tube_Diameter+Tube_Holder_Wall_Thickness*2+2, r = Slider_Thickness/4); 

	translate([-Tube_Compressed_Thickness+Slider_Thickness/-4,
				 Tube_Diameter/2+Tube_Holder_Wall_Thickness+1, 
				 Slider_Thickness-(Slider_Thickness/4)])
		rotate([90,0,0])
			cylinder(h = Tube_Diameter+Tube_Holder_Wall_Thickness*2+2, r = Slider_Thickness/4); 
	}

}

module Tube_Holder(){

difference(){

	rotate([90,0,0])
		cylinder(Stem_Length, Tube_Diameter/2+Tube_Holder_Wall_Thickness, Tube_Diameter/2+Tube_Holder_Wall_Thickness);

	translate([0,1,0])
		rotate([90,0,0])
			cylinder(Stem_Length+2, Tube_Diameter/2, Tube_Diameter/2);

	translate([0,1,0])
		rotate([90,0,0])
			cylinder(h = 6, r = Tube_Diameter/2+.5);


	translate([0, Stem_Length/-2,(Tube_Diameter+Tube_Holder_Wall_Thickness*2)/-1+2])
		cube([ Tube_Diameter+Tube_Holder_Wall_Thickness*2+2,
				Stem_Length+2,
				Tube_Diameter+Tube_Holder_Wall_Thickness*2], 
				center = true);

	hull(){
		
		translate([0,0,(Tube_Diameter+Tube_Holder_Wall_Thickness*2+2)/-2])
			cylinder( h = Tube_Diameter+Tube_Holder_Wall_Thickness*2+2, 
						r = Tube_Compressed_Thickness/2+Slider_Thickness);

		translate([0,
					(Tube_Compressed_Thickness/2+Slider_Thickness)-Stem_Length+Tube_Holder_Wall_Thickness,						(Tube_Diameter+Tube_Holder_Wall_Thickness*2+2)/-2])
			cylinder( h = Tube_Diameter+Tube_Holder_Wall_Thickness*2+2, 
						r = Tube_Compressed_Thickness/2+Slider_Thickness);
			} 

	translate([0,-3,0])
		rotate([90,0,0])
			rotate_extrude(convexity = 10)
				translate([Tube_Diameter/2+Tube_Holder_Wall_Thickness, 0, 0])
					circle(r = 1, $fn = 100);


}

}


module Stem()
{
hull()
{
translate([0,3,2.5])
rotate([0,90,0])
cylinder(h = Stem_Width, r = Hinge_Thickness/2);
translate([Stem_Length,2.2,1.5])
rotate([0,90,0])
cylinder(h = Stem_Thickness, r = (Stem_Thickness)/2);
}
difference()
	{
hull()
		{

	translate([0,0,Hinge_Thickness/2])
		cube([Stem_Width, Hinge_Width, Hinge_Thickness], center = true);

	translate([Stem_Length,Stem_Width*2.5,0])
		cylinder(h = Stem_Thickness, r = Stem_Width*3);

	translate([Stem_Length+Stem_Curve_Length,Stem_Width*2.5+Stem_Curve_Length,0])
		cylinder(h = Stem_Thickness, r = Stem_Width);
		}


translate([0,Stem_Width,0])
hull()
		{
	translate([0,Hinge_Width/2-Stem_Width/2,(Hinge_Thickness+1)/2])
		cube([Stem_Width, Stem_Width, Hinge_Thickness+2], center = true);

	translate([Stem_Length-Stem_Width,Stem_Width*2.5,-1])
		cylinder(Stem_Thickness+2, Stem_Width*3, Stem_Width*3);

	translate([Stem_Length+Stem_Curve_Length-Stem_Width*2,Stem_Width*2.5+Stem_Curve_Length,-1])
		cylinder(Stem_Thickness+2, Stem_Width, Stem_Width);
		}
	}

difference()
	{
	union()
		{
		translate([-Hinge_Length,0,Hinge_Thickness/2])
			cube([Hinge_Length, Hinge_Width, Hinge_Thickness], center = true);

		translate([-Hinge_Length-Hinge_Thickness/2,(Hinge_Width)/2,Hinge_Thickness/2])	
rotate([90,0,0])
			#cylinder(h = Hinge_Width, r = Hinge_Thickness/2);
		}
		

	translate([-Hinge_Length-Hinge_Thickness/2,(Hinge_Width+2)/2,Hinge_Thickness/2])	
		rotate([90,0,0])
			cylinder(h = Hinge_Width+2, r = Hinge_Pin_Diameter/2);
	}	

}

