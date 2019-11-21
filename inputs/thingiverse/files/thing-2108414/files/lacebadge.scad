//input from http://chaaawa.com/stencil_factory_js/
input = "no_input";
//The size of the border arround the image (0 is no boarder)
boarder = 0; //[100]
//how much extra to add to the base shape, to allow for pointy or unusual images
comp_size = 10;//[100]
//xposition compensation
xcomp=0;
//yposition compensation
ycomp=-2;
//size of lace loop
loop_size = 5;
//the shape of the badge (including boarder)
shape = 0 ;// [180:Round, 360:Smooth, 4:Diamond, 5:Pentagon, 6:Hexagon, 7:Heptagon, 8:Octagon, 9:Nonagon, 10:Decagon, 11:Hendecagon, 12:Dodecagon,0:Square]

points_array = (input=="no_input"?  [[91,35],[[179.03,131.04],[177.55,131.62],[174.75,132.95],[170.86,135.19],[166.75,137.95],[162.81,141.35],[159.29,145.13],[156.83,148.58],[155.45,151.17],[155.18,152.75],[155.42,153.75],[156.7,153.55],[158.91,152.22],[161.69,150.53],[164.33,149.45],[166.68,149.18],[168.78,149.43],[170.47,150.6],[171.84,152.56],[173.14,154.41],[174.93,154.04],[178.04,153.3],[182.79,153],[188.16,153.49],[192.1,155.25],[195.09,158.08],[197.5,161.72],[199.06,164.7],[200,165.96],[201.09,164.61],[203,161.33],[205.76,157.43],[208.98,154.83],[213.16,153.46],[218.68,153],[223.24,153.29],[225.5,154],[226.19,154.71],[226.99,155],[227.8,154.41],[228.5,153],[229.53,151.27],[231.13,149.93],[233.4,149.37],[236.08,149.52],[239.06,150.72],[242.07,152.71],[244.4,154.3],[245.76,154.57],[245.57,152.83],[244.16,149.59],[241.46,145.49],[238.19,141.7],[233.84,138.13],[228.56,134.56],[224.11,132.05],[221.76,131],[220.86,131.84],[219.9,133.85],[218.06,136.42],[213.2,137.98],[208.81,139.02],[206.25,139.73],[205.36,139.67],[204.98,138.86],[204.7,137.46],[204.02,136],[202.97,135.13],[201.54,136.5],[200,138.5],[198.95,136.75],[197.93,135.51],[196.95,135],[196.28,135.54],[196,136.83],[195.85,138.28],[195.48,139.19],[193.15,139.09],[188.3,138.12],[182.66,136.32],[180.61,133.77],[179.71,131.82],[179.03,131.04]]]: input);

dispo_width = boarder*2;
badge_height = 10;
  
module logo(){
    translate([-400/2, -300/2, -badge_height/2]){
        for (i = [1:len(points_array) -1] ) {
            linear_extrude(height=badge_height/2)
            {
                polygon(points_array[i]);
            }
        }
    }
}

module back(){
    swidth = input_width+comp_size+boarder;
    sheight = input_height+comp_size+boarder;
    if (shape!= 0){
        translate([xcomp,xcomp,0]){
            scale([swidth,sheight,1]){
                cylinder(d=1,h=badge_height/2,$fn=shape);
            }
        }
    } else {
        translate([xcomp,ycomp,badge_height/4]){
            cube([swidth,sheight,badge_height/2],center=true);
        }
    }
}
module loop(){
    swidth = input_width+comp_size;
    translate([0,0,(badge_height+loop_size)/2]){
        rotate([0,90,0]){
            cylinder(d=loop_size+5,h=swidth*0.75, center=true);
        }
    }
}
module add_boarder(){
    swidth = input_width+comp_size;
    sheight = input_height+comp_size;
    
    if (shape!= 0){
        translate([xcomp,xcomp,-badge_height/2]){
            difference(){
                scale([swidth+boarder,sheight+boarder,1]){
                    cylinder(d=1,h=badge_height/2,$fn=shape);
                }
                scale([swidth,sheight,1]){
                    cylinder(d=1,h=badge_height/2,$fn=shape);
                }
            }
        }
    } else {
        translate([xcomp,ycomp,-badge_height/4]){
            difference(){
                cube([swidth+boarder,sheight+boarder,badge_height/2],center=true);
                cube([swidth,sheight,badge_height/2],center=true);
            }
        }
    }
}

module badge(){
    color("gray"){
        logo();
    }
    difference(){   
        hull(){
            back();
            loop();
        }
        translate([0,0,(badge_height+loop_size)/1.75]){
            rotate([0,90,0]){
                cylinder(d=loop_size,h=(input_width+comp_size)*2, center=true);
            }
        }
    }
    if (boarder>0){
        add_boarder();
    }
}
input_width = points_array[0][0];
input_height= points_array[0][1];
badge();