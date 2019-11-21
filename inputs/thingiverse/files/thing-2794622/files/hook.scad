$fn=60;
// Measurements assumed as mm

// Internal measurement: bottom of 'leg' to top of arch
loop_height=25;
// Internal measurement: distance between legs desk is 31
loop_width=31; 

////
//Customisable options:
////
// Rounded or square profiled hook
hook_type="rounded";//[rounded,square]

// Internal measurement: gap between arch and hook lip. 5 for small hook, 21 for headset
hook_depth=5;//[1:40]

// Internal measurement: height of hook lip above semi circle. 2.5 recommended
hook_height=2.5;//[0:25]

// Print height from bed
print_height=7;//[1:15]

// Horizontal thickness of 2d shape
pla_width=2.8;//[2:5]



if(hook_type == "rounded"){
linear_extrude(height=print_height){
    roundedhook(loop_height, loop_width, pla_width, hook_depth, hook_height);
}};

if(hook_type == "square"){
linear_extrude(height=print_height){
    hook(loop_height, loop_width, pla_width, hook_depth, hook_height);
}};


// Hook with a semi-circular profile. Smoother for hanging things off
module roundedhook(loop_height, loop_width, pla_width, hook_depth, hook_height){
    union(){
        loop(loop_height, loop_width, pla_width);
        translate([loop_width + 2*pla_width + hook_depth/2, 0.5])semi_arc(hook_depth/2, pla_width);
        translate([loop_width + 2*pla_width + hook_depth, 0])rounded_square(pla_width, hook_height);
    }
}

// A hook with a square profile. Not great for hanging things on really
module hook(loop_height, loop_width, pla_width, hook_depth, hook_height){
    union(){
        loop(loop_height, loop_width, pla_width);
        translate([loop_width + pla_width, 0])rounded_square((2*pla_width + hook_depth), pla_width);
        translate([loop_width + 2*pla_width + hook_depth, 0])rounded_square(pla_width, hook_height);
    }
}

// The "U" shaped pard of the hook, that slots over the divider, with tabs to hold it in place
module loop(height, width, depth){
    union(){
      // Main U shape
        rounded_square(depth, height+depth);
        translate([0,height])rounded_square((2*depth + width), depth);
        translate([width+depth,0])rounded_square(depth, height+depth);

      // Tabs to hold in place
        translate([pla_width/4,height-16])rotate([0,0,90])semicircle(4.5); // magic number 16 is: 12mm top to gap, + circle rad - tiny bit to get it closer fitting.... Magic
        translate([width+depth+(3/4*pla_width),height-16.5])rotate([0,0,270])semicircle(4.5);
    }
}
    

// Produces a rectangle with rounded corners, starting at [0,0]
// Rounding has to be based on the smaller dimension, so we don't draw a square with negative sides
module rounded_square(width, length){
    rounding= width>length ? length*0.2 : width*0.2;
    translate([rounding, rounding])
    minkowski(){
        square([width-(2*rounding), length-(2*rounding)]);
        circle(rounding);
    }
}

// Semicircle. Go figure
module semicircle(radius){
difference(){
    circle(r=radius);
    translate([-radius,0])square(2*radius);
    }
}

// Cuts one semi-circle with another, to produce an arc
module semi_arc(radius, width){
    difference(){
    semicircle(radius+width);
    circle(r=radius);
    }
}
