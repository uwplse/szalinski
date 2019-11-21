//parametric box by Lars Baronat 2015 Creative Commons - Attribution - Non-Commercial

/* [Basic Settings] */
//inner dimensions in mm
length=50;
width=50;
height=50;

//number of latches
latches=1;

/* [Display Options] */

print=1;    //[0:Off,1:On]

close=0;    //[0:90]
lock=0;     //[0:unlocked,1:locked]



//===========================================================================
//code for the box

//base
difference(){
	translate([0,0,height/4-1.25])cube([length,width+6,height/2+2.5],center=true);
	translate([0,0,height/4+0.5])cube([length+1,width,height/2+1],center=true);	
	translate([length/2,(width+6)/2,height/4+2.5])cube([3,3,height/2],center=true);
	translate([length/2,-(width+6)/2,height/4+2.5])cube([3,3,height/2],center=true);
	translate([-length/2,(width+6)/2,height/4+2.5])cube([3,3,height/2],center=true);
	translate([-length/2,-(width+6)/2,height/4+2.5])cube([3,3,height/2],center=true);
    translate([0,(width+6)/2,height/2])cube([length,3,3],center=true);
    translate([0,-(width+6)/2,height/2])cube([length,3,3],center=true);
    translate([length/2,0,-1.5])cube([0.5,width,4],center=true);
    translate([-length/2,0,-1.5])cube([0.5,width,4],center=true);
}

//hinge(base part)
for(x=[0,180]){
	rotate(x)for(y=[-width/2-1.5,width/2+1.5]){
		difference(){
			union(){
				translate([length/2+1.25,y,0])cube([2.5,3,5],center=true);
				translate([length/2+2.5,y,0])rotate(90,[1,0,0])cylinder(h=3,r=2.5,center=true,$fn=50);
			}
			translate([length/2+2.5,y,0])rotate(90,[1,0,0])cylinder(h=38,r=1.75,center=true,$fn=50);
		}
	}
}

//lid
for(side=[0,180])rotate(side)translate([length/2+2.5,0,0])rotate(90-(close-close*print),[0,1,0]){
	rotate(90,[1,0,0])cylinder(h=width+6,r=1.25,center=true,$fn=50);
	difference(){
		union(){
			translate([0,0,height/2])cube([5,width+6,height],center=true);
			rotate(90,[1,0,0])cylinder(h=width+6,r=2.5,center=true,$fn=50);
		}
		for(y=[-width/2-1.5,width/2+1.5]){
			translate([0,y,0])rotate(90,[1,0,0])cylinder(h=3.5,r=3,center=true,$fn=50);
			translate([-1.5,y,1.5])cube([3,3.5,3],center=true);
		}
	}
	for(y=[-width/2-1.5,width/2+1.5]){
		difference(){
			translate([-length/4-2.5,y,3*height/4])cube([length/2,3,height/2],center=true);
			translate([-length/2-2.5,y+1.5,3*height/4])cube([1.5,3,height/2+1],center=true);
		}
		translate([-length/2-2.5,y-0.75,3*height/4])cube([1.5,1.5,height/2],center=true);
	}

	translate([-(length/2-0.75)/2-2.5,width/2+2.25,height/2])cube([length/2-0.75,1.5,3],center=true);
    translate([-(length/2+0.75)/2-2.5,-width/2-2.25,height/2])cube([length/2+0.75,1.5,3],center=true);
	translate([-3.25,width/2+2.25,height/4+3])cube([1.5,1.5,height/2],center=true);
	translate([-3.25,-width/2-2.25,height/4+3])cube([1.5,1.5,height/2],center=true);

	translate([-(length/2+5)/2+2.5,0,height+1.25])cube([length/2+5,width+6,2.5],center=true);

	if(side==0){    //hook
        for(k=[1:latches]){
            translate([-length/2+7.5,-width/2+k*width/(latches+1),height+2.5])difference(){
                rotate(90,[1,0,0])cylinder(h=9.5,r=6,center=true,$fn=50);
                translate([0,0,2.5])rotate(90,[1,0,0])cylinder(h=10,r=2.5,center=true,$fn=50);
                translate([3.5,0,0])cube([7,10,13],center=true);
                translate([0,0,-3.5])cube([12,10,6],center=true);
            }
        }
	}
	else{           //hinge for latch
        for(k=[1:latches]){
            translate([-length/2+2.5,-width/2+k*width/(latches+1),height+5]){
                difference(){
                    union(){
                        rotate(90,[1,0,0])cylinder(h=5,r=2.5,center=true,$fn=50);
                        translate([0,0,-2.5])cube([5,5,5],center=true);
                    }
                    rotate(90,[1,0,0])cylinder(h=6,r=1.25,center=true,$fn=50);
                }
                if(print==0){
                    latch(lock,0);
                }
            }
        }
	}
}

module latch(lock,seperate){
    rotate(lock*90,[0,1,0]){
        translate([-2.5,2.75,0])cube([5,2,20]);
        translate([0,4.75,0])rotate(90,[1,0,0])cylinder(h=2,r=2.5,$fn=50);
        translate([-2.5,-4.75,0])cube([5,2,20]);
        translate([0,-2.75,0])rotate(90,[1,0,0])cylinder(h=2,r=2.5,$fn=50);
        translate([0,0,20])rotate(90,[1,0,0])cylinder(h=9.5,r=2.5,center=true,$fn=50);
        translate([0,2.75,0])rotate(90,[1,0,0])cylinder(h=2,r=1,$fn=50);
        translate([0,-0.75,0])rotate(90,[1,0,0])cylinder(h=2,r=1,$fn=50);
        translate([0,7,5])rotate(90,[1,0,0])cylinder(h=2.25,r=1,$fn=50);
        translate([0,-4.75,5])rotate(90,[1,0,0])cylinder(h=2.25,r=1,$fn=50);

        translate([0,0,5-seperate*10])rotate(-lock*90,[0,1,0]){
            difference(){
                union(){
                    translate([-20,5,-2.5])cube([20,2,5]);
                    translate([0,7,0])rotate(90,[1,0,0])cylinder(h=2,r=2.5,$fn=50);
                    translate([-20,-7,-2.5])cube([20,2,5]);
                    translate([0,-5,0])rotate(90,[1,0,0])cylinder(h=2,r=2.5,$fn=50);
                    translate([-20,0,0])rotate(90,[1,0,0])cylinder(h=14,r=2.5,center=true,$fn=50);
                }
                rotate(90,[1,0,0])cylinder(h=40,r=1.25,center=true,$fn=50);
            }
            
        }
    }
}