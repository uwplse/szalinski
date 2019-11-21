//match case
width=36;
thickness=17;
height=58.2;
shell=1;
slot=thickness/1.5;

difference(){
//outside box
translate([-(width+shell*2)/2,-(thickness+shell*2)/2,0]){
    cube([width+shell*2, thickness+shell*2, height+shell]);
    }
//inside box
translate([-width/2,-thickness/2,shell]){
    cube([width, thickness, height+shell*2]);
    }

//slot in the side to light the match
//circle1
    translate([width/2.2,0,height-slot]){
rotate(a = 90, v=[0, 1, 0]) cylinder(r=slot/2, h=shell*4);
}
//circle2
translate([width/2.2,0,slot]){
rotate(a = 90, v=[0, 1, 0]) cylinder(r=slot/2, h=shell*4);
}
//square
translate([width/2.2,-slot/2,slot]){
    cube([shell*4, slot, (height-slot*2)]);
}
//slot in the bottom to open
//circle1
    translate([-width*0.5+slot,0,-shell*2]){
cylinder(r=slot/2, h=shell*4);
}
//circle2
translate([width*0.5-slot,0,-shell*2]){
cylinder(r=slot/2, h=shell*4);
}
//square
translate([-width*0.5+slot,-slot/2,-shell*2]){
    cube([width-slot*2, slot, shell*4]);
}


}

