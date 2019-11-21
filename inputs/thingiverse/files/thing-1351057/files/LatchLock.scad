// Which one would you like to see?
part = "all"; // [first:Base Only,second:Top Only,third:Hook only,all:All]

/* [Base Settings] */
BaseHeight=5;
BaseLength=45;
BaseWidth=35;
//This one applies also to the hole to set the top on to the base.
MountingHoles=4;
/* [Pillar Settings] */
CylHeight=15;
Spacing=.3;
/* [Hook Settings] */
HookLength=30;
TabLength=15;
/* [Hidden] */
TabWidth=5;
print_part();

module print_part(){
    if(part=="first"){
        Base(BaseHeight,BaseLength,BaseWidth,MountingHoles,CylHeight);
    }
    else if(part=="second"){
        translate([0,0,BaseHeight/2+Spacing+CylHeight-CylHeight/5]) Top(BaseHeight,MountingHoles);
    }
    else if(part=="third"){
        translate([0,0,CylHeight/5]) Hook(HookLength,BaseHeight,BaseWidth,TabLength,CylHeight,Spacing);
    }
    else if(part=="all"){
        Base(BaseHeight,BaseLength,BaseWidth,MountingHoles,CylHeight);
translate([0,0,BaseHeight/2+Spacing+CylHeight-CylHeight/5]) Top(BaseHeight,MountingHoles);
translate([0,0,CylHeight/5]) Hook(HookLength,BaseHeight,BaseWidth,TabLength,CylHeight,Spacing);
    }
}

module Base(BaseHeight,BaseLength,BaseWidth,MountingHole,CylHeight){
    union(){difference(){
        minkowski(){
            cube([BaseLength-10,BaseWidth-10,BaseHeight-1],center=true);
            cylinder(r=5,h=1);
        }
        translate([BaseLength/3,BaseWidth/3,-BaseHeight/2+0.5]) cylinder(h=BaseHeight,r=MountingHoles/2);
        translate([BaseLength/3,-BaseWidth/3,-BaseHeight/2+0.5]) cylinder(h=BaseHeight,r=MountingHoles/2);
        translate([-BaseLength/3,-BaseWidth/3,-BaseHeight/2+0.5]) cylinder(h=BaseHeight,r=MountingHoles/2);
        translate([-BaseLength/3,BaseWidth/3,-BaseHeight/2+0.5]) cylinder(h=BaseHeight,r=MountingHoles/2);
    }
    difference(){
        union(){
            if(BaseLength<BaseWidth){
                translate([0,0,BaseHeight/2]) cylinder(r=BaseLength/3,h=(CylHeight/5));
                translate([0,0,BaseHeight/2+CylHeight/5]) cylinder(r=BaseLength/4-0.2,h=(CylHeight+Spacing)-((CylHeight/5)*2));
            }
            else{
                translate([0,0,BaseHeight/2]) cylinder(r=BaseWidth/3,h=(CylHeight/5));
                translate([0,0,BaseHeight/2+CylHeight/5]) cylinder(r=BaseWidth/4-0.2,h=(CylHeight+Spacing)-((CylHeight/5)*2));
            }
            
        }
            translate([0,0,(BaseHeight/2)+CylHeight-(CylHeight/1.5)+Spacing]) cylinder(r=MountingHoles/2,h=CylHeight/1.5);
        }
    }
}

module Top(BaseHeight,MountingHoles){
    if(BaseLength<BaseWidth){
                difference(){
                cylinder(r=BaseLength/3,h=CylHeight/5);
        cylinder(r=MountingHoles/2,h=CylHeight/5);
            }
        }
            else{
                difference(){
                cylinder(r=BaseWidth/3,h=CylHeight/5);
        cylinder(r=MountingHoles/2,h=CylHeight/5);
            }
    }
}

module Hook(HookLength,BaseHeight,BaseWidth,TabLength,CylHeight,Spacing){      
            if(BaseLength<BaseWidth){
                difference(){
                translate([0,0,BaseHeight/2+Spacing/2]) cylinder(r=BaseLength/3,h=(CylHeight)-(2*(CylHeight/5)));
                 translate([0,0,BaseHeight/2+Spacing/2]) cylinder(r=BaseLength/4,h=(CylHeight-(2*(CylHeight/5))));   
                }
            }
            else{
                difference(){
                translate([0,0,BaseHeight/2+Spacing/2]) cylinder(r=BaseWidth/3,h=(CylHeight-(2*(CylHeight/5))));
                    translate([0,0,BaseHeight/2+Spacing/2]) cylinder(r=BaseWidth/4,h=(CylHeight-(2*(CylHeight/5))));}
            }
        if(BaseLength<BaseWidth){
                translate([BaseLength/3-BaseLength/24,-TabWidth/2,BaseHeight/2+Spacing/2]) cube([HookLength,TabWidth,CylHeight-(2*(CylHeight/5))]);
            }
            else{
                translate([BaseWidth/3-BaseWidth/24,-TabWidth/2,BaseHeight/2+Spacing/2]) cube([HookLength,TabWidth,CylHeight-(2*(CylHeight/5))]);
            }
            if(BaseLength<BaseWidth){
                union(){
                translate([HookLength-BaseLength/12+BaseLength/1.5,1.5,BaseHeight/2+Spacing/2]){difference(){
                cylinder(r=BaseLength/3,h=(CylHeight)-(2*(CylHeight/5)));
                cylinder(r=BaseLength/4,h=(CylHeight-(2*(CylHeight/5))));
                translate([-BaseLength/3,-BaseLength/3-4,0]) cube([BaseLength/1.5,BaseLength/3,CylHeight-(2*(CylHeight/5))]);
                }
                translate([BaseLength/3-BaseLength/24,-4,0]) cube([TabLength,TabWidth,(CylHeight-(2*(CylHeight/5)))]);
            }
            }
            }
            else{
                union(){
                translate([HookLength-BaseWidth/12+BaseWidth/1.5,1.5,BaseHeight/2+Spacing/2]){difference(){
                cylinder(r=BaseWidth/3,h=(CylHeight)-(2*(CylHeight/5)));
                cylinder(r=BaseWidth/4,h=(CylHeight-(2*(CylHeight/5))));
                translate([-BaseWidth/3,-BaseWidth/3-4,0]) cube([BaseWidth/1.5,BaseWidth/3,CylHeight-(2*(CylHeight/5))]);
                }
                translate([BaseWidth/3-BaseWidth/24,-4,0]) cube([TabLength,TabWidth,(CylHeight-(2*(CylHeight/5)))]);
            }
            }
            }
}

/*Base(BaseHeight,BaseLength,BaseWidth,MountingHoles,CylHeight);
translate([0,0,BaseHeight/2+Spacing+CylHeight-CylHeight/5]) Top(BaseHeight,MountingHoles);
translate([0,0,CylHeight/5]) Hook(HookLength,BaseHeight,BaseWidth,TabLength,CylHeight,Spacing);
*/

