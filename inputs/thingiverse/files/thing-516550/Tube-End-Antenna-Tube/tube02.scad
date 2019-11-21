// Antenna tube End
// (c) g3org

//antenna tube 
tube_outer=48.5;

//wall
tube_wall=4.1;

//material between sectors
material_wall=2;

//object height
height=10;

//frint hole
hole=20;


$fn=40*1;




//Aussenkontur
module aussenkontur(){
	hull(){
		cylinder(r=tube_outer/2+material_wall,h=1);
		translate([tube_outer/2,0,0]) cylinder(r=hole/2,h=1);
		translate([0,0,height+1]) cylinder(r=tube_outer/2+material_wall,h=1);
	}

}

module innenkontur(){
	hull(){
		cylinder(r=tube_outer/2,h=1);
		translate([tube_outer/2-material_wall,0,0]) cylinder(r=hole/2,h=1);
		translate([0,0,height]) cylinder(r=tube_outer/2,h=1);
	}

}


module inlay(){
difference(){
		cylinder(r=tube_outer/2-tube_wall,h=height+1);	
		cylinder(r=tube_outer/2-tube_wall-material_wall,h=height+1);
		}
}

module topside(){
		translate([0,0,height-material_wall]){
			cylinder(r=tube_outer/2,h=material_wall);	
		}

}
module durchbruch(){
	translate([material_wall,0,+height/2]){
		cube ([tube_outer-2*tube_wall-2*material_wall,4*tube_wall,height],center=true);
	}

}



difference(){
	aussenkontur();
	innenkontur();
}

difference(){
	inlay();
	durchbruch();
}
//topside();
//durchbruch();

//testtube();



module testtube(){
	difference(){
		cylinder(r=tube_outer/2,h=2*height);	
		cylinder(r=tube_outer/2-tube_wall,h=2*height);	
	}
}





