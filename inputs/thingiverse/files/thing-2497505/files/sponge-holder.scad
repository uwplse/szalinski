thick = 5;
length = 120;
width = 85;
extrude_h = 8;
text_sizeX = 110;
text_sizeY = 49;
font = "arial";
gap_spacing = 4;


difference(){
    resize([length,width,thick+extrude_h]){
       cylinder( r = width, h = thick );
    }
    translate([0,0,thick]){
        scale([0.9,0.9,2]){
            resize([length,width,thick]){
                cylinder( r = width, h = thick );
            }
        }
    }
    translate([0,0,thick+extrude_h/2]){
        cube([length, text_sizeY+2*gap_spacing, extrude_h], center=true);
    }
    for (ii = [0:20:180]){
        rotate([0,0,ii]){
            translate([0,0,thick+extrude_h/2]){
                cube([length,gap_spacing,extrude_h], center=true);
            }
        }
    }
}

difference(){    
    intersection(){
        resize([text_sizeX,text_sizeY,extrude_h]){
            translate([0,0,thick]){
                linear_extrude( height = extrude_h ){
                   text("SPONGE", font=font, halign="center", valign="center");
                }
            }
        }
        resize([length,width,thick+extrude_h]){
            cylinder( r = width, h = thick );
        }
    }
    for (ii = [-(width-27)/2:2*gap_spacing:width]){
        translate([-length/2,ii,thick]){
            cube([length,gap_spacing,extrude_h]);
        }
    }
}

