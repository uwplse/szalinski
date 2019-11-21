module outline(wall = 1) {
  difference() {
    offset(wall / 2) children();
    offset(-wall / 2) children();
  }
}

module dome() {
difference() {
    sphere(r=30);
    translate([-30,-30,-30]) cube([60,60,53]);
}
}

module insetpanel(x,y) {
    translate([x,-2,y]) {
        rotate([-15,0,0]) minkowski() {
            cube([28,2,4]);
            rotate([90,0,0]) cylinder(r=2,h=2);
        }
    }
}

module roofelem() {
    cube([4,6,0.8]);
    translate([2, 2, 0.8]) {
      linear_extrude(height = 0.4) {
        outline(wall = 0.4) circle(1.5,$fn=20);
      }
    }    
}


module panel() {
    difference() {
        union() {
            cube([50,t,60]);
            translate([8.5,0,7.5]) minkowski() {
                cube([33,0.5,48]);
                rotate([90,0,0]) cylinder(r=2,h=0.5);
            }
        }
        insetpanel(11,10);
        insetpanel(11,20);
        insetpanel(11,30);
        insetpanel(11,40);
        insetpanel(11,50);
    }
    translate([0,-2,0]) cube([5,2,60]);
    translate([45,-2,0]) cube([5,2,60]);
    translate([5,-1,0]) cube([40,1,5]);
}

// offset parameter, larger than 0 explodes the object
offset=0;
// wall thickness
t=3;

// left front element
M = [ [ 1  , 0  , 0.3  , 0   ],
      [ 0  , 1  , 0, 0   ],  
      [ 0  , 0  , 1  , 0   ],
      [ 0  , 0  , 0  , 1   ] ];
      
multmatrix(M) {
    difference() {
        panel();
        translate([0,-2,0]) rotate([0,0,45]) cube([sqrt(2)*(t+2),sqrt(2)*(t+2),60]);
    }
}

// right front element
M2 = [ [ 1  , 0  , -0.3  , 0   ],
      [ 0  , 1  , 0, 0   ],  
      [ 0  , 0  , 1  , 0   ],
      [ 0  , 0  , 0  , 1   ] ];

translate([155,0,0]) multmatrix(M2) difference() {
    panel();
    translate([50,-2,0]) rotate([0,0,45]) cube([sqrt(2)*(t+2),sqrt(2)*(t+2),60]);
}

// entrance floor
translate([50,0,-offset]) union() {
    multmatrix(M) cube([60,30,5]);
    translate([50,0,0]) multmatrix(M2) cube([55,30,5]);
}

// door
translate([50,30+offset,0]) difference() {
    union() {
        multmatrix(M) cube([60,t,60]);
        translate([50,0,0]) multmatrix(M2) cube([55,t,60]);
    }
    translate([0,1.5,0]) rotate([90,0,0]) union() {
       linear_extrude(height=2) polygon(points=[[50,37],[55,37],[57.5,34.5],[57.5,29.5],[55,27],[50,27],[47.5,29.5],[47.5,34.5]]);
       linear_extrude(height=2) polygon(points=[[8,10],[14,30],[44.5,30]]);
       linear_extrude(height=2) polygon(points=[[13,10],[44.5,27.5],[47.5,22.5],[47.5,10]]);
       linear_extrude(height=2) polygon(points=[[15,33],[21,55],[44.5,33]]);
       linear_extrude(height=2) polygon(points=[[24,55],[44.5,35],[47.5,40],[47.5,55]]);

       linear_extrude(height=2) polygon(points=[[52,0],[52,60],[53,60],[53,0]]);

       linear_extrude(height=2) polygon(points=[[97,10],[91,30],[60.5,30]]);
       linear_extrude(height=2) polygon(points=[[92,10],[60.5,27.5],[57.5,22.5],[57.5,10]]);
       linear_extrude(height=2) polygon(points=[[90,33],[84,55],[60.5,33]]);
       linear_extrude(height=2) polygon(points=[[81,55],[60.5,35],[57.5,40],[57.5,55]]);
    } 
}

// left door panel
translate([50-offset-t,t+offset,0]) multmatrix(M) difference() {
        cube([t,30,60]);
        translate([2,2.5,10]) cube([t,20,10]);
        translate([2,2.5,25]) cube([t,20,10]);
        translate([2,2.5,40]) cube([t,20,15]);
    }


// right door panel
translate([155+offset,t+offset,0]) multmatrix(M2) difference() {
     cube([t,30,60]);
    translate([-2,2.5,10]) cube([t,20,10]);
    translate([-2,2.5,25]) cube([t,20,10]);
    translate([-2,2.5,40]) cube([t,20,15]);
}

// left wall
translate([0,offset-2,0]) multmatrix(M) rotate([0,0,-80]) difference() {
    union() {
        translate([-50,2,0]) panel();
        translate([-95,2,0]) panel();
        translate([-140,2,0]) panel();
        translate([-185,2,0]) panel();
    }
    translate([0,0,0]) rotate([0,0,35]) cube([sqrt(2)*(t+2),sqrt(2)*(t+2),60]);
}

// right wall
translate([205,offset-2,0]) multmatrix(M2) rotate([0,0,80]) difference() {
    union() {
        translate([0,2,0]) panel();
        translate([45,2,0]) panel();
        translate([90,2,0]) panel();
        translate([135,2,0]) panel();
    }
    translate([0,0,0]) rotate([0,0,55]) cube([sqrt(2)*(t+2),sqrt(2)*(t+2),60]);
}

// rear wall (optional)
union() {
translate([-25,178+offset,-offset]) multmatrix(M) {
    cube([150,t,60]);
    translate([-1.5,-0.5,0]) rotate([0,0,10]) cube([t,t,60]);
}
translate([100,178+offset,-offset]) multmatrix(M2) {
    cube([130,t,60]);
    translate([128.5,0,0]) rotate([0,0,-10]) cube([t,t,60]);
}
}

union() {
// roof
translate([102.5,180,60+offset]) 
    linear_extrude(height=10,scale=0.98) 
        polygon(points=[[-90,-sin(80)*190],[90,-sin(80)*190],[90+cos(80)*190,0],[-90-cos(80)*190,0]]);

translate([102.5,180,70+offset]) 
    linear_extrude(height=7,scale=0.98) 
        polygon(points=[[-85,-sin(80)*180],[85,-sin(80)*180],[85+cos(80)*185,0],[-85-cos(80)*185,0]]);

// roof ornaments
translate([25,-6.5,61+offset]) rotate([70,0,0]) roofelem();
translate([95,-6.5,61+offset]) rotate([70,0,0]) roofelem();
translate([100,-6.5,61+offset]) rotate([70,0,0]) roofelem();
translate([105,-6.5,61+offset]) rotate([70,0,0]) roofelem();
translate([170,-6.5,61+offset]) rotate([70,0,0]) roofelem();
translate([175,-6.5,61+offset]) rotate([70,0,0]) roofelem();

translate([0,100,0]) rotate([0,0,-80]) {
    translate([10,-6,61+offset]) rotate([75,0,0]) roofelem();
    translate([15,-6,61+offset]) rotate([75,0,0]) roofelem();
    translate([73,-6,61+offset]) rotate([75,0,0]) roofelem();
    translate([78,-6,61+offset]) rotate([75,0,0]) roofelem();

}
translate([189,10,0]) rotate([0,0,80]) {
    translate([10,-6,61+offset]) rotate([75,0,0]) roofelem();
    translate([15,-6,61+offset]) rotate([75,0,0]) roofelem();
    translate([73,-6,61+offset]) rotate([75,0,0]) roofelem();
    translate([78,-6,61+offset]) rotate([75,0,0]) roofelem();

}
}

// half domes
translate([40,32,54+2*offset]) dome();

translate([165,32,54+2*offset]) dome();
