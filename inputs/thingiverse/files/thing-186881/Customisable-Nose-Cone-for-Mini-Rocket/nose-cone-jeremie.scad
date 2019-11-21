// Model rocket nose cone by Lutz Paelke (lpaelke)
//Customizing AirDuino - MiDuino
// CC BY-NC-SA 3.0
 
//change fill% of print to alter weight

//inside radius of rocket tube in mm (should be >= 7) 
radius_in=9; //[7:10] 
//ouside radius of rocket tube/nose cone(should be > radius_in)
radius_out=10; //[7:15]
//length of nose cone
length=50;	//[30:100]
taper=0.125;

union(){
	difference() {
		cylinder(h=15, r1=radius_in-taper, r2=radius_in,$fn=60); //cylindre du bas
		translate ([-6,-2,0]) cube(size = [12,4,4]); // cube d'ouverture du bas
		translate ([0,2,4]) rotate ([90,0,0]) cylinder(h=4,r=6,$fn=60); //cercle d'ouverture au dessus du cube
	}
	translate([0,2,2]) rotate([90,0,0]) cylinder(h=4,r=2,$fn=60); //cylindre à l'intérieur du cube
	translate ([0,0,15]) scale([1,1,length/radius_out]) difference() {
		sphere(r=radius_out,$fn=60);
		translate ([0,0,-radius_out/2]) cube(size=[2*radius_out,2*radius_out,radius_out],center=true);
	}
}
