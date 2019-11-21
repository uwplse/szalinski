/*

    KeyBoard penholder
    
    Fernando Jerez 2017
    License: CC-NC Creative Commons, Non Commercial



*/
// Wich part want to see in preview?
part="vase"; //  [vase: Vase, cap: Cap]
// Number of key lines
lines = 4; // [1:4]

// 1st line (Top) 
line1 = "1st Line";
// 2nd line 
line2 = "2nd Line";
// 3rd line 
line3 = "3rd Line";
// 4th line
line4 = "4th Line";

// Cap text
captext = "Cap text";

// Squared layout
squared = "no"; // [no,yes]

/* [Hidden] */
$fn=30;
line_height=18;

// Convert to string to ensure Thingiverse customizer dont treat as a number
t1 =str(line1);
t2 =str(line2);
t3 =str(line3);
t4 =str(line4);
capt = str(captext);

scale([1.05,1.05,1.05]){ // adjust to a real scale keyboard
    // Different files for Thingiverse Customizer    
    if(part=="both"){

        translate([-50,0,0]) keyCylinder(lines,[t1,t2,t3,t4],cap = false);
        translate([50,0,line_height]) rotate([180,0,0]) 
          keyCylinder(1,[capt],cap = true);

    }else if(part=="vase"){

        keyCylinder(lines,[t1,t2,t3,t4],cap = false);

    }else if(part=="cap"){

        translate([0,0,line_height]) rotate([180,0,0]) keyCylinder(1,[capt],cap = true);
        
    }
}


module keyCylinder(lines,linetext,cap = false){
    rad = 29;
    total_height = line_height*(lines-1);
    
    union(){
        if(cap==true){
            // Cap
            difference(){
                union(){
                    cylinder(r=rad+1,h=line_height*lines,$fn=100);
                    translate([0,0,-4]) cylinder(r=rad-1.3,h=4+line_height*lines,$fn=100);
                }
                translate([0,0,-4.01]) cylinder(r=rad-3,h=line_height*lines,$fn=100);
            }
        }else{
            // Vase
            difference(){
                cylinder(r=rad+1,h=line_height*lines,$fn=100);
                translate([0,0,2]) cylinder(r=rad-1,h=line_height*lines,$fn=100);
            }
        }


        // keys 
        translate([0,0,9]){
            for(i=[0:lines-1]){ //rows
                translate([0,0,total_height-i*line_height]){
                    for(j=[0:9]){ // circles...10 keys per loop
                        
                        rot=(squared=="yes")?0:(i==0)?-35:(i==1)?-17:(i==2)?-10:8; // Adjust rotation for each line
                        
                        // Select letter
                        letter= linetext[i][j];
                        // draw key
                        rotate([0,0,36*j+rot]) translate([rad,0,0]) rotate([90,0,90]) 
                        key(letter);
                    }
                }
            }

        }
    }
}
module key(letter){
    // some sort of key ...
    angle = 6;
    size = 17;
    difference(){
        // key body
        hull(){
            translate([0,0,0])
            roundRect([size,size,0.01],2);
            translate([0,0,5])    
            rotate([angle,0,0])
            roundRect([size-5,size-5,0.01],2);
        }
        // curve on top
        translate([0,10,25])
        rotate([90+angle,0,0])
        cylinder(r=20,h=20,$fn=100);
    }
    // text
    color("white")
    translate([-4.5,-0.5,3])rotate([angle,4,0]){
        linear_extrude(height=1.8) text(letter, font = "Arial Rounded MT Bold:style=Bold", size = 5);
    }
}

// simple module for rounded rectangles
module roundRect(size, radius) {
	x = size[0];
	y = size[1];
	z = size[2];

	translate([-x/2,-y/2,0])
	linear_extrude(height=z)
	hull() {
		translate([radius, radius, 0])circle(r=radius);
		translate([x - radius, radius, 0])circle(r=radius);
		translate([x - radius, y - radius, 0])circle(r=radius);
		translate([radius, y - radius, 0])circle(r=radius);
	}
}