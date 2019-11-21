numFaces=18;
pencilDiameter=3;

module aPencil(height,radius) {
	translate([0,0,-3]) union() {
        cylinder(height,radius,radius,$fn=numFaces);
        translate([-pencilDiameter/3/2,-pencilDiameter,0]) cube([pencilDiameter/3,pencilDiameter*2,height],false);
        }
}

module drawPencils3(radius,rodRadius,numbRods,height) {
	for (i=[0:numbRods-1]) color([i/numbRods,1,i/numbRods,1]){
        
        rotate([0,0,i*(360/numbRods)])translate([radius,0,0])rotate([-16,-16,0])aPencil(height,rodRadius);
		//rotate([-16,-17,i*(360/numbRods)])translate([radius*1.06,0,0])aPencil(height,rodRadius);
	}
}

module drawPencils3b(radius,rodRadius,numbRods,height) {
	for (i=[0:numbRods-1]) color([i/numbRods,1,i/numbRods,1]){
        
        rotate([0,0,i*(360/numbRods)])translate([radius,0,0])rotate([14.9,-16,0])aPencil(height,rodRadius);
        
		//rotate([16,-17,i*(360/numbRods)])translate([radius*1.06,0,0])aPencil(height,rodRadius);
	}
}

module pencils(elevate) {
	 union() {
		drawPencils3(44,pencilDiameter/2,16,180);
        rotate([0,0,3*(360/64)]) drawPencils3b(41,pencilDiameter/2,16,180);
	}
}

module pencilMid(quart) {
	difference() {
		union() {
			intersection() {
				translate([0,0,0]) difference() {
					cylinder(6,48,46);
					translate([0,0,-1])cylinder(8,36,34);
                    }
				}

		}
		pencils(true);

	}
}

//translate([0,0,-140]) 
pencilMid(false);