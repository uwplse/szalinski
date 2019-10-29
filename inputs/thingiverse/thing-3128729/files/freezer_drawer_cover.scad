//freezer drawer cover

left =1;
right=1;
mid  =1;

$fn = 50;
wall = 2;
hingeWidth = 13.5;
hingeHeight = 15;
hingeLength = 67;

cylinder1 = 12;
cylinder2 = 45+12;
support1 = 145;
support2 = hingeLength;

width = 477;
height = 194;

sqrt2=1.4142135623730950488016887242097;

if (left) leftPart();
if (right) rightPart();
if (mid) midPart();

module rightPart(){
    difference(){
        toPrint();
        rightCut();
    }
}

module leftPart(){
    difference(){
        toPrint();
        leftCut();
    }
}

module midPart(){
    difference(){
        toPrint();
        midCut();
    }
}

module rightCut(){
    translate([height/2,0,0]) cube([2*height,width,width],center=true);
    difference(){
        translate([height/2,width,0]) cube([2*height,2*width,width],center=true);       
        midCut();
    }
}

module leftCut(){
    translate([height/2,width,0]) cube([2*height,width,width],center=true);
    difference(){
        translate([height/2,width,0]) cube([2*height,2*width,width],center=true);       
        midCut();
    }
}

module midCut(){
    difference(){
        translate([height/2,width/2,0]) cube([2*height,2*width,width],center=true);
        translate([height*.75,width/2,hingeHeight/2]) rotate([45,0,0]) cube([height*3,width/3/sqrt2,width/3/sqrt2],center=true);
    }
}

module toPrint(){
    hinge();
    translate([0,width,0]) mirror([0,1,0]) hinge();
    frame();
    supports();
}

module hinge(){
    width = hingeWidth;
    heightH = hingeHeight;
    length = hingeLength;
    
    translate([0,hingeWidth,0]) rotate([90,0,0]){
        difference(){
            cube([47,heightH,width]);
            translate([cylinder1,heightH/2,-1]) cylinder(h = width+2, r = 5.1);
        }
        translate([0,0,-wall]) cube([height,heightH,2*wall]);                
        translate([hingeLength,0,width-wall]) cube([height-hingeLength,heightH,wall]);                
        translate([cylinder2,width-6,0]) cylinder(h = width, r = 5);
        // triangle
        translate([cylinder2,0.75*(width-6)/2,0]) rotate([0,0,90]) cylinder(r=0.75*(width-6),h=width,$fn=3);
    }
}

module supports(){
    translate([15-wall/2,hingeWidth,0]) cube([wall,width-2*hingeWidth,hingeHeight]);
    translate([cylinder2-wall/2,hingeWidth,0]) cube([wall,width-2*hingeWidth,hingeHeight]);
    translate([support2,0,0]) cube([wall,width,hingeHeight]);
    translate([support1-wall/2,0,0]) cube([wall,width,hingeHeight]);    
}

module frame(){
    translate([height-wall,0,0]) cube([wall,width,hingeHeight]);
    difference(){
        cube([height,width,wall]);
        // handle
        translate([support1-40,width/2-80/2,-wall]) cube([40,80,3*wall]);
    }
}    