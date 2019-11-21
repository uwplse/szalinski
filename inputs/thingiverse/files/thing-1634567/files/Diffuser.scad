

// Wedge length (mm)
length = 55;

// Wedge face width (mm)
faceW = 10;

// Wedge face angle (degrees >0)
angle = 30;

// Plinth thickness
thickness = 2;

// Wall thickness
wall = 1.5;

//======================
A = 180 - 90 - angle;
base = sin(A)*faceW;
side = cos(A)*faceW;
chord = (sqrt((side*side)+((base/2)*(base/2))))+2;
totalWidth = 2*chord;
centre = chord;
totalLength = length+(2*wall)+1;

module ledDiffuser(){
    angleMount();
    
    translate([2*totalWidth,0,0])
        diffuser();
}ledDiffuser();

module angleMount(){
    translate([0,0,0])
        cube([totalWidth,totalLength,thickness]);
      
    offset = base/2;
    translate([centre+offset,thickness,thickness])        
            prism(length,base,side);
      
    translate([totalWidth/2,0,0])
        ear();
   
    translate([totalWidth/2,totalLength,0]){
        rotate([0,0,180])
            ear();
    }
}

module prism(l, w, h){
    rotate([0,0,90]){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
    }
}

module ear(){
    difference(){
        cylinder(h=thickness,d=totalWidth,$fn=180);      
        translate([0,-(totalWidth/4),-0.1])
            cylinder(h=2*thickness,d=4,$fn=180);
        translate([-totalWidth/2,0,-0.1])
            cube([totalWidth,(totalWidth/2)+1,(2*thickness)]);
    }    
}


module diffuser(){
    translate([-(chord),0,0]){
        difference(){
            cube([totalWidth,totalLength,wall]);
            translate([wall,wall,-0.1])
                cube([(2*chord)-(2*wall),length+1,wall+1]);
            
            translate([chord-2,-0.1,-0.1])
                cube([4,totalLength+1,5]);
        }
    }
    
    difference(){
        ear();
        translate([-2,-totalWidth,-0.1])
            cube([4,totalLength,5]);
    }
    
    translate([0,totalLength,0]){
        rotate([0,0,180]){
            difference(){
                ear();
                translate([-2,-totalWidth,-0.1])
                    cube([4,totalLength,5]);
            }
        }
    }
    
    translate([0,0,wall]){
        lense();
    }
}

module lense(){ 
    rotate([-90,0,0]){
        difference(){
            cylinder(h=totalLength,d=totalWidth,$fn=180);
            translate([0,wall,wall])
                cylinder(h=length+1,r=chord-wall,$fn=180);
            
            translate([-(chord),0,-.1])
                cube([2*chord,chord,totalLength+1]);   
       
            translate([0,-chord/3,-0.5])
                cylinder(h=totalLength+1,d=4,$fn=180);
            
            translate([-thickness,-chord/3,-0.5])
                cube([4,10,totalLength+1]);
        }          
    }
}