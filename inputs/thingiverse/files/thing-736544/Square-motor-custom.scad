
//Height support
Height_support=40;

//thickness;
Thickness = 2.5;//[1:10]

//Diameter of the center hole motor
Motor_center_hole_diameter=10;

//Diameter of the motor mount holes
Motor_mount_hole_diameter=2;

//Diameter of the holes for fixing the equerre
Motor_mount_hole_spacing=15;

//use renforcement
Renforcement = "yes"; // [yes,no]

//Diameter of the slot holes for fixing the equerre
Base_slot=4;


//ignore variable values
H=Height_support / 1;
E=Thickness / 1; 
D=Motor_center_hole_diameter/1;
d=Motor_mount_hole_diameter/1;
T=Base_slot/1; 
M=Motor_mount_hole_spacing/1; 

module equerre(){
		union(){
			//base
			difference(){
				cube([H/2,H,E]);
				union(){
					//Oblon
			      hull(){ 
			        translate([H/2-(E+T/2),E+T+H/10,-E]) cylinder(r=T/2, h=3*E);
			        translate([H/2-(E+T/2),H-E-T-H/10,-E])cylinder(r=T/2, h=3*E);
					}
				}

			}
if(Renforcement == "yes"){
		translate([H/2-E,E,E]) polyhedron(
			points=[[0,0,0],[E,0,0],[E,0,E],[0,0,E],[0,E,0],[E,E,0]],
			faces=[[0,1,2],[0,2,3],[0,1,5],[0,5,4],[3,2,5],[1,2,5],[5,3,4],[0,4,3]
					]
				);
	}
				 
			//haut
			difference(){
				cube([H/2,E,H]);
				rotate([90,0,0]){
					union(){
						//trou axe moteur
						translate([0,H/2,-2*E])cylinder(r=D/2,h=4*E);
						//trou fixation moteur
						translate([M/2+d/2,H/2,-2*E])cylinder(r=d/2,h=4*E);
					}
				}
			}
		}
}

	union(){
		equerre();
		mirror([1,0,0])equerre();
	}


