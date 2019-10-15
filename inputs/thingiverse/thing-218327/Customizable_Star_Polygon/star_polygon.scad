//Customizable Star Polygon
//Created by Ari M. Diacou, January 2014
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

// preview[view:south, tilt:top diagonal]
//The length of one of the sides of the star
length=10;
//The thickness of one of the sides of the star
thickness=.2;
//The height of one of the sides of the star
height=1;
//Vertices (number of points)
p=7;//[5,7,9,11,13,15,17,19]
//Density
//q=5;

/* HIDDEN */
angle=abs(180/p); echo("angle = ",angle);//internal angle of the points
circle_radius=length/(2*sin(2*angle));echo("circle_radius = ",circle_radius);//circle that the polygon is inscribed in
sagitta=circle_radius-sqrt(circle_radius*circle_radius-.25*length*length);echo("sagitta = ",sagitta); //distance from a vertex to the side of the polygon at the vertex's base
side_length=2*sagitta*sin(angle/2)/cos(angle/2); echo("side_length = ",side_length);//the length of the side of the internal polygon
apothem=.5*side_length*cos(180/p)/sin(180/p); echo("apothem = ",apothem); //distance from the origin to one of the sides in the internal regular polygon

module side(){
	mirror([0,1,0]){
		difference(){
			cube([length,thickness,height]);
			rotate([0,0,angle]) 
				cube([thickness/sin(angle),thickness,height]);
			translate([length,0,0]) 	
				mirror([1,0,0]){
					rotate([0,0,angle]) 
						cube([thickness/sin(angle),thickness,height]);
					}
			}
		}
	}

for(i=[1:p]){
	   rotate([0,0,i*2*angle]) 
			translate([-length/2,apothem,0]) 
				side();
		}

