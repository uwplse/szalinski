//Displays a 30cm long ruler
showruler = "no"; //["yes","no"]
rulerheight = 2; 
rulerlenght = 300; 

//Pattern-Element parameter 1
circle_1 = 5;//[1:100]
//Pattern-Element parameter 2
circle_2 = 1;//[1:100]
//Pattern-Element parameter 3
lenght = 20;//[1:100]
//Height of the moustache
height = 5;//[1:100]

//How often the element is repeated per side
repeat = 8;//[0:100]
//shift in x direction (10 = 1mm)(elementnumber*x)
shift_x = 2;//[-100:100]
//shift in y direction (10 = 1mm)(elementnumber*y)
shift_y = 5;//[-100:100]
//rotation of elements (elementnumber*rotation)
rotate = 10;//[0:360]
//scale of elements (elementnumber*scale)
scale =1;//[-100:100]


//Noseclip-Parameter: Angle the noseclip is open
noseclip_openingangle = 100;//[0:180]
//Noseclip-Parameter: diameter of the noseclip
noseclip_diameter = 10;//[0:180]
//Noseclip-Parameter: wallthickness of the noseclip
noseclip_wallthickness = 2;//[0:180]
//Noseclip-Parameter: radius of the little circles at the end of the noseclip
noseclip_endcircle = 2;//[0:180]
//Noseclip-Parameter: shift in x direction
noseclip_x = 0;//[-100:100]
//Noseclip-Parameter: shift in y direction
noseclip_y = -6;//[-100:100]

realshift_x = shift_x/10;
realshift_y = shift_y/10;
realscale = scale/10;





if(showruler == "yes"){
	ruler();
}
full(circle_1,circle_2,lenght,height);
noseclip();


module ruler(){
	translate([0,-noseclip_diameter,rulerheight + height]){
		difference(){
			cube([rulerlenght,10,rulerheight], center = true);
			for(i=[0:30]){
				translate([(i*10)-150,0,0]){
					cube([1,5,rulerheight+2], center = true);
				}
			}
		}
	}
}


module noseclip(){
translate([noseclip_x,noseclip_y,height/2]){
	difference(){
		union(){
			cylinder(h = height, r = noseclip_diameter/2+noseclip_wallthickness, center = true);
			
		}
		cylinder(h = height+2, r = noseclip_diameter/2, center = true);	
		rotate(180+90 + noseclip_openingangle/2) 
			linear_extrude(height = height+2, center = true)
				slice(noseclip_diameter*2, noseclip_openingangle);
	}
rotate(noseclip_openingangle/2) 
	translate([0,-noseclip_diameter/2,0]){
		cylinder(h = height, r = noseclip_endcircle, center = true);
	}

rotate(-noseclip_openingangle/2) 
	translate([0,-noseclip_diameter/2,0]){
		cylinder(h = height, r = noseclip_endcircle, center = true);
	}
}
}


module slice(r = 10, deg = 30) { 
	degn = (deg % 360 > 0) ? deg % 360 : deg % 360 + 360;
	difference() {
		circle(r);
		if (degn > 180) 
			intersection_for(a = [0, 180 - degn]) 
				rotate(a) 
					translate([-r, 0, 0]) 
						square(r * 2); 
		else 
			union() 
				for(a = [0, 180 - degn]) 
					rotate(a) 
						translate([-r, 0, 0]) 
							square(r * 2); 
	}
}

module full() {
	half(circle_1,circle_2,lenght,height);
	mirror([ 1, 0, 0 ])
		half(circle_1,circle_2,lenght,height);
}



module half() {
	for(i=[0:repeat]){
		translate([i*realshift_x,i* realshift_y, 0]){
			rotate([0,0,i*-rotate]){
				translate([-circle_1,0,0]){
					scale(v = [(i*realscale)+1,(i*realscale)+1, 1])
						element(circle_1,circle_2,lenght,height);
				}
			}
		}
	}
}


module element(circle_1,circle_2,lenght,height) {
 linear_extrude(height=height)
 	hull() {
 		translate([circle_1, circle_1, 0])
 			circle(r=circle_1,center = true);
 		translate([circle_1 ,  circle_1+ lenght, 0])
 			circle(r=circle_2,center = true);
 	}
}