/********************************************************************
*   Parametric Small Parts Drawer Divider                           *
*   (c) 2017 R. Jamieson                                            *
********************************************************************/
//Construct the dividers
HSections = 1;          //Number of horizontal sections
VSections = 4;          //Number of vertical sections
FullHeight = 1;         //Full height walls =1 otherwise half height
wallThickness = 0.8;   //Wall thickness

//Drawer inside dimensions
dMajorWidth=49;
dMinorWidth=45;
dMinorHeight=18;
dLength=130;
dHeight=29;
cutoutWidth=5;
cutoutDepth=2;
cutoutOffset=40;


module box() {
    difference() {
        union() {
            translate([-dMinorWidth/2,0,0]) cube([dMinorWidth,dLength,dMinorHeight]);
            translate([-dMajorWidth/2,0,dMinorHeight]) cube([dMajorWidth,dLength,dHeight-dMinorHeight]);
        }
        //Difference cutting objects below
        translate([-(dMinorWidth-2*wallThickness)/2,wallThickness,wallThickness]) cube([dMinorWidth-2*wallThickness,dLength-2*wallThickness,dMinorHeight]);
            translate([-(dMajorWidth-2*wallThickness)/2,wallThickness,dMinorHeight+wallThickness]) cube([dMajorWidth-2*wallThickness,dLength-2*wallThickness,dHeight-dMinorHeight]);
    }
}


module dividers() {
    union(){
        //Create Horizontal Sections
        if (HSections >1) {
            for (i=[1:HSections-1]) {
                if (FullHeight == 1) 
                translate([((dMajorWidth/HSections)*i)-(wallThickness/2)-dMajorWidth/2,0,0]) cube([wallThickness, dLength,dHeight]);
                else
                    translate([((dMajorWidth/HSections)*i)-(wallThickness/2)-dMajorWidth/2,0,0]) cube([wallThickness, dLength,dMinorHeight]);
            }
        }

        //Create Vertical Sections    
        for (i=[1:VSections-1]) {
            if (FullHeight == 1)
                translate([-dMajorWidth/2,(dLength/VSections)*i-(wallThickness/2),0]) cube([dMajorWidth,wallThickness,dHeight]);
           else
               translate([-dMajorWidth/2,(dLength/VSections)*i-(wallThickness/2),0]) cube([dMajorWidth,wallThickness,dMinorHeight]);
        }
    }
}

module assembly() {
    union(){
        dividers();
        
        difference(){
            union(){
                box();
                //Add cutout walls
                translate([dMinorWidth/2-cutoutDepth-wallThickness,cutoutOffset-wallThickness,0]) cube([cutoutDepth+wallThickness,cutoutWidth+2*wallThickness,dMinorHeight+wallThickness]);  
                translate([dMinorWidth/2-cutoutDepth-wallThickness,dLength-cutoutOffset-wallThickness,0]) cube([cutoutDepth+wallThickness,cutoutWidth+2*wallThickness,dMinorHeight+wallThickness]);
                translate([-dMinorWidth/2+wallThickness,cutoutOffset-wallThickness,0]) cube([cutoutDepth+wallThickness,cutoutWidth+2*wallThickness,dMinorHeight+wallThickness]);
                translate([-dMinorWidth/2+wallThickness,dLength-cutoutOffset-wallThickness,0]) cube([cutoutDepth+wallThickness,cutoutWidth+2*wallThickness,dMinorHeight+wallThickness]);
                }
            //difference cutouts
            translate([dMinorWidth/2-cutoutDepth,cutoutOffset,-wallThickness]) cube([cutoutDepth+wallThickness,cutoutWidth,dMinorHeight+wallThickness]);
            translate([dMinorWidth/2-cutoutDepth,dLength-cutoutOffset,-wallThickness]) cube([cutoutDepth+wallThickness,cutoutWidth,dMinorHeight+wallThickness]);
            translate([-dMinorWidth/2,cutoutOffset,-wallThickness]) cube([cutoutDepth+wallThickness,cutoutWidth,dMinorHeight+wallThickness]);
            translate([-dMinorWidth/2,dLength-cutoutOffset,-wallThickness]) cube([cutoutDepth+wallThickness,cutoutWidth,dMinorHeight+wallThickness]);
            } 
        }
}

//Cleanup
difference(){
    assembly();
    //Trim sides
    translate([dMinorWidth/2,0,-wallThickness]) cube([10,dLength,dMinorHeight+wallThickness]);
    translate([-dMinorWidth/2-10,0,-wallThickness]) cube([10,dLength,dMinorHeight+wallThickness]);
    //trim cutouts
    translate([dMinorWidth/2-cutoutDepth,cutoutOffset,-wallThickness]) cube([cutoutDepth+wallThickness,cutoutWidth,dMinorHeight+wallThickness]);
    translate([dMinorWidth/2-cutoutDepth,dLength-cutoutOffset,-wallThickness]) cube([cutoutDepth+wallThickness,cutoutWidth,dMinorHeight+wallThickness]);
    translate([-dMinorWidth/2,cutoutOffset,-wallThickness]) cube([cutoutDepth+wallThickness,cutoutWidth,dMinorHeight+wallThickness]);
    translate([-dMinorWidth/2,dLength-cutoutOffset,-wallThickness]) cube([cutoutDepth+wallThickness,cutoutWidth,dMinorHeight+wallThickness]);
}

