//use <tyler.scad>;

$fn=32*1;

E=0.05*1;

// Thickness of the part that goes over whatever you're hanging it on. (mm)
lip_thickness = 7;

// Thickness of the hook part. (mm)
hook_thickness = 7;

// Width of the hook; also basically sets its strength. (mm)
width = 3; 

// Height of the stem, i.e. the vertical part on the hook side. (mm)
stem_height = 30;

// How large is the actual hook part, measured as the diameter of the inside of the hook. (mm)
hook_diameter = 16; 

// How thick is the thing you're hanging the hook on? (mm)
lip_length = 14; 

// Height of the back part of the hook. (mm)
lip_height = 30;

hook_radius = hook_diameter/2;

//stem
cube2([width,stem_height+width,hook_thickness],aligns="LLC");

// hook
translate([-hook_radius,0,0]) {
    difference() {
        cylinder(r=hook_radius+width,h=hook_thickness,center=true);
        cylinder(r=hook_radius,h=hook_thickness+2*E,center=true);
        cube2([hook_diameter+2*width+E,hook_radius+width+E,hook_thickness+2*E],aligns="CLC");
    }
}
// rounded hook end
translate([-hook_diameter-width/2,0,0]) cylinder(d=width, h=hook_thickness, center=true); 


// lip
translate([0,stem_height,0]) {
    rotate([0,90,0]) linear_extrude(width) arc(r=lip_thickness/2, a1=180, a2=0);
    
    translate([0,width,0]) cube2([lip_length+width+width,width,lip_thickness],aligns="LRC");
    
    translate([lip_length+width,width,0]) cube2([width,lip_height+width,lip_thickness],aligns="LRC");
    
}


module cube2(size,aligns="LLL",radius=0,xy_radius=0) {
    real_size = len(size) ? size : [size,size,size];
    tr = [
        aligns[0]=="C" ? 0 : aligns[0]=="R" ? (-real_size[0]/2) : (+real_size[0]/2),
        aligns[1]=="C" ? 0 : aligns[1]=="R" ? (-real_size[1]/2) : (+real_size[1]/2),
        aligns[2]=="C" ? 0 : aligns[2]=="R" ? (-real_size[2]/2) : (+real_size[2]/2)
    ];
    translate(tr) {
        if (xy_radius>0) {
            inner_size = [for (v=real_size) v-min(xy_radius*2,v)];
            linear_extrude(real_size[2], center=true) offset(r=xy_radius) square([inner_size[0],inner_size[1]], center=true);
        } else if (radius>0) {
            if (radius*2 >= max(real_size)) {
                resize(real_size) sphere(1);
            } else {
                inner_size = [for (v=real_size) v-min(radius*2,v)];
                minkowski() {
                    cube(inner_size,center=true);
                    sphere(r=radius);
                }
            }
        } else {
            cube(real_size,center=true);
        }
    } 
}

module arc(r,a1,a2,ir=0) {
    // normalize to 0..360 (even for negatives)
    a1n = (a1 % 360 + 360) % 360; 
    a2n = (a2 % 360 + 360) % 360;
    difference() {
        circle(r);
        if (ir != 0) circle(ir); // if inner radius given, subtract it away
            
        // get the a1 to interpolate to, adding a revolution if going the long way
        a1next = a2n>a1n ? a1n + 360 : a1n; 
        
        polygon([
            [0,0],
            [cos(1.00*a2n + 0.00*a1next)*2*r,sin(1.00*a2n + 0.00*a1next)*2*r],
            [cos(0.66*a2n + 0.33*a1next)*2*r,sin(0.66*a2n + 0.33*a1next)*2*r],
            [cos(0.33*a2n + 0.66*a1next)*2*r,sin(0.33*a2n + 0.66*a1next)*2*r],
            [cos(0.00*a2n + 1.00*a1next)*2*r,sin(0.00*a2n + 1.00*a1next)*2*r],
        ]);
    }
}


