//[ Parametric box w/slidable lid v.1 ]
//written by: Hermes Alvarado <hermesalvarado@gmail.com>

//parameters:
width = 40;
length = 60;
height = 40;
lidthickness = 2;
thickness = 1; //
bottomthickness = 1;
raildepth = 1;
tolerance = 0.4;
drawerpullerradius = 7;
resolution = 35;

//Generators:
module boxmainsubs(){
polygon(points=[[thickness,bottomthickness],[width-thickness,bottomthickness],[width-thickness,height-bottomthickness-lidthickness*3],[width-thickness-lidthickness,height-bottomthickness-lidthickness*3+lidthickness],[thickness+lidthickness,height-bottomthickness-lidthickness*3+lidthickness],[thickness,height-bottomthickness-lidthickness*3]],paths=[[0,1,2,3,4,5]],convexity=10);
}
module mainbox(){
    difference(){
        cube([width,length,height]);
        union(){
        translate([raildepth+thickness,0,bottomthickness]){
            cube([width-thickness*2-raildepth*2,length-thickness,height-bottomthickness]);
        }
        translate([0,length-thickness,0]){
            rotate([90,0,0]){
                linear_extrude(height=length-thickness,center=false,convexity=10){
                    boxmainsubs();
                }
            }
        }
        translate([thickness,0,height-lidthickness*2]){
            cube([width-thickness*2,length-thickness,lidthickness]); //rail
            }
        translate([thickness,0,bottomthickness]){
            cube([width-thickness*2,lidthickness,height-bottomthickness]); //side
        }

        }
    }
}
module puller(){
    difference(){
        cylinder(h=lidthickness-tolerance*2,r=drawerpullerradius,$fn=resolution);
        translate([0,drawerpullerradius,(lidthickness-tolerance*2)/2]){
            cube([drawerpullerradius*2,drawerpullerradius*2,lidthickness-tolerance*2],true);
            }
        }
    }

module slidelid(){
    difference(){
    union(){
    translate([0,length*1.5,0]){
            cube([width-thickness*2-tolerance*2,length-thickness-tolerance,lidthickness-tolerance*2]);
        }
        translate([0,length*1.5,0]){
            cube([width-thickness*2-tolerance*2,lidthickness-tolerance*2,height-bottomthickness-lidthickness-tolerance]);
            }
            }
                translate([(width-thickness-tolerance*2)/2,length*1.5+lidthickness-tolerance*2,0]){
                    rotate([0,0,180]){
                       puller();
                    }
                }
            }
        }

mainbox();
slidelid();