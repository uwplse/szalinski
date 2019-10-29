/**
 * Jonas Knoell, jonas.knoell@utexas.edu
 */

//in degrees
angle=5;
//fine tune to fit just right
innerbaseradius=12.275; 
//outer diameter of base
outerbaseradius=14;
//height of mount piece
mountheight=7;
//create mount holes?
nanmountholes=1;
//mm from top
nanmountholedistance=2;


//usually left unchanged
mth=5.1;


angleminheight=outerbaseradius*sin(angle);
difference(){
	union(){
		difference(){
			cylinder(h = 9.5,r=outerbaseradius,$fn=50);
			cylinder(h = 9.5,r=innerbaseradius,$fn=50);
		}
			
		intersection(){
			 translate([0.0, mth*sin(angle), 4.5 ])
		    rotate([angle,0,0])
		    difference(){
			  	union(){
			        difference(){
			        scale([1,cos(angle),1])cylinder(h = mth+angleminheight,r=14,$fn=50);
			        cylinder(h = mth+angleminheight,r=10,$fn=50);
			        };
			        
			        difference(){
			        	cylinder(h = mth+mountheight+angleminheight,r=12,$fn=50);
						cylinder(h = mth+mountheight+angleminheight,r=10,$fn=50);
			        }
	
				}

				if(nanmountholes){
					translate([-15,00,(mth+mountheight-nanmountholedistance+angleminheight)])
					rotate([0,90,0])
					cylinder(r=1, h=30,$fn=50);
					
					translate([0,15,(mth+mountheight-nanmountholedistance+angleminheight)])
					rotate([90,00,0])
					cylinder(r=1, h=30,$fn=50);
	
					rotate([90,00,45])
					translate([00,(mth+mountheight-nanmountholedistance+angleminheight),-15])
					cylinder(r=1, h=30,$fn=50);
	
					rotate([90,00,-45])
					translate([00,(mth+mountheight-nanmountholedistance+angleminheight),-15])
					cylinder(r=1, h=30,$fn=50);
				}

		    }
		    translate([0, 0, 9.5 ])
		    cylinder(h = 50,r=20,$fn=50);
		
		}
	}

	union(){
		translate([0,15,2])
		rotate([90,0,0])
		cylinder(r=1.5, h=30,$fn=50);
		
		translate([-15,0,2])
		rotate([0,90,0])
		cylinder(r=1.5, h=30,$fn=50);

		translate([-1.5,-15,-1])
	   cube([3,15,3]);

	}
}