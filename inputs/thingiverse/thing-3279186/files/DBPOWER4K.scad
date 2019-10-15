//DBPower-4K//
//action-cam mount//
//camera case//
translate([0, 0, 5,])
difference(){
difference(){
cube([66, 48, 13, ], center=true );
cube([46, 30, 13, ], center=true );
}
translate([0, 0, 3,])
cube([60, 41, 13, ], center=true );
//shutter button//
 translate([20.5, -18, 9,])
rotate([90, 0, 0]) {   
   cylinder(h=11, d=20, $fn=30 );}
   //side buttons//
   translate([33, 0, 3,])
cube([10, 36, 10, ], center=true );
}

//hold in clip//
difference(){
translate([0, -21, 20,])
difference(){
cube([22, 6, 19, ], center=true );
    translate([0, 2, -2,])
cube([22, 3, 15, ], center=true );
    
} 

translate([-11, -18, 28,])
rotate([0, 90, 0]) {   
   cylinder(h=22, d=6, $fn=3 );}
   
    translate([-11, -16, 25.5,]) 
  rotate([0, 0, 0]) { 
    cylinder(h=5, d=16, $fn=4 );}
}


//module borrowed from thingiverse//
$fn = 50;

// 5.5 diameter
bolt_hole_r = 5.5 / 2;

module GoPro_Connection()
{
	translate([-5, 24, 0,])
	{
		difference()
		{
			// tabs
			union()
			{
                //tab1//
				cube([3,10,10]);
				translate([0,10,5]) rotate([90,0,90]) cylinder(3,5,5);
		
				// note: center tab is slightly larger the the other two tabs
				translate([6.5,0,0])
				{
					cube([3.0,10,10]);
					translate([0,10,5]) rotate([90,0,90]) cylinder(3.0,5,5);
				}

				//translate([12.8,0,0])
			//	{
			//		cube([3,10,10]);
			//		translate([0,10,5]) rotate([90,0,90]) cylinder(3,5,5);
	//			}
			}

			// bolt hole
			translate([-7, 10, 5]) rotate([0,90,0]) cylinder(30, bolt_hole_r, bolt_hole_r);
		}
	}

	// connection block
    translate([-5, 24, 0,])
	cube([9.5,3,10]);
}

GoPro_Connection();






