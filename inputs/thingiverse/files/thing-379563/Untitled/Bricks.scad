// Brick Creator
// by Javier Villarroel June 2014

//

// preview[view:north west, tilt:top]

/* [Creator] */

Style = "LEGO"; //[LEGO, Solid Brick, Honeycomb, Cored Brick A, Cored Brick B]

Lenght = 3; // [1:10]
Width  = 2; // [1:10]

height = 9.6; // [9.6:Normal, 3.2:Flat, 1.7:Total Flat, 19.2:Double]

/* [Extras] */

Connector = "Circle"; // [Circle, Circle with Hole, Triangle, Square, Pentagon, Hexagon] 

Angle = 0; // [0:180]

Internal_Structure = "Cylinders"; //[None, Grid, Cylinders]

Accesories = "None"; //[None, Ring, Holes]
Direction = 0; //[0:Horizontal, 1:Vertical]

/* [Hidden] */

P = 8; 
conectorR = 2.5;
conectorH = 2.8;
tolerance = 0.2;
wall = 1.2;

module conector(){
	if(Connector=="Circle"){
		cylinder(r=conectorR, h=conectorH , $fn=100);
	} else if(Connector=="Circle with Hole"){
		difference(){
			cylinder(r=conectorR, h=conectorH , $fn=50);
			translate([0,0,0.1])
			cylinder(r=conectorR-0.6, h=conectorH+0.1 , $fn=50);
		}
	} else if(Connector=="Triangle"){
		rotate([0,0,Angle]) cylinder(r=conectorR, h=conectorH , $fn=3);
	} else if(Connector=="Square"){
		rotate([0,0,Angle]) cylinder(r=conectorR, h=conectorH , $fn=4);
	} else if(Connector=="Pentagon"){
		rotate([0,0,Angle]) cylinder(r=conectorR, h=conectorH , $fn=5);
	} else if(Connector=="Hexagon"){
		rotate([0,0,Angle]) cylinder(r=conectorR, h=conectorH , $fn=6);
	}

}



module internalStructure(){
	if (Internal_Structure == "Grid"){
		if(Lenght > 1){
		for (i = [0 : Lenght-2]){
			translate([(wall+conectorR*2+0.6)+P*i,0,0])
			cube([wall*2,Width*P-tolerance,height]);
		}}
		if(Width > 1){
		for (j = [0 : Width-2]){
			translate([0,(wall+conectorR*2+0.6)+P*j,0])
			cube([P*Lenght-tolerance,wall*2,height]);
		}}

	} else if (Internal_Structure == "Cylinders"){
		if(Lenght > 1 && Width > 1){
			difference(){
				union(){
					for (i = [0 : Lenght-2]){
						translate([(wall*1.75+conectorR*2+0.6)+P*i,0,0])
						cube([wall/2,Width*P-tolerance,height]);
					}
					for (j = [0 : Width-2]){
						translate([0,(1.75*wall+conectorR*2+0.6)+P*j,0])
						cube([P*Lenght-tolerance,wall/2,height]);
					}
					for (i = [1 : Lenght-1]){
						for (j = [1 : Width-1]){
							translate([P*i,P*j,0])
							cylinder(r=conectorR+0.8, h=height-0.9 , $fn=40);							
						}
					}
				}
				for (i = [1 : Lenght-1]){
					for (j = [1 : Width-1]){
						translate([P*i,P*j,-0.1])
						cylinder(r=conectorR, h=height-0.9 , $fn=40);
					}
				}


			}		
		}
	}

}


module legoBrick(){
	union(){
		difference() {
			union() {
			cube([P*Lenght-tolerance,Width*P-tolerance,height]);
				{
					for (i = [0 : Lenght-1]){
						for (j = [0 : Width-1]){
							translate([3.9+i*P,3.9+j*P,height])
							conector();
						}
					}
	
				}
			}
			if(height > 1.7){
			translate([wall-0.1,wall-0.1,-0.1]) 
			cube([P*Lenght-tolerance-2*wall,Width*P-tolerance-2*wall,height-0.9]);}
		}
		internalStructure();
	}
}

module Ring(){
	translate([0,Width/2*P,height/2])
	if(Direction == 1){
		difference(){
	
			rotate([90,0,0])
			rotate_extrude(convexity = 10, $fn=100)
			translate([2.8, 0, 0])
			circle(r = 0.8, $fn = 100);
			
			translate([1,-4.5,-2])
			cube([4,9,4]);
		}
	} else {
		difference(){	
			//rotate([90,0,0])
			rotate_extrude(convexity = 10, $fn=100)
			translate([2.8, 0, 0])
			circle(r = 0.8, $fn = 100);
			
			translate([1,-4.5,-2])
			cube([4,9,4]);
		}
	} 
	
}


module Hole(){
	translate([0,Width/2*P,height/2])
	if(Direction == 1){
		rotate([90,0,0])
		rotate_extrude(convexity = 10, $fn=100)
		translate([2, 0, 0])
		circle(r = 0.8, $fn = 100);
	} else {
		rotate_extrude(convexity = 10, $fn=100)
		translate([2, 0, 0])
		circle(r = 0.6, $fn = 100);
	}	
}


module solidBrick(){
	difference(){
		cube([Lenght*P, Width*P, height]);	
		union(){
			translate([wall,wall,-0.1])	
			cube([Lenght*P-wall*2, Width*P-wall*2, 0.6]);
			translate([wall,wall,height-0.5])
			cube([Lenght*P-wall*2, Width*P-wall*2, 0.6]);
		}
	}
}


module coredBrickA(){
	difference(){
		cube([Lenght*P, Width*P, height]);
		union(){
			for(i = [0 : Lenght-1]){
				for(j = [0 : Width-1]){
					translate([P*i+P/2,P*j+P/2,-0.1])
					cylinder(r=2.7, h=height + 0.2 , $fn=40);
				}
			}
		}
	}

}


module coredBrickB(){
	difference(){
		cube([Lenght*P, Width*P, height]);
		union(){
			for(i = [0 : Lenght-1]){
				translate([P*i+3*wall/2,3*wall/2,-0.1])
				cube([P-wall*3,Width*P-wall*3,height+0.2]);			
			}
		}
	}
}


module honeycomb(){
	union(){
		difference(){
			cube([Lenght*P, Width*P, height]);
			union(){
				for(i = [0 : Lenght]){
					for(j = [0 : Width + 1]){
						translate([3*P/2*i,P/2*1.7*j,-0.1])
						cylinder(r=3.5, h=height + 0.2 , $fn=6);
						translate([3*P/2*i+P/2*1.5,P/2*1.7*j+P/2*0.8,-0.1])
						cylinder(r=3.5, h=height + 0.2 , $fn=6);
					}
				}
			}
		}
		difference(){	
			cube([Lenght*P, Width*P, height]);
			translate([1,1,-0.2])
			cube([Lenght*P-2, Width*P-2, height+0.4]);
		}
	}
}


module brick(){
	if(Style == "LEGO"){
		legoBrick();
	} else if(Style == "Solid Brick"){
		solidBrick();
	} else if(Style == "Cored Brick A"){
		coredBrickA();
	} else if(Style == "Cored Brick B"){
		coredBrickB();
	} else if(Style == "Honeycomb"){
		honeycomb();
	} else {
	
	}
	
}

//legoBrick();


if(Accesories == "None"){
	brick();
} else if(Accesories == "Ring") {
	union(){
		brick();
		Ring();
	}
} else if(Accesories == "Holes") {
	difference(){
		brick();
		Hole();
	}
}

