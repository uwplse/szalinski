//Thickness of the Notebook
thickness = 5;

//Pencil Diamater
penD = 8;

//Pen Radius
penrad=(penD+2)/2;

//Depth of the part
depth = 10; // [5:20]

//Wall Thickness
wlthk = 2; //[2:5]

//How angled the edges are
angle = 2.5; // [1:10]


//Modeled by Eugene Pentland
//Creates the center most rectangle
cube([wlthk,depth,thickness],true);

translate([-wlthk/2,-depth/2,(thickness/2)]){
    rotate(a=angle,v=[0,1,0])
    cube([15,depth,wlthk],false);
}

//Creates the bottom tab
translate([-wlthk/2,-depth/2,(-thickness/2)-wlthk]){
    rotate(a=-angle,v=[0,1,0])
    cube([15,depth,wlthk],false);
}

translate([-penrad-wlthk,0,0]){
    rotate(a=90,v=[1,0,0]){
        difference(){
            //Creates the initial cylinder for the pen
            cylinder(depth,penrad+wlthk,penrad+wlthk,true);
            
            //Cuts out the inner cylinder for the pen
            cylinder(depth+2,penrad,penrad,true);
        
            //Creates gap to slide the pen/pencil in
            translate([-penrad,0,0]){
                rotate(a=-90,v=[1,0,0])
            cube([penrad*3,depth+2,penrad*1.25],true);

                                    }
                    }
}
}
