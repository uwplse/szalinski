use <write/Write.scad>

// Size of the first hole
min_size = 8;

// size increment for each hole
size_step = 1.105;

// number of holes
num_steps = 9;

// height of the base plate
thing_height = 2;

// distance between the edges of consecutive holes
margin_between_holes = 3;

// around the holes and the text
margin_outside = 3;

// between text and holes
margin_text = 2;

// cut depth of text engraving
text_depth = 0.5;

// the size is auto-determined by a heuristic that may fail. If text falls of, manually increase this
extra_space_for_text = 0;


space_for_text = min_size*len(str(size_step*(num_steps-1)));
max_size = min_size+size_step*(num_steps-1);
last_center = (num_steps-1)*size_step + (num_steps-1)/2*(2*min_size+((num_steps-1)-2)*(size_step)) + (num_steps-1)*margin_between_holes; // substiture (num_steps-1) for i in dx below
width = last_center + min_size/2 + max_size/2;

difference(){
	$fn=50;
    translate([-max_size/2-margin_outside,-margin_outside-min_size/2,0])
    cube([max_size+2*margin_outside+extra_space_for_text+space_for_text,2*margin_outside+width,thing_height]);

    for(i=[0:num_steps-1]) {
        sz = min_size+size_step*i; // diameter of this hole
        dx = i*size_step + i/2*(2*min_size+(i-2)*(size_step)) + i*margin_between_holes; // distance from 0 to center of this circle
        translate([0,dx,-1])
        cylinder(r=sz/2,h=thing_height+2);
        
        translate([max_size/2+margin_text,dx-min_size/2/*for baseline adjustment*/,thing_height-text_depth+0.01])
        write(str(sz),h=0.9*min_size,t=text_depth,font="orbitron.dxf");

    }
}


