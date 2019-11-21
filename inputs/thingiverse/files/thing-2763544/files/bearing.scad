/* [Basic] */

// Which one would you like to see?
part = "all"; // [all:Everything, outer: Outer Race, inner:Inner Race, roller:One Roller, retainer: One Retainer, section:Cross section]

// Render quality
$fn=200; //[20:Fast viewing, 200:Quality printing]

// Outer radius
outerRadius = 18;  //[14:0.5:50]

// Inner radius
innerRadius = 6;  //[3.5:0.5:45]

// Width
width = 13;  //[10:0.5:50]

// Tolerance (extra space between rollers and races)
tolerance = 0.2;  //[0.05:0.05:0.5]

// Number of rollers
numRollers = 7;  //[3:50]

/* [Advanced] */

// Thickness of walls (should be a multiple of your nozzle diameter)
wallThickness = 0.8;  //[0.1:0.1:5]

raceLipWidth = 2;

rollerHoleRadius = 2;

retainerBaseHeight = 0.6;  //[0.2:0.1:1]

outerRace = outerRadius - wallThickness;
innerRace = innerRadius + wallThickness;
rollerRadius = (outerRace - innerRace)/2 - tolerance;
rollerCentreDistance = innerRadius+wallThickness+tolerance+rollerRadius;
rollerHeight = width-2*(1+tolerance/0.707); 
rollerVerticalOffset= 1+tolerance/0.707;

//echo (rollerRadius);

module outerHalf(){
    difference(){
        cylinder(width/2, outerRadius, outerRadius);
             
        translate([0,0,raceLipWidth+0.98])
        cylinder(width, outerRace, outerRace);
        
        //race lip
        translate([0,0,0.99])
        cylinder(raceLipWidth, outerRace-raceLipWidth, outerRace);
        
        translate([0,0,-0.02])
        cylinder(1.02, outerRace-raceLipWidth, outerRace-raceLipWidth);
        
        //chamfer
        translate([0,0,-0.02])
        difference(){
            cylinder(2, outerRadius+1, outerRadius+1);
            cylinder(2, outerRadius-1, outerRadius+1);
            
        }
    }
}

module outer(){
    difference(){
        union(){
            outerHalf();
            translate([0,0,width])
            mirror([0,0,1])
            outerHalf();
        }
        translate([rollerCentreDistance,0,width/2])
        cylinder(width, rollerRadius, rollerRadius);
    }
}

module innerHalf(){
    difference(){
        union(){
            translate([0,0,1+raceLipWidth])
            cylinder(width/2 + 1, innerRace, innerRace);
            
            translate([0,0,0.99])
            cylinder(raceLipWidth + 0.01, innerRace+raceLipWidth, innerRace);
            
            translate([0,0,-0.01])
            cylinder(1.01, innerRace+raceLipWidth, innerRace+raceLipWidth);
        }
        
        //centre hole
        translate([0,0,-1])
        cylinder(width+2, innerRadius, innerRadius);
        
        //chamfer
        translate([0,0,-0.02])
        cylinder(2, innerRadius+1, innerRadius-1);
    }
}

module inner(){
    difference(){
        union(){
            innerHalf();
            translate([0,0,width])
            mirror([0,0,1])
            innerHalf();
            }
        translate([rollerCentreDistance,0,width/2])
        cylinder(width, rollerRadius, rollerRadius);
    }
}

module rollerHalf(){
    rollerOuterChamferHeight = raceLipWidth+1 - rollerVerticalOffset+tolerance*2;
    difference(){
        union(){
            translate([0,0,rollerOuterChamferHeight])
            cylinder(width/2-wallThickness, rollerRadius, rollerRadius);
            
            cylinder(rollerOuterChamferHeight, rollerRadius-rollerOuterChamferHeight, rollerRadius);
        }

            translate([0,0,wallThickness+(rollerRadius-wallThickness) - rollerHoleRadius-0.01])
            cylinder(width, rollerRadius-wallThickness, rollerRadius-wallThickness);
            
            translate([0,0,wallThickness])
            cylinder((rollerRadius-wallThickness) - rollerHoleRadius, rollerHoleRadius, rollerRadius-wallThickness);
        
        
        translate([0,0,-1])
        cylinder(width, rollerHoleRadius, rollerHoleRadius);
        
        
    }
}

module roller(){
    rollerHalf();
    
    translate([0,0, rollerHeight])
    mirror([0,0,1])
    rollerHalf();
}

module rollers(){
    for (angle=[0:360/numRollers:360])
        rotate([0,0,angle])
        translate([rollerCentreDistance,0,0])
        roller();
}

module pin(){
    translate([-0.707*(wallThickness+rollerHoleRadius),0,wallThickness+tolerance*2+0.707*wallThickness+rollerHoleRadius])
    rotate([0,45,0])
    translate([0.84,0,(wallThickness+rollerHoleRadius)/4])
    cube([1.2*.707, 1.2, (wallThickness+rollerHoleRadius)/2], center=true);
    
    translate([0,0,wallThickness+tolerance*2])
    rotate([0,-45,0])
    translate([0,0,(wallThickness+rollerHoleRadius)/2])
    cube([1.2*.707, 1.2, wallThickness+rollerHoleRadius], center=true);
    
    translate([0,0,(rollerVerticalOffset+wallThickness)/2])
    cube([1.2, rollerHoleRadius*2-1.6, rollerVerticalOffset+wallThickness], center=true);
}

module retainer(){
    difference(){
        cylinder(retainerBaseHeight,rollerCentreDistance+1,rollerCentreDistance+1);
        translate([0,0,-1])
        cylinder(4,rollerCentreDistance-1,rollerCentreDistance-1);
    }

    for (angle=[0:360/numRollers:360])
        rotate([0,0,angle])
        translate([rollerCentreDistance,0,0])
        pin();
}

module all(){
    translate([0,0,0.01])
    retainer();
    
    translate([0,0,width])
    mirror([0,0,1])
    retainer();

    translate([0,0,rollerVerticalOffset])
    rollers();

    inner();
    outer();
}

module section(){
    difference(){
        all();
        translate([0,-50,-1])
        cube([50,50,50]);
    }
}

module printPart(){
    if (part == "all") {
		all();
	} else if (part == "outer") {
		outer();
	}else if (part == "inner") {
		inner();
    }else if (part == "roller") {
		roller();
    }else if (part == "retainer") {
		retainer();
    }else if (part == "section") {
		section();
	}  
}

printPart();

//retainer();

//rollerHalf();
//roller();
//translate([0,0,2])
//rollers();

//inner();
//outer();

//all();
//section();


