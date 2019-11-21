/* [Global] */

// Overall size
size = 15; // [1:1:100]

/* [Head] */
//Rotation left/right
rotationLeftRightHead = 0; // [-130:130]

//Rotation up/down
rotationUpDowntHead = 0; // [-45:45]

//Rotation left eyebrow
rotationLeftEyebrow = 0; // [-10:0.5:10]
//Rotation right eyebrow
rotationRightEyebrow = 0; // [-10:0.5:10]
//Rotation mouth
rotationMouth = 0; // [-20:0.5:20]

/* [Body] */
//Rotation
bodyRotation = 0; // [-45:0.5:45]

/* [Arms] */
//Rotation left arm
rotationLeftArm = 0; // [-90:90]
//Rotation right arm
rotationRightArm = 0; // [-90:90]

/* [Legs] */
//Rotation left leg
rotationLeftLeg = 0; // [-90:90]
//Rotation right leg
rotationRightLeg = 0; // [-90:90]

module arm(size) {
    cube([size, size, size*3], center=true);
}

module leg(size) {
    cube([size, size, size*3], center=true);
    translate([0,0,size*1.5])rotate([0,90,0])cylinder(r=size/2, h=size,center=true);
}

module body(size, rotation) {
    translate([0,0,-size/4])rotate([rotation,0,0]) translate([0,0,size/4]){
    cube([size*2,size,size*3], center=true);
    translate([0,0,-size*1.5])rotate([0,90,0])cylinder(r=size/2, h=size*2, center=true);
    }
}

module head(x,y,z,rle, rre, rlm, rrm, rotationLeftRightHead,rotationUpDowntHead) {
    translate([0,0,-z/2])rotate([rotationUpDowntHead,0,rotationLeftRightHead]) {
        translate([0,0,z/2]) {
    difference() {
        union() {
            //Main head
            cube([x,y,z], center=true);
            //Left eyebrow
            translate([-x/2+x/3.5,-y/2.1,z/6])rotate([0,rle,0])cube([x/5,y/10,z/13], center=true);
            //Right eyebrow
            translate([x/2-x/3.5,-y/2.1,z/6])rotate([0,-rre,0])cube([x/5,y/10,z/13], center=true);
        };
        //Left eye
        translate([-x/2+x/3.5,-y/2.1,z/13])cube([x/5,y/10,z/12], center=true);
        //Right eye
        translate([x/2-x/3.5,-y/2.1,z/13])cube([x/5,y/10,z/12], center=true);
        //Mouth
        translate([0,-y/2.1, -z/5]) {
            translate([-x/7,0,0])rotate([0,rlm,0])cube([x/2.75, y/10, z/15], center=true);//left
            translate([x/7,0,0])rotate([0,-rrm,0])cube([x/2.75, y/10, z/15], center=true);//right
        };
     
    };
       //Mouthfix
    if (rlm > 0) {
        translate([0,-y/2+y/20, -z/3.75]) {
            translate([-x/7,0,0])rotate([0,rlm,0])cube([x/2, y/10, z/15], center=true);//left
            translate([x/7,0,0])rotate([0,-rrm,0])cube([x/2, y/10, z/15], center=true);//right
        };
    } else if (rlm < 0) {
        translate([0,-y/2+y/20, -z/7.5]) {
            translate([-x/7,0,0])rotate([0,rlm,0])cube([x/2, y/10, z/15], center=true);//left
            translate([x/7,0,0])rotate([0,-rrm,0])cube([x/2, y/10, z/15], center=true);//right
        };
    };
}
}
    
}

body(size, bodyRotation);



if (bodyRotation >= 0) {
    
    translate([0,-sin(bodyRotation)*size,size*2.5-sin(bodyRotation)*size])head(size*2, size*2, size*2, rotationLeftEyebrow, rotationRightEyebrow,rotationMouth, rotationMouth,rotationLeftRightHead,rotationUpDowntHead);
    
    translate([size/.675,-sin(bodyRotation)*size*1.25,size-sin(bodyRotation)*size/2])rotate([-rotationLeftArm,0,0])translate([0,0,-size])arm(size);
    translate([-size/.675,-sin(bodyRotation)*size*1.25,size-sin(bodyRotation)*size/2])rotate([-rotationRightArm,0,0])translate([0,0,-size])arm(size);
    
    translate([size/2,sin(bodyRotation)*size*1.25,-size*2+sin(bodyRotation)*size/2+size/2])rotate([-rotationLeftLeg,0,0])translate([0,0,-size*1.5])leg(size);
    translate([-size/2,sin(bodyRotation)*size*1.25,-size*2+sin(bodyRotation)*size/2+size/2])rotate([-rotationRightLeg,0,0])translate([0,0,-size*1.5])leg(size);
    
    
} else {
    translate([0,-sin(bodyRotation)*size,size*2.5+sin(bodyRotation)*size])head(size*2, size*2, size*2, rotationLeftEyebrow, rotationRightEyebrow,rotationMouth, rotationMouth,rotationLeftRightHead,rotationUpDowntHead);
    
    translate([size/.675,-sin(bodyRotation)*size*1.25,size+sin(bodyRotation)*size/2])rotate([-rotationLeftArm,0,0])translate([0,0,-size])arm(size);
    translate([-size/.675,-sin(bodyRotation)*size*1.25,size+sin(bodyRotation)*size/2])rotate([-rotationRightArm,0,0])translate([0,0,-size])arm(size);
    
    translate([size/2,sin(bodyRotation)*size*1.25,-size*2-sin(bodyRotation)*size/2+size/2])rotate([-rotationLeftLeg,0,0])translate([0,0,-size*1.5])leg(size);
    translate([-size/2,sin(bodyRotation)*size*1.25,-size*2-sin(bodyRotation)*size/2+size/2])rotate([-rotationRightLeg,0,0])translate([0,0,-size*1.5])leg(size);
}


