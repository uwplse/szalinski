/*[Dimensions]*/

/*Width of the shape being cut*/
width = 42; //[10:300]

/*Length of the shape being cut*/
length = 70; //[10:300]

/*Height of the cutter*/
height = 15; //[5:200]

/*[Blade]*/

/*Thickness of the blade*/
wall_thickness = 1.2; //[0.3:10]

/*Cutting angle*/
cutting_angle = 20; //[10:85]

/*[Other]*/

/*Width of the base*/
base_width = 4; //[0.3:150]

/*Height of the base*/
base_height = 2; // [0.3:200]




module heart(width=60, height=60, thickness=15) {

r=width/4;
m=height-r;
alpha=atan(r/m)*2;

translate([-width/4,0,0])
	cylinder(r=r, h=thickness);
translate([width/4,0,0])
	cylinder(r=r, h=thickness);

echo("Angle of the hearth spike:");
echo(alpha);

linear_extrude(height=thickness)
	polygon(points=[
			[0, -m],
			[m*sin(alpha),-m + m*cos(alpha)],
			[width/2,0],
			[-width/2,0],
			[-m*sin(alpha),-m + m*cos(alpha)]
		]);
}


module heart_cutter(width=60, length=60, height=15, thickness=1, base_thickness=5, base_height=4, cutting_angle=30) {

	blade_height=thickness/tan(cutting_angle);

	difference() {

    	union() {

			render()
				minkowski() {
					heart(width=width, height=length, thickness=base_height/3);
					cylinder(r=base_thickness, h=base_height/3);
				}

			render() {
				minkowski() {
					heart(width=width, height=length, thickness=height-blade_height);
					cylinder(h=blade_height, r1=thickness, r2=0);
				}
			}

		}

		translate([0,0,-blade_height])
		heart(width=width, height=length, thickness=height+3*blade_height);
	
	}
}

heart_cutter(width=width, length=length, height=height, thickness=wall_thickness, base_thickness=base_width, base_height=base_height, cutting_angle=cutting_angle);

