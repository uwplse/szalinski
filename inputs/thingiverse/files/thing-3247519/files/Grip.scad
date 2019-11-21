//iPad Pro Hand Grip
//Grip  is now the same length as the ipad.
//It feels very comfortable, and light.

//Printing - Print vertical with support.  Infill = 20%.  Very little infill used.

$fn=100;

/* Some of the measurements needed for older tablets
//iPadAir 1
thick=3;
slot=[11, 7.58];        //ipad air 1 7.59, 7.58  Actual ipad thickness is 7.47
gripL=240+1;            //1 mm for clearance

//ipadPro 1 (9.7")
thick=2.5;
slot=[10.3, 6.18];      //ipad pro 1 9.7"
gripL=240+1;            //1 mm for clearance
*/

//iPad Pro 11" dimensions
thick=2.5;
thick=2;
slot=[10,5.95+.2];      //iPadPro 3 11'
gripL=248+1;            //iPadPro 11"
gripOffset=14;          //distance from center of grip radius to ipad side
handleD=14.5;           //OD of pencil case (Apple pencil 1 and 2)
pencil=[8.9,166];       //Apple pencil 1 and 2 diameter, length

print();
//============================================================================
//                              Modules
//============================================================================
module print(){
//Lays everything out for printing.  comment out what is not needed.
    
standWidth=20;    
scale=100;   //percentage of inner cap size, adjust for overprint.  99 worked OK.
    
    cylindrical_grip(yOffset=0, hollow=true);   //Printed upside down so smoother at grip.
    support();  //Not needed if printing horizontally
    
    //print 3 caps in 1% decreasing size.  1 set should be perfect fit
    for(i=[-3:-1]){
        translate([-30,i*-40-10,thick]) rotate(180,[1,0,0]) upper_cap(scale+i);
        translate([-30,i*40+10,0]) lower_cap(scale+i);
    }
    
    //Clip on stand for landscape mode
    translate([10,-30,standWidth/2]) stand(standWidth);
    
}

//------------------------------------------------------------------------------
module cylindrical_grip(yOffset=0, hollow=true){
//handgrip
//deliver a handgrip where x=0 = back of inside of rectangular tablet grip section
//Grip lies in Y dimension as it is printed vertically

gripOffset=14;      //Center of grip radius
thick=2;
thumbLip=[2, 50, 6];//Lip to keep thumb from sliding onto tablet
cornerD=24;         //Diameter of iPad 11" corner curve
magnetZ=[34,50,69,gripL-28, gripL-45, gripL-55];  //Left hand side magnets Z position, from top to bottom
magnet=[3.05,5.98]; //h,d
tol=.25;            //printing tolerance
    
    //Make the solid blank of the round part
    translate([0,0,gripL/2]) 
    //rotate(90, [1,0,0])  
    difference(){ union(){ 
            outer_pencil_case(gripOffset, thick, gripL);
            //Grooved part of grip, tablet seats here
            translate([slot[0]/2, slot[1]/2+thick, 0]) cube([slot[0], slot[1]+thick*2, gripL], center=true);
            
            //edge for thumb (hull very processor intensive, so used 2 statements)
            for(i=[-1:2:1])  translate([slot[0]-1,slot[1]+thick*2,i*(gripL/2-1)]) sphere(d=2);
            translate([slot[0]-1,slot[1]+thick*2,0]) cylinder(h=gripL-2, d=2, center=true);
            
            //Thumbgrip
            translate([slot[0]-thumbLip[0],slot[1]+thick*1.5,-gripL/2+60]) hull(){ for(i=[-1:2:1]) 
                translate([0,0,i*thumbLip[1]/2]) rotate(90,[0,1,0])  cylinder(h=thick, d=6); }
        }//end union()
        
        //Now hollow out     
     if (hollow==true) union(){ difference(){ 
                inner_pencil_case(gripOffset, thick, gripL);
                D=25;
                translate([-D/2,D/4,-gripL/2+190]) cylinder(h=thick*2, d=D);  //bottom partiton
            }//end difference()
            translate([cornerD/2, slot[1]/2+thick, 0]) hull(){  //Slot
                for(i=[-1:2:1]) translate([0,0,i*(gripL-cornerD)/2])  
                     rotate(90,[1,0,0]) cylinder(d=cornerD, h=slot[1], center=true);
            }//end hull() 
            for(i=[0:5]) translate([-magnet[0]/2, slot[0]/2,magnetZ[i]-gripL/2]) rotate(90,[0,1,0]) 
                color("Red") cylinder(h=magnet[0]+tol, d=magnet[1]+.1, center=true);
        }//end union()
                
    }//end difference()
    support();

}//end module
//------------------------------------------------------------------------------
module outer_pencil_case(gripOffset, thick, length){
    
    hull(){  //Rounded part of grip, holds pencil, outside
                translate([-gripOffset,handleD/2,0]) cylinder(h=length, d=handleD, center=true);
                translate([-thick*1.5, slot[1]/2+thick, 0]) cube([thick*3,slot[1]+thick*2, length],center=true);
           }//end hull() 
}
//------------------------------------------------------------------------------
module inner_pencil_case(gripOffset, thick, length){
    hull(){ //pencil holder inside
        translate([-gripOffset,handleD/2,0]) cylinder(h=length+.01, d=handleD-thick*2, center=true);
        translate([-thick*3, slot[1]/2+thick+.5, 0]) cube([.01,slot[1]+1, length],center=true);
    }//end hull()
    
}
//------------------------------------------------------------------------------
module support(){
//support for printing vertical with ABS
//If printing with non warping material, print horizontally for strength.
    
    translate([50,-15,0]) cube([50,30,2]);
    hull(){
        //translate([75,0,0]) rotate(60) cylinder(d=25,h=1, $fn=3);
        translate([75,0,0]) rotate(60) cylinder(d=20,h=1, $fn=50);
        translate([10,0,75]) cube([1,1,20]);
    }

    translate([-2,50,0]) cube([30,50,2]);
    hull(){
        //translate([13,75,0,]) rotate(30) cylinder(d=30,h=1, $fn=3);
        translate([13,75,0,]) rotate(30) cylinder(d=20,h=1, $fn=50);
        translate([13,0,72]) cube([1,1,20]);
    }
}
//------------------------------------------------------------------------------
//upper_cap(scale=100);
module upper_cap(scale=100){
//length=2;
thick=2;
gripOffset=14;
inset=5;                //Inner Z height of cap
SR=.8;                  //Y/X scale ratio
    
SF=(100-scale)/100;     //scale factor (%).  This is the only variable that can change
    
    translate([0,0,thick/2]) outer_pencil_case(gripOffset, thick, thick);
    translate([0,0,-inset/2]) scale([1-SF, 1-(SF*SR), 1]) inner_pencil_case(gripOffset, thick, inset);
}
//------------------------------------------------------------------------------
//lower_cap();
module lower_cap(scale=100){
//length=2;
thick=2;
gripOffset=14;
inset=5;                //Inner Z height of cap    
SR=.8;                  //Y/X scale ratio
SF=(100-scale)/100;     //scale factor (%).  This is the only variable that can change

    translate([0,0,thick/2]) outer_pencil_case(gripOffset, thick, thick);
    translate([0,0,inset-.5]) scale([1-SF, 1-(SF*SR), 1]) 
        inner_pencil_case(gripOffset, thick, inset);
        
}

// ------------------------------------------------------------------------------
//stand(width=20);
module stand(width=10){
    
//On a soft surface, 1 of these will do.  On a hard surface, 2 needed to keep from rocking
    
scale=130;
SR=.8;                  //Y/X scale ratio
SF=(100-scale)/100;     //scale factor (%).  This is the only variable that can change
D=3;                    //Diameter of rounded chamfers
wedgeL=100;             //Length of triangular section

    translate([thick*3,0,0]) difference(){  //Outer curve of part the tablet sits in
        scale([1-(100-scale)/100*SR, 1-(100-scale)/100, 1]) 
            outer_pencil_case(gripOffset, thick, width);
        //Erase inside, 1% smaller hole than tablet case so not too tight
        translate([-thick, thick,0]) scale([1, 1-(101-100)/100*SR, 1]) 
            outer_pencil_case(gripOffset, thick, width+1);
        translate([thick, 20/2,0]) cube([10, 20, width+1],center=true);
    }

    //translate([thick*3,0,0]) translate([thick, 20/2,0]) cube([10, 20, width+1],center=true);
    
    //foot
    difference(){   //Wedge shaped piece
        hull(){
            hull(){
                //translate([10+3-D/2,.5,-width/2]) cylinder(h=width, d=D);
                translate([10+D/2,.5,-width/2]) cylinder(h=width, d=D);
                translate([-10-D,.5,-width/2]) cylinder(h=width, d=D);
            }
            translate([6, -wedgeL,-width/2]) cylinder(h=width, d=D);
        }//end hull()
        hull(){
            hull(){
                translate([10-D/2,-D+.5,-width/2-.01]) cylinder(h=width+1, d=D);
                translate([-10,-D+.5,-width/2-.01]) cylinder(h=width+1, d=D);
            }//end hull()
            translate([5, -(wedgeL-15),-width/2-.01]) cylinder(h=width+1, d=D); 
        }//end hull()   
    }//end difference(){
    
}
// ------------------------------------------------------------------------------
/*
Changelog


*/
