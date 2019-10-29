/*
parametric optical chopper "blades". It creates a cylinder with slits that are used to let light through with certain intervals and for specified amounts of time. 
    parameters that can be defined by the user:
    - rotation frequency
    - blade diameter
    - blade thickness
    - duration of each scanning line
    - amount of time the stimulus light should be blocked.
    - diameter of the central holding part
    - style of the slit to be created
*/

/*
units:
mm, degrees, milliseconds, Hz
*/

rotateF = 50;/*rotation frequency degrees*/
bladeD = 100;/*blade diameter mm*/
bladeT = 0.9;/*blade thickn mm*/
lineDur = 2; /*total time in between slits ms*/
blankTime = 1.6;/*time in covered area ms*/
centerD = 35;/*central circle mm*/
slitStyle = 0; /*type of slit to be used 
                0 = regular "pizza slice"
                1 = shape1...*/
 

 
nSlits =  (1000/rotateF)/lineDur;
slitSize = (360*(lineDur-blankTime))/
           (1000/rotateF); //in degrees
/*the next variable is to "trick" the
optical chopper, since it normally 
uses blades that have evenly spaced slits,
with equal block and pass periods. Since
the device has a feedback system that aligns
input signal with feedback, our "uneven"
blades would probably make it go crazy*/

slitLineDur = ((360*(lineDur/2))/              (1000/rotateF)); //in degree
         
echo(slitLineDur);
module slit(slitL,slitH,slitSize1){
///////// main slit//////////
intersection(){
    cylinder(h=slitH+30,
          d=slitL,
          center=true,
          $fn=50);
    cube([slitL/2,
          slitL/2,
          slitH+10],
          center=false);
    rotate([0,0,-90+slitSize1]){
    //translate([slitL/2,slitL/2,0]){
    cube([slitL/2,
          slitL/2,
          slitH+20],
          center=false);
 }//end rotate
}//end intersection
////////////////////////////

}//end module 

module customSlit1(slitL,slitH){}



module allSlits(slitNum,slitL,slitH,midHole){
difference(){
    union(){
  for (a =[1:slitNum]){
    rotate([0,0,(a*(360/slitNum))]){ 
        slit(bladeD*0.95,bladeT,slitSize);
    difference(){
        slit(bladeD*0.95,bladeT,slitLineDur);
     translate([0.001,0.001,0]){
        slit(bladeD*0.90,bladeT,slitLineDur);
         }//end translate
     }//difference
 }//end rotate
 }//end for
  
     
  
 }//end union
 cylinder(d=midHole,h=80,center=true);
}//end difference
}//end module

module mount_holes(){
    cylinder(h=10,d=6,center=true,$fn=50);
    //cylinder(h=5,d=25,center=true,$fn=3);
    translate([16,0,0]){
        //text("1",5);
    cylinder(h=5,d=1,center=true,$fn=50);
        }//end translate
    translate([12,0,0]){
        //text("1",5);
    cylinder(h=10,d=3,center=true,$fn=50);
        }//end translate
        
    translate([-6.5,10,0]){
        //text("2",5);
    cylinder(h=10,d=3,center=true,$fn=50);
        }//end translate
    translate([-6,-11,0]){
        //text("3",5);
    cylinder(h=10,d=3,center=true,$fn=50);
        }//end translate
    }//end module
// 
difference(){
    difference(){
        cylinder(h=bladeT,
            d1=bladeD,
            d2=bladeD,
            center=true,$fn=50);
        translate([0,0,-2*bladeT]){
            if (slitStyle==0) {
                allSlits(nSlits,bladeD-10,          bladeT,centerD);}//end if
            if (slitStyle==1) {}//end if    
        }//end translate
//
}//end difference
rotate([0,0,90])    
mount_holes();}//end difference
    
