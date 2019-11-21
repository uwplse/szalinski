// : mm of extra z clearance you wish to add. usually around your glass thickness. note: 1/8" = 3.175mm, 3/8" = 9.525mm, 5/8" = 15.625mm, 3/4" = 19.05mm
ADJUST_HEIGHT = 2; // [0.8, 1, 1.5, 2, 2.5, 3, 3.175, 3.5, 4, 4.5, 5, 5.6, 6, 9.525, 15.625, 19.05]
// : a 1/10 mm fine tuning of the adjust_height. For example choosing 1.5 above and -0.2 here results in height = 1.5-0.2 = 1.3mm.
FINE_TUNE_HEIGHT = 0.0; // [-0.5, -0.4, -0.3, -0.2, -0.1, 0.0, 0.1, 0.2, 0.3, 0.4, 0.5]
// : how wide you want the spacer to be. 7mm is just right for fully covering the exposed side.
SPACER_WIDTH = 7; // [5,6,7]
// : how much you would like the tines of the hook to stick out. 
HOOK_PROTUBERANCE = 2.0; // [2.0, 3.0, 4.0]
// : add insertion levers on the back allowing you to insert and remove from the machine without disassembly. 1=Levers 0=No Levers
INSERTION_LEVERS = 1; // [0,1]

module zadjust() {

    HOOK_LENGTH = HOOK_PROTUBERANCE;
    ID_HEIGHT = 36;
    ID_WIDTH = 29.8;
    BASE_WIDTH = 2;
    LEVER_LENGTH = 32;
    EXTRA_HEIGHT = ADJUST_HEIGHT+FINE_TUNE_HEIGHT;
    
    translate([ID_WIDTH+HOOK_LENGTH, ID_HEIGHT+BASE_WIDTH+EXTRA_HEIGHT])
rotate([0,0,180]){
    // C shape
    difference() {
        // positive
        xsize = INSERTION_LEVERS ? ID_WIDTH+BASE_WIDTH+LEVER_LENGTH : ID_WIDTH+BASE_WIDTH;
        scale([xsize, ID_HEIGHT+BASE_WIDTH+EXTRA_HEIGHT, SPACER_WIDTH])
            cube();
        
        // negative
        translate([-0.01, BASE_WIDTH, -0.01])
            scale([ID_WIDTH+0.01,ID_HEIGHT,SPACER_WIDTH+0.02])
                cube();
        
        // insertion levers
        if(INSERTION_LEVERS)
            translate([LEVER_LENGTH, BASE_WIDTH, -0.01])
                scale([LEVER_LENGTH+BASE_WIDTH+0.01,ID_HEIGHT,SPACER_WIDTH+0.02])
                    cube();
    }
    
    // top hook
    translate([-BASE_WIDTH*HOOK_LENGTH,0,0])
        scale([BASE_WIDTH*HOOK_LENGTH, BASE_WIDTH+HOOK_PROTUBERANCE, SPACER_WIDTH])
            linear_extrude(1)
                polygon(points=[[1,1],[1,0],[0,0]]);
    
    // bottom hook
    translate([-BASE_WIDTH*HOOK_LENGTH,ID_HEIGHT+BASE_WIDTH+EXTRA_HEIGHT-(HOOK_PROTUBERANCE+EXTRA_HEIGHT),0])
        scale([BASE_WIDTH*HOOK_LENGTH, HOOK_PROTUBERANCE, SPACER_WIDTH])
            linear_extrude(1)
                translate([0,1,0])
                rotate([180,0,0])
                polygon(points=[[1,1],[1,0],[0,0]]);
    
    // bottom fill
    translate([-BASE_WIDTH*HOOK_LENGTH,ID_HEIGHT+BASE_WIDTH,0])
    scale([BASE_WIDTH*HOOK_LENGTH,EXTRA_HEIGHT,SPACER_WIDTH])
    cube();
}
}
color([0.4,0.7,0.8])
zadjust();