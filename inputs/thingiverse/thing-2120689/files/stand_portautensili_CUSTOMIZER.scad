hole_dimension = 4; // [2:0.1:4.5]
step = 9+1;
grid_depth = 40; //[20:10:100]
grid_width = 100;// [20:10:200]

//step_totaliy = 35;
//step_totalix = 115;
step_totaliy = grid_depth-5;
step_totalix = grid_width-5;
height_stand = 60;  //[20:10:100]
dimensione_parete = 3+0;
height_supporti=height_stand/3;
$fn=100+0; //risoluzione cilindro
shows_support = "yes"; // [yes,no]
x=1+0;
difference(){
cube([grid_width,grid_depth,height_stand]);
for ( i = [step : step : step_totalix]){
for ( z = [step : step : step_totaliy]){
translate([i,z,dimensione_parete-2]){
cylinder(height_stand,hole_dimension,hole_dimension,center=false);
//cylinder(hole_dimension,2,2);
}
}
}
//caso 1



//caso2

translate([0,0,dimensione_parete]){

cube([grid_width,grid_depth-dimensione_parete,height_stand-dimensione_parete-dimensione_parete]);
}
translate([10,grid_depth-10,height_stand-25]){//foro per appendere sinistro
cube([5,15,15]);}
translate([grid_width-15,grid_depth-10,height_stand-25]){//foro per appendere destro
cube([5,15,15]);}

}



//inizio sostegni
	module sostegno(){
hole_dimension_sostegno = grid_depth;
if (shows_support == "yes") {
		difference(){	
			translate([0,0,height_stand-dimensione_parete-height_supporti]){
			cube([dimensione_parete,grid_depth,height_supporti]);
			}
		/*
		translate([grid_width-dimensione_parete,0,height_stand-dimensione_parete-height_supporti]){
		cube([dimensione_parete,grid_depth,height_supporti]);}
		*/
		translate([0,dimensione_parete,(height_stand/3)-dimensione_parete]){	
			rotate([0,90,0]) {
			cylinder(dimensione_parete+1,hole_dimension_sostegno,hole_dimension_sostegno,center=false);
			}
		}
		}
}
	}
sostegno();
translate([grid_width-dimensione_parete,0,0]){
sostegno();
}

//fine sostegni
