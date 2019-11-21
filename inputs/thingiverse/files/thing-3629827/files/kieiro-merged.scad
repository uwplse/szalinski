use <modules_kieiro.scad>

boxwidth = 1000;
boxheight = 400;    
boxdepth = 600;     


thickness = 12;     
leg = 100;          
pillar=40;          
backheight = 100;   






draw_beranda(boxwidth, boxdepth, boxheight, thickness, leg, pillar, backheight);



module draw_kieiro(width, depth, height, thickness, leg, pillar, backheight){
    
    kieiro_body(width, depth, height, thickness, leg, pillar, backheight);

    kieiro_hatch(width - thickness*2, depth, height, thickness, leg, pillar, backheight);
}

module draw_beranda(width, depth, height, thickness, leg, pillar, backheight){

    beranda_body(width, depth, height, thickness, leg, pillar, backheight);
    beranda_hatch(width-thickness*2, depth+pillar+pillar+thickness, height+leg, pillar, thickness, backheight);

}


module kieiro_body(width, depth, height, thickness, leg, pillar, backheight){
    echo("---- body ----");
    tk = thickness;
    p = pillar;
    
    translate([0, tk, leg])
    rotate([90, 0, 0])
    board([width, height, tk]);

    translate([0, tk, leg])
    rotate([90, 0, 90])
    board([depth, height, tk]);

    translate([0, tk*2 + depth, leg])
    rotate([90, 0, 0])
    board([width, height,tk]);

    translate([width - tk, tk, leg])
    rotate([90, 0, 90])
    board([depth, height, tk]);


    translate([tk, tk+depth-p, 0])
    pillar(p, leg + height + backheight);

    translate([width-tk-p, depth - tk - tk, 0])
    pillar(p, leg + height + backheight);


    translate([tk, tk, 0])
    pillar(p, leg + height);

    translate([width-tk-p, tk, 0])
    pillar(p, leg + height);

}

module kieiro_hatch(width, depth, height, thickness, leg, pillar, backheight){
    p = pillar;
    tk = thickness;
    hd = sqrt(pow(backheight,2) + pow(depth,2));   


    motion_range = 180 - atan((depth-pillar)/(backheight)); 

    
    
    echo("---- roof ----");

    translate([width - tk, depth - tk*2, height+leg+backheight])
    rotate([ vibrate($t, motion_range), 0, 180])
    translate([0, 0, p]){
        rotate([-90, 0, 0]){
           translate([0, -p, 0]){
               pillar(p, hd);
               
               translate([(width-p)/2, 0, 0])
               pillar(p, hd);
               
               translate([width-p, 0, 0])
               pillar(p, hd);
           }
           
        }
        
        rotate([0, 90, 0]){
            translate([0, 0, 0])
            pillar(p, width);

            translate([0, hd-p, 0])
            pillar(p, width);
        }

        margin = 0.2;
        color("snow", 0.8)
        translate([-width*margin/2, -hd*margin/2, p])
        roof([width*(1+margin), hd*(1+margin), tk]);
    }
}


module beranda_body(width, depth, height, thickness, leg, pillar, backheight){
    echo("---- body ----");
    
    tk = thickness;
    p = pillar;
    
    
    translate([tk, tk+tk+p, leg])
    rotate([90, 0, 0])
    board([width-tk*2, height, tk]);

    translate([tk+p, tk, 0])
    pillar(p, leg + height);

    translate([width-tk-p-p, tk, 0])
    pillar(p, leg + height);

    translate([tk, tk+tk+p, leg])
    rotate([90, 0, 90])
    pillar(p, width-tk*2);


    
    translate([tk, depth-pillar+tk, leg])
    rotate([90, 0, 0])
    board([width-tk*2, height,tk]);

    translate([tk+p, tk+depth-p, 0])
    pillar(p, leg + height + backheight);

    translate([width-tk-p-p, depth - tk - tk, 0])
    pillar(p, leg + height + backheight);

    translate([tk, depth-p-p, leg])
    rotate([90, 0, 90])
    pillar(p, width-tk*2);


    
    translate([0, tk, leg])
    rotate([90, 0, 90])
    board([depth, height, tk]);

    translate([tk, tk+depth-p, 0])
    pillar(p, leg + height);

    translate([tk, tk, 0])
    pillar(p, leg + height);


    
    translate([width - tk, tk, leg])
    rotate([90, 0, 90])
    board([depth, height, tk]);

    translate([width-tk-p, tk, 0])
    pillar(p, leg + height);

    translate([width-tk-p, depth - tk - tk, 0])
    pillar(p, leg + height);


    
    translate([tk, p+tk*2, leg+p])
    board([width-tk*2, depth-tk*2-p*2, tk]);

    translate([tk, depth/3*2, leg])
    rotate([90, 0, 90])
    pillar(p, width-tk*2);

    translate([tk, depth/3, leg])
    rotate([90, 0, 90])
    pillar(p, width-tk*2);

}


module beranda_hatch(width, depth, height, pillar, thickness, backheight){
    echo("---- hatch ----");
    p = pillar;
    tk = thickness;
    
    motion_range = 180 - atan((depth-pillar)/(backheight-pillar)); 

    hd = sqrt(pow(backheight,2) + pow(depth,2));   
    
    translate([width+tk, depth-p*2, height+backheight]){
        rotate([ vibrate($t, motion_range), 0, 180]){
            translate([0, tk-p*2, 0]){

                rotate([-90, 0, 0]){
                   translate([0, 0, 0]){
                       pillar(p, hd);
                       
                       translate([(width-p)/2, 0, 0])
                       pillar(p, hd);
                       
                       translate([width-p, 0, 0])
                       pillar(p, hd);
                   }
                   
                }
                
                rotate([0, 90, 0]){
                    translate([-p, 0, 0])
                    pillar(p, width);

                    translate([-p, hd-p, 0])
                    pillar(p, width);
                }

                margin = 0.2;
                color("snow", 0.8)
                translate([-width*margin/2, -hd*margin/2, p])
                roof([width*(1+margin), hd*(1+margin), tk]);
            }
        }
    }
}



module board(array){
    echo("board : ", array[0], array[1], array[2]);
    cube(array);
}

module pillar(width, height){
    echo("pillar : ", width, height);
    cube([width, width, height]);
}

module roof(array){
    echo("roof : ", array[0], array[1], array[2]);
    cube(array);
}


function vibrate(t, motion_range) = -sin(t*360)*motion_range/2 + (90 - motion_range/2);
