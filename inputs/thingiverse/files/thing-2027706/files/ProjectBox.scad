$fn=50;


LENGTH=30;
WIDTH=15;
RADIUS=1;
OFFSET=1;

//Parametric Version

difference() {
minkowski(){
    cube([WIDTH,LENGTH,10], center = true);
    sphere(RADIUS);
}

// Chop off the top

translate([0,0,5]) 
  cube([WIDTH + RADIUS*2 + OFFSET,
        LENGTH + RADIUS*2 + OFFSET,
        ,10], center = true);


// Hollow inside

minkowski(){
    cube([WIDTH - RADIUS - OFFSET,
          LENGTH - RADIUS - OFFSET
          ,8], center = true);
    sphere(RADIUS);
}

//Make a Ledge ( To receive top half later )
    translate([0,0,-1]) {
        linear_extrude(10) {
            minkowski(){
                square([WIDTH-OFFSET, LENGTH-OFFSET], center = true );
                circle(RADIUS);
            }
        }
    }
}

translate([20,0,0]){
      nonpara();
}

// Non-Parametric Version
module nonpara() {

    difference() {
    minkowski(){
        cube([10,20,10], center = true);
        sphere(1);
    }

    // Chop off the top

    translate([0,0,5]) cube([13,23,10], center = true);


    // Hollow inside

    minkowski(){
        cube([8,18,8], center = true);
        sphere(1);
    }


        translate([0,0,-1]) {
            linear_extrude(10) {
                minkowski(){
                    square([9,19], center = true );
                    circle(1);
                }
            }
        }
    }
    
}