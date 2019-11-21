//http://www.thingiverse.com/thing:56236
//by mattjoyce
//customized by Arvin Evans

//length of trough
l1=100;
//magnet radius given as diameter measure. ( /2 in code)
mr=6.25;
//magnet hole depth
md=2;
//outside diameter of cylinder to subtract from and give nice round edges
od=10;
//My additions to mattjoyce's code
withMagnets="no";//[yes:Magnets,no:Pins,other:both]

pinDia=3;//filament pins to attach to a non-magnetic back plate
pinHoleDepth=5;
pinLength=15;

//Pins at the same angle as the back or horizontal to build platform?
perpendicular="false";//[true:90 degrees to back,false:parallel to bottom]
backAngle=60;
placeOnBuildPlatform="true";//[true:Flat to build platform,false:As the Original]

$fn=100;

module track(){
	difference(){
		rotate([0,90,0]) translate([-od,od/2,0]) 
		cylinder(r=od,h=l1);// gives nice round edges
		rotate([backAngle,0,0]) translate([-1,-od,-od]) 
		cube([l1+2,od*2,od*3]);// flattens the bottom
		translate([-1,od+2.5,0]) 
		cube([l1+2,od*2,od*3]);// flattens the back
		rotate([0,90,0]) translate([-18,4.5,-1]) 
		cylinder(r=7,h=l1+2); // the marble trough
	
		if(withMagnets=="yes" || withMagnets=="other"){
			rotate([90,0,0]) translate([l1/5,mr*2,-15+md])// 1/5
			cylinder(r=mr/2,h=md);// (back) magnet hole1
			rotate([90,0,0]) translate([l1/5*2.5,mr*1.5,-15+md])// 2.5/5=1/2 
			cylinder(r=mr/2,h=md);// (middle) magnet hole2
			rotate([90,0,0]) translate([l1/5*4,mr*2,-15+md])// 4/5 
			cylinder(r=mr/2,h=md);// (front) magnet hole3
		}
		if(withMagnets=="no" || withMagnets=="other"){
			if(perpendicular=="true"){// 90 degrees
				rotate([90,0,0]) 
				translate([l1/5,od,-pinLength-pinHoleDepth-1])
#				cylinder(r=pinDia/2,h=pinLength);
			
				rotate([90,0,0]) 
				translate([l1/5*4,od,-pinLength-pinHoleDepth-1]) 
#				cylinder(r=pinDia/2,h=pinLength);

			}else{//angled at backAngle degrees
				rotate([backAngle,0,0]) 
				translate([l1/5,od+pinDia,-pinLength-1])
#				cylinder(r=pinDia/2,h=pinLength);
			
				rotate([backAngle,0,0]) 
				translate([l1/5*4,od+pinDia,-pinLength-1]) 
#				cylinder(r=pinDia/2,h=pinLength);
			}
		}
	}
}

module main(){
  if(placeOnBuildPlatform=="true"){
	translate([-l1/2,0,-od])// move down to platform
	rotate([90-backAngle,0,0])// put the base flat to platform
	track();
  } else {
	track();
  }
}

main();