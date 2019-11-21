


/* [Shell] */

height = 380; // [140 : 380]

innerRadius = 20; // [30 : 40]

outerRadius = 24; // [34 : 46]

shellDecoration = "none"; // [none, bumps]

/* [Rungs] */

rungsPerLevel = 2; // [1 : 4]

stepRadius = 1; // [1 : 5]

zDistanceBetweenRungs = 5; // [1:150]

zRotateAngle = 25; // [5 : 180]

/* [Endcap] */

generateEndcap = true; // [false:true]

/* [Hidden] */

i = 3; // [1:100]

rainmaker(height = height,
          outerRadius = outerRadius,
          innerRadius = innerRadius,
		  rungsPerLevel = rungsPerLevel,
		  shellDecoration = shellDecoration,
	  	  stepRadius = stepRadius,
	  	  zDistanceBetweenRungs = zDistanceBetweenRungs,
	  	  zRotateAngle = zRotateAngle);

if(generateEndcap)
{
	xTranslate = outerRadius * 2 + 10;

	endcapHeight = 6;

	endcapOuterRadius = outerRadius + 4;

	translate([xTranslate, 0, 0])
	endcap(height = endcapHeight,
			innerRadius = outerRadius,
			outerRadius = endcapOuterRadius);

}


module endcap(height = 10,
				innerRadius = 20,
				outerRadius = 24,
				endThickness = 3)
{
	union()
	{
		openCylinder(innerRadius = innerRadius,
						height = height, 
						outerRadius = outerRadius);

		endcap_end(height = endThickness,
					outerRadius = outerRadius);
	}
}

// support moduiles follow

module endcap_end(height, outerRadius)
{
	cylinder(h = height,
				r = outerRadius);
}


module rainmaker(height = 140,
                 innerRadius = 30,
                 outerRadius = 34,
				 rungsPerLevel = 1,
				 shellDecoration = "none",
				 showShell = "yes",
			 	 stepRadius = 2,
				 zDistanceBetweenRungs = 5,
			 	 zRotateAngle = 25)
{
    union()
    {
        // the main shell
		if(showShell == "yes")
		{
    		#
	        openCylinder(height = height,
	                     innerRadius = innerRadius,
	                     outerRadius = outerRadius);
		}

        bottomZ = 5;

        // the steps
        zStart = bottomZ;
        step_xLength = (innerRadius * 2) + 1;
        rainmaker_steps(height = height,
						outerRadius = outerRadius,
						rungsPerLevel = rungsPerLevel,
						shellDecoration = shellDecoration,
						stepRadius = stepRadius,
						step_xLength = step_xLength,
						zDistanceBetweenRungs = zDistanceBetweenRungs,
						zRotateAngle = zRotateAngle,
                        zStart = zStart);

        // the bottom
        cylinder(r=outerRadius, h=bottomZ);
    }
}

// suport modules follow

module rainmaker_steps(height,
						outerRadius,
						rungsPerLevel,
						shellDecoration,
						stepRadius,
						step_xLength,
						zDistanceBetweenRungs,
						zRotateAngle,
						zStart)
{
	zEnd = height - zDistanceBetweenRungs - stepRadius;

    for(z = [zStart : zDistanceBetweenRungs : zEnd])
    {
		xTranslate = 0;
        zTranslate = zStart + z;

		rotate([0, 0, zRotateAngle * z])
		union()
		{
			for(s = [1 : 1 : rungsPerLevel])
			{
				union()
				{
					stepColor  = s == 1 ? "yellow" :
								 s == 2 ? "green" :
								 s == 3 ? "orange" :
								 s == 4 ? "blue" :
								          "pink";

					angleDivision = 360.0 / rungsPerLevel;
				    zRotate = (angleDivision * (s-1) ) / 2;

					color(stepColor)
			        translate([xTranslate, 0, zTranslate])
					rotate([0, 90, zRotate])
			        cylinder(r = stepRadius,
								h = step_xLength,
								center = true);

					if(shellDecoration == "bumps")
					{
// The commented code below is to help debug why rotaion is not working for the bump.
// And it will be removed hopefully soon.						
//						bumpsRotate = (angleDivision * s) / s;
//						bumpsRotate = zRotate / s;
						bumpsRotate = zRotate;
//						bumpsRotate = s + 30;
//						bumpsRotate = 0;

//						echo("bumps", s, bumpsRotate);

						color(stepColor)
						translate([outerRadius, 0, zTranslate])
//rotate([bumpsRotate, 0, 0])
//rotate([0, 90, bumpsRotate])
						sphere(r=3);

// this is the bump on the 'other' end
						color(stepColor)
						translate([-outerRadius, 0, zTranslate])
//						rotate([0, 90, bumpsRotate * s])
						sphere(r=3);
					}
				}
			}
		}
    }
}

// TODO: Lower this to 50.
module openCylinder(height = 3,
                    outerRadius = 7,
                    innerRadius = 4.5,
                    fn = 100)
{
    $fn = fn;

    difference()
    {
        cylinder(r=outerRadius,
                 h=height);

        translate([0, 0, -1])
        cylinder(r=innerRadius,
                 h=height+1.01);
    }
}

// TODO: Lower this to 50.
module openCylinder(height = 3,
                    outerRadius = 7,
                    innerRadius = 4.5,
                    fn = 100)
{
    $fn = fn;

    difference()
    {
        cylinder(r=outerRadius,
                 h=height);

        translate([0, 0, -1])
        cylinder(r=innerRadius,
                 h=height+1.01);
    }
}