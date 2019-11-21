ringSize=0; // [0:0.25:16]

module ring(message,outerDiameter,innerDiameter,height)
{
    letterHeight=0.5;
    
    // major ring and triangle corner
	module shapeA() {
		difference() {
            union() {
                // corner
                translate([outerDiameter+7,0,0])
                    cube([16,8,height],true,$fn=90);
                // outer ring
                cylinder(height,outerDiameter,outerDiameter,true,$fn=90);
            }
            // interior hole
            cylinder(height*2,innerDiameter,innerDiameter,true,$fn=90);
            // tiny hole for management
			translate([outerDiameter+11,0,0])
				cylinder(height*2,2,2,true,$fn=45/2);
		}
	}

    // rounded corner near the small hole
	module roundedCorner() {
		difference() {
			translate([outerDiameter,outerDiameter,0])
				cube([8,8,height*2],true);
			translate([outerDiameter-4,outerDiameter-4,0])
				cylinder(height*2,4,4,true,$fn=90);
		}		
	}

    // text on the side
    module letters() {
        translate([outerDiameter-14,outerDiameter-letterHeight/2,-(height-1)/2])
        rotate([90,0,180])
            linear_extrude(letterHeight)
                text(message,
                    font="Liberation Sans",
                    size=height-1,
                    halign="right");
    }

    // fillets on interior curve
    module fillets() {
        color([1,0,0])
            cylinder(height*2,innerDiameter-height-1.5,innerDiameter+height-1.5,true);
        color([1,0,0])
            rotate([0,180,0])
                cylinder(height*2,innerDiameter-height-1.5,innerDiameter+height-1.5,true);
    }
    
    // put the various pieces together
	module finalAssembly() {
        difference() {
            shapeA();
            letters();
            fillets();
        }
	}
	
    // do it!
    finalAssembly();
}

module ringMaker(ringSize) {
	function stod(s)= 0.8128 * s + 11.63;

    d = stod(ringSize)/2;
    if((ringSize%1)==0) {
        label = str(ringSize,".00");
        ring(label,d+3,d,4);
    } else {
        label = str(ringSize);
        ring(label,d+3,d,4);
    }
}

ringMaker(ringSize);

