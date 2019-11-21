// preview[view:south, tilt:side]

select_part =                   "Basic"; //[Basic, 2-way, 3-way, Cap, Base, Gate, Slide (for gate), Nozzle, Valve (part a), Valve (part b)]

//Allows for viewing internal geometry.
cut_away =                         "No"; //[Yes, No]

//Required for 2/3-way parts (eg. 90 for a T shape 3-way or elbow 2-way)
angle =                              90; //[45:180]

//Required for most parts.
fitting_1 =                           0; //[0:Ball, 1:Socket, 2:Tube Adapter]
//Required for 2/3-way parts, and gate.
fitting_2 =                           1; //[0:Ball, 1:Socket, 2:Tube Adapter]
//Required for 3-way parts only.
fitting_3 =                           2; //[0:Ball, 1:Socket, 2:Tube Adapter]

//Required for all parts. (1 Inch = 25.4 mm)
internal_diameter_1 =                10; //[5:0.1:50]
//Required for 2/3-way parts. (1 Inch = 25.4 mm)
internal_diameter_2 =                10; //[5:0.1:50]
//Required for 3-way parts only. (1 Inch = 25.4 mm)
internal_diameter_3 =                10; //[5:0.1:50]

//Required for length of 2/3-way parts, and height of nozzle.
size_1 =                              0; //[0:0.1:100]
//Required for 2/3-way parts, and X-scaling of nozzle.
size_2 =                              0; //[0:0.1:100]
//Required for 3-way parts, and Y-scaling of nozzle.
size_3 =                              0; //[0:0.1:100]

/*[Hidden]*/
$fn =                               100;

delta =                            0.01;

wall =                                2;

tolerance =                         0.3;

module ball(internal_diameter){
    rotate([180,0,0])
    translate([0,0,internal_diameter-tolerance/2])
    difference(){
        union(){
            sphere(d=2*internal_diameter-tolerance);
            
            rotate([180,0,0])
            cylinder(h=internal_diameter-tolerance/2, d=internal_diameter+2*wall);
        }
        union(){
            translate([0,0,-internal_diameter+tolerance/2-delta])
            cylinder(h=2*internal_diameter-tolerance+2*delta, d=internal_diameter);
        }
    }
}

module socket(internal_diameter){
    translate([0,0,-internal_diameter-wall])
    difference(){
        union(){
            sphere(d=2*internal_diameter+2*wall);
            
            cylinder(h=internal_diameter+wall, d1=2*internal_diameter+2*wall, d2=internal_diameter+2*wall);
        }
        union(){
            sphere(d=2*internal_diameter+tolerance);
            
            cylinder(h=internal_diameter+wall+delta, d=internal_diameter);
            
            translate([0,0,-internal_diameter-wall-delta])
            cylinder(h=0.75*internal_diameter+wall+delta, d=2*internal_diameter+2*wall);
        }
    }
}

module tube_adapter(internal_diameter){
    rotate([180,0,0])
    difference(){
        union(){
            cylinder(h=0.5*internal_diameter, d=internal_diameter+2*wall);
            
            translate([0,0,0.5*internal_diameter])
            cylinder(h=0.5*internal_diameter, d1=internal_diameter+3*wall, d2=internal_diameter+2*wall);
            
            translate([0,0,internal_diameter])
            cylinder(h=0.5*internal_diameter, d1=internal_diameter+3*wall, d2=internal_diameter+2*wall);
            
            translate([0,0,1.5*internal_diameter])
            cylinder(h=0.5*internal_diameter, d1=internal_diameter+3*wall, d2=internal_diameter+2*wall);
        }
        union(){
            translate([0,0,-delta])
            cylinder(h=2*internal_diameter+2*delta, d=internal_diameter);
        }
    }
}

module basic(){
    rotate([180,0,0])
    ball(internal_diameter_1);
    
    socket(internal_diameter_1);
}

module 2_way(){
    difference(){
        union(){
            translate([(internal_diameter_1+internal_diameter_2)/4+wall,0,-(internal_diameter_1+internal_diameter_2)/4-size_1])
            cylinder(h=(internal_diameter_1+internal_diameter_2)/4+size_1, d1=internal_diameter_1+2*wall, d2=(internal_diameter_1+internal_diameter_2)/2+2*wall);
            
            rotate([0,180+angle,0])
            translate([(internal_diameter_1+internal_diameter_2)/4+wall,0,0])
            cylinder(h=(internal_diameter_1+internal_diameter_2)/4+size_2, d1=(internal_diameter_1+internal_diameter_2)/2+2*wall, d2=internal_diameter_2+2*wall);
        }
        
        union(){
            translate([(internal_diameter_1+internal_diameter_2)/4+wall,0,-(internal_diameter_1+internal_diameter_2)/4-size_1-delta])
            cylinder(h=(internal_diameter_1+internal_diameter_2)/4+size_1+2*delta, d1=internal_diameter_1, d2=(internal_diameter_1+internal_diameter_2)/2);
            
            rotate([0,180+angle,0])
            translate([(internal_diameter_1+internal_diameter_2)/4+wall,0,-delta])
            cylinder(h=(internal_diameter_1+internal_diameter_2)/4+size_2+2*delta, d1=(internal_diameter_1+internal_diameter_2)/2, d2=internal_diameter_2);
        }
    }

    rotate([90,0,0])
    difference(){
        union(){
            rotate_extrude()
            translate([(internal_diameter_1+internal_diameter_2)/4+wall,0,0])
            circle(d=(internal_diameter_1+internal_diameter_2)/2+2*wall);
        }
        union(){
            rotate_extrude()
            translate([(internal_diameter_1+internal_diameter_2)/4+wall,0,0])
            circle(d=(internal_diameter_1+internal_diameter_2)/2);
            
            translate([0,-150/2,0])
            cube(150, center=true);
            
            rotate([0,0,-angle])
            translate([0,-150/2,0])
            cube(150, center=true);
        }
    }

    translate([(internal_diameter_1+internal_diameter_2)/4+wall,0,-(internal_diameter_1+internal_diameter_2)/4-size_1])
    if (fitting_1 == 0){
        ball(internal_diameter_1);
    }
    else if (fitting_1 == 1){
        socket(internal_diameter_1);
    }
    else if (fitting_1 == 2){
        tube_adapter(internal_diameter_1);
    }

    rotate([0,angle,0])
    translate([-(internal_diameter_1+internal_diameter_2)/4-wall,0,-(internal_diameter_1+internal_diameter_2)/4-size_2])
    if (fitting_2 == 0){
        ball(internal_diameter_2);
    }
    else if (fitting_2 == 1){
        socket(internal_diameter_2);
    }
    else if (fitting_2 == 2){
        tube_adapter(internal_diameter_2);
    }
}

module 3_way(){
    difference(){
        union(){
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+wall,0,-(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6-size_1])
            cylinder(h=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+size_1, d1=internal_diameter_1+2*wall, d2=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3+2*wall);
            
            rotate([0,180+angle,0])
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+wall,0,0])
            cylinder(h=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+size_2, d1=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3+2*wall, d2=internal_diameter_2+2*wall);
            
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3+2*wall,0,0])
            rotate([0,180-angle,0])
            translate([-(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6-wall,0,0])
            cylinder(h=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+size_3, d1=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3+2*wall, d2=internal_diameter_3+2*wall);
        }
        
        union(){
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+wall,0,-(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6-size_1-delta])
            cylinder(h=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+size_1+2*delta, d1=internal_diameter_1, d2=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3);
            
            rotate([0,180+angle,0])
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+wall,0,-delta])
            cylinder(h=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+size_2+2*delta, d1=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3, d2=internal_diameter_2);
            
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3+2*wall,0,0])
            rotate([0,180-angle,0])
            translate([-(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6-wall,0,-delta])
            cylinder(h=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+size_3+2*delta, d1=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3, d2=internal_diameter_3);
        }
    }

    rotate([90,0,0])
    difference(){
        union(){
            rotate_extrude()
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+wall,0,0])
            circle(d=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3+2*wall);
            
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3+2*wall,0,0])
            rotate_extrude()
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+wall,0,0])
            circle(d=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3+2*wall);
        }
        union(){
            rotate_extrude()
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+wall,0,0])
            circle(d=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3);
            
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3+2*wall,0,0])
            rotate_extrude()
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+wall,0,0])
            circle(d=(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3);
            
            translate([0,-150/2,0])
            cube(150, center=true);
            
            rotate([0,0,-angle])
            translate([0,-150/2,0])
            cube(150, center=true);
            
            translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3+2*wall,0,0])
            rotate([0,0,angle])
            translate([0,-150/2,0])
            cube(150, center=true);
        }
    }

    translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+wall,0,-(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6-size_1])
    if (fitting_1 == 0){
        ball(internal_diameter_1);
    }
    else if (fitting_1 == 1){
        socket(internal_diameter_1);
    }
    else if (fitting_1 == 2){
        tube_adapter(internal_diameter_1);
    }

    rotate([0,angle,0])
    translate([-(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6-wall,0,-(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6-size_2])
    if (fitting_2 == 0){
        ball(internal_diameter_2);
    }
    else if (fitting_2 == 1){
        socket(internal_diameter_2);
    }
    else if (fitting_2 == 2){
        tube_adapter(internal_diameter_2);
    }

    translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/3+2*wall,0,0])
    rotate([0,-angle,0])
    translate([(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6+wall,0,-size_3-(internal_diameter_1+internal_diameter_2+internal_diameter_3)/6])
    if (fitting_3 == 0){
        ball(internal_diameter_3);
    }
    else if (fitting_3 == 1){
        socket(internal_diameter_3);
    }
    else if (fitting_3 == 2){
        tube_adapter(internal_diameter_3);
    }
}

module cap(){
    difference(){
        union(){
            translate([0,0,2*internal_diameter_1+wall])
            sphere(d=2*internal_diameter_1-tolerance);
            
            translate([0,0,internal_diameter_1])
            cylinder(h=internal_diameter_1/2, d=internal_diameter_1+2*wall);
            
            sphere(d=2*internal_diameter_1+2*wall);
            
            cylinder(h=internal_diameter_1+wall, d1=2*internal_diameter_1+2*wall, d2=internal_diameter_1+2*wall);
        }
        union(){
            sphere(d=2*internal_diameter_1+tolerance);
            
            translate([0,0,-internal_diameter_1-wall-delta])
            cylinder(h=0.85*internal_diameter_1+wall+delta, d=2*internal_diameter_1+2*wall);
        }
    }
}

module base(){
    difference(){
        union(){
            rotate([0,180,0])
            if (fitting_1 == 0){
                ball(internal_diameter_1);
            }
            else if (fitting_1 == 1){
                socket(internal_diameter_1);
            }
            else if (fitting_1 == 2){
                tube_adapter(internal_diameter_1);
            }
            
            translate([0,0,-wall/2])
            cube([3*internal_diameter_1,3*internal_diameter_1,wall], center=true);
        }
        union(){
            translate([-internal_diameter_1,-internal_diameter_1,-wall-delta])
            cylinder(h=wall+2*delta, d1=3, d2=5);
            
            translate([-internal_diameter_1,internal_diameter_1,-wall-delta])
            cylinder(h=wall+2*delta, d1=3, d2=5);
            
            translate([internal_diameter_1,-internal_diameter_1,-wall-delta])
            cylinder(h=wall+2*delta, d1=3, d2=5);
            
            translate([internal_diameter_1,internal_diameter_1,-wall-delta])
            cylinder(h=wall+2*delta, d1=3, d2=5);
        }
    }
}

module gate(){
    difference(){
        union(){
            translate([0,0,1.5*wall+tolerance])
            rotate([0,180,0])
            if (fitting_1 == 0){
                ball(internal_diameter_1);
            }
            else if (fitting_1 == 1){
                socket(internal_diameter_1);
            }
            else if (fitting_1 == 2){
                tube_adapter(internal_diameter_1);
            }
            
            translate([0,0,-1.5*wall-tolerance])
            if (fitting_2 == 0){
                ball(internal_diameter_1);
            }
            else if (fitting_2 == 1){
                socket(internal_diameter_1);
            }
            else if (fitting_2 == 2){
                tube_adapter(internal_diameter_1);
            }
            
            cube([3*internal_diameter_1+2*tolerance,3*internal_diameter_1+2*tolerance,3*wall+2*tolerance], center=true);
        }
        union(){
            translate([0,0,-1.5*wall-tolerance-delta])
            cylinder(h=3*wall+2*tolerance+2*delta, d=internal_diameter_1);
            
            translate([wall/2,0,0])
            cube([3*internal_diameter_1-wall+2*tolerance+delta,3*internal_diameter_1-2*wall+2*tolerance,wall+2*tolerance], center=true);
            
            translate([1.5*internal_diameter_1,0,-1.5*wall-tolerance-delta])
            cylinder(h=3*wall+2*tolerance+2*delta, d=internal_diameter_1);
        }
    }
}

module slide(){
    translate([wall/2,0,0])
    cube([3*internal_diameter_1-wall,3*internal_diameter_1-2*wall,wall], center=true);
    
    translate([1.5*internal_diameter_1,0,-wall/2])
    cylinder(h=wall, d=internal_diameter_1);
}

module nozzle(){
    difference(){
        union(){
            linear_extrude(height=size_1+10, scale=[(internal_diameter_1*(size_2/10)+2*wall)/(internal_diameter_1+2*wall),(internal_diameter_1*(size_3/10)+2*wall)/(internal_diameter_1+2*wall)])
            circle(d=internal_diameter_1+2*wall);
            
            translate([0,0,size_1+10])
            linear_extrude(height=wall, scale=[(internal_diameter_1*(size_2/10))/(internal_diameter_1*(size_2/10)+2*wall),(internal_diameter_1*(size_3/10))/(internal_diameter_1*(size_3/10)+2*wall)])
            scale([(internal_diameter_1*(size_2/10)+2*wall)/(internal_diameter_1+2*wall),(internal_diameter_1*(size_3/10)+2*wall)/(internal_diameter_1+2*wall)])
            circle(d=internal_diameter_1+2*wall);
        }
        union(){
            translate([0,0,-delta])
            linear_extrude(height=size_1+10+2*delta, scale=[size_2/10,size_3/10])
            circle(d=internal_diameter_1);
            
            translate([0,0,size_1+10-delta])
            linear_extrude(height=wall+2*delta)
            scale([(internal_diameter_1*(size_2/10))/(internal_diameter_1+2*wall),(internal_diameter_1*(size_3/10))/(internal_diameter_1+2*wall)])
            circle(d=internal_diameter_1+2*wall);
        }
    }
    
    if (fitting_1 == 0){
        ball(internal_diameter_1);
    }
    else if (fitting_1 == 1){
        socket(internal_diameter_1);
    }
    else if (fitting_1 == 2){
        tube_adapter(internal_diameter_1);
    }
}

module valve_a(){
    difference(){
        union(){
            cylinder(h=internal_diameter_1+2*wall, d=internal_diameter_1+2*wall-tolerance);
            
            translate([0,0.5*wall,internal_diameter_1+2*wall])
            rotate([90,0,0])
            cylinder(h=wall, d=internal_diameter_1);
        }
        union(){
            translate([-0.5*internal_diameter_1-wall,0,0.5*internal_diameter_1+wall])
            rotate([0,90,0])
            cylinder(h=internal_diameter_1+2*wall, d=internal_diameter_1);
        }
    }
}

module valve_b(){
    difference(){
        union(){
            translate([0,0,-wall])
            cylinder(h=internal_diameter_1+3*wall, d=internal_diameter_1+4*wall);
            
            translate([-0.5*internal_diameter_1-3*wall,0, 0.5*internal_diameter_1+wall])
            rotate([0,90,0])
            cylinder(h=internal_diameter_1+6*wall, d=internal_diameter_1+2*wall);
        }
        union(){
            cylinder(h=internal_diameter_1+2*wall+delta, d=internal_diameter_1+2*wall+tolerance);
            
            translate([-0.5*internal_diameter_1-3*wall-delta,0, 0.5*internal_diameter_1+wall])
            rotate([0,90,0])
            cylinder(h=internal_diameter_1+6*wall+2*delta, d=internal_diameter_1);
        }
    }
    
    translate([-0.5*internal_diameter_1-3*wall,0, 0.5*internal_diameter_1+wall])
    rotate([0,90,0])
    if (fitting_1 == 0){
        ball(internal_diameter_1);
    }
    else if (fitting_1 == 1){
        socket(internal_diameter_1);
    }
    else if (fitting_1 == 2){
        tube_adapter(internal_diameter_1);
    }
    
    translate([0.5*internal_diameter_1+3*wall,0, 0.5*internal_diameter_1+wall])
    rotate([0,-90,0])
    if (fitting_2 == 0){
        ball(internal_diameter_1);
    }
    else if (fitting_2 == 1){
        socket(internal_diameter_1);
    }
    else if (fitting_2 == 2){
        tube_adapter(internal_diameter_1);
    }
}

module show_what(){
    if (select_part == "Basic")
        color("grey")
        basic();
    if (select_part == "2-way")
        color("grey")
        2_way();
    if (select_part == "3-way")
        color("grey")
        3_way();
    if (select_part == "Cap")
        color("grey")
        cap();
    if (select_part == "Base")
        color("grey")
        base();
    if (select_part == "Gate")
        color("grey")
        gate();
    if (select_part == "Slide (for gate)")
        color("grey")
        slide();
    if (select_part == "Nozzle")
        color("grey")
        nozzle();
    if (select_part == "Valve (part a)")
        color("grey")
        valve_a();
    if (select_part == "Valve (part b)")
        color("grey")
        valve_b();
}


difference(){
    union(){
        show_what();
    }
    
    if (cut_away == "Yes")
    translate([-150,-55,-150])
    cube([300,55,300]);
}