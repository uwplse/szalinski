// ---------------------------------------------
// CROSS-DEVICE BRACKETS
// Version 0.1, February 26, 2017
// ---------------------------------------------



//Number of brackets (all offset in 90 degrees)
brackets=2;//[1:4]

//Thickness of the outer border
border_width=7;//[4:20]

//Tablet cover width
cover_width=7;//[4:20]

//Thickness of the top and bottom layer
layer_thickness=1;//[2:10]

//Thickness of the device (e.g., Tablet)
device_thickness=5;//[3:30]

//Tilt angle (around x axis)
angle=50;//[0:90]

//Length of the brackt
length=40;//[20:100]


build_brackets(brackets, 
    border_width,
    cover_width,
    layer_thickness,
    device_thickness,
    angle, length);


// Build the complete, multi-element bracket
module build_brackets(brackets, 
    bw, cw,, lt, dt, angle, length)
{
    for (count =[0:brackets - 1]){
        if((count == 1) || (count == 2)) {    
            rotate([0 ,angle,0])
              rotate(count*90)
                build_bracket(bw, cw,, lt, dt, length);
        }
        else{
            rotate(count*90)
                build_bracket(bw, cw,, lt, dt, length);
        }          
    }
}

// Build a single L-shape bracket
module build_bracket(bw, cw, lt, dt, length){
    slide_bracket(bw, cw, lt, dt, length);
    mirror([1,-1,0])    
        slide_bracket(bw, cw, lt, dt, length);
}


// Build a single slide-in element for the tablet
module slide_bracket(bw, cw, lt, dt, length){  
    difference() {
        cube([length, bw+cw, (dt + 2*lt)]);
        translate([0, bw, lt])
            cube([length, cw, dt]);
    }  
}