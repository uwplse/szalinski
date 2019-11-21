// you need this library from http://dkprojects.net/openscad-threads/
use </home/oja/threads.scad>

// Written by Ondrej Janovsky <oj@alarex.cz>
//
// To the extent possible under law, the author(s) have dedicated all
// copyright and related and neighboring rights to this software to the
// public domain worldwide. This software is distributed without any
// warranty.
//
// You should have received a copy of the CC0 Public Domain
// Dedication along with this software.
// If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.


module holder_tile(text, height=5, width_x = 15, width_y= 15){
    difference(){
       cube([width_x,width_y,height]);
       translate([(width_x/2),width_y-5,0]) metric_thread(diameter=6.5, pitch=1, length=height, internal=true);
       translate([(width_x/2),width_y-15, height-0.8]) linear_extrude(height=0.8) text(text=text, size=5, halign="center", font="Liberation Sans:style=Bold");      
    }  
}

module empty_tile(height=5, width_x = 15, width_y= 15){
   cube([width_x,width_y,height]);
}

//calculate max. number of columns in array - recursion
function computeColumns(array,line,num_max=0) = line<len(holes)? computeColumns(array,line+1,num_max<len(array[line]) ?len(array[line]):num_max ) : num_max<len(array[line]) ?len(array[line]):num_max; 


module createHolder(holes=[], tile_width_x=20, tile_width_y=20, total_height=5) {
    columns = computeColumns(holes,0,0);
    
    echo("Maximum columns: ",columns);
    
    i=0;
    for(line_index=[0:len(holes)-1]){
        line = holes[line_index];
        for(index=[0:columns-1]) {
            yy = -line_index*tile_width_y + 1;
            xx = index*tile_width_x;
            cell = line[index];
            if(cell!=undef) {
                    translate([xx,yy,0]) holder_tile(text = cell, height=total_height, width_x=tile_width_x, width_y=tile_width_y);
            }  else {
                 translate([xx,yy,0]) empty_tile(height=total_height, width_x=tile_width_x, width_y=tile_width_y);
            }    
        }
    }    
}


//use this
//vector contains vectors - lines with holes. Number of holes can be different for each line.
holes = [["0.25","0.3","0.35"],["0.4","0.6","0.8"]];
createHolder(holes,20,20,5);

