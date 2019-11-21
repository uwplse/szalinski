Base = 10;
Base_Height = 1.5;
Curve = 6;
Cone_Height = 12;
Cone_Bottom_Width = 4;
Cone_Top_Width = 1;

$fn = 30;

difference(){
	cube([Base,Base,Base_Height], center=true);
	difference(){
		cylinder(Base_Height+.1,r=Curve*2, center=true);
		cylinder(Base_Height+.1,r=Curve, center=true);
	}
}
cylinder(Cone_Height,Cone_Bottom_Width,Cone_Top_Width);

