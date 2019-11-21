/* [Basic] */
thickness=0.75;
units="inch";//[inch,mm]
drillsize=0.375;
platethick=0.5;
woodremain=0.625;

/* [Advanced] */
angle=15; //[10:45]
holespacing=1;
th=0.125;
totallength=4;
bump=0.125;
collarod=0.438;
collarlen=0.7;

/* [hidden] */
inmm=25.4;
cf=units=="inch"?inmm:1;
tl=totallength-bump;
unittext=units=="inch"?"in":"mm";
maxh=sin(angle)*totallength*cf;
//Hex key is 2.5mm, 2.71 diameter
//56mm long
//20.3mm across
//Radiused at about 5mm

//Eyeline
if(0){
translate([-50,0,-(thickness/2)*cf]){
  rotate([0,90,0]){
    cylinder(100,1,1);
}}
}

collarset=totallength-woodremain;

//rotate([angle,0,0]){cylinder(1000,5,5,$fn=120);}
//tl is the distance from the end of the collar to where the wood comes out.
//For 3/4 to 3/4, Kreg recommends 1 1/4 (32mm) screws.
//Screws to penetrate to a depth of 0.622" or 15.8mm
//That is 16.4mm of the screw. Let's call it 1/2 so need approximately
//5/8 of the material remaining.
//
//Note, seems approximately you want half the screw in each piece as long as that means the screw would not exit the target material.

//            translate([0,-(drillsize+th*2)*cf,tl*cf])rotate([90,0,0]){  
//              scale(1)text(str(round(100*collarset)/100,units));
            //}
//union(){
intersection(){
//  union(){
  difference(){
    union(){
      translate([0,0,-thickness*cf/2]){

        rotate([-90+angle,0,0]){
//          union(){   
          difference(){   
            translate([-cf*(th*2+drillsize+holespacing)/2,-(drillsize*cf/2+th*cf),0]){
              cube([cf*(th*2+drillsize+holespacing),tan(angle)*totallength*cf,tl*cf]);

            }
            //Collar position text
            translate([-cf*(th*2+drillsize+holespacing)/2+1,-(drillsize/2+th)*cf+1,tl*cf-22])rotate([90,0,0]){  
              linear_extrude(2)text(str("C ",round(100*collarset)/100,unittext),5);
            }
            //Total length text
            translate([-cf*(th*2+drillsize+holespacing)/2+1,-(drillsize/2+th)*cf+1,tl*cf-13])rotate([90,0,0]){  
              linear_extrude(2)text(str("L ",totallength,unittext),5);
            }
            
        }
          
        //Collar1
        translate([holespacing/2*cf,0,0]){
          cylinder(tl*cf+bump*cf,drillsize*cf/2+th*cf,drillsize*cf/2+th*cf,$fn=24);
        }
        //Collar2
        translate([-holespacing/2*cf,0,0]){
          cylinder(tl*cf+bump*cf,drillsize*cf/2+th*cf,drillsize*cf/2+th*cf,$fn=24);
        }


        }
      }
      //Clamp plate
      translate([-cf*(th*2+drillsize+holespacing)/2,0,0]){
       cube([cf*(th*2+drillsize+holespacing),tl*cf*cos(angle)-(th+drillsize/2)*cf*sin(angle),platethick*cf]);
      }

    }
    translate([0,0,-thickness*cf/2]){
      rotate([-90+angle,0,0]){
        //Hole1
        translate([holespacing/2*cf,0,0]){
          cylinder(totallength*cf*1.1,drillsize*cf/2,drillsize*cf/2,$fn=24);
        }
        //Hole2
        translate([-holespacing/2*cf,0,0]){
          cylinder(totallength*cf*1.1,drillsize*cf/2,drillsize*cf/2,$fn=24);
        }
        //Metal1
        translate([holespacing/2*cf,0,(tl+bump-collarlen)*cf]){
          cylinder(collarlen*cf+0.01,collarod/2*cf,collarod/2*cf,$fn=24);
        }
        //Metal2
        translate([-holespacing/2*cf,0,(tl+bump-collarlen)*cf]){
          cylinder(collarlen*cf+0.01,collarod/2*cf,collarod/2*cf,$fn=24);
        }



      }
    }
//    translate([-500,-500,-1000]){cube([1000,1000,1000]);}
    //hanger
    translate([0,6,0])cylinder(maxh,2,2,$fn=12);
    
    //Finger grips
    translate([-cf*(th*2+drillsize+holespacing)/2-1,20,0])cylinder(maxh,2,2,$fn=12);
    translate([-cf*(th*2+drillsize+holespacing)/2-1,25,0])cylinder(maxh,2,2,$fn=12);
    translate([-cf*(th*2+drillsize+holespacing)/2-1,30,0])cylinder(maxh,2,2,$fn=12);
    translate([-cf*(th*2+drillsize+holespacing)/2-1,35,0])cylinder(maxh,2,2,$fn=12);

    //Finger grips
    translate([cf*(th*2+drillsize+holespacing)/2+1,20,0])cylinder(maxh,2,2,$fn=12);
    translate([cf*(th*2+drillsize+holespacing)/2+1,25,0])cylinder(maxh,2,2,$fn=12);
    translate([cf*(th*2+drillsize+holespacing)/2+1,30,0])cylinder(maxh,2,2,$fn=12);
    translate([cf*(th*2+drillsize+holespacing)/2+1,35,0])cylinder(maxh,2,2,$fn=12);

    //Bevel
    translate([-cf*(th*2+drillsize+holespacing)/2-2,-1,2])rotate([-135,0,0])cube([cf*(th*2+drillsize+holespacing)+4,4,4]);
    
    //Dust hole
    translate([-cf*(drillsize+holespacing)/2,(tl*cf*cos(angle)-(th+drillsize/2)*cf*sin(angle))*0.45,platethick*cf/2]){
    cube([cf*(drillsize+holespacing),10,maxh]);
    }

    //Hex holder
    translate([-cf*(th*2+drillsize+holespacing)/2-2,10,5]){
      rotate([0,90,0])cylinder(cf*(th*2+drillsize+holespacing)+4,2.75/2,2.75/2,$fn=12);
    }

    //Vanity
                translate([cf*(th*2+drillsize+holespacing)/2-2,15,platethick*cf-1])rotate([0,0,180]){  
              linear_extrude(2)text("3D.RTCONS.COM",3);
            }



  }
  translate([-cf*(th*2+drillsize+holespacing)/2-2,0,0]){cube([cf*(th*2+drillsize+holespacing)+4,totallength*1.2*cf,maxh]);}
}

