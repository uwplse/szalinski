
/* [Global] */

// the width of the base
baseWidth = 90; // [80:100]
// the length of the base
baseLen = 180; // [100:200]
// the thickness of the base
baseThickness = 3; // [1:3]

// the diameter of your heater
heaterDiam = 24.5; // 
// the height of the center of the heater
postHeight = 25; // [19:30]
// the distance between the center of the heaters
postSpacing = 50; // [30:60]

/* [Hidden] */

postWidth = heaterDiam*.95; // 25;
postLen = 10;

ringThickness = 3;

echo("baseLen", baseLen);

module print_post_ring()
{
	translate([postWidth/2, postLen+0.00, postHeight]) {
		rotate([90, 0, 0]) {
			difference() {
				cylinder(h=postLen+.0, r=(heaterDiam/2+ringThickness), $fn=50);
				translate([0, 0, -0.1]) {
					cylinder(h=postLen+.2, r=heaterDiam/2, $fn=50);
				}
			}
		}
	}
}

module print_post_base()
{
	difference()
	{
       	cube([postWidth, postLen, postHeight]);
		translate([postWidth/2, postLen+0.02, postHeight]) {
			rotate([90, 0, 0]) {
				cylinder(h=postLen+.1, r=heaterDiam/2, $fn=50);
			}
		}
	}
}

module print_post()
{
	center = postWidth/2;
	gapWidth = heaterDiam * .95;

	chopper = heaterDiam+(ringThickness*2);

	translate([-postWidth/2, -postLen/2, 0]) {
		difference() {
//		union() {
			union()
			{
				print_post_base();
				print_post_ring();
			}
			union() {
				translate([0, -.1, postHeight]) {
					color("green") {
						translate([center-(gapWidth/2), 0, 0])
							cube([gapWidth, 10+.2, 20]);
					}
				}
				translate([(center-(chopper/2)), -.1, postHeight+7]) {
					color("red");
					cube([chopper, 10+.2, 20]);
				}
			}
		}
	}
}

module fillet(r, h) {
    translate([r / 2, r / 2, 0])

        difference() {
            cube([r + 0.02, r + 0.02, h], center = true);

            translate([r/2, r/2, 0])
                cylinder(r = r, h = h + 1, center = true, $fn=50);

        }
}

module print_base()
{

	HoleCount = 4;
	holeWidth = baseWidth/(HoleCount+1);
	extraSpace = baseWidth - (holeWidth*HoleCount);
	spacing = extraSpace/5; // baseWidth / (HoleCount);
	echo("baseWidth ", baseWidth);
	echo("holeWidth ", holeWidth);
	echo("extraSpace ", extraSpace);
	echo("spacing ", spacing);
	translate([-baseWidth/2, 0, 0])
	{
		difference() {
			cube([baseWidth, baseLen, baseThickness]);
			for (holeNum = [1:HoleCount]) {
				translate([((holeNum-1)*(holeWidth+spacing))+spacing/1, 
						baseLen*.138, -.1]) {
		        		cube([baseWidth/5, baseLen/5, baseThickness+.2]);
				}
			}
			for (yHole = [2:3]) {
				for (holeNum = [1:HoleCount]) {
					translate([((holeNum-1)*(holeWidth+spacing))+spacing/1, 
							((yHole-1)*((baseLen/5.5)+spacing))+(baseLen*.33), -.1]) {
			        		cube([baseWidth/5, baseLen/5.5, baseThickness+.2]);
					}
				}
			}
			fillet(baseLen*.05, baseThickness*3);
			translate([baseWidth, 0, 0])
				rotate([0, 0, 90])
					fillet(baseLen*.05, baseThickness*3);
			translate([baseWidth, baseLen, 0])
				rotate([0, 0, 180])
					fillet(baseLen*.05, baseThickness*3);
			translate([0, baseLen, 0])
				rotate([0, 0, 270])
					fillet(baseLen*.05, baseThickness*3);
		}
	}
}

module print_test_base()
{
	test_base_size = 30;
	translate([-test_base_size/2, -test_base_size/2, 0])
	{
        cube([test_base_size, test_base_size, baseThickness]);
	}
}

module print_all()
{
	union() {
		print_base();
		translate([postSpacing/2, (baseLen*.11)-(postLen/2), 0])
			print_post();
		translate([-postSpacing/2, (baseLen*.11)-(postLen/2), 0])
			print_post();
		translate([postSpacing/2, baseLen*.44, 0])
			print_post();
		translate([-postSpacing/2, baseLen*.44, 0])
			print_post();
	}
}

module print_postTest()
{
	union() {
		print_test_base();
		print_post();
	}
}


test = 0;

if (test == 0) {
	print_all();
} else {
	print_postTest();
}

