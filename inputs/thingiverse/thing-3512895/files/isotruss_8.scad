$fn=32;

d1=2;
d2=50;
// 0, 1, 2, or 3 defines location of poles. The higher number the higher the strength.
poles=0;
length=100;

isoTruss8Tube(d1,d2,length,poles);

/// circle outscribed
//#cylinder(d=d2*(cos(22.5)+sin(22.5))+d1,h=length);
/// circle inscribed
//%cylinder(d=d2*cos(22.5)-d1,h=length);


module isoTruss8Tube(d1=2,d2=50,length=100,poles=3){
	l = (2+sqrt(2))*d2*sin(22.5)/sqrt(2);
	cells = ceil(length/l);
	echo("Cells ",str(cells));
	
	difference(){
		for(i=[1:cells]){
			translate([0,0,(i-1)*l]) isoTruss8(d1=d1,d2=d2,poles=poles);
		}
		translate([-2*d2,-2*d2,-d1]) cube([4*d2,4*d2,d1]);
		translate([-2*d2,-2*d2,length]) cube([4*d2,4*d2,l]);
	}
}

module isoTruss8(d1=2,d2=50,poles=3){

	s = d2*sin(22.5);
	l = s*(2+sqrt(2));

	if(poles==1 || poles>=3) poles1();
	if(poles>=2) poles2();
	wall();

	module poles1(){
		for(i=[0:45:360]){
			rotate([0,0,i]) translate([d2/2,0,0]) cylinder(d=d1,h=l/sqrt(2));	
		}
	}

	module poles2(){
		for(i=[0:45:360]){
			rotate([0,0,i+22.5]) translate([d2/2*(cos(22.5)+sin(22.5)),0,0]) cylinder(d=d1,h=l/sqrt(2));	
		}
	}

	module wall(){
		translate([0,0,d2*sin(22.5)*sin(45)]){
			for(i=[0:45:360]){
				rotate([0,0,i]) translate([d2/2,0,0]) rotate([45,0,-45/2]) translate([0,0,-s]) cylinder(d=d1,h=l);
				
				rotate([0,0,i]) translate([d2/2,0,0]) rotate([-45,0,45/2]) translate([0,0,-s]) cylinder(d=d1,h=l);
			}
		}
		
		/// balls
		for(i=[0:45:360]){
			rotate([0,0,i+22.5]) translate([d2/2*(cos(22.5)+sin(22.5)),0,0]) sphere(d=d1);
			rotate([0,0,i+22.5]) translate([d2/2*(cos(22.5)+sin(22.5)),0,l/sqrt(2)]) sphere(d=d1);
		}
	}
}
