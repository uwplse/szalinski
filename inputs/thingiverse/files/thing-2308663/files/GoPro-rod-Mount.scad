/*
 * Go Pro mount for Cabela's ( Scotty's ) fishing pole holder
 * CCv3 SA BY 
 * by Angus Ainslie May 9 2017
 *
 * Much thanks goes to additional code work the following:
 *
 * GoPro variables from MoonCactus
*/


// Go Pro Parameters
/* [Rod and captive nut] */

gopro_rod_nut_od= 8.05;
// How much is the protruding output of the rod on the rod attachment (can be zero), useful if you don't want a captive nut with still a tight coupling
gopro_captive_protruding_h= 0.5;
// The gopro connector itself (you most probably do not want to change this but for the first two)

// The locking nut on the gopro mount triple arm mount (keep it tight)
gopro_nut_d= 9.2;
// How deep is this nut embossing (keep it small to avoid over-overhangs)
gopro_nut_h= 2;
// Hole diameter for the two-arm mount part
gopro_holed_two= 5;
// Hole diameter for the three-arm mount part
gopro_holed_three= 5.5;
// Thickness of the internal arm in the 3-arm mount part
gopro_connector_th3_middle= 3.1;
// Thickness of the side arms in the 3-arm mount part
gopro_connector_th3_side= 2.7;
// Thickness of the arms in the 2-arm mount part
gopro_connector_th2= 3.04;
// The gap in the 3-arm mount part for the two-arm
gopro_connector_gap= 3.1;
// How round are the 2 and 3-arm parts
gopro_connector_roundness= 1;
// How thick are the mount walls
gopro_wall_th= 3;

gopro_connector_wall_tol=0.5+0;
gopro_tol=0.04+0;

gopro_connector_z= 2*gopro_connector_th3_side+gopro_connector_th3_middle+2*gopro_connector_gap;
gopro_connector_x= gopro_connector_z;
gopro_connector_y= gopro_connector_z/2+gopro_wall_th;



gopro =true;



difference(){
union(){

//add a GoPro style mount?
			// add the base wall
			translate([-(gopro_connector_x/2),-(gopro_connector_z/2),50])	
				cube([gopro_connector_x,gopro_connector_z,gopro_connector_z]);


			// add the rounded top
			translate([7.25,0,gopro_connector_z+50])
				rotate([0,-90,0])
					cylinder(r=7.25, h=gopro_connector_z);

			// add the optional nut emboss
			rotate([0,0,0])
			translate([-7.25,0,gopro_connector_z+50])
				rotate([0,-90,0])
				difference()
				{
  				cylinder(r1=gopro_connector_z/2-gopro_connector_roundness/2, r2=11.5/2, h=gopro_nut_h+gopro_tol);
				cylinder(r=gopro_nut_d/2, h=gopro_connector_z/2+3.5+gopro_tol, $fn=6);
				}


	difference()
	{
        union() {
            cylinder (d=18.7,h=50);
            cylinder (d=22.2,h=9);
            translate( [ 0,0,26 ]) cylinder (d=22.2,h=22);
            translate( [ 0,0,46 ]) cylinder (d=26,h=4);
            for (i=[0:360/4:360])
                rotate( [0,0,i] ) translate( [11, -1.1, 36.5 ] ) cube( [1.9, 2.2, 10 ] );
        }
        union() {

            translate( [9.3, -2.4, 0 ] ) cube( [3, 4.8, 10 ] );
        }
//		english_thread(7/8, 5, 1, internal=true);
	}


}//end the union of the base shapes & start removing

			//GoPro Screw Hole
			translate([8,0,gopro_connector_z+50])
				rotate([0,-90,0])
					cylinder(r=2.6, h=gopro_connector_z+2);

			//GoPro Mount Slots
			translate([-((gopro_connector_x/2)-2.6),-7.5,50])	
				cube([3.1, gopro_connector_x+1,gopro_connector_z*2]);

			translate([-((gopro_connector_x/2)-2.6)+3.1+3.3,-7.5,50])	
				cube([3.1, gopro_connector_x+1,gopro_connector_z*2]);
	

}
























