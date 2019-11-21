//Upright or Sideways (whichever you feel works best with your support needs/capabilities)
Orientation="Sideways";//[Upright,Sideways]

//Clamp (Requires support)
Clamp="True";//[True,False]

//Units
Units=1;//[1:mm,25.4:inches]

//Diameter of the stem where inserted into the holder
Stem_Diameter=8;

//Diameter of the dial bezel
Bezel_Diameter=56;

Stem_Radius = Stem_Diameter * Units * 0.5;
Bezel_Radius = Bezel_Diameter * Units * 0.5;

module block(){
	union(){
		translate([-12,0,0])
		cube([30,15,15]);

		translate([-12,-17,0])
		cube([22,18,15]);

		rotate(30,[1,0,0])
		translate([-12,-20,0])
		cube([22,20,15]);

		translate([-12,-42,-17])
		cube([22,25,17]);
	}
}

module mill(){
	translate([7.5,5,-2])
	cylinder(r=1.5,h=25,$fn=20);
	translate([-7.5,5,-2])
	cylinder(r=1.5,h=25,$fn=20);

	translate([-1,-30,-20])
	cylinder(r=Stem_Radius,h=40,$fn=20);

	rotate(90,[0,1,0])
	translate([30-(2*Bezel_Radius),-30,0])
	cylinder(r=Bezel_Radius,h=25, center=true,$fn=30);

	if(Clamp=="True"){
		translate([-2,-54,-20])
		cube([2,25,25]);
		rotate(90,[0,1,0])
		translate([10,-38,-20])
		cylinder(r=1.5,h=40,$fn=20);
	}else{
		rotate(90,[0,1,0])
		translate([10,-30,-20])
		cylinder(r=1.5,h=40,$fn=20);
	}	
}

module dialholder(){
	difference(){
		block();
		mill();
	}
}

if(Orientation=="Sideways"){
	rotate(-90,[0,1,0])
	translate([12,0,0])
	dialholder();
}else{
	translate([0,0,17])
	dialholder();
}






