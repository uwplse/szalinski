//max width of the feeder
cup_width = 180;
//thickness of building wall, minimal, some place it's reinforced
thickness = 6;
//max height
tower_height = 60;

//jar openning external width (including tooths) 
jar_width = 80;

//number of "teeth" on the container you want to recycle, 
thread_count = 6;

//height in regard to the container, so the width of the thread on the bottle
thread_vertical_height = 2.5;
//vertical space between every thread
thread_spacing = 1.9;

//height of the thread, how much raise it is in regard to the bottle
thread_height = 1.5;

//drain control, a drain width of 1.5 won't let pass any seed, 
//if you are only using black sunflower you can put a larger drain
drain_width = 1.5;

//drain minimal space is to avoid too-small ribs when these span on the z axis 
//where inter layer adhesion can become an issue.
drain_min_space = 8;

//number of support (ropes/rods holes)
support_holes_count = 6;

//+1 magic number for tolerance
tower_width = jar_width +(thickness*2)+1;


$fn = 100*1;

function closest_whole_divisor(n,x) = ( n%x == 0 ? x : closest_whole_divisor(n,x-1) );


module cup(cup_radius,lip_height,plate_ratio) {
    difference(){
        cylinder(h=lip_height-0.01,r2=cup_radius,r1=cup_radius*plate_ratio);
        translate([0,0,thickness]) cylinder(h=lip_height-0.01,r2=cup_radius,r1=cup_radius*plate_ratio);
    }
}
module fullCup(cup_radius,lip_height,tower_ratio,tower_height,plate_ratio){
    difference(){
        difference(){
            union(){
                cup(cup_radius,lip_height,plate_ratio);
                cylinder(h=tower_height,r1=cup_radius*tower_ratio,r2=0);
            }
            translate([0,0,-thickness*1.5]) cylinder(h=tower_height,r1=cup_radius*tower_ratio,r2=0);
        }
        union(){
            drain(cup_radius*plate_ratio-thickness,tower_width/2+thickness);
            drain(cup_radius*tower_ratio-thickness,(cup_radius*tower_ratio-thickness)/2);
            translate([0,0,thickness]) horizontal_drain(lip_height-thickness*2,cup_radius*plate_ratio);
        }
    }
}
module drain(outer_radius,inner_radius){
    drain_length = outer_radius - inner_radius;
    drain_count = floor((inner_radius*PI*2)/(drain_width+drain_min_space));
    steps = 360/closest_whole_divisor(360,drain_count);
    for(i=[0:steps:359]){
        rotate([0,0,i]) translate([inner_radius,-drain_width/2,-50]) cube([drain_length,drain_width,100]);
        rotate([0,0,i+(steps/2)]) translate([inner_radius+(drain_length/2),-drain_width/2,-50]) cube([drain_length/2,drain_width,100]);
    }
}
module horizontal_drain(height,inner_radius){
    drain_count = floor((inner_radius*PI*2)/(drain_width+drain_min_space));
    steps = 360/closest_whole_divisor(360,drain_count);
    for(i=[0:steps:359]){
        rotate([0,0,i]) translate([inner_radius,-drain_width/2,0]) cube([100,drain_width,height]);
    }
}
module seed_doors(height,door_width,door_spacing,inner_radius){
            doors_count = floor((inner_radius*PI*2)/(door_width+door_spacing));
            steps = 360/closest_whole_divisor(360,doors_count);     
	difference(){
        union(){


            for(i=[0:steps:359]){
                rotate([0,0,i]) translate([inner_radius,0,thickness]) rotate([0,90,0]) cylinder(h=height,r=door_width/2);
				}
            
        }
        translate([0,0,-50+thickness-0.01]) cube([100,100,100],center=true);
    }
}
module threadedTower(){
    difference(){
        cylinder(h=tower_height+1,r=tower_width/2);
        union(){
            translate([0,0,-1]) cylinder(h=tower_height+3,r=(tower_width/2)-thickness);
            seed_doors(10,20,10,(tower_width/2)-(thickness+2));
        }
    }
}
module thread(){
    tower_revolving_reference_perimeter =  2*(tower_width/2-(thickness+thread_height))*PI;
    height_displacement = (thread_height+thread_spacing)*thread_count;
    angle = atan(height_displacement/tower_revolving_reference_perimeter);
    
    points = [[thread_vertical_height,-thread_height],[0,thread_height],[-thread_vertical_height,-thread_height]];
    
    difference(){
        union(){
            for(thread_index = [0:360/thread_count:359]){
                rotate([0,0,thread_index])
                for(i = [0:5:360]){
                    rotate([0,0,i]) translate([0,-((tower_width/2)-thickness),(i/360)*height_displacement]) rotate([0,90-angle,0]) linear_extrude(height=5,center=true)         polygon(points);
                }
            }
        }
        union(){
            translate([0,0,-thread_height*2]) cylinder(h=thread_height*2,r=tower_width);
          //  translate([0,0,height_displacement]) cylinder(h=thread_height*2,r=tower_width);
        }
    }
    
}

module support(count,radius,height,distance_from_center){
    for(i = [0:360/count:359]){    
        rotate([0,0,i]) translate([distance_from_center,0,0]) 
            cylinder(h=height,r=radius);
        }
    }

module support_hole(count,radius,height,distance_from_center){
    for(i = [0:360/count:359]){    
        rotate([0,0,i]) translate([distance_from_center,0,0]) 
        union(){
                translate([0,0,-1]) cylinder(h=height+2,r=radius/2);
                if(count > 4){
                    rotate([90,0,180/count])  
                        translate([0,0,-(radius*1.5)])  
                        cylinder(h=radius*1.5,r=radius/2);
                    rotate([90,0,180-180/count]) 
                        translate([0,0,-(radius*1.5)]) 
                        cylinder(h=radius*1.5,r=radius/2);
                }
            }
        }
    }

difference(){
    union(){
        translate([0,0,tower_height-((thread_height+thread_spacing)*thread_count)]) thread();
        fullCup(cup_radius=cup_width/2,lip_height = 15,tower_ratio=0.4,tower_height=40,plate_ratio=0.85);
        threadedTower();
        support(support_holes_count,5,20,cup_width/2);
    }
    support_hole(support_holes_count,5,30,cup_width/2);
    translate([0,0,tower_height+50]) cube([100,100,100],center=true);
    //cube([200,200,tower_height*2-5],center=true);
    //cube([100,100,100]);
}
