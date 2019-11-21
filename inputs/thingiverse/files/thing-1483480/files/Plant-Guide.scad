Guide_Tickness = 4; // [1:10]
Guide_Width = 3; // [2:6]

// Radius of the thing you fix the guide to
Small_Radius = 3; // [1:10]

// How much room do you give your plant?
Large_Radius = 20; // [10:50]


module arc(radius, thick, angle){
	intersection(){
		union(){
			rights = floor(angle/90);
			remain = angle-rights*90;
			if(angle > 90){
				for(i = [0:rights-1]){
					rotate(i*90-(rights-1)*90/2){
						polygon([[0, 0], [radius+thick, (radius+thick)*tan(90/2)], [radius+thick, -(radius+thick)*tan(90/2)]]);
					}
				}
				rotate(-(rights)*90/2)
					polygon([[0, 0], [radius+thick, 0], [radius+thick, -(radius+thick)*tan(remain/2)]]);
				rotate((rights)*90/2)
					polygon([[0, 0], [radius+thick, (radius+thick)*tan(remain/2)], [radius+thick, 0]]);
			}else{
				polygon([[0, 0], [radius+thick, (radius+thick)*tan(angle/2)], [radius+thick, -(radius+thick)*tan(angle/2)]]);
			}
		}
		difference(){
			circle(radius+thick);
			circle(radius);
		}
	}
}


// Set number of faces
$fs=0.5;
$fa=5;

// Draw Small Arc
translate([0,Small_Radius+Guide_Width/2,0])
rotate([0,0,20])   
linear_extrude(height=Guide_Tickness)
    arc(Small_Radius, Guide_Width, 220);
;

// Draw Small Arc Fillet
translate([0,Small_Radius+Guide_Width/2,0])
rotate([0,0,220])    
translate([0,-Small_Radius-Guide_Width/2,0]) 
linear_extrude(height=Guide_Tickness)
        arc(0, Guide_Width/2, 180);
;

// Draw Large Arc
translate([0,-Large_Radius-Guide_Width/2,0])    
rotate([0,0,245])
linear_extrude(height=Guide_Tickness)
    arc(Large_Radius, Guide_Width, 310);
;

// Draw Large Arc Fillet
translate([0,-Large_Radius-Guide_Width/2,0])    
rotate([0,0,130])    
translate([0,-Large_Radius-Guide_Width/2,0]) 
linear_extrude(height=Guide_Tickness)
    arc(0, Guide_Width/2, 180);
;
