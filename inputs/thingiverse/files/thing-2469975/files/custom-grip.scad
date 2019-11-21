/* [grip parameters] */
//number of finger rings
fingers = 4;   //[1, 2, 3, 4]
//finger ring diameter
fingerWidth = 22; //[20:1:28]
// include palm bar
palmBar = "no";   //[yes, no]

/* [hidden] */
$fn = 40;
x = 0; y = 1; z = 2;
height = 7;
thick = 3;
width = [fingerWidth, fingerWidth, fingerWidth, .82*fingerWidth];
xOffset = [0, 4, 2, -13];
radius = 2;
scaleX = thick / height;

module fcylinder(ht, x1, xScale, yScale, rad) {
   minkowski() {
      scale([xScale, yScale, 1])
      cylinder(h=ht-2*rad, d1=x1-2*rad, center=true);
         sphere(rad, center=true);
   }
}
module fcube(wi, de, he, rad) {
   minkowski() {
      cube([wi-2*rad, de-2*rad, he-2*rad], center=true);
      sphere(r=rad);
   }
}
module torus(ht, innerD) {
   rotate_extrude(convexity = 10)
      translate([innerD/2+ht*scaleX/2, 0, 0])
         scale([scaleX, 1])
            circle(d=ht);
}
translate([0, -30.8, 0])
   gopro_connector("triple");
hull() {
   translate([0, -width[0]/2-3.8, 0])
      scale([1, 1, .4])
         rotate([90, 0, 0])
            fcylinder(7, 14.7, 1, 1, radius);
   translate([0, -18, 0])
      cube([14.7, 4, 14.7], center=true);
}
for ( n=[0:1:fingers-1]) {
   yOffset = (n==3) ? (width[0]+thick)*n-6 : (width[0]+thick)*n;
   translate([xOffset[n], yOffset, 0])
      torus(height, width[n]);
}

// crossbar
crossbarXOffset = -width[0]/2-thick/2-14/2;
if ( palmBar == "yes" )
   translate([crossbarXOffset, 0, 0])
      rotate([90, 0, 90])
         scale([.75, 1, 1])
            cylinder(h=14, d=7, center=true);
// palm bar
palmBarXOffset = -width[0]/2-thick-14+3.5;
if ( palmBar == "yes" )
   union() {
      hull() {
         translate([palmBarXOffset, 0, 0])
            sphere(d=height, center=true);
         translate([palmBarXOffset-4, 1.7*width[0], 0])
            scale([1, 3, 1])
            sphere(d=height, center=true);
      }
      hull() {
         translate([palmBarXOffset-4, 1.7*width[0], 0])
            scale([1, 3, 1])
           sphere(d=height, center=true);
         translate([palmBarXOffset, 3.4*width[0], 0])
            sphere(d=height, center=true);
      }
   }
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

// Can be queried from the outside
gopro_connector_z= 2*gopro_connector_th3_side+gopro_connector_th3_middle+2*gopro_connector_gap;
gopro_connector_x= gopro_connector_z;
gopro_connector_y= gopro_connector_z/2+gopro_wall_th;
module gopro_connector(version="double", withnut=true, captive_nut_th=0, captive_nut_od=0, captive_rod_id=0, captive_nut_angle=0)
{
	module gopro_profile(th)
	{
		hull()
		{
			gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
			translate([0,0,th-gopro_connector_roundness])
				gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
			translate([-gopro_connector_z/2,gopro_connector_z/2,0])
				cube([gopro_connector_z,gopro_wall_th,th]);
		}
	}
	difference()
	{
		union()
		{
			if(version=="double")
			{
				for(mz=[-1:2:+1]) scale([1,1,mz])
						translate([0,0,gopro_connector_th3_middle/2 + (gopro_connector_gap-gopro_connector_th2)/2]) gopro_profile(gopro_connector_th2);
			}
			if(version=="triple")
			{
				translate([0,0,-gopro_connector_th3_middle/2]) gopro_profile(gopro_connector_th3_middle);
				for(mz=[-1:2:+1]) scale([1,1,mz])
					translate([0,0,gopro_connector_th3_middle/2 + gopro_connector_gap]) gopro_profile(gopro_connector_th3_side);
			}

			// add the common wall
			translate([0,gopro_connector_z/2+gopro_wall_th/2+gopro_connector_wall_tol,0])
				cube([gopro_connector_z,gopro_wall_th,gopro_connector_z], center=true);

			// add the optional nut emboss
			if(version=="triple" && withnut)
			{
				translate([0,0,gopro_connector_z/2-gopro_tol])
				difference()
				{
					cylinder(r1=gopro_connector_z/2-gopro_connector_roundness/2, r2=11.5/2, h=gopro_nut_h+gopro_tol);
					cylinder(r=gopro_nut_d/2, h=gopro_connector_z/2+3.5+gopro_tol, $fn=6);
				}
			}
		}
		// remove the axis
		translate([0,0,-gopro_tol])
			cylinder(r=(version=="double" ? gopro_holed_two : gopro_holed_three)/2, h=gopro_connector_z+4*gopro_tol, center=true, $fs=1);
	}
}
module gopro_torus(r,rnd)
{
	translate([0,0,rnd/2])
		rotate_extrude(convexity= 10)
			translate([r-rnd/2, 0, 0])
				circle(r= rnd/2, $fs=0.2);
}
