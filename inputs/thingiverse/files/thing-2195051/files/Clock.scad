//customized variables
hour_drop = 2; // [12,1,2,3,4,5,6,7,8,9,10,11]
minute_drop = 5; // [0,5,10,15,20,25,30,35,40,45,50,55]

//clock
union() {
    difference() {
        cylinder(h=3, r1=20, r2=18.6, $fn=60);
        cylinder(h=3.1, r1=18, r2=16, $fn=60);
    }
    cylinder(h=1, r1=18.6, r2=18.2);
    cylinder(h=3, r=1, $fn=20);
}



//numbers
union() {
    //1
    translate([5.5,9,0])
        linear_extrude(height=1.5)
            smallNumber("1");
    //2
    translate([9.5,5,0])
        linear_extrude(height=1.5)
            smallNumber("2");
    //3
    translate([11,-2,0])
        linear_extrude(height=1.5)
            bigNumber("3");
    //4
    translate([9.5,-7.4,0])
        linear_extrude(height=1.5)
            smallNumber("4");
    //5
    translate([5.5,-11.4,0])
        linear_extrude(height=1.5)
            smallNumber("5");
    //6
    translate([-2,-15,0])
        linear_extrude(height=1.5)
            bigNumber("6");
    //7
    translate([-7.9,-11.4,0])
        linear_extrude(height=1.5)
            smallNumber("7");
    //8
    translate([-11.9,-7.4,0])
        linear_extrude(height=1.5)
            smallNumber("8");
    //9
    translate([-15,-2,0])
        linear_extrude(height=1.5)
            bigNumber("9");
    //10
    translate([-11.9,5,0])
        linear_extrude(height=1.5)
            smallNumber("10");
    //11
    translate([-7.9,9,0])
        linear_extrude(height=1.5)
            smallNumber("11");
    //12
    translate([-4,10,0])
        linear_extrude(height=1.5)
            bigNumber("12");
}




//arms
//hours
if (hour_drop==12) {
    rotate([0,0,0])
        smallArm();
}
if (hour_drop==1) {
    rotate([0,0,-30])
        smallArm();
}
if (hour_drop==2) {
    rotate([0,0,-60])
        smallArm();
}
if (hour_drop==3) {
    rotate([0,0,-90])
        smallArm();
}
if (hour_drop==4) {
    rotate([0,0,-120])
        smallArm();
}
if (hour_drop==5) {
    rotate([0,0,-150])
        smallArm();
}
if (hour_drop==6) {
    rotate([0,0,-180])
        smallArm();
}
if (hour_drop==7) {
    rotate([0,0,-210])
        smallArm();
}
if (hour_drop==8) {
    rotate([0,0,-240])
        smallArm();
}
if (hour_drop==9) {
    rotate([0,0,-270])
        smallArm();
}
if (hour_drop==10) {
    rotate([0,0,-300])
        smallArm();
}
if (hour_drop==11) {
    rotate([0,0,-330])
        smallArm();
}

//minutes
if(minute_drop==0) {
    rotate([0,0,0])
        bigArm();
}
if(minute_drop==5) {
    rotate([0,0,-30])
        bigArm();
}
if(minute_drop==10) {
    rotate([0,0,-60])
        bigArm();
}
if(minute_drop==15) {
    rotate([0,0,-90])
        bigArm();
}
if(minute_drop==20) {
    rotate([0,0,-120])
        bigArm();
}
if(minute_drop==25) {
    rotate([0,0,-150])
        bigArm();
}
if(minute_drop==30) {
    rotate([0,0,-180])
        bigArm();
}
if(minute_drop==35) {
    rotate([0,0,-210])
        bigArm();
}
if(minute_drop==40) {
    rotate([0,0,-240])
        bigArm();
}
if(minute_drop==45) {
    rotate([0,0,-270])
        bigArm();
}
if(minute_drop==50) {
    rotate([0,0,-300])
        bigArm();
}
if(minute_drop==55) {
    rotate([0,0,-330])
        bigArm();
}
///////////////////Modules////////////////////

module bigNumber(number) {
    scale([.5,.5,1])
        text(number);
}

module smallNumber(number) {
    scale([.3,.3,1])
        text(number);
}
module smallArm() {
    union() {
        translate([-.75,0,2.5])
            cube([1.5,8,.5]);
        translate([-.75,8,0])
            cube([1.5,.5,3]);
    }
}
module bigArm() {
    union() {
        translate([-.75,0,2])
            cube([1.5,12,.5]);
        translate([-.75,12,0])
            cube([1.5,.5,2.5]);
    }
}