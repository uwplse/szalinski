//Begin MKVII


        //**//Begin Global Variables//**//
        
        length = 35; //Length of hinge
        height = 40; //height of hinge
        thickness = 2; //thickness of hinge 
        
        numberOfBoltHoles = 2; //Choose between 2 or 3 fastener bolt holes on a hinge
        
        Hinge = 3; //Parts of hinge
                    //1 and 2 are seperate pieces;
                    //they do not come with a pin
                    //3 is full assembly, pin included
        
        boltDia = 3.2; //Diameter of fastener bolt 
        pinDia = 3; //Diameter of pinm
        
        Pins = 1; //Support pin option.
                  //If Pins = 1, then small holes for metal support pins of your choosing will be created in the hinge.
                  //If Pins = 2, then no support holes will be created.
        
        n = 2; //Number of shells used during printing.

        //**//End global Variables//**//

//Good
 module Barrel(length,height,thickness,curveDia,barrelThickness,pinDia,res=40){
    
        rotate([90,0,0])
            difference(){
        
            cylinder(r=pinDia/2+n*.2+barrelThickness,h=1/3*height-.2,center=true,$fn=res);
                
            cylinder(r=pinDia/2+n*.2,h=1/3*height+1,center=true,$fn=res);
        
  }
    
}


//Good
module BaseShape(length,height,thickness,curveDia,barrelThickness,pinDia,res=40){
    hull(){
        translate([(length-curveDia/2)/2,height/2-curveDia/2,0])
            cylinder(r=curveDia/2,h=thickness,center=true,$fn=res);
        
         translate([-(length-curveDia/2)/2,height/ 2-curveDia/2,0])
            cylinder(r=curveDia/2,h=thickness,center=true,$fn=res);
        
        translate([-(length-curveDia/2) /2,-height/2-curveDia/2,0])
            cylinder(r=curveDia/2,h=thickness,center=true,$fn=res);
        
         translate([(length-curveDia/2)/2,-height/2-curveDia/2,0])
            cylinder(r=curveDia/2,h=thickness,center=true,$fn=res);
        
        cube(size=[length-curveDia/2,height,thickness],center=true);
    }   
}

//Good
module BoltHoles(length,height,thickness,curveDia,barrelThickness,pinDia,res=40){
    
   
    if (numberOfBoltHoles == 2){
        
    translate([-length/3+boltDia/2*n,height/2-boltDia*n,0])
        cylinder(r=boltDia/2+n*.2, h = thickness*2,center=true,$fn=res);
        
        mirror([0,1,0])
     translate([-length/3+boltDia/2*n,height/2-boltDia*n,0])
       cylinder(r=boltDia/2+n*.2, h = thickness*2,center=true,$fn=res);
    }
    
    if (numberOfBoltHoles == 3){
        translate([length/6,height/2-boltDia*n,0])
        cylinder(r=boltDia/2+n*.2, h = thickness*2,center=true,$fn=res);
        
        mirror([0,1,0])
     translate([length/6,height/2-boltDia*n,0])
        cylinder(r=boltDia/2+n*.2, h = thickness*2,center=true,$fn=res);
        
        translate([-length/3,0,0])
        cylinder(r=boltDia/2+n*.2, h = thickness*2,center=true,$fn=res);
    }

}

//Good
module Pin(height,headDia1,headDia2,res=40){
   
    rotate([90,0,0])
    cylinder(r1=headDia1/2-.5,r2=headDia2/2-.5,h=height,center=true,$fn=res);
    
}


//Good
module BodyA(length,height,thickness,curveDia,barrelThickness,pinDia,res=40){
    difference(){
   
        BaseShape(length,height,thickness,curveDia,barrelThickness,pinDia,res=40);
    
   BoltHoles(length,height,thickness,curveDia,barrelThickness,pinDia,res=40);
    
     rotate([90,0,0])
        translate([length/2+pinDia/4+n*.2/2+barrelThickness/2,0,0])
            cylinder(r=pinDia/2+n*.2+barrelThickness,h=1/3*height,center=true,$fn=res);
        
        rotate([90,0,0])
        translate([length/2+pinDia/4+n*.2/2+barrelThickness/2,0,0])
        
            cylinder(r=pinDia/2+n*.2+barrelThickness,h=1/3*height,center=true,$fn=res);
        
    
}
 translate([length/2+pinDia/2+n*.2+barrelThickness,-height/3,0])
    Barrel(length,height,thickness,curveDia,barrelThickness,pinDia,res=40);
    
        translate([length/2+pinDia/2+n*.2+barrelThickness,height/3,0])
    Barrel(length,height,thickness,curveDia,barrelThickness,pinDia,res=40);
}



//Good
module BodyB(length,height,thickness,curveDia,barrelThickness,pinDia,res=40){
 
 difference(){    
    
   BaseShape(length,height,thickness,curveDia,barrelThickness,pinDia,res=40);
   
   BoltHoles(length,height,thickness,curveDia,barrelThickness,pinDia,res=40);
    
      translate([0,-length-.5,0])
    
        Barrel(length,height,thickness,curveDia,barrelThickness+n*.2,res=40);
    
    translate([0,-.5,0])
        Barrel(length,height,thickness,curveDia,barrelThickness+n*.2,res=40);  
}
rotate([90,0,0])
    translate([length/2+pinDia/2+n*.2+barrelThickness,0,0])
difference(){
   cylinder(r=pinDia/2+n*.2+barrelThickness,h=1/3*height-1,center=true,$fn=res);
    
    cylinder(r=pinDia/2+n*.2,h=1/3*height+1,center=true,$fn=res);
    }

    
}

module FullAssembly(length,height,thickness,curveDia,barrelThickness,pinDia,headDia1,headDia2,res=40){
    
    BodyA(length,height,thickness,curveDia,barrelThickness,pinDia,res=40);
    
    translate([length+pinDia+barrelThickness*2+n*.2+1,0,0])
    rotate([0,180,0])
    
    BodyB(length,height,thickness,curveDia,barrelThickness,pinDia,res=40);
    
    translate([length/2+pinDia-barrelThickness/2,0,0])
Pin(height+1,pinDia,pinDia);

translate([length/2+pinDia-barrelThickness/2,(height+1)/2,0])
Pin(1,headDia2,headDia1);

translate([length/2+pinDia-barrelThickness/2,-(height+1)/2,0])
Pin(1,headDia1,headDia2);
    
}

if (Hinge == 1){
    
    BodyA(length,height,thickness,1,1,pinDia);
}

if (Hinge == 2) {
    
    BodyB(length,height,thickness,1,1,pinDia);
}

if (Hinge == 3){
  
    rotate([90,0,0])
    FullAssembly(length,height,thickness,1,1,6,8.5,8.5,3.5);
}