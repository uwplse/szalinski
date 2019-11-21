// Give the PCB Measurements below.
// DO NOT ADD ANY EXTRA MARGIN AS THAT IS ALREADY CALCULATED

pcbwidth = 100;
pcblength = 52;

// DO NOT CHANGE ANYTHING BELOW THIS LINE
rotate(a=[180,0,0]){
	difference(){
		cube([pcbwidth+6,pcblength+6,8]);
		translate([2,2,0])
			cube([pcbwidth+2,pcblength+2,5]);
		translate([19,8,4],center=true){
			cylinder(h=10,r=3);
			cylinder(h=3,r1=5,r2=3);
		}
		translate([pcbwidth-13,8,4],center=true){
			cylinder(h=10,r=3);
			cylinder(h=3,r1=5,r2=3);
		}
		translate([pcbwidth-13,pcblength-2,4],center=true){
			cylinder(h=10,r=3);
			cylinder(h=3,r1=5,r2=3);
		}
		translate([19,pcblength-2,4],center=true){
			cylinder(h=10,r=3);
			cylinder(h=3,r1=5,r2=3);
		}
		translate([28,5,0])
			cube([pcbwidth-50,pcblength-4,8]);
		translate([5,14,0])
			cube([pcbwidth-4,pcblength-22,8]);
	}
	translate([5,5,3])
	difference(){
		cylinder(h=5,r=5);
		cylinder(h=5,r=2);
	}
	translate([pcbwidth+1,5,3])
	difference(){
		cylinder(h=5,r=5);
		cylinder(h=5,r=2);
	}
	translate([pcbwidth+1,pcblength+1,3])
	difference(){
		cylinder(h=5,r=5);
		cylinder(h=5,r=2);
	}
	translate([5,pcblength+1,3])
	difference(){
		cylinder(h=5,r=5);
		cylinder(h=5,r=2);
	}
	echo("The PCB has a dimention of ", pcbwidth, "x", pcblength, "mm");
	echo("The PCBHolder will have a final dimension of ", pcbwidth+6, "x", pcblength+6, "mm");
}