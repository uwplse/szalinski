//[Parametric Heart Box v.1]
//Written by Hermes Alvarado
//<hermesalvarado@gmail.com>

//Definitions:
size = 40; //total width and length of box
height = 20; //total height of box
thickness = 1; //wall thickness
bottomthickness = 1;
lidheight = 5;
tolerance = 0.2; //tolerance between box and lid


//Calculations
module heart(){
    polygon([[0,-size/2],[size/2,0],[size/2,size/4],[size/4,size/2],[0,size/4],[-size/4,size/2],[-size/2,size/4],[-size/2,0]],[[0,1,2,3,4,5,6,7]],10);
};
module innerheart(){
    offset(delta=-thickness){
        polygon([[0,-size/2],[size/2,0],[size/2,size/4],[size/4,size/2],[0,size/4],[-size/4,size/2],[-size/2,size/4],[-size/2,0]],[[0,1,2,3,4,5,6,7]],10);
    }
};
module heartbox(){
    difference(){
        linear_extrude(height=height,center=false,convexity=10,twist=0){
            heart();
        }
        translate([0,0,bottomthickness]){
            linear_extrude(height=height-bottomthickness,center=false,convexity=10,twist=0){
                innerheart();
            }
        }
    }
};
module heartboxlid(){
    translate([0,size*1.2,0]){
        difference(){
            linear_extrude(height=lidheight,center=false,convexity=10,twist=0){
                offset(delta=thickness+tolerance){
                    heart();
                }
            }
            translate([0,0,bottomthickness]){
            linear_extrude(height=lidheight-bottomthickness,center=false,convexity=10,twist=0){
                offset(delta=thickness+tolerance){
                    innerheart();
                }
            }
        }
        }
    }
};
heartbox();
heartboxlid();