Length  =   100;//X axis
Width   =   50; //Y
Height  =   50; //Z
Wall    =   3; //Wall thickness

//Box
difference(){
    cube([Length,Width,Height]);
    
    translate([Wall,Wall,Wall]){ //move to the inside of the box
        cube([Length-(Wall*2),Width-(Wall*2),Height]);
    }
}

//Top
translate([0,Width+10,0]){
union(){
    cube([Length,Width,Wall]);
    
    translate([Wall,Wall,0]){ //move to the inside of the box
        cube([Length-(Wall*2),Width-(Wall*2),Wall+2]);
    }
}}