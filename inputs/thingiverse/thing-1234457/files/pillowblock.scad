holeCreationOffset=0.001;
boltLength = 18; // dimension of the bolt mount 
boltWidth = 24;// dimension of the bolt mount 
bracketLength = 30;// how long the bracket is 
bracketWidth = 34;// how wide the bracket is 
bracketHeight = 3.75;// how "thick" the bracket is 
bracketScrewHeight=50;
bracketScrewDiameter=3.5; // m3 bolt diameter + a little wiggle room
bracketScrewRadius=bracketScrewDiameter/2;
bracketScrewHeadDiameter=6; // the m3 bolt head
bracketScrewHeadRadius=bracketScrewHeadDiameter/2;
bearingLength = 24.5; // how long your bearing is
bearingDiameter = 15; // how big around it is (heh girth)
bearingRadius = bearingDiameter/2;
bearingOffset = 4.03; // the offset (from center) from the top of the bracket plate this is used by the bearing block height below. 
bearingThicknessOffset = 5;
bearingLengthOffset = 2; // the cap around the edges of the bearing
squareRadius=3; // Roundness of the bracket corners
rodDiameter=10; // center rod
rodRadius=rodDiameter/2;
bearingBlockHeight = bearingDiameter - bracketHeight + bearingOffset; 
bearingBlockWidth = bearingDiameter + bearingThicknessOffset;
bearingBlockLength = bearingLength + bearingLengthOffset;
ziptieWidth=2;
ziptieHeight=2;

echo(bearingBlockHeight);



module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn, center = true);
}
   
module cylinder_outerdual(height,radius,radiustwo,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r1=radius*fudge,r2=radiustwo*fudge,$fn=fn, center = true);
}
   
module cylinder_mid(height,radius,fn){
   fudge = (1+1/cos(180/fn))/2;
   cylinder(h=height,r=radius*fudge,$fn=fn, center = true);
}
   
module createMeniscus(h,radius) {// This module creates the shape that needs to be substracted from a cube to make its corners rounded.
    difference(){        //This shape is basicly the difference between a quarter of cylinder and a cube
       translate([radius/2+0.1,radius/2+0.1,0]){
          cube([radius+0.2,radius+0.1,h+0.2],center=true);         // All that 0.x numbers are to avoid "ghost boundaries" when substracting
       }

       cylinder(h=h+0.2,r=radius,$fn = 25,center=true);
    }
}

module roundCornersCube(x,y,z,r){  // Now we just substract the shape we have created in the four corners
    difference(){
       cube([x,y,z], center=true);

    translate([x/2-r,y/2-r]){  // We move to the first corner (x,y)
          rotate(0){  
             createMeniscus(z,r); // And substract the meniscus
          }
       }
       translate([-x/2+r,y/2-r]){ // To the second corner (-x,y)
          rotate(90){
             createMeniscus(z,r); // But this t�ime we have to rotate the meniscus 90 deg
          }
       }
          translate([-x/2+r,-y/2+r]){ // ... 
          rotate(180){
             createMeniscus(z,r);
          }
       }
          translate([x/2-r,-y/2+r]){
          rotate(270){
             createMeniscus(z,r);
          }
       }
    }
}




module bracket( ){
    difference(){ // hole assembly difference
        union() { // union of the assembly
            difference (){ // mount plate difference 
                roundCornersCube ( bracketLength,bracketWidth,bracketHeight,squareRadius); // the mount plate
                
            }
            //translate([0,0,bracketHeight/2+bearingRadius+bearingOffset]) rotate(a=90, v=[1,0,0]) cylinder(h=50,r= bearingRadius,$fn=50, center =true);    
            difference(){ // bearing block difference
                translate([0,0,bracketHeight/2+bearingRadius+bearingOffset-bearingBlockHeight/2]) roundCornersCube ( bearingBlockWidth,bearingBlockLength,bearingBlockHeight,squareRadius);
                //translate([0,0,bracketHeight/2+bearingRadius+bearingOffset]) rotate(a=90, v=[1,0,0]) cylinder_outer(bearingLength ,bearingRadius + bearingOffset/2,360);
                translate([0,0,bracketHeight/2+bearingRadius+bearingOffset]) rotate(a=90, v=[1,0,0]) cylinder(h=bearingLength+ holeCreationOffset,r= bearingRadius,$fn=50, center =true);  // the bearing hole
                translate([0,0,bracketHeight/2+bearingRadius+bearingOffset]) rotate(a=90, v=[1,0,0]) cylinder(h=bearingLength*2 ,r= rodRadius,$fn=50, center =true);  // the rod hole

            }
        
        }
        difference(){ // zip tie channel
            translate([0,0,bracketHeight/2+bearingRadius+bearingOffset-4]) rotate(a=90, v=[1,0,0]) cylinder_outer(ziptieWidth,bearingRadius +ziptieHeight*2,360);
            translate([0,0,bracketHeight/2+bearingRadius+bearingOffset-4]) rotate(a=90, v=[1,0,0]) cylinder_outer(ziptieWidth,bearingRadius+ ziptieHeight,360); // inner hole for channel
        }
                translate([boltWidth/2,boltLength/2,0]) cylinder(h=50,r= bracketScrewRadius,$fn=50, center =true); // mount holes
                translate([-boltWidth/2,boltLength/2,0]) cylinder(h=50,r= bracketScrewRadius,$fn=50, center =true);// mount holes
                translate([boltWidth/2,-boltLength/2,0])cylinder(h=50,r= bracketScrewRadius,$fn=50, center =true);// mount holes
                translate([-boltWidth/2,-boltLength/2,0])cylinder(h=50,r= bracketScrewRadius,$fn=50, center =true);// mount holes
        
        translate([boltWidth/2,boltLength/2,bracketHeight/2 + bearingBlockHeight/2+ holeCreationOffset]) cylinder(h=bearingBlockHeight,r= bracketScrewHeadRadius,$fn=50, center =true); // recessed mount holes
                translate([-boltWidth/2,boltLength/2,bracketHeight/2 + bearingBlockHeight/2+ holeCreationOffset]) cylinder(h=bearingBlockHeight,r= bracketScrewHeadRadius,$fn=50, center =true);// recessed mount holes
                translate([boltWidth/2,-boltLength/2,bracketHeight/2 + bearingBlockHeight/2+ holeCreationOffset])cylinder(h=bearingBlockHeight,r= bracketScrewHeadRadius,$fn=50, center =true);// recessed mount holes
                translate([-boltWidth/2,-boltLength/2,bracketHeight/2 + bearingBlockHeight/2 + holeCreationOffset])cylinder(h=bearingBlockHeight,r= bracketScrewHeadRadius,$fn=50, center =true);// recessed mount holes
    }
}

bracket( );
