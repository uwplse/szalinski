tube_size = 13.8; //[13.8:BT-5, 18.7:BT-20, 24.8:BT-50, 33.7:BT-55, 34.2:BT-56, 41.6:BT-60, 56.3:BT-70, 66.04:BT-80, 100:BT-101]

//How long do you want the tube to be (mm)?
length = 125;

if (tube_size==13.8) {
difference(){
cylinder(h=length, r=13.8/2, center=false, $fn=50);
    cylinder (h=length, r=13.2/2, center=false, $fn=50);
}
}

if (tube_size==18.7) {
difference(){
cylinder(h=length, r=18.7/2, center=false, $fn=50);
    cylinder (h=length, r=18/2, center=false, $fn=50);
}
}

if (tube_size==24.8) {
difference(){
cylinder(h=length, r=24.8/2, center=false, $fn=50);
    cylinder (h=length, r=24.1/2, center=false, $fn=50);
}
}

if (tube_size==33.7) {
difference(){
cylinder(h=length, r=33.7/2, center=false, $fn=50);
    cylinder (h=length, r=32.6/2, center=false, $fn=50);
}
}

if (tube_size==34.2) {
difference(){
cylinder(h=length, r=34.2/2, center=false, $fn=50);
    cylinder (h=length, r=33.1/2, center=false, $fn=50);
}
}

if (tube_size==41.6) {
difference(){
cylinder(h=length, r=41.6/2, center=false, $fn=50);
    cylinder (h=length, r=40.5/2, center=false, $fn=50);
}
}

if (tube_size==56.3) {
difference(){
cylinder(h=length, r=56.3/2, center=false, $fn=50);
    cylinder (h=length, r=55.4/2, center=false, $fn=50);
}
}

if (tube_size==66.04) {
difference(){
cylinder(h=length, r=66.04/2, center=false, $fn=50);
    cylinder (h=length, r=65.7/2, center=false, $fn=50);
}
}

if (tube_size==100) {
difference(){
cylinder(h=length, r=100/2, center=false, $fn=50);
    cylinder (h=length, r=99/2, center=false, $fn=50);
}
}