length              = 193.3;
width               = 100;
height              = 100;
gutter              = 11;
tickness            = 5;
patternAngle        = 45;
patternLength       = 10;
patternWidth        = 10;
makePattern         = true;
makeConnectorHole   = true;

module support () {
    inclined = height > length / 2;
    tanAngle = atan((length+tickness)/height);
    cosAngle = acos(height/(length+tickness));
    sinAngle = asin(height/(length+tickness));
    
    translate([-width/2, -length/2, 0]) {
        difference() {
            union() {
                cube([width, length, tickness], 0);
                translate([0, length, 0]) {
                    cube([width, tickness, gutter + tickness], 0);
                }
                rotate([inclined ? sinAngle : 0 , 0, 0]) {   
                    difference() {
                        translate([0, 0, -height-tickness]) {
                            cube([width, tickness, height+tickness], 0);
                        }
  
                        if (!inclined) {
                            translate([-1, -tickness/2 , -height])
                            rotate([-tanAngle, 0, 0])
                            cube([width+2, tickness*2, tickness*2], 0);
                        }
                    }
                }
            }
            
            translate([-1, length, 0]) {
                rotate([inclined ? -cosAngle : -tanAngle, 0, 0]) {
                    cube([width+2, tickness, tickness*10]);
                }
            }
        }
    }
}

module connectorHole() {
    difference () {   
        translate([-6, length/2 - tickness * 3, 0]) {
            cube([12, tickness*4, gutter + tickness], 0);
        }
    }
}

module pattern() {
    diagonal = sqrt(pow(width, 2) + pow(length, 2));

    difference() {
        // create rectangle pattern
        rotate([0, 0, patternAngle]) {
            translate([-diagonal/2, -diagonal/2, 0]){
                cols = floor(diagonal / (patternLength + tickness)) - 1;
                lines = floor(diagonal / (patternWidth + tickness)) - 1;
                for(x = [0:cols], y = [0:lines]) {
                    translate([tickness + (x * (patternLength + tickness)), tickness + ( y * (patternWidth + tickness)), 0]) {
                        cube([patternLength, patternWidth, tickness], 0);
                    }
                }
            }
        }
        
        // create hole structure for the main diff
        difference() { 
            rotate([0, 0, patternAngle]) { 
                translate([-diagonal/2, -diagonal/2, -tickness]){
                        cube([diagonal, diagonal, tickness * 3], 0);
                }
            }
            translate([-width/2 + tickness, -length/2 + tickness, -tickness*2]) {
                cube([width - (tickness * 2), length - tickness, tickness*5], 0);
            }
        }
    }
}


difference(){
    support();
    if (makePattern) pattern();
    if (makeConnectorHole) connectorHole();
}