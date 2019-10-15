//Brian Check
//bcheck555(at)gmail(dot)com
//Customizable jig for mortising hinges
//roundedcube module credit https://www.youtube.com/watch?v=gKOkJWiTgAY

hingeLength=90;
hingeWidth=29;
Thick=12;
Edge=12;
cornerRadius=15;

difference(){
cube(size=[hingeLength+(Edge*2),hingeWidth+(Edge*2),Thick+Edge]);
    translate([Edge,Edge,0]){
        roundedcube(hingeLength,(hingeWidth+Edge*2),Thick+Edge,cornerRadius);
    }
    translate([0,-Edge,Thick]){
        cube(size=[hingeLength+Edge*2,(hingeWidth+Edge*2),Thick*2]);
    }
}

module roundedcube(xdim ,ydim ,zdim,rdim){
hull(){
translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);

translate([0,ydim,0])cube(size=[1,1,zdim]);
translate([xdim-1,ydim,0])cube(size=[1,1,zdim]);
}
}