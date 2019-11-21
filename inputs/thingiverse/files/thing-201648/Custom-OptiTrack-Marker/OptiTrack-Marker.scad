//	Thingiverse Customizer Template v1.2 by MakerBlock
//	http://www.thingiverse.com/thing:44090
//	v1.2 now includes the Build Plate library as well
//	v1.3 now has the cube sitting on the build platform - check out the source to see how!

//	Uncomment the library/libraries of your choice to include them
//	include <MCAD/filename.scad>
//	include <pins/pins.scad>
//	include <write/Write.scad>
	include <utils/build_plate.scad>

//CUSTOMIZER VARIABLES

//	This section is displays the box options
//	Stand Width (X) (mm)
x_measurement = 10;	//	[5,10,20,25]

//	Stand Width (Y) (mm)
y_measurement = 10;	//	[5:small, 10:medium, 20:large, 25:extra large]

//	Stand Height (mm)
z_measurement = 10;	//	[5:25]

//	Marker Diameter (mm)
diameter = 10;	//	[5:30]

//	Number of Markers
marker_count = 5;	//	[1:5]

//CUSTOMIZER VARIABLES END

//	This is just a Build Plate for scale
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

//	This is the cube we've customized!
translate([0,0,z_measurement/2]) cube([x_measurement, y_measurement, z_measurement], center=true);



rotX = rands(0, 180, marker_count);
rotY = rands(0, 180, marker_count);
rotZ = rands(0, 360, marker_count);
lengthR = rands(diameter*2, max(diameter*5, 7), marker_count);

for (i = [0 : marker_count])
{
	markerOnAStick(rotX[i]-90, rotY[i]+90, rotZ[i], lengthR[i], 10);
}

module markerOnAStick(rotX, rotY, rotZ, length, diameter)
{
	rotate(rotX, [1, 0, 0])
	{
		rotate(rotY, [0, 1, 0])
		{
			rotate(0 , [0, 0, 1])
			{
				cylinder(length, diameter / 4);
				translate([0,0,length]) 
				{
					sphere(diameter / 2);
				}
			}
		}
	}
}


module flange() {
     rotate([rand(0, 360, 16),0,180]){
          translate([-10,6,-4]){
              difference(){
                 union(){
                   cube([20,12,4]);
                   translate([10,0,0]){
                      cylinder(h=4, r=10);
                    }
                 }
                 translate([10,0,0]){
                    cylinder(h=4,r=3.5);
                       rotate([0,0,90]){
                          cylinder(h=3, r=7);
                       }
                 }
             }
         }
     }
}
