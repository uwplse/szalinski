// @pabile 20180510
// Z bracket openscad parametric customizeable customizer

thick = 3;
width = 20;
armheight = 30;
armdepth = 5;

screwhole = 3;

difference() {
    minkowski(){
        cube (size = [((armheight*2)+thick)-2,width-2,((thick*2)+armdepth)-2]);
        sphere(1);
    }
     

    // top: the one that holds your thing
    # translate ([armheight+thick-1,-1,thick-1]) {
        cube (size = [armheight,width,armdepth+thick]);
    }
	
    // bottom: the one that mounts to the wall. has screw holes.
    # translate ([-1,-1,-1]) {
        cube (size = [armheight,width,armdepth+thick]);
	}
    
    // screw hole
    # translate ([(armheight/2)+2,(width/2)-1,armdepth]) {
        cylinder (armdepth*5,screwhole,screwhole,center=true);
    }

}