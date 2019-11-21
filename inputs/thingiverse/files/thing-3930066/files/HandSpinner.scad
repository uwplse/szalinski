// Quality of model based on number of segments in each circle
resolution = 45; //[15, 30, 45, 90, 120]

// Number of lobes
lobes = 3; //[2,3,4,5,6]

//Diameter of the outside of the bearings
bearOut = 22;//[21:0.1:23]

//Thickness of the bearings
bearThick = 7;//[6:0.1:8]

// Number of bearings in each lobe
lobeBearCount = 1;//[1:2]

//Thickness of the walls around the bearings, not including the rounded edge
wallThickF = 2;//[1:4]

//Thickness of the rouded edges on the walls
wallThickR = 3;//[2:5]

//Diameter of the outside of the bearings
capDiameter = 20;//[18:22]

//Diameter of the inside of the bearings
bearIn = 8;//[7:0.1:9]

//Thickness of the cap on top of the bearing
capThick = 3;//[2:4]

//Number of caps you want to print. Can't do more than 2 caps per bearing
capCount = 2;//[0:2:14]

//Set to "false" if you would like a flat cap
concaveCap = true;

wallOutRad = bearOut/2+wallThickF;// Radius to the outside of the walls, not including the rounded edge

spinner();
if(capCount<=lobes+1) {// If you want less caps than the amount of lobes
    if(capCount>0) {// If you dont want caps
        translate ([0,0,(capThick-bearThick*lobeBearCount)/2])
        cap();
    }
    if(capCount>1) {// If you dont want caps
        for (i = [0:capCount-2]) {
            rotate([0,0,360/lobes*i])
            translate([0,wallOutRad*2,(capThick-bearThick*lobeBearCount)/2])
            cap();
        }
    }
}
if(capCount>lobes+1) {// If you want more caps than ther is lobes
    translate ([0,0,(capThick-bearThick*lobeBearCount)/2])
    cap();

    for (i = [0:lobes-1]) {
        rotate([0,0,360/lobes*i])
        translate([0,wallOutRad*2,(capThick-bearThick*lobeBearCount)/2])
        cap();
    }

    if(capCount<=lobes*2+1) {// If you want more caps than ther is lobes and the caps dont exeed the second ring of placement
        for (i = [0:capCount-lobes-2]) {
            rotate([0,0,360/lobes*i])
            translate([0,wallOutRad*4,(capThick-bearThick*lobeBearCount)/2])
            cap();
        }
    }

    if(capCount>lobes*2+1) {// If you want caps for bearing
        for (i = [0:capCount-lobes-2]) {
            rotate([0,0,(360/(lobes+1))*i])
            translate([0,wallOutRad*4,(capThick-bearThick*lobeBearCount)/2])
            cap();
        }
    }
}

module cap(){
    if(concaveCap) {
        difference() {
            // Top of cap
            shape_edge((capDiameter-capThick)/2){
                cylinder(h=capThick,d=capDiameter-capThick,center=true,$fn=resolution);
                circle(d=capThick,$fn=resolution);
            }

            // Concavity
            translate([0,0,-capThick/2])
            resize([0,0,(capThick/2)*2])
            sphere(d=capDiameter-capThick,$fn=resolution,center=true);
        }
    }
    else {
        shape_edge((capDiameter-capThick)/2){
            cylinder(h=capThick,d=capDiameter-capThick,center=true,$fn=resolution);
            circle(d=capThick,$fn=resolution);
        }
    }

    // Inner spacer
    translate([0,0,capThick/2+0.2])
    cylinder(h=0.4,d=bearIn+2,center=true,$fn=resolution);

    // Shaft
    translate([0,0,capThick/2+1.9])
    cylinder(h=3,d=bearIn,center=true,$fn=resolution);
}

module spinner(){
    difference() {
        union() {
            // Center
            union() {
                // Center base
                cylinder(h=bearThick, r=wallOutRad, center=true, $fn=resolution);
                
                // Center round edge
                rotate_extrude($fn=resolution)
                translate([wallOutRad,0,0])
                resize([wallThickR*2,0,0])
                circle(d=bearThick, $fn=resolution);
            }

            // Lobes
            if(lobes<=7) {
                if(lobes>=1) {
                    rotational_array(lobes)
                    union() {
                        translate([0,wallOutRad*2,0])
                        union() {
                            // Lobe base
                            cylinder(h=bearThick*lobeBearCount, r=wallOutRad, center=true, $fn=resolution);
                                
                            // Lobe round edge
                            rotate_extrude($fn=resolution)
                            translate([wallOutRad,0,0])
                            resize([wallThickR*2,0,0])
                            circle(d=bearThick, $fn=resolution);
                        }

                        // Connections
                        mirror_copy([1,0,0]){
                            if(lobes <= 3) {
                                translate([-wallOutRad*sqrt(3),wallOutRad,0])
                                rotate([0,0,-60])
                                wedge(60)
                                rotate_extrude($fn=resolution)
                                translate([wallOutRad,0,0])
                                union() {
                                    // Conection filler
                                    translate([wallOutRad/2,0,0])
                                    square([wallOutRad,bearThick], center = true);
                                    
                                    // Conection rounded edge
                                    resize([wallThickR*2,0,0])
                                    circle(d=bearThick, center = true, $fn=resolution);
                                }
                            }
                            
                            if(lobes>3) {
                                translate([2*sqrt(pow(wallOutRad*2,2)-pow(sin(360/lobes/2)*wallOutRad*2,2))*cos(-90-360/lobes/2),2*sqrt(pow(wallOutRad*2,2)-pow(sin(360/lobes/2)*wallOutRad*2,2))*sin(90-360/lobes/2),0])
                                rotate([0,0,-((90-360/lobes)+90)])
                                wedge(360/lobes/2)
                                rotate_extrude($fn=resolution)
                                translate([wallOutRad,0,0])
                                union() {
                                    // Conection filler
                                    translate([wallOutRad,0,0])
                                    square([wallOutRad*2,bearThick], center = true);
                                    
                                    // Conection rounded edge
                                    resize([wallThickR*2,0,0])
                                    circle(d=bearThick, center = true, $fn=resolution);
                                }
                            }
                        }
                    }
                }
                else {
                    echo("Lobes should not be 0 or more than 6.");
                }
            }
            else {
                echo("Lobes should not be 0 or more than 6.");
            }
        }

        // Bearing cut out center
        cylinder(h=bearThick+.1, d=bearOut, center=true, $fn=resolution);

        // Bearing cut out lobes
        rotational_array(lobes)
        translate([0,wallOutRad*2,0])
        cylinder(h=bearThick*lobeBearCount+.1, d=bearOut, center=true, $fn=resolution);
    }
}

// Creates a wedge out of object off of the positive Y axis
module wedge(deg) {
    difference() {
        rotate([0,0,-deg])
        difference() {
            children();

            translate([50,0,0])
            cube(100, center = true);
        }

        translate([-50,0,0])
        cube(100, center = true);
    }
}

// Creates an array of specified number of objects around the Z axis 
module rotational_array(num) {
    for (i = [0:num-1]) {
        rotate([0,0,(360/num)*i])
            children();
    }
}

// Mirrors object on specified axis without deleteing origanal
module mirror_copy(vec=[0,0,0]) {
    children();
        
    mirror(vec)
        children();
}

// Rotate extrudes object around an object at a given radius
module shape_edge(rad) {
        rotate_extrude($fn=resolution)
        translate([rad,0,0])
        children([1:$children-1]);
        children(0);
}