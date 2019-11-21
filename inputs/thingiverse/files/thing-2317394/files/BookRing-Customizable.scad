

message = "Words Go Here";
textdepth = 1.5;
textfont = "Franklin Gothic Heavy:style=Bold";
protrude = false;

length = 87;
w = 15;

if(protrude){
    import("bookring-blank.stl");
    protrusion();
}
else{
    difference(){
        import("bookring-blank.stl");
        translate([0,textdepth,0]){
            impression();
        }
    }
}


module protrusion(){
    translate([0,.1,0]){
        intersection(){
            impression();
            translate([0,-textdepth+.1,0]){
                holefilled();
            }
        }
    }
}
module impression(){
    intersection(){
        translate([14,15,7]){
            rotate([90,0,0]){
                linear_extrude(15){
                    if(len(message)< 12){
                            text(message, font=textfont, valign="center", halign="center", size=12);
                        }
                    else{
                        resize([length,], auto = true){
                            text(message, font=textfont, valign="center", halign="center");
                        }
                        echo("Autoresizing");
                    }
                }
            }
        }
        
        difference(){
            translate([-31,0,0]){
                cube([90,15,15]);
            }
            holefilled();
        }
    }
}
module holefilled(){
    
    //Hole Fillers
    import("bookring-blank.stl");
    translate([-25,12.6,0]){
        cube([79,5,15]);
    }
    
    translate([-12,10.5,0]){
        cube([55,9,15]);
    }
    translate([14,19,0]){
        cylinder(r=13,h=15);
    }
}
//translate([-31,12,0]){
//    cube([90,5,15]);
//}