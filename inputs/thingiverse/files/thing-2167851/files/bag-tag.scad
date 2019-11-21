

//letter height
    letterheight = 1; // [1,1.5,2,2.5,3,3.5]
//letter size
    lettersize = 20; // [10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50]
//label text
    label =  "TEXT";


module letter(l){
    
    linear_extrude(height = letterheight) {
        text(l, size = lettersize, font = "Arial:style=Bold", halign = "left", valign = "top");
    }
}



difference() { 
    union() {
            translate ([-4,-28,0]) cube([90,40,2], center = false);
            translate([0,0,2])  letter(label);
    }
    
    translate([2,6,0]) cylinder(h=5, r=3.5, center = true);
}
