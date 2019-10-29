//Redbull can tank


RedBullcandiameter = 54;//55;//measured 53:10
RBRad = RedBullcandiameter/2;

beltthick = 2;
beltwidth = 12;
beltrad = RBRad+beltthick;
beltCanOverlap = 10;
RivetHeight = 1;
RivetRad = 2;

spherewallthick = 1.5;
innerRad = RBRad-spherewallthick;


Part();
module Part(){
    OuterDome();
    Belt();
    
    //endNub
    translate([0,0,beltCanOverlap+RBRad])
    Nub(4,1);
    Rivets(16);
    Foot();
}

module Foot(){
    difference(){
        translate([-(RBRad/2),-(beltrad+RivetHeight),0])
        cube([RBRad,10,beltwidth]);
        translate([0,0,-1])
        cylinder(beltCanOverlap+1,RBRad,RBRad,$fn=50);
        translate([0,0,-.001+beltCanOverlap])
        InnerDome();
    }
}

//Rivets(8);
module Rivets(count){
    angle = 360/count;
    for(a=[0:1:count-1]){
        rotate([0,0,a*angle]){
           Rivet(beltrad,(beltwidth/2)); 
        }
    }        
}

//Rivet(beltrad,(beltwidth/2));
module Rivet(Rad,elevation){
    Radadj = 0;
    translate([Rad+Radadj,0,elevation])
    rotate([0,90,0]){
        //ButtonTop(RivetRad,RivetHeight,$fn=45);
        RoundTop(RivetRad,RivetHeight);
        translate([0,0,-(beltthick-.001)])
        cylinder(beltthick,RivetRad,RivetRad,$fn=45);
        //cylinder(beltthick,RivetRad+RivetHeight,RivetRad+RivetHeight,$fn=45);
    }
}



module Nub(nubdia,fillet){
    nubrad = nubdia/2;
        //ButtonTop(nubrad,fillet);
        RoundTop(nubrad+fillet,fillet);
        translate([0,0,-spherewallthick])
        cylinder(spherewallthick,nubrad+fillet,nubrad+fillet,$fn=50);
    
    
}


//OuterDome();
module OuterDome(){
    translate([0,0,beltCanOverlap]){
        difference(){
            Hemisphere(RBRad);
            translate([0,0,-.001])
            InnerDome();
        }
    }
}

//Belt();
module Belt(){
    difference(){
        cylinder(beltwidth,beltrad,beltrad,$fn=50);
        translate([0,0,-.001]){
            cylinder(beltCanOverlap,RBRad,RBRad,$fn=50);
            cylinder(beltwidth+1,innerRad,innerRad,$fn=50);
        }
    }
}

//InnerDome();
module InnerDome(){
    difference(){
        Hemisphere(innerRad);  
        //HollowSphere_rays(innerRad+.01,spherewallthick*2,8);
    }
}

//Hemisphere(5);
module Hemisphere(Rad){
    difference(){
        sphere(Rad,$fn=50);
        translate([0,0,-(Rad+1)])
        cylinder(Rad+1,Rad+1,Rad+1,$fn=50);
    }
}

//RoundTop(5,2);
module RoundTop(Rad,Height){
    DomeRad = ((Height*Height)+(Rad*Rad)) / (2*Height);
    difference(){
        //Dome
        translate([0,0,Height])
        translate([0,0,-DomeRad])
        sphere(DomeRad, $fn=50);
        
        //mask
        translate([0,0,-(DomeRad*2)])
        cylinder(DomeRad*2,DomeRad+1,DomeRad+1,$fn=32);
    }
}

//ButtonTop(5,2);
module ButtonTop(Rad,Height){
    
    difference(){
        union(){
            translate([0,0,-1])
            cylinder(Height+1,Rad,Rad,$fn=50);
            torus(Rad,Height);
        }
        translate([0,0,-(Height+1)])
        cylinder(Height+1,Rad+Height+1,Rad+Height+1,$fn=50);
    }
}

//torus(5,2);
//cylinder(2,5,5);
module torus(rad,tuberad){
    rotate_extrude(convexity = 15, $fn = 50)
    translate([rad, 0, 0])
    circle(tuberad, $fn = 50);
}




module AcuteWedgeMask(Height,Rad,Angle){
    //creates a mask to be differences with a shape to make a wedge
    H = 2+(Height);
    R = Rad+2;
    rotate([0,0,-Angle/2]){
        difference(){
            translate([0,0,+.5]){
                cylinder(H-2,R-1,R-1,$fn = 22.5);
            }
            translate([0,0,-1])
            difference(){
                //first create a cylinder representing our object
                cylinder(H,R,R,$fn = 22.5);
                union(){
                    //overlap to rectangles, rotating one.
                    translate([-R,0,-1]) cube([2*R,R,H+2]);
                    rotate([0,0,180+Angle])
                    translate([-R,0,-1]) cube([2*R,R,H+2]);
                }
            }
        }
    }
}





module HollowSphere_rays(rad,wallthick,raycount){
    sphereresolution = 90;
    rayThick = wallthick/2;
    rayRad = rad - rayThick/2;
    intersection(){
        HollowSphere(rayRad,rayThick);
        union(){
            for(a=[0:1:(raycount/2)]){
                rotate([0,0,(360/raycount)*a]){
                    translate([-rayRad,-wallthick/4,-rayRad]){
                        cube([2*rayRad,wallthick/2,2*rayRad]);
                    }
                }
            }
        }
    }
}

module HollowSphere(rad,wallthick){
    sphereresolution = 90;
    difference(){
        sphere(rad,$fn = sphereresolution);
        sphere(rad-wallthick,$fn = sphereresolution);
    }
}










