////Set arms to -1 for round torque mount, 0 for nothing, 1... for number of arms
arms = 6;
$fn=360;
// TowerPro MG955 Servo dummy
module screwBracket(){
//screwBracket
	difference(){
		union(){
			minkowski(){
				cube([5.25,17,1]);
				translate([1,1,0]) cylinder(h=1.5, d=2);
				}
			cube([5.25,19,2.5]);
			rotate([0,10,0]) translate([-1.4,9,1.7]) cube([8,1,2]);
			}
		//srewHoles
		union() {
			translate([4.25,4.3,-1])  cylinder(h=4, d=4.5);
			translate([4.25,14.8,-1])  cylinder(h=4, d=4.5);	
			translate([5,3,-1]) cube([2.5,2.5,4]);
			translate([5,13.5,-1]) cube([2.5,2.5,4]);
			
			}
		}
}
module TorqueArm(arms) {
    color("Silver"){
        if (arms==-1) 
            TorqueMount();
        if (arms>0)
        for(angle=[0:360/arms:360])
            rotate([0,0,angle])
        difference() {
            union() {
                cylinder(h=4.7,d=8);
                hull() {
                    translate([0,0,2.7]) cylinder(h=2, d=13);
                    translate([17.0,0,2.7]) cylinder(h=2, d=6);
                }
            }
            for(i=[16:-3:5]) {
                translate([i,0,-10]) cylinder(h=20, d=1);
            }           
            translate([0,0,3.3])cylinder(h=5,d=6);
        }
        
    }
}
module TorqueMount(){
// torque mount
		color("Silver"){            
			difference(){
				union(){
					translate([0,0,2.7]) cylinder(h=2, d=20);
					cylinder(h=4.7, d=9);				
				}
				translate([0,0,-1])cylinder(h=8, d=4.5);
				translate([7,0,2]) cylinder(h=4,d=3);
				rotate([0,0,90]) translate([7,0,2]) cylinder(h=4,d=3);
				rotate([0,0,180]) translate([7,0,2]) cylinder(h=4,d=3);
				rotate([0,0,270]) translate([7,0,2]) cylinder(h=4,d=3);
			}
		}
}
module WireTerminal(){
		//wireTerminal
	color("DimGray",1){
		translate([40,6.5,4]) cube([5,7,4]);
		}
		color("Red",1){
			translate([40,7.5,5.5]) cube([7,5,1]);
		}


}
module ServoMainPart(arms){
	color("DimGray",1){
		//mainpart
		cube([40.5,20,36.5]);
		translate([40.5,0.5,28]) screwBracket();
		rotate([0,0,180]) translate([0,-19.5,28])  screwBracket();
		translate([10,10,36.5]) cylinder(h=2, d=19);
		translate([10,10,38.5]) cylinder(h=1, d=13);
		translate([10,10,39.5]) cylinder(h=0.5, d=11);
		translate([14,1.5,36.5]) cube([21,17,2]);
		}
		//torqueConnector
		color("Gold",1){
			translate([10,10,40]) cylinder(h=4.5, d=5);
		}
	//silver torque disc
	//translate([10,10,40.5]) TorqueMount();
    translate([10,10,40.5]) TorqueArm(arms);
	//red wire terminal
	rotate([0,0,180]) translate([-42,-20,0]) WireTerminal();
}
// END SERVODUMMY
ServoMainPart(arms);