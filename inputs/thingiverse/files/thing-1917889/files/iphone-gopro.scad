
// part to render
part = "assembly"; // [bottom:Bottom,top:Top,print:For printing,assembly:Whole assembly]

// quality
$fn = 50;

// GoPro connector
goproConnector = "triple"; // [double,triple]

// diameter of edge of phone (6 to 15mm are good values)
edgeDiameter = 9;

// width of clamping area of phone
clampWidth = 50; // [20:100]

// minimal clamp height; a few millimeters less than the height of the phone
minClampHeight = 67; // [20:100]

// clamp range
clampRange = 20; // [10:50]

// clamp sides of phone; if true, clamp is enclosed on both sides
clampSides = 0; // [0:false,1:true]

// minimal wall thickness
thickness = 2.5; // [1:0.1:5]

// width of spring wire (0.5 to 5mm are good values)
springWireDiameter = 3;

// diameter of lock spring wire (0.5 to 2mm)
lockSpringWireDiameter = 1.5;

// spring box dimension (width and height)
springBoxSquareDimension = 12; // [10:20]

// tolerance between tubes (0 to 3mm are good values)
tubeTolerance = 1.2;

/* [Hidden] */

// internal variables
__minClampDim = minClampHeight - edgeDiameter;
__realClampWidth = (clampSides == 1) ? (clampWidth + 2*thickness) : clampWidth;

module phoneEdge() {
  translate ([0, __realClampWidth/2, 0])
  rotate ([90,0,0])
  linear_extrude (height=__realClampWidth, convexity=3)
  difference() {
    circle (d=edgeDiameter + thickness, center=true);
    translate ([-edgeDiameter/2-thickness/2, 0]) square (size=edgeDiameter + thickness, center=true);
    circle (d=edgeDiameter, center=true);
  }
}

module tube (height, dimension) {
  difference() {
    cube ([dimension + 2*thickness, dimension + 2*thickness, height], center=true);
    translate([0,0,-0.05]) cube ([dimension - 0.1, dimension - 0.1, height + 0.2], center=true);
  }
}

module topCover() {
  bOffset = -springBoxSquareDimension/2 - edgeDiameter/2 - thickness;
  
  difference() {
    union() {  
      phoneEdge();
      translate([-thickness/2, 0, bOffset]) rotate([0,90,0]) {
        // cover
        union() {
          rotate([0,0,90]) difference() {
            pom = thickness * 2 + lockSpringWireDiameter;
            cube ([springBoxSquareDimension - 0.2, springBoxSquareDimension - 0.2, pom], center=true);
            cube ([springWireDiameter, 100, pom + 0.1], center=true);
          }
          translate ([0,0,thickness-0.1]) cube ([springBoxSquareDimension + 2*thickness, springBoxSquareDimension + 2*thickness, thickness], center=true);
        }
      }
      
      // gopro connector
      translate([10 + 4 * thickness, 0, -springBoxSquareDimension+edgeDiameter/2]) rotate([0, 90, 90]) gopro_connector (goproConnector);
      
      // hull connection between elements
      difference() {
        hull() {
          translate([4 * thickness,0,-springBoxSquareDimension+edgeDiameter/2]) rotate([0,90,0]) cylinder (d=springBoxSquareDimension + 2*thickness + edgeDiameter/2, h=1);
          translate([thickness,0,bOffset]) cube ([2*thickness, springBoxSquareDimension + 2*thickness, springBoxSquareDimension + 2*thickness], center=true);   
          phoneEdge();
        }
        translate ([0, clampWidth/2 + 0.05, 0]) rotate ([90,0,0]) linear_extrude (height=clampWidth + 0.1, convexity=3) circle (d=edgeDiameter, center=true);
      }
      
      
      translate([-__minClampDim/2, 0, bOffset]) rotate([0,90,0]) difference() {
        tube (__minClampDim, springBoxSquareDimension);
        translate ([-springBoxSquareDimension/2-thickness/2-0.2,0,0]) cube ([thickness, springBoxSquareDimension/2, __minClampDim+0.1], center=true);
      }
    }
    // hole for lock wire
    translate([-thickness/2,0,bOffset]) rotate([90,0,0]) cylinder (d = lockSpringWireDiameter, h = springBoxSquareDimension * 2, center=true);
  }
}

module bottomCover() {
  pom2 = springBoxSquareDimension - 2*thickness - tubeTolerance;
  pom = thickness * 2 + lockSpringWireDiameter;
  
  difference() {
    rotate([0,90,0]) union() {
      rotate([0,0,90]) difference() {
        cube ([pom2, pom2, pom], center=true);
        cube ([springWireDiameter, 100, pom + 0.1], center=true);
      }
      translate ([0,0,thickness-0.1]) cube ([springBoxSquareDimension + 2*thickness, springBoxSquareDimension + 2*thickness, thickness], center=true);
      translate ([0,0,-clampRange/2+thickness/2]) tube (clampRange, pom2);
    }
    rotate([90,0,0]) cylinder (d = lockSpringWireDiameter, h = springBoxSquareDimension * 2, center=true);  
  }
  
  translate([thickness/2,0,-springBoxSquareDimension/2-edgeDiameter/2-thickness]) phoneEdge();

  difference() {  
    hull() {
      edgePos = -springBoxSquareDimension/2-edgeDiameter/2-thickness;
      botDia = springBoxSquareDimension + edgeDiameter;
      
      translate([thickness+0.1,0,0]) rotate([0,90,0])cube ([springBoxSquareDimension + 2*thickness, springBoxSquareDimension + 2*thickness, thickness], center=true);
      translate([thickness/2,0,edgePos]) phoneEdge();
      translate([4 * thickness + edgeDiameter/6, 0, edgePos+botDia/2-edgeDiameter/2-thickness/2]) rotate([0,90,0]) cylinder (d=botDia, h=1);
    }
    translate([thickness/2, clampWidth/2 + 0.05, -springBoxSquareDimension/2-edgeDiameter/2-thickness]) rotate ([90,0,0]) linear_extrude (height=clampWidth + 0.1, convexity=3) circle (d=edgeDiameter, center=true);
  }
}

module assembly() {
  translate([-minClampHeight-clampRange/2-edgeDiameter,0,-springBoxSquareDimension - tubeTolerance/2 - edgeDiameter/2 + thickness + tubeTolerance/2]) rotate([0,180,0]) bottomCover();
  topCover();
}

module forPrint() {
  translate([0,0,springBoxSquareDimension+edgeDiameter+thickness/2]) topCover();
  translate([-25, 60, springBoxSquareDimension]) rotate([0,90,0]) bottomCover();
}

module print_part() {
	if (part == "top") {
		topCover();
	} else if (part == "bottom") {
		rotate([0,90,0]) bottomCover();
  } else if (part == "print") {
    forPrint();
	} else {
		assembly();
	}
}

print_part();

/** End of my code */

/**
 * This is part of http://www.thingiverse.com/thing:62800. I'am copy this there to make thing
 * compact for Thingiverse Customizer.
*/

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

module gopro_torus(r,rnd) {
	translate([0,0,rnd/2])
		rotate_extrude(convexity= 10)
			translate([r-rnd/2, 0, 0])
				circle(r= rnd/2, $fs=0.2);
}


module gopro_connector(version="double", withnut=true, captive_nut_th=0, captive_nut_od=0, captive_rod_id=0, captive_nut_angle=0) {
	module gopro_profile(th) {
		hull() {
			gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
			translate([0,0,th-gopro_connector_roundness])
				gopro_torus(r=gopro_connector_z/2, rnd=gopro_connector_roundness);
			translate([-gopro_connector_z/2,gopro_connector_z/2,0])
				cube([gopro_connector_z,gopro_wall_th,th]);
		}
	}
	difference() {
		union()	{
			if(version=="double") {
				for(mz=[-1:2:+1]) scale([1,1,mz])
						translate([0,0,gopro_connector_th3_middle/2 + (gopro_connector_gap-gopro_connector_th2)/2]) gopro_profile(gopro_connector_th2);
			}
			if(version=="triple") {
				translate([0,0,-gopro_connector_th3_middle/2]) gopro_profile(gopro_connector_th3_middle);
				for(mz=[-1:2:+1]) scale([1,1,mz])
					translate([0,0,gopro_connector_th3_middle/2 + gopro_connector_gap]) gopro_profile(gopro_connector_th3_side);
			}

			// add the common wall
			translate([0,gopro_connector_z/2+gopro_wall_th/2+gopro_connector_wall_tol,0])
				cube([gopro_connector_z,gopro_wall_th,gopro_connector_z], center=true);

			// add the optional nut emboss
			if(version=="triple" && withnut) {
				translate([0,0,gopro_connector_z/2-gopro_tol])
				difference() {
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


