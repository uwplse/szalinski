//Rod_connector V4 for Rostock / Kossel Printers. 
// (c) g3org

// What type of object should be generated?
generate = "Round"; // [Round,Square]

//mm
Rod_diameter_outside=6; //

//mm 
Jaws_diameter_outside=7; //

// object height mm
height=30; 

// Wall_thickness
Wall_thickness=2;


/* [Hidden] */
$fn=50;

//inputs end

// cylinder object


module cylinder_full(){
	if (Rod_diameter_outside <= Jaws_diameter_outside){
					cylinder(h=height,r=Jaws_diameter_outside/2+Wall_thickness+0.1);
				}
				else{
					cylinder(h=height,r=Jaws_diameter_outside/2+Wall_thickness+0.1);
				}
}

module cylinder_final(){

		difference(){
			cylinder_full();
			inlay();
		}

}








//cube object
module cube_full(){
	difference(){
		linear_extrude(height = height){
			minkowski(){
				if (Rod_diameter_outside <= Jaws_diameter_outside){
				   square(Jaws_diameter_outside+Wall_thickness-2,center=true);
				}
				else{
					square(Rod_diameter_outside+Wall_thickness-2,center=true);
				}
				circle(1);
				}
		}
	}

}
module inlay(){

		translate([0,0,-1]){
				cylinder (h=height/2+2,r=Rod_diameter_outside/2);
				}
		translate([0,0,height/2]){
				cylinder (h=height/2+1,r=Jaws_diameter_outside/2);
		}
}


module cube_Final(){
	difference(){
		cube_full();
		inlay();
	}

}


////////////////////////////////////////////////////////////////////////////////
// Main


if (generate=="Round") {
	cylinder_final();
		
	
}
else if (generate=="Square"){
	cube_Final();
}


