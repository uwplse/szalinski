// Text
modelText = "Cisco SG-100";

// Hole Diameter in mm
holeDiam = 4;

// Distance between holes in mm
holeDist = 63;

// Plate thickness in mm
plateThick = 5;

/* [Hidden] */

$fn = 100;

module plate (){
// Center the plate
translate([-(holeDiam)/10, -((holeDist + 20) /2),0]) {
    // Draw the plate    
    cube([20, (holeDist + 20),plateThick]);
    }
}
module holes (){
     
        translate([0,(holeDist/2),-0.1]){
            cylinder(h=plateThick+1, d=holeDiam);
        }
        translate([0,-(holeDist/2),-0.1]){
            cylinder(h=plateThick+1, d=holeDiam);
    }
}

module drawText(){
    translate([10,0,plateThick-1]){linear_extrude(height=2){
        
        rotate(90,0,0){
        text(text=modelText,halign="center",valign="center",font="Ubuntu Mono:style=Bold");
        }
    }
}
}

difference(){
    // Draw plate
    plate();
    // Draw holes
union(){
    holes();
    drawText();
}
}

