/* [Global] */

Personalize = "no"; // [yes,no]
Name = "Somebody";	
Address = "Somewhere";

/* [Hidden] */

h = 65;
w = 71;
t = 2;

module cover() {
	difference() {
		cube([w,h,t]);
	
		for (i=[5:2:15]) {	
			translate([w-i-10, h/2-(20-i)/2, 2-.4])
				cube([1,20-i,.4]);
		}
		
		if (Personalize == "yes") {
			translate([w-40, h-32, 2-.4])
				rotate([0,0,-90])
				linear_extrude(height = .4)
					text( "Property of", 
						font = "Arial:style=Bold",
								size=4, 
								$fn=20, 
								valign="center", 
								halign = "center"
							);
			
			translate([w-50, h-32, 2-.4])
				rotate([0,0,-90])
				linear_extrude(height = .4)
					text( Name, 
						font = "Arial:style=Bold",
								size=4, 
								$fn=20, 
								valign="center", 
								halign = "center"
							);
			translate([w-60, h-32, 2-.4])
				rotate([0,0,-90])
				linear_extrude(height = .4)
					text( Address, 
						font = "Arial:style=Bold",
								size=4, 
								$fn=20, 
								valign="center", 
								halign = "center"
							);
		}	
	}
	translate([0,-.8,0])
		cube([14,.8,1.4]);
	
	translate([13,-.8,-2])
		cube([5.4,2.4,2]);
		
	translate([0,h,0])
		cube([14,.8,1.4]);
	
	translate([13,h-1.6,-2])
		cube([5.4,2.4,2]);
		
	translate([w-1,h/2-15/2,-1.4])
		cube([6,15,1]);
	
	difference() {
		translate([w+4,h/2-15/2,-1.4])
			cube([2,15,2]);
		
		translate([w+4+.2,h/2-15/2-.5,1])
		rotate([0,45,0])
			cube([4,16,2]);
	}
	
	
	difference() {
		translate([w-2,h/2-15/2,-1.4])
			cube([2,15,2]);
	
		translate([w-3.8,h/2-15/2-.5,-1.8])
			rotate([0,45,0])
				cube([2.8,16,2]);
	}
}

rotate([0,180,0]) 
	translate([0,0,-2]) 
		cover();
