//Milan Peksa 2016 V1.0
// Creative Commons - Attribution - Non-Commercial

// Which one would you like to see?
part = "both"; // [1:Hyperbola,2:Parabola,3:Ellipse,4:Core,5:Circle,6:Bottom text check]
// BOTTOM TEXT 1. line
note1="    MILAN PEKSA";
// BOTTOM TEXT 2. line
note2="2016";

// DESCRIPTION TEXT ELLIPSA
mellipse="ELIPSA";
// DESCRIPTION TEXT HYPERBOLA
mhyperbola="HYPERBOLA";
// DESCRIPTION TEXT PARABOLA
mparabola="PARABOLA";
// DESCRIPTION TEXT CIRCLE
mcircle="KRUŽNICE";
// MAGNETS HOLES SWITCH
magnetsholes=true; // [true,false]
// Number Of Fragments
NoFragments=50;


print_part();



//color("red") {translate([5,0,0])  hyperbola($fn=NoFragments);};
//color("blue") {translate([-5,0,0])parabola($fn=NoFragments);};
//color("cyan") {translate([0,0,5])ellipse($fn=NoFragments);};
//rotate([180,0,0]) ellipse($fn=NoFragments); // for  printing
//color("green") {core($fn=NoFragments);};
//color("purple") {translate([0,0,10])ncircle($fn=NoFragments);};

//http://www.dx.com/p/3x3mm-ndfeb-magnet-silver-60pcs-415498#.V0yINPmLSUk

module print_part() {
	if (part == 1) {
		rotate([0,0,180]) hyperbola($fn=NoFragments);
	} else if (part == 2) {
		parabola($fn=NoFragments);
	} else if (part == 3) {
		rotate([180,0,180]) ellipse($fn=NoFragments); 
	} else if (part == 4) {
		core($fn=NoFragments);
	} else if (part == 5) {
		ncircle($fn=NoFragments);
	} else if (part == 6) {
		BootomTextCheck($fn=NoFragments);
	}
}


module BootomTextCheck()
{
    rotate([90,0,270])
     { hyperbola($fn=NoFragments);
     parabola($fn=NoFragments);
     core($fn=NoFragments);}; 
    
}

module core()
{
 
difference() {
    cylinder(h = 200, r1 = 100, r2 = 0, center = false);

    translate([5,0,175]) 
	rotate([0,-65,0]) 
		cube([150,220,250],center=true); 
   
    translate([-65,0,0]) 
	rotate([0,-26.565051177077989351572193720453,0]) 
		cube([100,220,180],center=true);
    
    translate([120,0,20]) 
    rotate([0,0,0]) 
    cube([100,220,180],center=true);

   {//parabola
      rotate([0,-26.565051177077989351572193720453,0])
    translate([-8, 58,30])
    rotate([90,0,-90])
    linear_extrude(height = 4, center = true, convexity = 10, twist = 0)
    {
    text(mparabola,size=15 ,font = "Open Sans:style=Bold");
    }
   } 
   
   {// hyperbola
    translate([70, -44,15])
    rotate([90,0,90])
    linear_extrude(height = 4, center =     true, convexity = 10, twist = 0)
    {
    text("HYPERBOLA", font =  "Open Sans:style=Bold");
    }
}
    
   {// elipsa
    translate([19, -35,86])
    rotate([25,0,90])
    linear_extrude(height = 4, center =     true, convexity = 10, twist = 0)
    {
    text(mellipse,size=15, font = "Open Sans:style=Bold");
    }
    
    // notes
    translate([93,-5,0])
    rotate([0,180,00])
    linear_extrude(height = 4, center =     true, convexity = 10, twist = 0)
    {
    text(note1,size=15, font =  "Open Sans:style=Bold");
    }
    translate([65,-60,0])
    rotate([0,180,00])
    linear_extrude(height = 4, center =     true, convexity = 10, twist = 0)
    {
    text(note2,size=30, font =  "Open Sans:style=Bold");
    }
    if(magnetsholes)
    {
        //magnets holes
    {// magnets holes hyperbola
    translate([70-3.2,55,7]) 
	rotate([0,90,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([70-3.2,-55,7]) 
	rotate([0,90,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([70-3.2,0,47]) 
	rotate([0,90,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
    }
 //magnets holes parabola
    {
    translate([-15-3.2,75,12]) 
	rotate([0,63,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([-15-3.2,-75,12]) 
	rotate([0,63,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([-48-3.2,-20,77]) 
	rotate([0,63,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
    
    translate([-48-3.2,20,77]) 
	rotate([0,63,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
    }
    
 
    //magnets holes elipsa
    {
    translate([-15-3.2,30,96+3.2]) 
	rotate([0,25,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([-15-3.2,-30,96+3.2]) 
	rotate([0,25,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
    
    translate([40,30,69+3.2]) 
	rotate([0,25,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
    
    translate([40,-30,69+3.2]) 
	rotate([0,25,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
    }
}
}
}
}
//--------------------------------------
module ncircle()
{
    difference() {    
    intersection() {
    cylinder(h = 200, r1 = 100, r2 = 0, center = false);

    translate([0,0,170]) 
    cube([150,220,80],center=true);
    


}
    translate([-30, 4,130])
    rotate([180,0,0])
    linear_extrude(height = 4, center =     true, convexity = 10, twist = 0)
    {
    text(mcircle,size=8, font ="Open Sans:style=Bold");
    }
    if(magnetsholes)
    {
    // magnets holes kruznice    
    translate([0,-23,130-3.2]) 
	rotate([0,0,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([0,23,130-3.2]) 
	rotate([0,0,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);   

    } 
}
}


//--------------------------------------
module ellipse()
{
    difference() {    
    intersection() {
    cylinder(h = 200, r1 = 100, r2 = 0, center = false);

    translate([5,0,175]) 
	rotate([0,-65,0]) 
		cube([150,220,250],center=true); 

}
    translate([0,0,170]) 
    cube([150,220,80],center=true);

    translate([19, 35,86])
    rotate([-25,180,90])
    linear_extrude(height = 4, center =     true, convexity = 10, twist = 0)
    {
    text("ELIPSA",size=15, font ="Open Sans:style=Bold");
    }
    
    translate([-30, -4,130])
    rotate([0,0,0])
    linear_extrude(height = 4, center =     true, convexity = 10, twist = 0)
    {
    text(mcircle,size=8, font ="Open Sans:style=Bold");
    }
    if(magnetsholes)
    {
     //magnets holes
    {
    translate([-15-3.2,30,96+3.2]) 
	rotate([0,25,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([-15-3.2,-30,96+3.2]) 
	rotate([0,25,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([40,30,69+3.2]) 
	rotate([0,25,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
    
    translate([40,-30,69+3.2]) 
	rotate([0,25,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
    
    // magnets holes kruznice    
    translate([0,-23,130-3.2]) 
	rotate([0,0,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([0,23,130-3.2]) 
	rotate([0,0,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);   
    
}
}
} 
}
//--------------------------------------
module parabola()
{
    difference() {
    intersection()
    {
    cylinder(h = 200, r1 = 100, r2 = 0, center = false);
    translate([-65,0,0]) 
	rotate([0,-26.565051177077989351572193720453,0]) 
		cube([100,220,180],center=true); 

    }

    rotate([0,-26.565051177077989351572193720453,0])
    translate([-8, -57,30])
    rotate([90,0,90])
    linear_extrude(height = 4, center = true, convexity = 10, twist = 0)
    {
   text(mparabola,size=15 ,font = "Open Sans:style=Bold");
    }
 
    // notes
    translate([93,-5,0])
    rotate([0,180,00])
    linear_extrude(height = 4, center =     true, convexity = 10, twist = 0)
    {
    text(note1,size=15, font =  "Open Sans:style=Bold");
    }
    translate([65,-60,0])
    rotate([0,180,00])
    linear_extrude(height = 4, center =     true, convexity = 10, twist = 0)
    {
    text(note2,size=30, font = "Open Sans:style=Bold");
    }
    
    if(magnetsholes)
    {
     //magnets holes
    {
    translate([-15-3.2,75,12]) 
	rotate([0,63,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([-15-3.2,-75,12]) 
	rotate([0,63,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
    
    translate([-48-3.2,-20,77]) 
	rotate([0,63,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
        
    translate([-48-3.2,20,77]) 
	rotate([0,63,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
}
}
}


}
//--------------------------------------
module hyperbola()
{
    difference() {
    intersection()
    {
    cylinder(h = 200, r1 = 100, r2 = 0, center = false);
       translate([120,0,20]) 
        rotate([0,0,0]) 
            cube([100,220,180],center=true); 

    }

    translate([70, 42,15])
    rotate([90,0,-90])
    linear_extrude(height = 4, center = true, convexity = 10, twist = 0)
    {
    text(mhyperbola, font = "Open Sans:style=Bold");
    }
    // notes
    translate([93,-5,0])
    rotate([0,180,00])
    linear_extrude(height = 4, center =     true, convexity = 10, twist = 0)
    {
    text(note1,size=15, font ="Open Sans:style=Bold");
    }
    translate([65,-60,0])
    rotate([0,180,00])
    linear_extrude(height = 4, center =     true, convexity = 10, twist = 0)
    {
    text(note2,size=30, font ="Open Sans:style=Bold");
    }
    if(magnetsholes)
    {
    //magnets holes
{
    translate([70-3.2,55,7]) 
	rotate([0,90,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([70-3.2,-55,7]) 
	rotate([0,90,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);

    translate([70-3.2,0,47]) 
	rotate([0,90,0])
    cylinder(h = 6.4, r1 = 1.5, r2 = 1.5, center = false);
}
}
}

}
