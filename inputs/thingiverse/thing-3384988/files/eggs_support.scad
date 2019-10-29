/*egg size table : https://adamcap.com/schoolwork/1407/

Table I
Egg Size	Length	Width	Mass
Medium	53.30 mm	40.98 mm	50.4 g
Medium	52.94 mm	40.24 mm	47.9 g
Large	54.45 mm	43.05 mm	55.7 g
Large	56.10 mm	42.81 mm	57.8 g
Extra Large	60.10 mm	44.70 mm	67.1 g
Extra Large	59.25 mm	44.96 mm	65.7 g

*/

//print : 
//no support 

eggs_number = 6 ; //min 2, must be 2^x even number
plate_tickness= 1.5;

inner_diameter = 44.85;
walltickness= 0.8;


//[hidden]
$fn=50;
half_lenght=inner_diameter+2*walltickness;


//echo("number of plates",eggs_number/2);

if (eggs_number % 2 == 1) { echo("eggs number is odd"); }


for(n=[1:1:round(eggs_number/2)]) {
	translate([n*half_lenght-half_lenght/2,half_lenght/2,0])
	2eggs();
}


module 2eggs(){
	///// plate & spheres - substract inner spheres

	difference() {//diff inner sphere
		union() { //union plate & sphere
			

			for(y=[0, half_lenght]) {
				translate([0,y,0]) 
				//half sphere
				half_sphere(inner_diameter/2+walltickness);
				
				if(eggs_number <=2){  //make supports
					
					//support for joints       
					translate([-half_lenght/2,y,0])
					cube([half_lenght,plate_tickness,inner_diameter/2]);
					
					
					translate([half_lenght/2,y-half_lenght/8+plate_tickness/2,0])rotate([0,0,90])
					cube([half_lenght/4,plate_tickness,inner_diameter/2]);
					
					translate([-half_lenght/2+plate_tickness,y-half_lenght/8+plate_tickness/2,0])rotate([0,0,90])
					cube([half_lenght/4,plate_tickness,inner_diameter/2]);
				}       
				
			}

			//plate
			translate([-half_lenght/2,-half_lenght/2,0]) cube([ half_lenght, 2* half_lenght, plate_tickness]);
			

		}//union
		
		//diff

		//inner half sphere
		for(y=[0, half_lenght]) {
			translate([0,y,-1]) 
			//cup();
			half_sphere(inner_diameter/2);
		}
		

		
	}//diff inner sphere

}//end module 2eggs



module half_sphere(radius){
	difference(){
		sphere(r=radius);
		translate([0,0,-radius])
		cube(size=radius*2, center = true);
	}
}

