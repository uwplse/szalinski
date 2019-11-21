


rote_diameter = 4;

// Bigest diameter
nut_diameter = 7.9;

// from base of nut
height = 3;

access_cut = 0; // [0:No,1:Yes]


nut_gear();



module nut_gear(){

fi_gwint = rote_diameter;
fi_nakretka = nut_diameter;


// -----------
r_gwint = fi_gwint*0.5;
r_nakretka = fi_nakretka*0.5;

module grip(nr=n){
	rotate([0,0,-22.5+(45*nr)])
	translate([fi_nakretka,0,-0.1])
	cylinder(r=r_nakretka*0.4,h=(fi_nakretka+height),$fn=16);
}



difference() {
	// podstawka
	cylinder(r=r_nakretka*2,h=r_nakretka+height);

	// nakretka
	translate([0,0,r_nakretka*0.5])
	cylinder(r=r_nakretka,h=r_nakretka+height,$fn=6);

	// gwint
	translate([0,0,-0.1])
	cylinder(r=r_gwint,h=fi_nakretka,$fn=32);

	if( access_cut == 1){ // dojscie
		translate([-r_gwint*0.9,0,-0.1])
		cube([fi_gwint*0.9,fi_nakretka*2,fi_nakretka*2]);
	}


	// chwyty
	for( i = [1:8])
		grip(i);


}

}