tiecount=8; // [1:50]
ringdiameter=30; // [20:80]
thickness=5; // [2, 3, 4, 5]

$fn=32;
union(){
    union() {
		//HOOK
        difference() {
            union() {
                cylinder(d=ringdiameter+10,h=thickness, center=true);
                translate([0,0,-thickness/2]) cube([ringdiameter+3.5,ringdiameter/2+5,thickness]);
            }
            union() {
                hull() {
                 cylinder(d=ringdiameter,h=thickness+2, center=true);
                 translate([ringdiameter/2,0,0]) cylinder(d=ringdiameter,h=thickness+2, center=true);   
                }
                translate([ringdiameter/2,-ringdiameter/2,0]) cube([ringdiameter,ringdiameter,thickness+2], center=true);
            }
        }
        
		//HOOK_END_ROUND
        translate([0,-ringdiameter/2-2.5,0]) cylinder(d=5,h=thickness, center=true);
        
		//SHOULDER
        translate([ringdiameter+3.5,0,0]) 
		if(ringdiameter>45){
			hull(){
				translate([0,-max(45,ringdiameter+3)/2,0]) cylinder(d=7,h=thickness,center=true);
				translate([0,max(45,ringdiameter+3)/2,0]) cylinder(d=7,h=thickness,center=true);
			}
		}
		else{
			hull(){
				translate([0,-max(45,ringdiameter+3)/2+1,0]) cylinder(d=7,h=thickness,center=true);
				translate([0,max(45,ringdiameter+3)/2-1,0]) cylinder(d=7,h=thickness,center=true);
			}	
		}
    }
	//TIE_SLOTS
    for(i = [1:tiecount]) {
		translate([i*12+ringdiameter+4.5,0,0]) union() {
			cube([5,max(45,ringdiameter+5),thickness], center=true);
			hull(){
				translate([0,max(45,ringdiameter+5)/2,0]) cylinder(d=5,h=thickness,center=true);
				translate([-5,max(45,ringdiameter+5)/2,0]) cylinder(d=5,h=thickness,center=true);
			}
			hull(){
				translate([0,-max(45,ringdiameter+5)/2,0]) cylinder(d=5,h=thickness,center=true);
				translate([-13,-max(45,ringdiameter+5)/2,0]) cylinder(d=5,h=thickness,center=true);
			}
		}
	}
}