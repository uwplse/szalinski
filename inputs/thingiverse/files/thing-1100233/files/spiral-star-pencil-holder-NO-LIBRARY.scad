
charmName = "balloon"; // [star, balloon, blue-moon, pacman, Spurs]

charmCount = 28; // [1:100]

charmXYScale = 0.9;   // [0.1:0.1:5]

cupHeight = 150; // [75:300]

/* [Hidden] */
maxRandom = 0;
charmIndcies = rands(0,maxRandom, charmCount);


charmXYScales = rands(charmXYScale, charmXYScale, charmCount);

depthScale = 40.2;
charmDepthScales = rands(depthScale, depthScale, charmCount);


difference()
{
	cup(cupHeight=cupHeight);

	// uses the default value for the charmStls parameter
	rotatedCutouts(charmCount = charmCount,
				   charmIndcies = charmIndcies,
				   charmXYScales = charmXYScales,
				   charmDepthScales = charmDepthScales,
				   charmStls = ["../../../../shapes/star/star.stl"]);
}


//use <../../../../shapes/cup/cup.scad>;
/**
  * Create a cylindrical cup.
  */
module cup(cupHeight=70, innerRadius=53)
{
	difference()
	{
		centered = false;
	
		// outer part of the cup
		translate([0,0,0])
		cylinder (h = cupHeight, r=55, center = centered, $fn=100);
		
		// subtracted inner cup
		translate([0,0,5])
		cylinder (h = cupHeight, r=innerRadius, center = centered, $fn=100);
	}
}

//use <../../../../cutouts/rotated-spiral-cutouts.scad>;
/**
  * This is a library for evenly spaced cutouts.
*/
module rotatedCutouts(charmCount = 16,
					  charmXYScales,
					  charmStls = ["../shapes/oshw/oshw.stl"],
					  charmIndcies = [],  // the vector of array index needs required
					  charmDepthScales,
					  yTranslateFactor = 5,
					  yTranslateMinimum = 0,
					  zRotationFactor = 30)
{
    for ( i = [0 : charmCount-1] )
    {

        single_rand = charmIndcies[i];

        charmIndex = round(single_rand);
        
		yTranslate = (i * yTranslateFactor) + yTranslateMinimum;
		
		zRotation = i * zRotationFactor;
		
        rotate([
                90, 
                0,
                zRotation
        ])
        // normally x,y,z - but here y moves the little spurs up and down
        translate([15, yTranslate, 30])
        scale([
		       charmXYScales[charmIndex], 
			   charmXYScales[charmIndex], 
			   charmDepthScales[charmIndex] //20.2])
			 ])
//        import(charmStls[charmIndex])
//		star(1);
		
		if(charmName == "balloon")
		{
			echo("no sucka!");
			balloon();
		}
		else if(charmName == "blue-moon")
		{
			blueMoon();
		}
		else if(charmName == "pacman")
		{
			pacman();
		}
		else if(charmName == "Spurs")
		{
			spursa(5);
		}
		else
		{
			// star is the default	
			star(1);
		}
		
    }
}

// from the OpenSCAD tutotials
module star_poly_Selection(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[9.080000,-22.000000],[10.922500,-17.093750],[12.213125,-14.728281],[13.890000,-13.020000],[15.773906,-12.298125],[18.041250,-12.022500],[22.500000,-11.910000],[34.390000,-10.968750],[40.862812,-10.133906],[45.500000,-9.000000],[28.500000,4.610000],[21.270000,12.170000],[22.870000,22.000000],[27.500000,43.000000],[8.500000,31.580000],[-0.500000,27.200000],[-10.500000,32.320000],[-28.500000,43.000000],[-22.870000,21.000000],[-21.690000,11.090000],[-28.500000,4.130000],[-45.500000,-11.000000],[-11.500000,-13.000000],[-0.500000,-43.000000],[2.289219,-38.828594],[4.908750,-33.096250],[9.080000,-22.000000]]);
  }
}

module star(h)
{
	star_poly_Selection(h);
}


// ../../../../shapes/balloon/balloon.scad
module balloon()
{
	union () 
	{
		// balloon
		scale ([0.8, 1, 1]) 
		cylinder (h = 4, r=10, center = true, $fn=100);
		
		// middle knot piece
		knotPiece();

		// left knot piece
		rotate ([0, 0, -6.5])
		knotPiece();
		
		// right knot piece
		rotate ([0, 0, 6.5])
		knotPiece();
	}	
}

module knotPiece()
{
	translate ([0, -10.5, 0]) 
	scale ([0.3, 0.8, 1]) 
	cylinder (h = 4, r=2, center = true, $fn=100);
}



// ../../../../shapes/blue-moon/blue-moon.scad
module blueMoon()
{
	difference() 
	{ 
		// blue moon
		cylinder (h = 4, r=10, center = true, $fn=100);
		
		// top cutout
		translate([5, 5, 0]) 
		cylinder (h = 4.20, r=6, center = true, $fn=100);
				
		// bottom cutout
		translate([5, -5, 0]) 
		cylinder (h = 4.20, r=6, center = true, $fn=100);
		
		// remainder cutout
		translate([10, 0, 5]) 
		color("red")
		cylinder (h = 14.20, r=6, center = true, $fn=100);			
	}
}

// http://www.thingiverse.com/thing:241081/
module pacman()
{
	//linear_extrude(height=50, center=true, convexity = 10, twist = 0) 
	difference () 
	{
	  cylinder(r=20, center=true, h=5);
	  
	  linear_extrude(height=10, center= true)
	//  linear_extrude(height=50, center=true, convexity = 10, twist = 0) 
	//  {
		  polygon(points=[[0,0],[100,60],[100,-60]], paths=[[0,1,2]]);
	//  };
	}
}

//pacman();


// http://www.thingiverse.com/thing:603115
module poly_Selection(h)
{
  scale([25.4/90, -25.4/90, 1]) union()
  {
    linear_extrude(height=h)
      polygon([[13.500000,-56.000000],[29.500000,-55.000000],[54.500000,-55.000000],[58.503750,-55.048750],[60.522969,-55.341719],[62.290000,-56.020000],[64.325156,-57.853594],[66.241250,-60.541250],[69.240000,-66.000000],[80.500000,-87.000000],[106.280000,-135.000000],[118.870000,-159.000000],[122.780000,-198.000000],[124.023594,-204.882813],[125.843750,-209.652500],[128.457031,-214.095937],[132.080000,-220.000000],[148.490000,-248.000000],[153.376719,-256.487656],[155.041895,-259.143652],[156.518750,-260.956250],[158.055137,-262.086816],[159.898906,-262.696719],[165.500000,-263.000000],[214.500000,-263.000000],[214.500000,-213.000000],[213.360000,-196.000000],[213.360000,-154.000000],[213.495000,-150.462500],[213.360000,-147.000000],[196.920000,-117.000000],[156.350000,-45.000000],[125.920000,9.000000],[120.671250,18.592500],[117.385469,23.577187],[115.794199,25.366055],[114.320000,26.400000],[112.797344,26.797500],[110.981250,26.970000],[107.500000,27.000000],[79.500000,27.000000],[65.500000,28.000000],[31.500000,28.000000],[27.943750,28.030000],[24.500000,28.600000],[22.684180,29.597539],[20.548438,31.277812],[15.792500,35.922500],[7.670000,45.000000],[-36.500000,94.040000],[-25.500000,94.040000],[-15.500000,95.000000],[1.500000,95.000000],[22.500000,96.000000],[2.500000,114.080000],[-38.500000,149.000000],[-23.230000,165.000000],[-3.230000,188.000000],[14.500000,210.000000],[-66.500000,189.000000],[-91.500000,263.000000],[-92.970664,261.624141],[-94.426562,259.592500],[-97.197500,254.302500],[-101.500000,244.000000],[-121.500000,198.000000],[-200.500000,222.000000],[-174.840000,182.000000],[-154.500000,151.000000],[-187.500000,128.020000],[-214.500000,108.000000],[-166.500000,103.830000],[-135.500000,101.000000],[-137.410000,77.000000],[-139.590000,41.000000],[-140.500000,31.000000],[-138.108496,32.343340],[-135.722969,34.055469],[-131.038750,38.223750],[-122.500000,47.000000],[-111.500000,57.040000],[-94.500000,74.000000],[-77.500000,27.000000],[-107.500000,26.000000],[-117.196250,25.451250],[-122.812656,24.814531],[-126.090000,23.980000],[-127.513906,22.488438],[-128.773750,20.335000],[-130.730000,16.000000],[-138.200000,-1.000000],[-140.195000,-5.868750],[-140.649688,-8.406719],[-140.330000,-11.000000],[-134.780000,-21.000000],[-120.780000,-45.000000],[-74.650000,-124.000000],[-55.110000,-158.000000],[-46.570000,-206.000000],[-30.280000,-238.000000],[-21.920000,-254.000000],[-19.818750,-257.793750],[-18.535156,-259.646094],[-17.110000,-260.980000],[-15.251406,-261.684844],[-12.943750,-261.983750],[-8.500000,-261.990000],[5.500000,-261.000000],[19.500000,-261.000000],[31.500000,-260.040000],[43.500000,-260.040000],[43.500000,-217.000000],[44.500000,-200.000000],[44.500000,-162.000000],[43.800000,-154.000000],[28.100000,-127.000000],[-14.500000,-56.000000],[13.500000,-56.000000]]);
  }
}

module spursa(h)
{
	poly_Selection(h);
}
