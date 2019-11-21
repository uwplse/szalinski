//its ugly but it works

//TODO maybe add built-in supports for the arms

//things you will probably have to change

fansize=40; //how big is the fan

nozzledistanceV=57; //vertical distance from mounting hinge to tip of nozzle

nozzledistanceH=20; //horizontal distance ...

armclearance=5; //how high above the bed should the arms be

armdistance=40; //distance between duct arms

tubeIR=5; //interal radius, because ID would need more math

shellthickness=1.2; //how thick should the shell be, I recommend at least 3 x nozzle diameter

//things that are usually standard

thickness=7; //thickness of main fan block, also affects the hinge

screwholeR=1.6; //radius of holes to mount the fan to the duct

hingedistance=6; //distance between the two hinge pieces

hingeholeR=2; //radius of the hinge hole

ventlength=15; //how long should the vent be

ventwidth=4; //and how wide

//hopefully you won't have to change any thing below this line

tubeOR=tubeIR+shellthickness; //save some math steps later

armY=(armdistance/2)+tubeOR; //save some math steps later

armZ=nozzledistanceV-(tubeOR+armclearance);

//move things relative to the center of the hinge
module hingeoffset() {
    translate([-1*(thickness/2),0,thickness/2]) children();
}

module armjoint() {
    hingeoffset() rotate([0,45,0]) translate([tubeOR,armY,armZ])
    children();
}

module armend() {
    hingeoffset() rotate([0,45,0]) translate([-1*nozzledistanceH-(ventlength/2),armY,armZ])
    children();
}

module endone() {
    //sphere end
    sphere(tubeIR);
}

module endtwo() {
    //cut-sphere end
    difference() {
            //
            rotate([0,90,0]) translate([0,0,-1*tubeIR]) sphere(tubeIR);
            rotate([0,-45,0]) translate([-4*tubeIR,-2*tubeIR,-2*tubeIR]) cube(tubeIR*4); //cutting off that piece might make it easier to print
    }
}

module endthree() {
    //cylinder end
    rotate([0,90,0]) translate([0,0,-1*tubeIR]) cylinder(r=tubeIR,h=tubeIR*2);
}

module endfour() {
    //cut-cylinder end
    difference() {
        rotate([0,90,0]) translate([0,0,-1*tubeIR]) cylinder(r=tubeIR,h=tubeIR*2);
        rotate([0,-45,0]) translate([-4*tubeIR,-2*tubeIR,-2*tubeIR]) cube(tubeIR*4); //cutting off that piece might make it easier to print
    }
}

module mainshapehalf() {
    hull() {
        translate([shellthickness,shellthickness/2,0]) cube([fansize-(shellthickness*2),(fansize/2)-(shellthickness*1.5),thickness]);
        
        armjoint() sphere(tubeIR);
        }
    hull() {
        armjoint() sphere(tubeIR);
        
        //pick one
        //armend() endone();
        //armend() endtwo();
        //armend() endthree();
        armend() endfour();
    }
}

module mainshape() {
    mainshapehalf();
    mirror([0,1,0]) mainshapehalf();
}

module hinge() {
    hingeoffset() {
        translate([0,thickness+(hingedistance/2),0]) {
            rotate([90,0,0]) {
                difference() {
                    union(){
                        cylinder(r=thickness/2,h=thickness);
                        translate([0,thickness*-0.5,0]) cube([(thickness/2)+shellthickness,thickness,thickness]);
                    }
                    cylinder(r=hingeholeR,h=thickness);
                }
            }
        }
    }
}

module mountingblock() {
    blocksize=(fansize/10)+screwholeR+shellthickness;
    translate([0,fansize*-0.5,0]) {
        difference() {
            cube([blocksize,blocksize,thickness]);
            translate([fansize/10,fansize/10,0]) cylinder(r=screwholeR,h=thickness);
        }
    }
}

module mountingblocks() {
    mountingblock();
    translate([fansize,0,0]) mirror([1,0,0]) mountingblock();
    
}

module shell() {
    minkowski() {
        mainshape();
        sphere(shellthickness);
    }
}

module vent() {
    ventangle=90-atan((armclearance+tubeOR)/((armdistance/2)+tubeOR));
    hingeoffset() rotate([0,45,0]) translate([-1*nozzledistanceH,armY,nozzledistanceV-(tubeOR+armclearance)]) rotate([ventangle,0,0]) 
    //move the vent hole, and raise it so it doesn't cut into the end of the arm
    translate([(ventwidth/2)-(ventlength/2),0,tubeIR/2]) {
        hull() {
            cylinder(r=ventwidth/2,h=tubeOR);
            translate([ventlength-ventwidth,0,0]) cylinder(r=ventwidth/2,h=tubeOR);
        }
    }
}

module finalizedpart() {
    difference() {
        shell(); //build the part
        //cut of the inside
        difference() {
            mainshape();
            //but first cut the mounting blocks out of the inside
            mountingblocks();
            mirror([0,1,0]) mountingblocks();
        }
        //cut out vent holes
        vent();
        mirror([0,1,0]) vent();
        //cut the bottom off to open it up
        translate([0,-.5*fansize,-1*shellthickness]) cube([fansize,fansize,shellthickness]);
    }
    //add hinge parts
    hinge();
    mirror([0,1,0]) hinge();
}

finalizedpart();



//just a test to make sure everthing lines up right
//the bottom corner should line up with the center of the hinge hole
//and the top slope should line up with the middle of the vent hole
//hingeoffset() rotate([0,-45,0]) cube([nozzledistanceV-armclearance,armdistance,nozzledistanceH]);

//corners should line up with fan holes
//translate([fansize/10, fansize*-.4],0) cube([fansize*.8,fansize*.8,thickness]);