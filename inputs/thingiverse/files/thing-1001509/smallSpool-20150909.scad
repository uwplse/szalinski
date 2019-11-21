// Small Spool

// preview[view:south, tilt:bottom]

// Which one would you like to see?
part = "bottom"; // [bottom:Bottom half of spool (with label), top:Top half of spool, both: Both halves]
//part = "top"; 
//part = "both";

// Label Text (up to 10 characters)
spoolText = "1.75mm PLA";

// Spool Width
spoolWidth = 15; //[15:Small, 30:Medium, 50:Large]
 

/* [Hidden] */

innerSpoolRadius = 20;
outerSpoolRadius = 50;
discRadius = 80;
thickness = 1;

 
hexRadius = 10;
hexEdge = 2; 

 // Simple list comprehension for creating N-gon vertices
function ngon(num, r) = 
  [for (i=[0:num-1], a=i*360/num) [ r*cos(a), r*sin(a) ]];

module hexagon(){
    hexagon = 6;
    hexagonRadius = hexRadius; //outside distance from centre to point
    hexagonEdge = hexEdge;    // increasing edge makes hole smaller. but does not change outside size
    
    difference(){
        polygon(ngon(hexagon, hexagonRadius));
        offset(-hexagonEdge)
            polygon(ngon(hexagon, hexagonRadius));
    }
    
}

 module hexHoles(){
     //Apothem given the radius (distance from the center to a vertex):
     // r * cos(180/sides)
     apothem = hexRadius * cos(180/6); // = 15.32
     yOffset = apothem*2-hexEdge; //Actual = 15.32, est = 15.5;
     // the x & y offset for next column is defined by right hand triangle with angle of 30 deg
     // xOff = 2*hexRadius * cos(30);
     // yOff = 2 * hexRadius * sin(30);
     
     xOffset = yOffset-hexEdge; //13.32;
     columns = 13;
     rows = 13;
          
     for(x = [0:rows-1]){
         for(y = [0:columns-1]){
              translate([x*xOffset,y*yOffset+(x%2)*yOffset/2,0])hexagon();
         }
     }
  //   hexagon();
//     translate([0,15.5,0])hexagon();
//     translate([13.5,15.5/2,0])hexagon();
     
 }
 
 module bottomDisc(){
    //cylinder(r=discRadius, h = thickness);
     
     //hex pattern
     linear_extrude(height = thickness ){
        intersection(){
            difference(){
                circle(r=discRadius);
                circle(r=innerSpoolRadius);
            }
            translate([-discRadius, -discRadius,0]) hexHoles();
        }
 
      }
    
    // middle ring
    linear_extrude(height = thickness ){
        difference(){
            circle(r=discRadius, $fn = 100);
            circle(r=discRadius-5, $fn = 100);
        }
    }
    
    // outer ring
    linear_extrude(height = thickness ){
        difference(){
            circle(r=outerSpoolRadius+5, $fn = 100);
            circle(r=outerSpoolRadius-5, $fn = 100);
        }
    }
    
    //round outer rim
    rotate_extrude(convexity = 10, $fn = 100)
        translate([discRadius, thickness, 0])
            circle(r = thickness, $fn = 100);
    //round inner rim
    *rotate_extrude(convexity = 10)
        translate([innerSpoolRadius, thickness, 0])
            circle(r = thickness, $fn = 100);
    
    // rim at center
    linear_extrude(height = 5 ){
        difference(){
            circle(r=innerSpoolRadius+5, $fn = 100);
            circle(r=innerSpoolRadius-1, $fn = 100);
        }
    }
    
 }
 
 module outerSpool(changeSize = 0){
     rim = 2*thickness;
     linear_extrude(height = spoolWidth) {
         difference(){
             offset(rim) circle(r=outerSpoolRadius-changeSize,$fn = 100);
             circle(r=outerSpoolRadius-changeSize, $fn = 100);
         }
     }
 }
     
module t(t, s = 18, style = "") {
    scale([0.5,0.5,1])
        linear_extrude(height = thickness)
            text(t, size = s, halign = "center", valign = "center", font = str("Liberation Sans", style), $fn = 16);
}

 module spoolBottom(){
     cubeWidth = 80;
     cubeHeight = 10;

     //bottom
     difference(){
         union(){
            bottomDisc();
            outerSpool();
            translate([0,-60,thickness/2]) cube([cubeWidth,cubeHeight,thickness], center = true);
        }
        translate([0,-60,thickness*3/4]) rotate ([180,0,0]) translate([0,0,0]) t(spoolText);
     }
     
 }
 
 module spoolTop(){
  
     //top
    translate([0,0,1]) {
        translate([0,0,spoolWidth]) mirror([0,0,1]) bottomDisc();
        outerSpool(2.2);  // change this number to adjust fit
    }
     
 }
 
module spool(){
   spoolBottom();
   spoolTop();
   
} 

module print_part() {
	if (part == "bottom") {
		spoolBottom();
	} else if (part == "top") {
		spoolTop();
	} else if (part == "both") {
		spool();
	} else {
		spool();
	}
}

 
print_part();
// spool();