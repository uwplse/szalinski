/* Open SCAD Name.: EchoBase_v1
*  Copyright (c)..: 2016 www.DIY3DTech.com
*
*  Creation Date..: 07052016
*  Discription....: Cord Wraped base for Amazon Ehco
*
*  Rev 1: Develop Model
*  Rev 2: 
*
*  For Personal Use ONLY! (all commercial referance is prohibited)
*
*  This program is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*/ 

/*------------------Customizer View-------------------*/

// preview[view:north, tilt:top]

/*---------------------Parameters---------------------*/

//Diameter of Amazon Echo Base (mm)
echo_base = 84.8; //[84:0.1:86]
//Amount of Area for Wire Storage in Base (mm)
wire_storage = 20; //[10:1:30]
//Wall Thickness (mm)
wall = 3; //[2:0.5:7]
//Resolution of Circles (suggest at least 100)
sides = 150; //[60:5:150]
//Number of Rocket Fins
fin_count = 4; //[2:1:12]

/*-----------------------Execute----------------------*/

 echo_base();


/*-----------------------Modules----------------------*/

module echo_base(){ //create module
    difference() {
            union() {//start union
                
                // create base for Amazon Echo stand
                translate([0,0,0]) rotate([0,0,0]) cylinder(22+wall,(echo_base+wire_storage+(wall*2))/2,(echo_base+(wall*2))/2, $fn=sides, true);
                
             
         //create circle pattern for fins
        for (i=[0:(360/fin_count):360]) {
            //theta is degrees set by for loop from 0 to 360 (degrees)
            theta=i;
            //this sets the x axis point based on the COS of the theta
            x=0+((echo_base/11)/2)*cos(theta);
            //this sets the y axis point based on the sin of the theta
            y=0+((echo_base/11)/2)*sin(theta);
            //this creates the circle or other obect at the x,y point
            translate([x,y,0]) rotate([0,0,i])fin();
        }//end for loop for circle creation
                

           } //end union
                            
    //start subtraction of differance
                    
    //remove for Echo Base
    translate([0,0,wall]) rotate([0,0,0]) cylinder(22+wall,echo_base/2,echo_base/2, $fn=sides, true);
    //remove ring area for wire storage
    translate([0,0,-2]) rotate([0,0,0]) ring();
    //remove keyhole 1 to allow the plug to pass though
    translate([((echo_base)/2)*cos(45),((echo_base)/2)*sin(45),0]) rotate([-45,90,0]) keyhole(10,15,wall*2);
    //remove keyhole 1 to allow the plug to pass though
    translate([((echo_base+wire_storage)/2)*cos(45),((echo_base+wire_storage)/2)*sin(45),-5]) rotate([-45,90,0]) keyhole(6,9,wall*2);                
                                               
    } //end differance
}//end module

module ring(){ //create module
    difference() {
            union() {//start union
                
                // create base for Amazon Echo stand
                translate([0,0,0]) rotate([0,0,0]) cylinder(22+wall,(echo_base+wire_storage+(wall*1))/2,(echo_base+(wall*1))/2, $fn=60, true);
                        
                    } //end union
                            
    //start subtraction of differance
    translate([0,0,0]) rotate([0,0,0]) cylinder(22+wall,(echo_base+(wall*1))/2,(echo_base+(wall*1))/2, $fn=60, true);
                                               
    } //end differance
}//end module

module keyhole(width,height,depth){ //create module
    
            union() {//start union
                
                // create base for Amazon Echo stand
               translate([0,0,0]) rotate([0,0,0]) cylinder(depth,width/2,width/2, $fn=60, true);
                translate([height/2,0,0]) rotate([0,0,0]) cube([height,width,depth],true);
                        
             } //end union

}//end module

module fin(){ //create module
    
            union() {//start union
                
             translate([0,0,0]) rotate([90,0,0]) linear_extrude(height = wall, center = true, convexity = 10, twist = 0) polygon([[echo_base/2,((22+wall)/2)],[echo_base/2,-((22+wall)/2)],[echo_base,-((22+wall)/2)],[echo_base,0]], paths=[[0,1,2,3]]);
                translate([echo_base,0,-6]) rotate([0,0,0]) cylinder(((22+wall+1)/2),6,3, $fn=sides, true);
                        
             } //end union

}//end module
                                       
/*----------------------End Code----------------------*/