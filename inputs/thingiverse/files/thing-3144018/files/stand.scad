include <MCAD/Shapes.scad>

inner=32.0;
thickness=2;
feet=5;
height=25;
footLen=48;
footHt = 15;
footTh = 4;
fT=0.5;
$fn=50;

//--------
innerRad=inner/2;

module ecigHolder(){
	intersection(){
		union(){
			difference(){
				union(){
					cylinder(r=innerRad+thickness, h=height, $fn=100);
					translate([0,0,-height/4])cylinder(r2=innerRad+thickness, r1=innerRad/2, h=height/2, center=true,$fn=100);
				}
				translate([0,0,4])cylinder(r=innerRad, h=height,$fn=100);
			}
			for (foot = [0 : feet-1]){
				rotate([0,0,foot*(360/feet)])translate([footLen/2+thickness*2, 0, -6]){
					minkowski(){
						difference(){
							translate([inner/4,0,footHt/2-1.5])rotate([0,0,0])cube([footLen, fT, footHt], center=true);
							translate([footLen/2+inner/4+85,0,footHt/2-footTh/2])rotate([0,30,0])cube([500, fT+10, 100], center=true);
							translate([inner/4-footLen/2,0,footHt])rotate([0,-60,0])cube([height, fT+10, inner/2], center=true);
							/* translate([8,0,-50])rotate([0,0,0])cube([footLen*2, fT+1, 100], center=true); */
						}
						sphere(r=footTh);
					}
				}
			}
		}
		translate([0,0,height-6-3.3-fT])cube([inner+thickness*2+footLen*2, inner+thickness*2+footLen*2, height*2],center=true);
	}
}

ecigHolder();
//%translate([0,0,height])cube([inner, 4,4], center=true);
