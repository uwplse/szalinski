//$fn = 50; //set fragments
min_height =100; //height of first row
height_step = 10; //step between rows
wall = 2; //rack wall thickness
rows = 3; // number of rows
tool_gap = 20; // distance from tool slot to tool slot
slot_diameter =12; // diameter of tool slot holes (default, diameter_by_row takes priority)
tools_odd = 8; // # of tools in odd rows
tools_even = 7; // # of tools in even rows
diameter_by_row = [12,12,14]; //vector containing the slot diameters for each row. If you want to use a set diameter (via slot_diameter), make empty, i.e. []. If you have more rows than diameters set, the remaining rows will default to slot-diameter
width = tool_gap * max(tools_odd, tools_even);

module prism(l, w, h){
    translate([-l/sup_mod, -w/sup_mod, -h/sup_mod]){
        polyhedron(
            points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
            faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
        );
    }
    
}
//
//make rack rows
difference(){
union(){
    for(r = [0:rows-1]){
        translate([0,tool_gap*r,height_step/2*r]){
            difference(){
                //make rectangular walls
                cube([width,tool_gap,min_height+(height_step*r)],center=true);
                union(){
                    translate([0,0,-(height_step*r/2)])cube([width - (wall*2),tool_gap + (wall*2), min_height - (wall*2)],center=true);
                    
                }
            }
        }
    }
}

//make holes
//if row is even, use tools_even for # of tools, else tools_odd for # tools
//hole diameters dictated by diameter_by_row vector (preferentially) and / or slot_diameter value.
union(){
    for(x = [1:rows]){
        if(x%2 == 0.00){
            translate([-tool_gap*tools_even/2 + tool_gap/2,tool_gap*(x-1),height_step*(x-1)/2]){
                for(s = [1:tools_even]){
                    translate([tool_gap*(s-1),0,0]){
                        if(diameter_by_row[x-1] > 0){
                            translate([0,0,height_step*x])cylinder(min_height + x*height_step,d=diameter_by_row[x-1], center = true);
                        } else{
                            translate([0,0,height_step*x])cylinder(min_height + x*height_step,d=slot_diameter, center = true);
                        }
                    }
                }
            }
        } else{
            translate([-tool_gap*tools_odd/2 + tool_gap/2,tool_gap*(x-1),height_step*(x-1)/2]){
                for(s = [1:tools_odd]){
                    translate([tool_gap*(s-1),0,0]){
                        if(diameter_by_row[x-1] > 0){
                            translate([0,0,height_step*x])cylinder(min_height + x*height_step,d=diameter_by_row[x-1], center = true);
                        } else{
                            translate([0,0,height_step*x])cylinder(min_height + x*height_step,d=slot_diameter, center = true);
                        }
                    }
                }
            }
        }
    }
for(h=[0:rows-1]){
    translate([0,tool_gap*h,min_height/2+height_step*h-height_step/2])cube([width-(wall*2),tool_gap*rows*2+(wall*2),height_step-(wall*2)], center=true);
}
}
}















