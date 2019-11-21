//What is the diameter of the lenses you will be using?
Lens_Diameter=48.5; // [40:60]
//What is your pupillary distance?
Pupil_to_Pupil=70; // [30:90]

//What is the size of your nose bridge?
Nose_Bridge_Length=20; // [10:40]
//What is the width of your head?
Head_Width=151; // [50:200]

/* [Hidden] */
Syringe_Tube_Diameter=4.5;
Stem_Width=5;
Stem_Thickness=3;
Hinge_Pin_Diameter=1.75;
Hinge_Width=6;
Hinge_Length=5;
Hinge_Thickness=5;
Res=50;
Frame_Thickness=5;

//*******************************************************//
//***************        Glasses         ****************//
//*******************************************************//

module Glasses();
{		
		translate([(Pupil_to_Pupil)/-2,0,0])
		Lens_Right();
	
		mirror([1,0,0])
		translate([(Pupil_to_Pupil)/-2,0,0])
		Lens_Right();
		Nose_Piece();
}

//*******************************************************//
//***************       Nose Piece       ****************//
//*******************************************************//
module Nose_Piece(){
difference(){
translate([0,0,Frame_Thickness/2])
			rotate_extrude(convexity = 10, $fn = 50)
				translate([(Nose_Bridge_Length+Frame_Thickness)/2, 0, 0])
					circle(r = Frame_Thickness/2, $fn = 50);
		
		translate([0,Lens_Diameter/2,0])
			cylinder(h = Frame_Thickness, r= ((Pupil_to_Pupil+Nose_Bridge_Length)/2)/1.5);

translate([(Pupil_to_Pupil)/2,0,0])
		cylinder(h = Frame_Thickness, r = (Lens_Diameter/2));

	translate([(Pupil_to_Pupil)/-2,0,0])
		cylinder(h = Frame_Thickness, r = Lens_Diameter/2);

}
}



//*******************************************************//
//***************       Right Lens       ****************//
//*******************************************************//

module Lens_Right()
{
difference()
	{

	union()
		{
		cylinder(h = Frame_Thickness,r = (Lens_Diameter/2)+(Frame_Thickness/2));

		translate([0,0,Frame_Thickness/2])
			rotate_extrude(convexity = 10, $fn = 50)
				translate([(Lens_Diameter+Frame_Thickness)/2, 0, 0])
					circle(r = Frame_Thickness/2, $fn = 50);
		hinge();
		}

	translate([0,0,1])
		cylinder(h = Frame_Thickness,r = Lens_Diameter/2, $fn=100);

	translate([0,0,-1])
		cylinder(h = Frame_Thickness+2,r = (Lens_Diameter/2)-1, $fn=100);

	translate([-Lens_Diameter/2-Frame_Thickness-6,Hinge_Width+1,Frame_Thickness/2])
	rotate([0,90,0]) //Syringe Pump Hole
		cylinder(h = Frame_Thickness+10,r= Syringe_Tube_Diameter/2, $fn=Res);

	}
	styling();
}

module styling()
{
difference()
	{
	translate([-Lens_Diameter/2,0,2.5])
	hull()
		{
		translate([-3, -Lens_Diameter/2,0])
		sphere(r = Frame_Thickness/2, $fn = 50);

		translate([20, -Lens_Diameter/2-2,0])
		sphere(r = Frame_Thickness/2, $fn = 50);

		translate([-2, -Lens_Diameter/2+20,0])
		sphere(r = Frame_Thickness/2, $fn = 50);

		translate([-8, -Lens_Diameter/3,0])
		sphere(r = Frame_Thickness/2, $fn = 50);

		translate([-2, Lens_Diameter/3+4,0])
		sphere(r = Frame_Thickness/2, $fn = 50);

		translate([20, Lens_Diameter/3+10,0])
		sphere(r = Frame_Thickness/2, $fn = 50);
		}
	translate([0,0,-.5])
	cylinder(h = Frame_Thickness+2,r = (Lens_Diameter/2)+(Frame_Thickness/2));
	
translate([-Lens_Diameter/2-Frame_Thickness-6,Hinge_Width+1,Frame_Thickness/2])
	rotate([0,90,0]) //Syringe Pump Hole
		cylinder(h = Frame_Thickness+10,r= Syringe_Tube_Diameter/2, $fn=Res);
}}

module hinge()
{
translate([(Lens_Diameter+Frame_Thickness+1)/-2,
			(-Lens_Diameter/2+Frame_Thickness*2)+Hinge_Width/3-.5,
			Frame_Thickness/2])
union(){
intersection()
{
	
		
			cube([(Head_Width-(Pupil_to_Pupil+Lens_Diameter)-Frame_Thickness*2),
				Stem_Width+6,
				Frame_Thickness], center = true);

	translate([-4.15,0,5])
			rotate([90,0,0])
			cylinder(r=8, h=Stem_Width+6, center=true, $fn=100);
}
	
	
	translate([-10.75,.5,Frame_Thickness/2])
		
	difference()
		{
		translate([-1,-6,0])
			cube([10,Stem_Width+6,6]);

		translate([1,-3.5,0])
			cube([12,Hinge_Width,6.1]);
	
		translate([-Hinge_Thickness/2+6.2,Hinge_Width+5,Hinge_Thickness/2+0.5])	
		rotate([90,0,0])
			cylinder(h = Hinge_Width*4, r = Hinge_Pin_Diameter/2, $fn=50);
		}
}	
	
}