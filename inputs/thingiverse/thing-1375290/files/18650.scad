// number of rows
pack_x = 3; // [1:20]
//number of columns
pack_y = 3; // [1:20]
//Cell diameter
cell_dia = 18.8;
//thickness around cell
cell_rim_thiknes = 0.8;
//hight of support under cell
cell_rim_hight = 2.5;
//cell depth
cell_holder_hight = 8;
//tab wire width
tab_width = 7;
//tab wire thickness
tab_thickness = 1.5;
// number of faces in circle
$fn=48; 

//CUSTOMIZER VARIABLES END
/*[hidden]*/


x_offset = (cell_dia+cell_rim_thiknes)/2;
y_offset = 0;
module cell_holder(){
    difference(){
        cylinder(r = (cell_dia/2)+cell_rim_thiknes,h = cell_holder_hight);
        translate([0,0,cell_rim_hight]){
                cylinder(r = cell_dia/2, h =cell_holder_hight);
            }
        translate([0,0,-1]){
            cylinder(r = (cell_dia/2-cell_rim_thiknes), h = cell_holder_hight+2);
        }
    }
}

module x_row(){
    for(i=[0 : pack_x-1]){
        translate([(cell_dia+cell_rim_thiknes)*i,0,0]){
            cell_holder();
            if(i != pack_x-1){
                fill();
                mirror([0,1,0]) fill();
            }
        }
    }
}
module x_tab(){
    translate([0,-tab_width/2,cell_rim_hight-tab_thickness])
    cube(size = [((pack_x-1) * cell_dia)+(pack_x-1)*cell_rim_thiknes, tab_width,cell_holder_hight]);
}
module y_tab_l(){
    translate([(cell_dia+cell_rim_thiknes)*0.25,((cell_dia+cell_rim_thiknes)/4)*1.732,(cell_holder_hight/2)+cell_rim_hight-tab_thickness]){
        rotate(a=-60, v=[0,0,1])
            cube([cell_dia+cell_rim_thiknes, tab_width, cell_holder_hight], center = true);
    }
}

module y_tab_r(){
    translate([(cell_dia+cell_rim_thiknes)*0.25,((cell_dia+cell_rim_thiknes)/4)*1.732,(cell_holder_hight/2)+cell_rim_hight-tab_thickness]){
        rotate(a=60, v=[0,0,1])
            cube([cell_dia+cell_rim_thiknes, tab_width, cell_holder_hight], center = true);
    }
}

module ring(offset){
    difference(){
        translate([0,0,-(offset*0.5)]){
            cylinder(r = ((cell_dia/2)+cell_rim_thiknes)*1.5,h = cell_holder_hight+offset);
        }
        translate([0,0,-(offset*0.5)-1]){
            cylinder(r = ((cell_dia/2)+cell_rim_thiknes)*0.95,h = cell_holder_hight+offset+2);
        }
    }
}
module fill(){
    intersection() {
        ring(0);
        translate([cell_dia+cell_rim_thiknes,0,0]) ring(1);
        translate([(cell_dia+cell_rim_thiknes)/2,(((cell_dia+cell_rim_thiknes)/2)*1.732),0])ring(2);
    }
}

difference(){
    union(){
        // cell holders
        for(j = [0 : pack_y-1]){
            y_offset = (((cell_dia+cell_rim_thiknes)/2)*1.732*j);
            if((j%2) == 0){
                translate([0,y_offset,0]) x_row();
            }else{
                translate([x_offset,y_offset,0]) x_row();
            }
        }
        if(pack_y > 1){
            // outside fill
            for(j = [0 : pack_y-2]){
                y_offset = (((cell_dia+cell_rim_thiknes)/2)*1.732*j);
                if((j%2) != 0){
                    translate([(cell_dia+cell_rim_thiknes)/2,y_offset,0])
                    rotate(a=120, v=[0,0,1])
                    fill();
                    translate([((cell_dia+cell_rim_thiknes)/2)+(cell_dia+cell_rim_thiknes)*(pack_x-1),y_offset,0])
                    rotate(a=60, v=[0,0,1])
                    fill();
                }else{
                    translate([0,y_offset,0])
                    rotate(a=60, v=[0,0,1])
                    fill();
                    translate([(cell_dia+cell_rim_thiknes)*(pack_x-1),y_offset,0])
                    fill();
                }
            }
        }
    }

    // slots for tabwires
    if(tab_thickness != 0){
        for(j = [0 : pack_y-1]){
            y_offset = (((cell_dia+cell_rim_thiknes)/2)*1.732*j);
            if((j%2) == 0){
                translate([0,y_offset,0]) x_tab();
            }else{
                translate([x_offset,y_offset,0]) x_tab();
            }
        }
    //}
        if(pack_y > 1){
            for(j = [0 : pack_y-2]){
                for(k = [0 : pack_x-1]){
                    translate([(cell_dia+cell_rim_thiknes)*k,(((cell_dia+cell_rim_thiknes)/2)*1.732*j),0]) 
                    if((j%2) == 0){
                        y_tab_r();
                    }else{
                        y_tab_l();
                    }
                }
            }
        }
    }
}



