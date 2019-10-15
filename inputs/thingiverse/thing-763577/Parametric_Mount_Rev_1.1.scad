/*Rev 1.1  14/4/15
Coded by Siti

Downloaded from http://www.thingiverse.com/thing:763577

**use code as you like but give credit where credit is due!**
*/


//length of support
length=50;
//Diameter of device body.
Body_Diameter = 40;
//Diameter of collar or shaft.
Collar_Diameter = 20;
//Number of mounting points on device.
Mount_Points =3;// [0,1,2,3,4,5,6,7,8,9,10]
//Height of body centre above mount base.
Body_Height = 35;
//PCD, Diameter of circle that intersects mounting point centres
Pitch_Circle_Diameter = 33;
//Diameter of holes for device mounting screws
Mounting_Holes_Diameter = 5;
//Include feet in model
Add_Feet = 1;//[1:Yes, 0:No]
//Diameter of holes in feet
Feet_Hole_Diameter = 5;

//Vertical offset of shaft from body (only required for offset shafts, eg Pololu gearboxes).
Shaft_Offset = 0;
//Rotate mounting holes to have one or two holes at bottom (may be required for offset shafts).
Rotate_Holes = 1;//[1:Yes, 0:No]
//Depth of screw countersink holes (0 = no countersink).
Screw_Countersink_Depth = 0;
//Diameter of screw countersinks.
Screw_Countersink_Diameter = 8;
//Add full support ring.
Full_Ring=1;//[1:Yes, 0:No]
//Thicness of front support
Support_Thickness = 5;
//Tolerance between device dimensions and 3D object.
Tolerance = 0.2;
//Polygon Count
Polygon_Count=128;//[32:low, 64:Medium, 128:high, 256:Insane]


bodyR=Body_Diameter/2+Tolerance;//radius of body
width=bodyR*2+4;//width of base
collarR = Collar_Diameter/2+Tolerance*2;//radius of collar
PCR = Pitch_Circle_Diameter/2; //pitch circle radius of mounting screws
supportC =4*1;//support cutoff from Body_Height

numPads = min(ceil(length/45),3);//number of pads per side to place (max 3)
holePos = 0*1;

module pad(){
difference(){
union(){
translate ([Feet_Hole_Diameter*3/2,0,2.5])cylinder(d=Feet_Hole_Diameter*3, h=5, center=true, $fn=Polygon_Count);//pad
    translate ([0,0,2.5])cube([Feet_Hole_Diameter*3, Feet_Hole_Diameter*3,5], center=true);//pad
//objects to add
};
     translate ([Feet_Hole_Diameter*3/2,0,5])cylinder(d=Feet_Hole_Diameter, h=12, center=true, $fn=Polygon_Count);//pad;
}}


difference(){
//objects to add
union(){
    
    
    //add top ring and extra support
    if(Full_Ring){
    translate ([(length+Support_Thickness)/2,0,Body_Height])rotate([0,90,0])cylinder(d=Body_Diameter, h=Support_Thickness, $fn=Polygon_Count, center=true);
        translate([(length+Support_Thickness)/2,0,Body_Height-width/4])cube([Support_Thickness,width,width/2], center=true);
    }
    
    

translate ([0,0,Body_Height/2-supportC/2])cube([length,width,Body_Height-supportC], center=true);//base
    
    translate ([length/2+Support_Thickness/2,0,Body_Height/2-supportC/2])cube([Support_Thickness,width, Body_Height-supportC], center=true);//support
    
    //add mounting feet if required.
    
  if(numPads*Add_Feet==1)
  {
        
   translate([Support_Thickness/2,width/2,0])rotate ([0,0,90]) pad();
     translate([Support_Thickness/2,-width/2,0])rotate ([0,0,-90]) pad();
    
  }
  
    if(numPads*Add_Feet==2)
  {
        
   translate([length/2-Feet_Hole_Diameter*2+Support_Thickness,width/2,0])rotate ([0,0,90]) pad();
     translate([-length/2+Feet_Hole_Diameter*2,-width/2,0])rotate ([0,0,-90]) pad();
    translate([-length/2+Feet_Hole_Diameter*2,width/2,0])rotate ([0,0,90]) pad();
     translate([length/2-Feet_Hole_Diameter*2+Support_Thickness,-width/2,0])rotate ([0,0,-90]) pad();
  }
  
    if(numPads*Add_Feet==3)
  {
      
      //center feet
   translate([Support_Thickness/2,width/2,0])rotate ([0,0,90]) pad();
     translate([Support_Thickness/2,-width/2,0])rotate ([0,0,-90]) pad();
      //end feet
       translate([length/2-Feet_Hole_Diameter*2+Support_Thickness,width/2,0])rotate ([0,0,90]) pad();
     translate([-length/2+Feet_Hole_Diameter*2,-width/2,0])rotate ([0,0,-90]) pad();
    translate([-length/2+Feet_Hole_Diameter*2,width/2,0])rotate ([0,0,90]) pad();
     translate([length/2-Feet_Hole_Diameter*2+Support_Thickness,-width/2,0])rotate ([0,0,-90]) pad();
  }
    
};

//objects to subtract
union(){

translate ([-0.001,0,Body_Height])rotate([0,90,0])cylinder(h=length+0.004, r=bodyR, center=true, $fn=Polygon_Count);//body cutout
    
    translate ([length/2,0,Body_Height+Shaft_Offset])rotate([0,90,0])cylinder(h=Support_Thickness*2+length+2, r=collarR, center=true, $fn=Polygon_Count);//collar/shaft cutout
    
    
             
             //work out rotation of screw holes, depends if it's odd or even, go figure
             
             rotation =(floor(Mount_Points/2)-(Mount_Points/2)==0)?360/(Mount_Points*2):90;
           
             
                    
        //screws for front
        for(i=[0:Mount_Points-1]){
           translate([0,0,Body_Height])
      rotate([i*360/Mount_Points+rotation+Rotate_Holes*360/(Mount_Points*2),0,0])
       translate ([length/2,PCR,0])
           rotate ([0,90,0])
            union(){
            cylinder (h=Support_Thickness+2,d=Mounting_Holes_Diameter, $fn=Polygon_Count);
              
            }
            
            
            
            //countersink for screw heads
              translate([0,0,Body_Height])
      rotate([i*360/Mount_Points+rotation+Rotate_Holes*360/(Mount_Points*2),0,0])
       translate ([length/2+Support_Thickness+0.001-Screw_Countersink_Depth,PCR,0])
           rotate ([0,90,0])cylinder (h=Support_Thickness+2,d=Screw_Countersink_Diameter, $fn=Polygon_Count);

} 
        
             //cutout for cable tie
            
                 holePos =(numPads==1) ? -length/3: -length/2+Feet_Hole_Diameter*4 ;
             
            translate([holePos,0,Body_Height-bodyR-3]) rotate ([90,0,0])cylinder( h=width+6, r=2, center=true, $fn=Polygon_Count);

//cutout for center weight reduction

translate ([0,0,(Body_Height+bodyR)/2]) cylinder(h=Body_Height+bodyR+2, r=min(width/3,length/3), center = true, $fn=Polygon_Count);


//trims the ring and support when body height is low.

translate([length/2+Support_Thickness/2,0,-Body_Height/2])cube([Support_Thickness+2,width+2, Body_Height+0.001],center=true);
};

}
