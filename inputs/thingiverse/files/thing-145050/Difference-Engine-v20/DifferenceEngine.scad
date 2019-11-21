use <MCAD/involute_gears.scad>;
use <pins/pins.scad>;
/* [Global] */
$fn=50;
tab_offset=0;
sliding_tab_offset=0;
bearing_thickness=0;
view=0; //[0:Assembled,1:Bottom Plate A,2:Bottom Plate B,3:Figure Wheel,4:Sector Wheel,5:Figure Wheel Restore Arm,6:Sector Wheel Restore Arm,7:Sector Wheel Tab,8:Sector Wheel Lift Plate,9:Sector Wheel Bearing Plate]
bottom_plate_thickness=10;
stack_height=80;

/* [Hidden] */
module make_a_gear(number_of_teeth,axle_diameter,thickness){
	gear (number_of_teeth,350,pressure_angle=28,clearance=0.2,gear_thickness=thickness,rim_thickness=thickness,hub_thickness=thickness,bore_diameter=axle_diameter,involute_facets=2);
}
/* 
 * Excerpt from... 
 * 
 * Parametric Encoder Wheel 
 *
 * by Alex Franke (codecreations), March 2012
 * http://www.theFrankes.com
 * 
 * Licenced under Creative Commons Attribution - Non-Commercial - Share Alike 3.0 
*/ 
module arc( height, depth, radius, degrees ) {
    // This dies a horible death if it's not rendered here 
    // -- sucks up all memory and spins out of control 
    render() {
        difference() {
            // Outer ring
            rotate_extrude($fn = 100)
                translate([radius - height, 0, 0])
                    square([height,depth]);
         
            // Cut half off
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
            // Cover the other half as necessary
            rotate([0,0,180-degrees])
            translate([0,-(radius+1),-.5]) 
                cube ([radius+1,(radius+1)*2,depth+1]);
         
        }
    }
}
module technic_axle(length=20){
	union(){
		cube([1.75,4.75,length],center=true);
		cube([4.75,1.75,length],center=true);
	}
}
module interlocking_tab(height=10,sf=0){
linear_extrude(height = height, center = false, convexity = 10, twist = 0) polygon(points=[[5-sf,-5],[5-sf,0],[10-sf,10-sf],[-10+sf,10-sf],[-5+sf,0],[-5+sf,-5]], paths=[[0,1,2,3,4,5]]);
}
module figure_wheel(){
	render()
	union(){
		make_a_gear(40,5,10);
		difference(){
			cylinder(h=20, r=32,$fn=50);
			cylinder(h=21, r=28,$fn=50);
		}
		for (i=[0:3]){
			rotate(i*90+4.5,[0,0,1]){
				translate([0,32,12]){
					cube([3,8,6],center=true);
				}
			}
		}
		for (i=[0:1]){
			rotate(i*180+4.5,[0,0,1]){
				translate([0,28,12]){
					cube([3,8,16],center=true);
				}
			}
		}
	}
}
module sector_wheel(){
	translate([0,0,10]) rotate(180,[0,1,0]) union(){
		difference(){
			translate([0,0,-10]) make_a_gear(40,5,20);
			rotate(31.5,[0,0,1])translate([0,0,-10.5]) arc(100,21,100,153);
			rotate(31.5-90,[0,0,1])translate([0,0,-11]) arc(100,11,100,180);
			translate([0,0,-11])cylinder(r=28, h=11);
			rotate(220,[0,0,1]) arc(5,11,28,30);
		}
		difference(){
			cylinder(r=10,h=10);
			translate([0,0,-1]) cylinder(r=2.5,h=20);
		}
	}
}
module sector_wheel_tab(tab_factor=0){
	union(){
		arc(5-tab_factor,10.02,28-tab_factor,30);
		difference(){
			translate([0,0,10.01])arc(5,10,28,30);
			rotate(-25,[0,0,1]) translate([0,-50,25]) rotate(15,[0,0,1]) rotate(45,[0,1,0]) cube([30,30,30]);
			translate ([0,0,10]) sector_wheel_restore_arm();
		}
	}
}
module figure_wheel_restore_arm(){
	difference(){
		rotate([180,0,9]) union(){
			translate([0,0,-10]) cylinder(r=10, h=10);
			translate([0,0,-10]) arc(15.833,10,15.833,90);
			translate([0,0,-10]) arc(21.666,10,21.666,60);
			translate([0,0,-10]) arc(27.5,10,27.5,30);
		}
		translate([0,0,-10])technic_axle(50);
	}
}
module sector_wheel_restore_arm(){
	difference(){
		rotate([0,0,-26])union(){
			cylinder(r=10, h=11);
			arc(17,11,17,90);
			arc(24,11,24,60);
			arc(31,11,31,30);
		}
		translate([0,0,-10])rotate(-224.5,[0,0,1]) technic_axle(50);
	}
}
module bottom_plate_one(thickness=10,tab_factor=1,stack_height=50){
	translate([25,0,0]) difference(){
		union(){
			translate([-60,-30,0]) cube([75,59.5,thickness]);
			translate([-5,29.5,0]) interlocking_tab(thickness,tab_factor);
			translate([-40,29.5,0]) interlocking_tab(thickness,tab_factor);
			translate([-50.75,0,0]) cylinder(r=10, h=15-bearing_thickness);
			translate([10,0,0]) cylinder(h=stack_height,r=10);
			translate([10,0,stack_height]) pin(r=6,h=15);
		}
		translate([10,0,0]) pinhole(r=6,h=15);
		translate([10,0,15]) cylinder(r1=6, r2=0, h=10);
		translate([-50.75,0,-1]) cylinder(r=2.5,h=thickness+17);
		translate([-50.75,10,10]) cube([3,5,100], center=true);
		translate([-50.75,-10,10]) cube([3,5,100], center=true);
		translate([-5,-30,-1]) interlocking_tab(thickness+2);
		translate([-40,-30,-1]) interlocking_tab(thickness+2);
	}
}
module bottom_plate_two(thickness=10,tab_factor=1,stack_height=50){
	translate([25,-59.5,0]) difference(){
		union(){
			translate([-60,29.5,0]) cube([75,59.5,thickness]);
			translate([-5,89,0]) interlocking_tab(thickness,tab_factor);
			translate([-40,89,0]) interlocking_tab(thickness,tab_factor);
			translate([0,59.5,0]) cylinder(r=10, h=25);
			translate([-55,59.5,0]) cylinder(h=stack_height,r=10);
			translate([-55,59.5,stack_height]) pin(r=6,h=15);
		}
		translate([-55,59.5,0]) pinhole(r=6,h=15);
		translate([-55,59.5,15]) cylinder(r1=6, r2=0, h=10);
		translate([0,59.5,-1]) cylinder(r=2.5,h=thickness+27);	
		translate([-5,29.5,-1]) interlocking_tab(thickness+2);
		translate([-40,29.5,-1]) interlocking_tab(thickness+2);
	}
}
module sector_wheel_lift_plate() {
	difference(){
		cylinder(h=5,r=7);
		technic_axle(50);
	}
}
module sector_wheel_bearing_plate(tab_factor=0) {
	rotate(180,[1,0,0]) union(){
		difference(){
			cylinder(h=5,r=15);
			translate([0,0,-1])cylinder(h=7,r=2.5);
		}
		translate([0,10,-15]) cube([3-tab_factor,5-tab_factor,30],center=true);		
		translate([0,-10,-15]) cube([3-tab_factor,5-tab_factor,30],center=true);		
	}
}
if (view==0) {
	translate([0,-59.5,0]) rotate(0,[0,0,1]) figure_wheel();
	translate([0,-59.5,10]) rotate(0,[0,0,1]) figure_wheel_restore_arm();
	translate([0,59.5,0]) rotate(0,[0,0,1]) figure_wheel();
	translate([0,59.5,10]) rotate(0,[0,0,1]) figure_wheel_restore_arm();
	translate([-50.75,0,0])	rotate(4.5,[0,0,1]) rotate(180,[0,1,0])	translate([0,0,-10]) sector_wheel();
	translate([-50.75,0,0]) rotate(224.5,[0,0,1]) sector_wheel_tab();
	translate([-50.75,0,10]) rotate(224.5,[0,0,1]) sector_wheel_restore_arm();
	translate([-25,0,-25]) bottom_plate_one(bottom_plate_thickness,tab_offset,stack_height);
	translate([-25,59.5,-25]) bottom_plate_two(bottom_plate_thickness,tab_offset,stack_height);
	translate([-25,-59.5,-25]) bottom_plate_two(bottom_plate_thickness,tab_offset,stack_height);
	translate([-50.75,0,-10]) sector_wheel_lift_plate(tab_factor);
	translate([-50.75,0,-5]) rotate(180,[1,0,0]) sector_wheel_bearing_plate(sliding_tab_offset);
}
if (view==1) {
	bottom_plate_one(bottom_plate_thickness,tab_offset,stack_height);
}
if (view==2) {
	bottom_plate_two(bottom_plate_thickness,tab_offset,stack_height);
}
if (view==3) {
	figure_wheel();
}
if (view==4) {
	sector_wheel();
}
if (view==5) {
	figure_wheel_restore_arm();
}
if (view==6) {
	sector_wheel_restore_arm();
}
if (view==7) {
	sector_wheel_tab(tab_offset);
}
if (view==8) {
	sector_wheel_lift_plate();	
}
if (view==9) {
	sector_wheel_bearing_plate(sliding_tab_offset);	
}