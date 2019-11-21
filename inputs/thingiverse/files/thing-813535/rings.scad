// ring puzzle

// Tolerance (vertical gap)
tol=.4;
// Median-ish diameter
L=60;
// Width of of hexagonal cross-section
W=5;
// Angle
phi=60;
// Fraction to cut off points
f=0.43;

translate([0,0,W/2]){
    ring1();
    rotate([0,0,40])ring2();
    rotate([0,0,80])ring3();
}

module wedge(offset=0)
render()
translate([-L,0,0])intersection(){
    rotate([0,0,-45-phi/2])rotate([0,30,0])translate([offset,0,-L/2])cube(L);
    rotate([0,0,-45+phi/2])rotate([-30,0,0])translate([0,offset,-L/2])cube(L);
    translate([L*f,0,0])rotate([0,30,0])translate([offset,-L/2,-L/2])cube(L);
}

module ring(w=W)
render(convexity=4)
difference(){
    for(i=[0:2])rotate([0,0,120*i])intersection(){
        wedge(-w/2);
        mirror([0,0,1])wedge(-w/2);
        cube([2*L,2*L,w],center=true);
    }
    for(i=[0:2])rotate([0,0,120*i]){
        wedge(w/2);
        mirror([0,0,1])wedge(w/2);
    }
}

module cut(i,j,up=1)
intersection(){
    rotate([0,0,40*i])translate([0,0,(W-tol/2)*up])ring(2*W);
    rotate([0,0,60*j+75-40*i])translate([W,W,-L/2])cube(L);
}

module ring1()
render()
difference(){
    ring();
    cut(1,0,-1);
    cut(1,1);
    cut(1,2);
    cut(1,3);
    cut(1,4,-1);
    cut(1,5,-1);
    cut(2,0,-1);
    cut(2,1);
    cut(2,2);
    cut(2,3);
    cut(2,4,-1);
    cut(2,5,-1);
}

module ring2()
render()
difference(){
    ring();
    cut(1,0);
    cut(1,1);
    cut(1,2,-1);
    cut(1,3,-1);
    cut(1,4,-1);
    cut(1,5,-1);
    cut(2,0);
    cut(2,1,-1);
    cut(2,2,-1);
    cut(2,3,-1);
    cut(2,4);
    cut(2,5);
}

module ring3()
render()
difference(){
    ring();
    cut(1,0,-1);
    cut(1,1,-1);
    cut(1,2);
    cut(1,3);
    cut(1,4);
    cut(1,5,-1);
    cut(2,0,-1);
    cut(2,1,-1);
    cut(2,2);
    cut(2,3);
    cut(2,4);
    cut(2,5);
}