

//Font is "Harlow Solid Italic"! Update your Font database, if it doesn't show correctly!

hole_diameter = 10; //size of hole in mm

$fn = 100;
r = 85;

elemente = ["H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne", "Na", "Mg"];

difference() {
    union(){
		disc();
		translate([0,0,0.01]){
			//zeiger();
			element();
			atom();
		}
    }
	loch();
}

//zeiger();
module loch() linear_extrude(height = 12, center = true) circle(d=hole_diameter);


module atom(){
    color("black")
		linear_extrude(4)
			translate([0,0,2])
				union() {
					orbit();
					rotate(120) orbit();
					rotate(240) orbit();
					difference(){
						circle(r/5);
						circle(d = 20);
					}
				}

}
module orbit() {
    //linear_extrude(4)
scale([2,1,1]) difference() {
    circle(r/3); 
    circle(r/3.5);
    }
}


module disc() {
    color("grey") linear_extrude(2) {circle(r, $fn=50);
    for(i=[0:11]){
    
        rotate(360/12*(i))
            translate([0.8*r,0,0])
                circle(r/3);
    }
}
    
}
    
module zeiger() color("red") translate([6,0,3]) cube([1.5*r,5,5], center = true);

module element(){
    color("black")
    
    for(i=[0:11]){
    linear_extrude(5)
        rotate(360/12*(i))
            translate([0.9*r,0,0])
                rotate(-360/12*i-90)
                    //rotate(-90)
                    text(str(elemente[11-i]), font = "Harlow Solid Italic", valign = "center", halign = "center", size = 18);
        
}
}

