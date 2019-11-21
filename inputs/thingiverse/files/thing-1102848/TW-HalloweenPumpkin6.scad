//Thomas Wolfe
//Pumpkin and Witch hat

$fn = 30;
//you can chose which models to print
models = 1;//[1:complete, 2:Both parts of hat, 3:half of the hat, 4:other half of the hat, 5:Just Pumpkin, 6:upright hat, 7:all models possible]

//you can change the type of eyes
eyes = 1;//[1:Square, 2:Circle]

//you can choose to remove the tooth
tooth = 1;//[1:Yes, 2:No]


/* 
complete();
print1();//hat 1/2
print2();//hat 2/2
print3();//base of pumkin
//print4();//mini hat topper
 */

module print1() {//hat pt1
    difference(){
        rotate([-90,0,0]){
            translate([75,0,0]){
                scale([.6,.7,.8]){
                        hat();
                        }
                    }
                }
         translate([0,-100,-100]){
                cube([1000,1000,100]);
             }
            }
        }
module print2() {//hat pt2
    translate([-150,0,0]){
        rotate([180,0,0]){
            intersection(){
                rotate([-90,0,0]){
                    translate([75,0,0]){
                        scale([.6,.7,.8]){
                            hat();
                        }
                    }
                }
                translate([0,-100,-100]){
                    cube([1000,1000,100]);
                }
            }
        }
    }
    
}
module print3() {
    translate([0,-100,0])
    finalpumpkin();    
}
module print4(){
    translate([0,100,0]){
        rotate([90,0,0]){
            translate([0,18,0]){
                scale([1,5,1]){
                    minipumpkin();
                }
            }
        }
    }
}
module complete() {
    union(){//this is where the parts of the pumpkin are called
        color("black", 1){ //calls and sets the hat to  black and makes it fit the hight spec
            translate([0,0,49]){
                scale([.6,.7,.8]){
                    hat();
                }
            }
        }
        color("darkorange"){//makes the ornament pumpkin darker
            minipumpkin();//calls the ornimant to the hat
        }
        finalpumpkin();//calls the "carved" pumpkin
    }
}

module pumpkin() {//this calls the lobes and makes the pumpkin
        union(){//this is what makes the pumpkin
            color( "orange", 1) {
                translate([7,0,25]){
                    lobe();
                }
                translate([0,7,25]){
                    lobe();
                }
                translate([0,-7,25]){
                    lobe();
                }
                translate([-7,0,25]){
                    lobe();
                }
                translate([5,5,25]){
                    lobe();
                }
                translate([5,-5,25]){
                    lobe();
                }
                translate([-5,-5,25]){
                    lobe();
                }
                translate([-5,5,25]){
                    lobe();
                }
            }
        }
}

module lowstem(){//small bottem of pumpken that is a gray brown ish color like on real pumpkins
    color( "sandybrown", 1) {
             intersection(){
                 translate([-25,-25,0]){
                    cube([50,50,20]);
                     }
                 translate([0,0,26]){
                 scale([1.5,1.5,1]){
                        lobe();
                    }
                }
            }
        }
}
module lobe() {//part of the elipses-spheres that make up the pumpkin
        scale([.4,.4,1]){
            sphere(25);
        }
}
module hat(){//this is the witches hat that the pumpkin wears
    union(){
        hull(){
            cylinder(40,10,9);
            cylinder(1,25,25);
        }
        hull(){//bend in hat tip
            translate([10,0,51]){
                sphere(5);
            }
            translate([0,0,35]){
                rotate([0,30,0]){
                    cylinder(20,10,5);
                }
            }
        }
        hull(){//end of hat tip
            translate([10,0,50]){
                rotate([0,130,0]){
                    cylinder(20,5,0);
                }
            }
            translate([10,0,51]){
                sphere(5);
            }
        }
        hull(){//base to hat
            translate([10,0,0]){
                cylinder(5,50,45);
            }
            translate([-10,0,0]){
                cylinder(5,50,45);
            }
        }
    }
}
module minipumpkin() {//this is the small ornimant that goes on the hat
    //rotate([0,0,-30]){
        translate([0,-18,55]){
            scale([.25,0.05,.15]){
                scale([1,1,1]){
                    //for(d = [0:0.05:1]){
                    //    translate([0,d,0])
                    pumpkin();
                    //}
                    //pumpkin();
                }
            }
        }
    //}
    
}
module insideofpumpkin() {//smaller version of the pumpkin used to make it hollow
    translate([0,0,3]){
        scale([1.65,1.65,.90]){
            pumpkin();
        }
    }
}
module eye() {
    if(eyes == 1){
        translate([0,-100,30]){
        cube([8,200,8],center=true);
        }
    }
    if(eyes == 2){
        translate([0,0,30])
        rotate([90,0,0])
        cylinder(200,7,7);
        }
}

module mouth(){//creates a mouth with one tooth
    if(tooth == 1){
    intersection() {//takes the bottem half of the cylinder(minus the tooth)
        union(){
            translate([0,0,30]){
                rotate([90,0,0]) {
                    cylinder(100,20,20);
                }
            }
        }
        union(){
           difference() {
              translate([-100,-100,0]){
                cube([200,100,20]);
              }
              translate([0,-100,10]){
                cube([5,100,5]);
              }
           }
        } 
     }
 }
 if(tooth ==2){
        intersection() {//takes the bottem half of the cylinder(minus the tooth)
        union(){
            translate([0,0,30]){
                rotate([90,0,0]) {
                    cylinder(100,20,20);
                }
            }
        }
        union(){
            translate([-100,-100,0]){
                cube([200,100,20]);
              }
          }
      }
 }
  
}
module finalpumpkin() {//this is the pumpkin with the face and is hollowed out
    difference() {
        scale([1.75,1.75,1]){//scales the pumpkin and the lower stem part to then cut the other part from it to make the "carved" pumpkin
            pumpkin();
            lowstem();
        }
        translate([-11,0,0]){//sets the eye 11 to the left of origin
            eye();//moves eye into position(to be cut)
        }
        translate([11,0,0]){//sets eye 11 to the right of the origin
            eye();//moves other eye (to be cut)
        } 
        mouth();//calls mouth to be cut out
        
        insideofpumpkin();  //makes it hollow  
    }

}

Models = 1;//[1:completed, 2:Both parts of hat, 3:half of the hat, 4:other half of the hat, 5:Just Pumpkin, 6:upright hat]
if(models == 1){
    complete();
}

if(models == 2){
    print1();//hat 1/2
    print2();//hat 2/2
}
if(models == 3){
    print1();//hat 1/2
}

if(models == 4){
    print2();//hat 2/2
}

if(models == 5){
    print3();//base of pumkin
}

if(models == 6){
    translate([0,0,49]){
                scale([.6,.7,.8]){
                    hat();
                }
            }
}

if(models == 7){
    complete();
    print1();//hat 1/2
    print2();//hat 2/2
    print3();//base of pumkin
}






