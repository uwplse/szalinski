//external diameter
diameter=75;
height=85;
//N of polygon sides
faces=6;
//vertical subdivisions
segments=5;
//walls and base thickness
wall=3;
hollow=true; // [true,false]

module twisted_vase(diameter,height,faces,segments,wall,hollow) {
	
	e=.01;
	
	difference() {
		for(i=[0:segments-1]) 
			hull() {
				translate([0,0,height/segments*i])
					rotate([0,0,180/faces*(i%2)])
						cylinder(d=diameter, h=e, $fn=faces);
				translate([0,0,height/segments*(i+1)])
					rotate([0,0,180/faces*((i+1)%2)])
						cylinder(d=diameter, h=e, $fn=faces);
		}
		if(hollow)
			for(i=[0:segments-1]) 
				hull() {
					translate([0,0,height/segments*i])
						rotate([0,0,180/faces*(i%2)])
							cylinder(d=diameter-wall*2, h=e*2, $fn=faces);
					translate([0,0,height/segments*(i+1)])
						rotate([0,0,180/faces*((i+1)%2)])
							cylinder(d=diameter-wall*2, h=e*2, $fn=faces);
			}	
	}
	if(hollow) cylinder(d=diameter-wall*2+e, h=wall, $fn=faces);

}

twisted_vase(diameter,height,faces,segments,wall,hollow);