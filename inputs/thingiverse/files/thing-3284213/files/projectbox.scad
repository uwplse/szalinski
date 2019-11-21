//width (in mm)
width = 40;

//length
length = 60;

//height
height = 20;

//wall thickness
wall = 2;

//pitch (hole spacing)
pitch = 5;

module pbox(w,l,h,wall,pitch){
    difference(){
        cube([w,l,h]);
        union(){
            translate([wall,wall,wall]) cube([w-2*wall,l-2*wall,h]);
            for (f=[0:l/pitch-2]){
                for (i=[0:w/pitch-2]){
                    translate([pitch*i+pitch,pitch*f+pitch,0]) cylinder(r=0.5,h=2*wall);
                }
            }
        }
    } 
}

pbox(width,length,height,wall,pitch);
