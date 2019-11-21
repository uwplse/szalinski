// Coded by Ben Rockhold in 2012
// Inspired by the Touhou Project

// This is the first revision of the code, and it's 5am, so it may not be very stable.
// I am not liable for magical energy explosions caused by the mis-handling of this device.

// If you have a multiple-color capable printer, you should be able to print out the hakkero_body and the hakkero_inlay seperately, and get the two colors needed for accurate reproduction.

hakkero_width = 100;
hakkero_height=30;
$fn=40;

// Comment out the component you do not need when rendering, or it will take forever and then fail!
hakkero_body(hakkero_width,hakkero_height);
hakkero_inlay();

module hakkero_body(width,height){
	color("DimGrey")render()rotate([0,0,22.5]){
		difference(){
			octagon(width,height);
			translate([0,0,height-1])octagon(width-10,6);
			translate([0,0,height-2])ring(width/4-5,3,2.5);
			// Difference out our ba-gua
			translate([0,0,height-2.5])for(i=[
			//   Arrays for Ba_gua
				[1,0,1,0],
				[2,1,1,1],
				[3,0,0,1],
				[4,0,0,0],
				[5,1,0,1],
				[6,1,1,0],
				[7,0,1,1],
				[8,1,0,0]
			]){
				rotate([0,0,45*i[0]+22.5])Ba_gua(i);
				rotate([0,0,-22.5])translate([0,0,1])yingyang(30);
			}
		}
	}
}
//rotate([0,0,180])color("Black")yingyang(30);

module hakkero_inlay(){
	color("White"){
		rotate([0,0,22.5])translate([0,0,hakkero_height-2.5])
					for(i=[
					//   Arrays for Ba_gua
						[1,0,1,0],
						[2,1,1,1],
						[3,0,0,1],
						[4,0,0,0],
						[5,1,0,1],
						[6,1,1,0],
						[7,0,1,1],
						[8,1,0,0]
					]){
						rotate([0,0,45*i[0]+22.5])Ba_gua(i);
				}			
		translate([0,0,hakkero_height-2]){
			ring(hakkero_width/4-5,1.5,2.5);
			yingyang(30);
		}
	}
}

module yingyang(width){
	render(){
		translate([0,-width/4,0])cylinder(r=width/8,h=2,center=true);
		difference(){
			translate([0,width/4,0])cylinder(r=width/4,h=2,center=true);
			translate([0,width/4,0])cylinder(r=width/8,h=4,center=true);
		}
		difference(){
			cylinder(r=width/2,h=2,center=true);
			translate([width/2,0,0])cube([width,width,4],center=true);
			translate([0,-width/4,0])cylinder(r=width/4,h=3,center=true);
			translate([0,width/4,0])cylinder(r=width/8,h=4,center=true);
		}
	}
}

module Ba_gua(number){
	render(){
		difference(){
			translate([hakkero_width/2-10,0,0])for(i=[0:2]){
				translate([-7*i,0,0])cube([5,30,5],center=true);
			}
			translate([0,0,-3]){
				rotate([0,0,-112.5])translate([-2.5,0,0])cube([10,hakkero_width/2,6]);
				rotate([0,0,22.5])translate([0,-2.5,0])cube([hakkero_width/2,10,6]);
			}
			// Logic for dividing rods
			if (number[3]){
				translate([hakkero_width/2-10,0,0])cube(6,center=true);
			}
			if (number[2]){
				translate([hakkero_width/2-17,0,0])cube(6,center=true);
			}
			if (number[1]){
				translate([hakkero_width/2-24,0,0])cube(6,center=true);
			}
		}
	}
}

// Small Modules

module ring(radius,height,thickness){
	render()difference(){
		cylinder(r=radius,h=height);
		cylinder(r=radius-thickness,h=height);
	}
}

module octagon(width,height){
	cylinder(r=width/2,h=height,$fn=8);
}