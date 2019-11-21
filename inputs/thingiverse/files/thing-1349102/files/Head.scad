
pad_thickness = 10; //[10:10]
pad_x = 35; //[32:0.5:150]
pad_y = 30; //[26:0.5:150]


difference() {
    
    difference() {
        translate ([pad_x/2- pad_x + 15,0,0])
            color ("blue")
                cube([pad_x,pad_y,pad_thickness], center=true)
        ;
        
        translate ([0,0,0.5]) 
            color ("red")
                cube([33,26,6], center=true)
        ;
        
        translate ([2.5,0,pad_thickness/3.5]) 
            color ("Orange")
                cube([28,21,pad_thickness / 2 + 5], center=true)
        ;
    }


    difference() {
        translate ([pad_x/2 - pad_x + 12.6,0,pad_thickness/2 - 2.5]) 
            color ("yellow")
                cube([pad_x + 5,pad_y + 5,pad_thickness], center=true)
        ;
            
        translate ([-1,0,pad_thickness/2 - 2.5]) 
            color ("Aqua")
                cube([33,28,pad_thickness], center=true)
        ;
    }
}