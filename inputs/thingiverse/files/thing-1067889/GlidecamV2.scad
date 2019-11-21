/*
Defaults:

Main Bearing:    6007, 35mm ID, 62mm OD, 14mm Z
Sec Bearings:    625, 5mm ID, 14mm OD, 5mm Z
Retainer Plate:  1/4 in. fender washer, 25.4mm OD, 2mm Z
Main shaft:      3/4 in. PVC OR Monopod, 27mm OD
Handle shaft:    3/4 in. PVC, 27mm OD
Bolt Diameter:   M5, 5mm
Nut diameter:    M5, 8mm
Nut Z:           M5, 4mm
Washer Diameter: 25.4 mm

*/

/*Customizer Variables*/

/*[Dimensions]*/


Main_Bearing_Inside_Diameter = 35;
Main_Bearing_Outside_Diameter = 62;
Main_Bearing_Z  = 14;

Secondary_Bearing_Inside_Diameter = 5;
Secondary_Bearing_Outside_Diameter = 14;
Secondary_Bearing_Z  = 5;

Main_Shaft_Diameter = 27;

Handle_Shaft_Diameter = 27;

Bolt_Diameter = 5;

//This should be larger than the Secondary Bearing OD
Washer_Diameter = 25.4;
Washer_Z = 3 ;

//What is the diameter of the nuts used in the project, from flat to flat?
Nut_Diameter = 8;
Nut_Z   = 4;

/*[Main Body Structure]*/

//Desired diameter of the Main Bearing Housing, should be at least 2mm over Main Bearing OD. Should also take into account the space needed for 2 bearings, a washer, and a nut on each side 
Main_Cylinder = 64;


//Desired spacing between Main Bearing Housing, and handle arms, should be enough for at least 1 nut to hold the bearing in the Main Bearing Housing
Arm_Space = 6;

//Clearance between the bearing bushing and the arm, more give greater swing angle, but only to a point
Arm_Clearance = 20;

/*[Display Mode]*/

// Which part would you like to see?
item = "all"; // [first:Bearing Bushing, second:Main Bushing, third:Handle Arm, fourth:Handle, all:Display All]

/*[Hidden]*/
mainBearID = Main_Bearing_Inside_Diameter;
mainBearOD = Main_Bearing_Outside_Diameter;
mainBearZ  = Main_Bearing_Z;

bearID = Secondary_Bearing_Inside_Diameter;
bearOD = Secondary_Bearing_Outside_Diameter;
bearZ  = Secondary_Bearing_Z;

mainShaftDia = Main_Shaft_Diameter;

handleShaftDia = Handle_Shaft_Diameter;

boltDia = Bolt_Diameter;

washDia = Washer_Diameter;
washZ = Washer_Z;

nutDia = Nut_Diameter;
nutZ   = Nut_Z;

mainCyl = Main_Cylinder;

armSpace = Arm_Space;

armClearance = Arm_Clearance;


module displayAll(){
    translate([((mainCyl/2)+(washZ*1.1))*2+bearZ,(mainCyl+washDia)/2+3,0]){
        handle();
    }
    translate([0,-armSpace,0]){
        handleArm();
    }
    translate([((mainCyl/2)+(washZ*1.1))*2+bearZ,0,mainBearZ+washDia+5]){
        rotate([180,0,0]){
            bearingBushing();
        }
    }
    translate([0,0,0]){
        bushing();
    }
}

module handle(){
    difference(){
        union(){//makes the body of the part, sections are removed later
            translate([0,0,nutZ*1.5+handleShaftDia*0.25]){
                cube(size=[8*boltDia+washDia,washDia,nutZ*3+handleShaftDia*0.5],center=true);//flat bottom part
            }
            translate([0,0,handleShaftDia*0.5+nutZ*3]){
                rotate([0,90,0]){
                    //cylinder(d=(handleShaftDia*1.4),h=4*boltDia+washDia,center=true); //round portion to contain handle
                }
            }
        }
        translate([0,0,handleShaftDia*0.5+nutZ*3]){
            rotate([0,90,0]){
                cylinder(d=handleShaftDia,h=1000,center=true);
            }
        }
        translate([0,0,500+nutZ*1.5]){
            cube(size=[washDia,1000,1000],center=true);
        }
        rotate([0,0,0]){
            cylinder(d=boltDia,h=500,center=true);
        }
        translate([(4*boltDia+washDia)/2,0,0]){
            cylinder(d=boltDia,h=500,center=true);//makes hole on one end for securing handle
        }
        translate([(4*boltDia+washDia)/-2,0,0]){
            cylinder(d=boltDia,h=500,center=true);//makes hole on other end for securing handle
        }
    }
}

module handleArm(){
    difference(){
        union(){
            //side arms
            translate([((mainCyl/2)+(washZ*1.1)),-washDia/2,0]){
                cube(size=[bearZ,armClearance+(washDia/2),bearOD*1.5]);
            }
            mirror([]){//other side arm
                translate([((mainCyl/2)+(washZ*1.1)),-washDia/2,0]){
                    cube(size=[bearZ,armClearance+(washDia/2),bearOD*1.5]);
                }
            }
            //
            translate([0,armClearance,0]){//main cylinder
                cylinder(r=((mainCyl/2)+(washZ*1.1)+bearZ),h=(bearOD*1.5));
            }
            
            
            translate([0,armClearance+((mainCyl/2)+(washZ*1.1))+1.5*boltDia,0.75*bearOD]){//makes the squared-off section in the middle of the arm to hold the bearing for the sttachment of the handle
                cube(size=[1.5*bearOD,3*bearZ,1.5*bearOD],center=true);
            }
        }
        translate([0,0,(bearOD*1.5/2)]){//makes the hole in the squared off section
            rotate([90,0,0]){
                cylinder(d=bearOD,h=1000,center=true);
            }
        }
        
        translate([0,0,(bearOD*1.5/2)]){//makes holes for bearings in arms 
            rotate([0,90,0]){
                cylinder(d=bearOD,h=1000,center=true);
            }
        }
        
        translate([0,-250-(washDia/2),0]){
            cube(size=[500,500,500],center=true);//keeps arm end square
        }
        hull(){//provides room for main setup to swing 
            translate([0,armClearance,0]){//provides round arm, translate must be same as main constructor cylinder transform, as seen above
                cylinder(r=((mainCyl/2)+(washZ*1.1)),h=1000,center=true);
            }
            translate([0,-500,0]){
                rotate([0,0,90]){
                    cube(size=[0.1,(2*(mainCyl/2)+(washZ*1.1)),1000],center=true);//makes oblong space
                }
            }
        }
    
    }
}


module bearingBushing(){
    //note, this part is generated upside-down, will have to be flipped for printing
    difference(){
        //make the body to be subtracted from
        cylinder(d=mainCyl, h=(mainBearZ+washDia+5));
        //hollow for the main bearing
        translate([0,0,(mainBearZ/2)]){
            cylinder(d=mainBearOD, h=mainBearZ+1,center=true);
        }
        //space for main shaft to pass through
        cylinder(d=mainShaftDia+1,h=1000);
        //shaft for housing secondary bearings
        translate([0,0,(mainBearZ+2.5+(washDia/2))]){
            rotate([0,90,0]){
                cylinder(d=bearOD,h=1000,center=true);
            }
        }
        //slots for housing the retaining washers
        translate([((mainCyl/2)-(bearZ+(washZ/2))),0,500]){
            cube(size=[washZ,washDia,1000], center=true);
        }
        rotate(a=[0,0,180]){
            translate([((mainCyl/2)-(bearZ+(washZ/2))),0,500]){
                cube(size=[washZ,washDia,1000], center=true);
            }   
        }
    }
}
    


module bushing (){
    bushHeight = mainBearZ+(nutDia*1.16)+5;//generate main bushing body
        difference(){
            cylinder(d=mainBearOD-2, h=bushHeight);
            translate([0,0,-1])
                cylinder(d=mainShaftDia, h=bushHeight+2);
            translate([0,0,(bushHeight-mainBearZ)]){
                difference(){
                    cylinder(d=mainBearOD+1,h=bushHeight);
                    cylinder(d=mainBearID, h= bushHeight+1);
                }
                translate([0,0,-1]){
                    difference(){
                        cylinder(d=mainBearOD+1,h=bushHeight);
                        cylinder(d=mainBearID+3,h=bushHeight+1);
                    }
                }
            }
            
        union(){
            //hex shaft for nuts
            translate([0,0,((bushHeight-(mainBearZ+1))/2)]) {
                cube(size=[((mainBearID+mainBearOD)/2),nutDia,(2*((nutDia/2)/sqrt(3)))], center = true);
                rotate([60,0,0])
                    cube(size=[((mainBearID+mainBearOD)/2),nutDia,(2*((nutDia/2)/sqrt(3)))], center = true);
                rotate([-60,0,0])
                    cube(size=[((mainBearID+mainBearOD)/2),nutDia,(2*((nutDia/2)/sqrt(3)))], center = true); 
            
            //round shaft for bolt
                rotate([0,90,0])
                    cylinder(d=boltDia, h=mainBearOD+5, center=true);
            }
        }      
    }
}

module display(){
    if (item=="all"){
        displayAll();
    }
    else if (item=="first"){
        bearingBushing();
    }
    else if (item=="second"){
        bushing();
    }
    else if (item=="third"){
        handleArm();
    }
    else if (item=="fourth"){
        handle();
    }
    else{
        displayAll();
    }
}

display();