//Ultrasonic sensor mount.
//Parametric.
//Oktay Gülmez, 23/2/2016.
//GNU_GPL_V3


//Parameters:
//Distance between centers of transducers in mm.: 25.4mm for HC-SR04.
eyes_width=25.4;
//The diameter of the transducer in mm.: 16mm. mostly. 
eyes_diameter=16;
//Sensor PCB mounting holes in mm.: 41.4x17 for HC-SR04. 
mount_lenght=41.4;
mount_width=17;
//Desired thickness in mm.: Maximum 5mm.
thickness=2;
//Decorations: "1" smile, "2" teeth, "3" vampire, "4" mustage, "5" O, other for none.
face=1;

$fn=20;
difference(){
    union(){
 //Front plate:  
        linear_extrude(height = thickness, convexity = 10, $fn=60) hull() {
   translate([-eyes_width/2,0,0])circle(15.5);
   translate([eyes_width/2,0,0]) circle(15.5);
        }
        linear_extrude(height = thickness, convexity = 10, $fn=60) hull() {
   translate([-eyes_width/2,0,0])circle(15.5);
   translate([-8,-30,0]) circle(5);
        }
        linear_extrude(height = thickness, convexity = 10, $fn=60) hull() {
   translate([eyes_width/2,0,0])circle(15.5);
   translate([8,-30,0]) circle(5);
        }
        
       translate([-8,-35,0]) cube([16,35,thickness]);
        
//Servo mounting bracket:      
       translate([0,-35,0]) rotate([-90,-90,0]) linear_extrude(height = 6, convexity = 10) hull() {
   translate([0,0,0])circle(8);
   translate([23,0,0]) circle(5);
    }

//Sensor PCB mounting tabs:
     translate([-mount_lenght/2,mount_width/2,0]) cylinder(h=thickness+3.5, r=3);
    translate([mount_lenght/2,mount_width/2,0]) cylinder(h=thickness+3.5, r=3);
    translate([-mount_lenght/2,-mount_width/2,0]) cylinder(h=thickness+3.5, r=3);
    translate([mount_lenght/2,-mount_width/2,0]) cylinder(h=thickness+3.5, r=3);
     
}

//Transducers holes:
    translate([-eyes_width/2,0,-1]) cylinder(h=thickness+2, r=eyes_diameter/2+0.3, $fn=50);
   translate([eyes_width/2,0,-1])  cylinder(h=thickness+2, r=eyes_diameter/2+0.3, $fn=50);

//Servo head placement:   
    translate([0,-35,8]) rotate([-90,0,0]) cylinder(h=2.5, r=3.8);
    translate([0,-35-1,8]) rotate([-90,0,0]) cylinder(h=8, r=1.25);
    translate([0,-35+4.5,8]) rotate([-90,0,0]) cylinder(h=3, r=3);
    translate([0,-35-1,23]) rotate([-90,0,0]) cylinder(h=8, r=1);
    
    translate([0,-35,8]) rotate([-90,-90,0]) linear_extrude(height = 2.5, convexity = 10) hull() {
   translate([0,0,0])circle(3.5);
   translate([15,0,0]) circle(2);
    }
    
    

//Sensor PCB mounting screws holes:    
   translate([-mount_lenght/2,mount_width/2,1]) cylinder(h=thickness+3.5, r=1);
    translate([mount_lenght/2,mount_width/2,1]) cylinder(h=thickness+3.5, r=1);
    translate([-mount_lenght/2,-mount_width/2,1]) cylinder(h=thickness+3.5, r=1);
    translate([mount_lenght/2,-mount_width/2,1]) cylinder(h=thickness+3.5, r=1);
    
 //Face decoration:   
    if (face==1) {
    translate([0,0,-1]) 
          linear_extrude(height = thickness+2, convexity = 10, $fn=60)
                import(file = "ultrasonic_face_smile.dxf", layer = "0");
    }
    else if (face==2) {
        linear_extrude(height = thickness+2, convexity = 10, $fn=60)
                import(file = "ultrasonic_face_teeth.dxf", layer = "0");
    }
    else if (face==3) {
        linear_extrude(height = thickness+2, convexity = 10, $fn=60)
                import(file = "ultrasonic_face_vampire.dxf", layer = "0");
    }
    else if (face==4) {
        linear_extrude(height = thickness+2, convexity = 10, $fn=60)
                import(file = "ultrasonic_face_mustage.dxf", layer = "0");
    }
    else if (face==5) {
        linear_extrude(height = thickness+2, convexity = 10, $fn=60)
                import(file = "ultrasonic_face_O.dxf", layer = "0");
    }
    else {
    }
    
//Cleaning overhang:    
    translate([-10,-35,-10]) cube([20,10,10]);
}
