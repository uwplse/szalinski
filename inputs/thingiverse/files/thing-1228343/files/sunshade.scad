/* [Monitor] */

Monitor_Width = 172;
Monitor_Height = 113;
Monitor_Depth = 20;

/* [Shield] */

// Which part would you like to see?
part = 6;  //[1:Top, 2:Left Side, 3:Right Side, 4:Clip Part 1, 5:Clip part 2, 6:Everything togheter]

// Shield Height
Shield_Height = 90; // [60:150]
// Because of my printer´s limitation, i had to limit the width of the top cover, use this to configure it
Shield_Cover_Width = 164;
Monitor_Top_Lock_Tab_Width = 5;
Monitor_Bottom_Lock_Tab_Width = 10;
// Tickness of all walls, 2 is good enough
Shield_Tickness = 2; //[2:4]

/* [Hidden] */

lockerSize = 14;
clipHeight = 20;
screwDiameter = 3.5;
screwCapDiameter = 5.5;

if(part < 6){
/*
Use this function to export the parts
1 = Top;
2 = Left Side;
3 = Right Side;
4 = Clip Part 1;
3 = Clip part 2;
*/
print(part);
}else{
// Use this function to see how everything looks like togheter 
BuildEverythings();
}



module print(piece){
    if (piece == 1)
        rotate([90,0,0]) top();
    
    if (piece == 2)
        rotate([0,90,0]) left();
    
    if (piece == 3)
        rotate([0,-90,0]) right();
    
    if (piece == 4)
        clipLeft();
   
    if (piece == 5)
        clipRight();
}

module BuildEverythings(){
#translate([0,0,Shield_Tickness]) monitor();
color([0.5,0.5,1]) translate([4,-Shield_Tickness * 2 + Shield_Tickness * 0.05,Shield_Tickness]) top();
color([0.2,0.5,0.6]) translate([-Shield_Tickness,-Shield_Tickness * 3,0]) right();
color([0.2,0.5,0.6]) translate([Monitor_Width + Shield_Tickness,-Shield_Tickness * 3,0]) left();
    translate([-(Shield_Tickness * 3),-(Shield_Tickness * 5),10]) adjustableClips();
}

module monitor(){
    cube([Monitor_Width, Monitor_Height,Monitor_Depth]);
}

module top(){
    cube([Shield_Cover_Width,Shield_Tickness * 0.9,Shield_Height + Monitor_Depth - Shield_Tickness]);
    translate([lockerSize,Shield_Tickness * 0.90,0]) cube([Shield_Cover_Width - lockerSize * 2,Shield_Tickness * 0.9, Shield_Tickness]);
}

module right(){
    difference(){
        cube([Shield_Tickness,Monitor_Height + Shield_Tickness * 3,Shield_Height + Monitor_Depth]);
        translate([-0.5,Monitor_Height + Shield_Tickness * 3,Monitor_Depth + Shield_Height/2 - 20]) rotate([50,0,0])  cube([Shield_Tickness+1, Monitor_Height, Shield_Height * 3]);
    }
    
    // Top lockers
    translate([Shield_Tickness,0,0]) cube([lockerSize,Shield_Tickness,Shield_Height + Monitor_Depth]);
    translate([Shield_Tickness,Shield_Tickness * 2,0]) cube([lockerSize,Shield_Tickness,Shield_Height + Monitor_Depth]);
    translate([Shield_Tickness,Shield_Tickness,0]) cube([lockerSize,Shield_Tickness,Shield_Tickness]);
    
    // Monitor Lockers
    translate([Shield_Tickness,Shield_Tickness,0]) cube([Monitor_Bottom_Lock_Tab_Width,Monitor_Height,Shield_Tickness]);
    translate([Shield_Tickness,Shield_Tickness * 2,Monitor_Depth + Shield_Tickness]) cube([Monitor_Top_Lock_Tab_Width,Monitor_Height - Shield_Tickness,Shield_Tickness]);
    
    // Rubber locker
    difference(){
        translate([0,Monitor_Height - 10,-5]) cube([9,6,5]);
        translate([-0.5,Monitor_Height - 10.5,-3]) cube([4,7,5.5]);
    }
}

module left(){
    mirror([1,0,0]) right();
}

module adjustableClips(){
   
   clipRight();
   translate([(Monitor_Width -  Monitor_Width / 2 + Shield_Tickness * 3) ,0,0])clipLeft();
   
}

module clipLeft(){
        cube([Monitor_Width / 2 +Shield_Tickness , Shield_Tickness * 2, clipHeight]);
    translate([Monitor_Width / 2 +Shield_Tickness ,0,0])  cube([Shield_Tickness * 2, Monitor_Height/3, clipHeight]) ; 
    difference(){
        translate([-(Monitor_Width / 3),-(Shield_Tickness * 2),0]) cube([Monitor_Width / 2 +Shield_Tickness , Shield_Tickness * 2, clipHeight]);
    
        translate([-(Monitor_Width / 3.3),0.5,clipHeight/2]) rotate([90,0,0]) cylinder(d = screwDiameter, h = Shield_Tickness * 2 + 1, $fn = 40) ;
        
        translate([-(Monitor_Width / 5),0.5,clipHeight/2]) rotate([90,0,0]) cylinder(d = screwDiameter, h = Shield_Tickness * 2 + 1, $fn = 40) ;
    }
    translate([Monitor_Width / 5 - Shield_Tickness * 2,0,0]) cylinder(h= clipHeight, r= Shield_Tickness * 2);
}

module clipRight(){
    difference(){
        translate([Shield_Tickness * 2,0,0]) cube([Monitor_Width / 2.5 + Shield_Tickness , Shield_Tickness * 2, clipHeight]) ;
        
    translate([20,-0.5,(clipHeight - screwDiameter) / 2 ]) cube([Monitor_Width / 3.5,Shield_Tickness * 2 + 1, screwDiameter]);
        
        translate([20,Shield_Tickness * 2 - 2,(clipHeight - screwCapDiameter) / 2 ]) cube([Monitor_Width / 3.5,2.1, screwCapDiameter]);
    }
    cube([Shield_Tickness * 2, Monitor_Height/3, clipHeight]) ;
}

module roundedcube(xdim ,ydim ,zdim,rdim){
hull(){
translate([rdim,rdim,0])cylinder(h=zdim,r=rdim);
translate([xdim-rdim,rdim,0])cylinder(h=zdim,r=rdim);

translate([rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
translate([xdim-rdim,ydim-rdim,0])cylinder(h=zdim,r=rdim);
}
}