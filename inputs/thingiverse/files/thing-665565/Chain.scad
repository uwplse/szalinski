/* [Chain] */

//Values above 8 work best.
Number_of_Links=20;

//Should the chain loop back?
Shape_of_Chain="circular";//["circular":Circular, "straight":Straight]

//How close together should the links be?
Chain_Stretch=5;//[0:10]


/* [Hidden] */
//How smooth should the result be? May drastically increase processing time. 
Quality=0;//[10:OK,15:Good (Recommended),20:Really Good,30:Perfect]





stretch = (Chain_Stretch * 4 / 10) + 12;
num = Number_of_Links;
shape = Shape_of_Chain;
Odd_Number_Fix = (num % 2 == 1)? "Enable" : "Disable";

for (i=[0:num-1]){
	if (shape == "circular"){
		
 		 rotate([0,0,i*360/num])
		    translate([stretch*num/6.5,0,0])
		      rotate([0,(Odd_Number_Fix == "Enable") ? (i*90) + (90*i/num) : (i*90),0])
		        scale([0.7,1,1])
		          rotate_extrude($fn = Quality * 3) translate([10,0,0]) circle(r=2, $fn=Quality);
		
		
			
	}
	if (shape == "straight"){
		translate([0,stretch*i,0])
			rotate([0,i*90,0])
				scale([0.7,1,1])
					rotate_extrude($fn = Quality * 3) translate([10,0,0]) circle(r=2, $fn = Quality);
	}
}

