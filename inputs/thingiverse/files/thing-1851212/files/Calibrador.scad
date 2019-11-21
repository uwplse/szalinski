//Size of X rule
sizeX=150;

//Size of Y rule
sizeY=150;

//Size of rule marks
markWidth=0.5;

//Milimeters for each mark
markStep=10;

//Laabel on X rule
labelX="X";

//Label on Y rule
labelY="Y";


module rule(lng,name){
	difference(){
		cube([lng,5,5]);
		for(i=[0:markStep:lng]){
			translate([i-(markWidth/2),0,4])
			cube([markWidth,5,2]);
		}
		translate([6,0.5,4])
		linear_extrude(4)
			text(name,size=4);
	}
}

rule(sizeX,labelX);
translate([5,0,0])
rotate([0,0,90])
rule(sizeY,labelY);