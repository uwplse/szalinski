/* Global */
type = "twin"; // [twin:twin,twinXL:twinXL,full:full,fullXL:fullXL,queen:queen,king:king,calKing:calKing]
height = 10; // [1:100]

/* Hidden */ 

bed(type,height);

module bed(type,height) {
frame =
(type == "twin") ? [39,75,height] : 
(type == "twinXL") ? [39,80,height] :
type == "full" ? [54,75,height] :
(type == "fullXL") ? [54,80,height] :
(type == "queen") ? [60,80,height] :
(type == "king") ? [70,80,height] :
(type == "calKing") ? [72,84,height] : 
"error!";
echo(type);
    module frame() {
    //frame
        difference() {
            hull() {
                cube ([frame[0]+4,frame[1]+4,frame[2]]);
                translate([0,0,frame[2]]) sphere(1);
                translate([0,frame[1]+4,frame[2]]) sphere(1);
                translate([frame[0]+4,frame[1]+4,frame[2]]) sphere(1);
                translate([frame[0]+4,0,frame[2]]) sphere(1);
                translate([0,0,0]) sphere(1);
                translate([0,frame[1]+4,0]) sphere(1);
                translate([frame[0]+4,frame[1]+4,0]) sphere(1);
                translate([frame[0]+4,0,0]) sphere(1);
            }
            translate([0,0,4]) cube([frame[0]+4,frame[1]+4,frame[2]+1]);
        };
    }
    module legs() {
        //legs
         {
            translate([0,0,-9]) cube([4,4,9]);
            translate([frame[0],0,-9]) cube([4,4,9]);
            translate([0,frame[1]-2,-9]) cube([4,4,9]);
            translate([frame[0],frame[1]-2,-9]) cube([4,4,9]);
        };
    }
    module mattress() {
        //mattress
        translate([2,2,2]) {
            hull() {
                cube([frame[0],frame[1],frame[2]]);
                translate([0,0,frame[2]]) sphere(1);
                translate([0,frame[1],frame[2]]) sphere(1);
                translate([frame[0],frame[1],frame[2]]) sphere(1);
                translate([frame[0],0,frame[2]]) sphere(1);
                translate([0,0,0]) sphere(1);
                translate([0,frame[1],0]) sphere(1);
                translate([frame[0],frame[1],0]) sphere(1);
                translate([frame[0],0,0]) sphere(1);
            };
        }
    }
    color("tan") frame();
    color("tan") legs();
    color("white") mattress();
    }