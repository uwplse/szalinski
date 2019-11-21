// Which one would you like to see?
SelectPart = 1 ; //[0:All,1:Carrier,2:Snapper] 
// Width in mm
LinkWidth = 30 ; 
// Heigth in mm
LinkHeight = 20 ; 
// Vertical Separator count
SeparatorCount= 0 ; //[0:10]
SnapHinge1= 1 ; //[1:Hinge/Snapper,2:Snapper/Snapper]  

/* [Advanced] */
// in mm 0=Auto
MaterialThickness = 0 ; 
AdditionalBottomStrength = 0 ; 
// in mm
LinkClearance= 0.3 ;
// in mm 0=Auto
SnapperWidth= 0 ;
// in mm
SnapperClearance= 0.2 ;
// Edge or Pin(for limiting the angle)
EdgePin= 1 ; //[0:Edge,1:Pin,2:edge and pin ]
// Degree of freedom between two links
DegreeFreedom= 45 ;
PinOffset= 0 ;

/* [Hidden] */
$fn= 80 ;






module DragChain(selectPart,linkWidth,linkHeight,materialThickness,linkClearance,snapperWidth,snapHinge1,snapperClearance,separatorCount,edgePin,additionalBottomStrength,degreeFreedom,pinOffset){


    snapperWidth=snapperWidth ? snapperWidth : linkHeight/2;
    bottomWidth=snapperWidth; //if snapperwidth < max width
    linkLength=snapperWidth+linkHeight*2;
    volume=linkLength*linkWidth*linkHeight;
    materialThickness= materialThickness ? materialThickness : 1+pow(volume,1/3)/30;
        echo ("material: ",materialThickness);

    degree=degreeFreedom+materialThickness/((PI*(linkHeight-(materialThickness+linkClearance)))/360); //+((PI*linkHeight)/360)*materialThickness);
    echo( volume, pow(volume,1/3),1+pow(volume,1/3)/30);
    echo(degree);

if(selectPart==0||selectPart==1){
difference(){
union(){
    // Grundplatte
    translate([0, materialThickness+linkClearance/2, 0]) cube([bottomWidth+linkHeight/2, linkWidth-materialThickness*2-linkClearance, materialThickness+additionalBottomStrength]);
    // Trennstege
    if(separatorCount>=1){
        for(i=[materialThickness+(linkWidth-4*materialThickness)/(separatorCount+1)+materialThickness/(separatorCount+1):(linkWidth-4*materialThickness)/(separatorCount+1)+materialThickness/(separatorCount+1):linkWidth-3*materialThickness]){
            echo(i);
            difference() {
                translate([0, i, 0]) cube([snapperWidth, materialThickness, linkHeight]);
                translate([materialThickness, 0, linkHeight-materialThickness]) cube([snapperWidth-materialThickness*2, linkWidth, materialThickness+1]);
            }
        }
    }

difference(){
    union(){
    //INNEN
    difference(){
        translate([0, materialThickness, 0]) cube([linkHeight/2+snapperWidth, materialThickness, linkHeight]);
        translate([snapperWidth+linkHeight/2, materialThickness+linkClearance/2, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=materialThickness+linkClearance/2, r=linkHeight/2+linkClearance/2);
        translate([snapperWidth+linkHeight/2, materialThickness+linkClearance/2, linkHeight/2]) rotate([0,-degreeFreedom,180])cube([linkHeight/2, materialThickness+linkClearance/2, linkHeight]);
        translate([snapperWidth+linkHeight/2, materialThickness+linkClearance/2, linkHeight/2]) rotate([0,160,180])cube([linkHeight/2, materialThickness+linkClearance/2, linkHeight]);


    }
    //AUSSEN
    difference() { 
        translate([-linkHeight/2, 0, 0]) cube([linkHeight+snapperWidth, materialThickness, linkHeight]);
        translate([snapperWidth+linkHeight/2, linkWidth+0.5, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=linkWidth+1, r=linkHeight/2+linkClearance/2);
        translate([snapperWidth+linkHeight/2, materialThickness+linkClearance/2, linkHeight/2]) rotate([0,-degreeFreedom,180])cube([linkHeight/2, materialThickness+linkClearance/2, linkHeight]);
        translate([snapperWidth+linkHeight/2, materialThickness+linkClearance/2, linkHeight/2]) rotate([0,160,180])cube([linkHeight/2, materialThickness+linkClearance/2, linkHeight]);
        translate([-linkHeight/2, materialThickness+1, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=linkWidth+linkWidth/2, r=linkHeight/4+linkClearance);
    }

    difference() { // Schnapper vorne
        translate([-linkHeight/2, materialThickness, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=materialThickness, r=linkHeight/2);
        translate([-linkHeight/2, materialThickness+1, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=100, r=linkHeight/4+linkClearance);
        translate([-linkHeight, 0, linkHeight/4,]) rotate([0, 0, 20]) cube ([linkHeight/2,linkHeight/2,linkHeight/2]);
    }
    // Schnapper hinten
    difference(){
        translate([snapperWidth+linkHeight/2, materialThickness*2, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=materialThickness-snapperClearance/2, r=linkHeight/2);
        translate([snapperWidth+linkHeight/2, materialThickness+linkClearance/2, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=materialThickness+linkClearance/2, r=linkHeight/2+linkClearance/2);
        
    }
    // 
    translate([snapperWidth+linkHeight/2, materialThickness+linkClearance/2, linkHeight/2]) rotate([90, 0, 0])difference(){
        rotate([0,0,-90])difference(){
            cylinder(h=materialThickness+linkClearance/2, r=linkHeight/4);
            translate([-(materialThickness)-linkClearance+linkHeight/4,-linkHeight/4,materialThickness+linkClearance])rotate([0,45,0])cube([linkHeight/2,linkHeight/2,materialThickness]);
        }
        //enhancement for clipping together
        translate([-(materialThickness)+linkHeight/4,-linkHeight/4,materialThickness*1.8])rotate([0,45,0])cube([linkHeight/2,linkHeight/2,materialThickness]);
    }
    }
    // cutout for Pin
    if(edgePin==1 || edgePin==2){
        translate([snapperWidth+linkHeight/2, materialThickness*2, linkHeight/2]) rotate([90, 0, 0])intersection(){
            difference(){
                union(){
                    cylinder(h=materialThickness+1, r=linkHeight/2);
                    translate([-linkHeight/2,0,0])cube([linkHeight/2,linkHeight/2,materialThickness+1]);
                }
                cylinder(h=materialThickness+1, d=linkHeight-(materialThickness+linkClearance/2)*2);
            }
            difference(){
                union(){
                    cube([linkHeight,linkHeight,materialThickness+1]); 
                    translate([-materialThickness-1,0,0])cube([materialThickness+1,linkHeight,materialThickness+1]);
                    }
                rotate([0,0,degree])cube([linkHeight,linkHeight,materialThickness+1]);
                }
            }
        }




}
difference(){
    union(){
    //INNEN
    difference(){
        translate([0, linkWidth-materialThickness*2, 0]) cube([snapperWidth+linkHeight/2, materialThickness, linkHeight]); 
        translate([snapperWidth+linkHeight/2, linkWidth, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=materialThickness+linkClearance/2, r=linkHeight/2+linkClearance/2);
        translate([snapperWidth+linkHeight/2, linkWidth, linkHeight/2]) rotate([0,-degreeFreedom,180])cube([linkHeight/2, materialThickness+linkClearance/2, linkHeight]);
                    translate([snapperWidth+linkHeight/2, linkWidth, linkHeight/2]) rotate([0,160,180])cube([linkHeight/2, materialThickness+linkClearance/2, linkHeight]);

       
    }
    // AUSSEN
        difference() {
            translate([-linkHeight/2,linkWidth-materialThickness,0]) cube([linkHeight+snapperWidth, materialThickness, linkHeight]); // Länge Breite Höhe
            translate([snapperWidth+linkHeight/2, linkWidth+0.5, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=linkWidth+1, r=linkHeight/2+linkClearance/2);
            translate([snapperWidth+linkHeight/2, linkWidth, linkHeight/2]) rotate([0,-degreeFreedom,180])cube([linkHeight/2, materialThickness+linkClearance/2, linkHeight]);
            translate([snapperWidth+linkHeight/2, linkWidth, linkHeight/2]) rotate([0,160,180])cube([linkHeight/2, materialThickness+linkClearance/2, linkHeight]);
            translate([-linkHeight/2, linkWidth+1, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=100, r=linkHeight/4+linkClearance);
        }

        difference() { // Schnapper vorne
            translate([-linkHeight/2, linkWidth, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=materialThickness, r=linkHeight/2);
            translate([-linkHeight/2, linkWidth+1, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=100, r=linkHeight/4+linkClearance);
            translate([-linkHeight, linkWidth, linkHeight/4,]) rotate([0, 0,-110]) cube ([linkHeight/2,linkHeight/2,linkHeight/2]);
        }
        // Schnapper hinten
        difference(){
        translate([snapperWidth+linkHeight/2, linkWidth-materialThickness, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=materialThickness, r=linkHeight/2);
        translate([snapperWidth+linkHeight/2, linkWidth, linkHeight/2]) rotate([90, 0, 0]) cylinder(h=materialThickness+linkClearance/2, r=linkHeight/2+linkClearance/2);    
        }
        //
        translate([snapperWidth+linkHeight/2, linkWidth-materialThickness-linkClearance/2, linkHeight/2]) rotate([90, 0, 0]) rotate([0,180,90])rotate([0,0,-90])difference(){   
            rotate([0,0,90])difference(){
                cylinder(h=materialThickness+linkClearance/2, r=linkHeight/4);
                translate([-(materialThickness)-linkClearance+linkHeight/4,-linkHeight/4,materialThickness])rotate([0,45,0])cube([linkHeight/2,linkHeight/2,materialThickness]);
            }
            //enhancement for clipping together
            translate([-(materialThickness)+linkHeight/4,-linkHeight/4,materialThickness*1.8])rotate([0,45,0])cube([linkHeight/2,linkHeight/2,materialThickness]);
        }
    }
    // cutout for Pin
    if(edgePin==1 || edgePin==2){
        translate([snapperWidth+linkHeight/2, linkWidth-materialThickness, linkHeight/2]) rotate([90, 0, 0])intersection(){
            difference(){
                union(){
                    cylinder(h=materialThickness+1, r=linkHeight/2);
                    translate([-linkHeight/2,0,0])cube([linkHeight/2,linkHeight/2,materialThickness+1]);
                }
            cylinder(h=materialThickness+1, d=linkHeight-(materialThickness+linkClearance/2)*2);
            }
            difference(){
                union(){
                    cube([linkHeight,linkHeight,materialThickness+1]); 
                    translate([-materialThickness-1,0,0])cube([materialThickness+1,linkHeight,materialThickness+1]);
                }
            rotate([0,0,degree])cube([linkHeight,linkHeight,materialThickness+1]);
            }
        }
    }
}


//Drehschutz Ecken am Schnapper
if(edgePin==0 || edgePin==2){
translate([snapperWidth+linkHeight/2, linkWidth-materialThickness*2, 0]) cube([linkHeight/2, materialThickness-linkClearance/2, linkHeight/2]);
translate([snapperWidth+linkHeight/2, materialThickness+linkClearance/2, 0]) cube([linkHeight/2, materialThickness-linkClearance/2, linkHeight/2]);
}
//Pin
if (edgePin==1 || edgePin==2){
translate([-materialThickness+linkClearance/2, linkWidth-materialThickness*2, linkHeight/2+linkClearance/2+pinOffset]) cube([materialThickness-linkClearance/2, materialThickness, materialThickness-linkClearance]);
translate([-materialThickness+linkClearance/2, materialThickness, linkHeight/2+linkClearance/2+pinOffset]) cube([materialThickness-linkClearance/2, materialThickness, materialThickness-linkClearance]);
}
}//union end

//Schließer oben DREHPUNKT
translate([materialThickness, 0, linkHeight-materialThickness]) cube([snapperWidth-materialThickness*2, linkWidth, materialThickness]);
//Scharnier 
if(snapHinge1==1){ //
translate([materialThickness, linkWidth-materialThickness*2, linkHeight-materialThickness*2]) cube([snapperWidth-materialThickness*2,materialThickness*2, materialThickness]);
translate([0, linkWidth-materialThickness, linkHeight-materialThickness-materialThickness/4]) cube([snapperWidth,materialThickness, materialThickness/2]);
translate([0, linkWidth-materialThickness, linkHeight-materialThickness]) rotate([0, 90, 0]) cylinder(h=materialThickness+0.5, r=materialThickness/2+0.2);
translate([snapperWidth-materialThickness, linkWidth-materialThickness, linkHeight-materialThickness]) rotate([0, 90, 0]) cylinder(h=materialThickness+0.5, r=materialThickness/2+0.2);
}
//schnapper 1
if(snapHinge1==3){ //
translate([materialThickness/2, 0, linkHeight-materialThickness*3]) cube([snapperWidth-materialThickness, materialThickness, materialThickness*2]);
translate([snapperWidth/3, 0, linkHeight-materialThickness*3.5]) cube([snapperWidth/3, materialThickness, materialThickness/2]);
}
//schnapper 2
if(snapHinge1==1||snapHinge1==2){ //
translate([materialThickness/2, 0, linkHeight-materialThickness*3]) cube([snapperWidth-materialThickness, materialThickness, materialThickness*3]);
translate([materialThickness/2, materialThickness, linkHeight-materialThickness*3]) cube([snapperWidth-materialThickness, materialThickness/2, materialThickness]);
translate([snapperWidth/3, 0, linkHeight-materialThickness*3.5]) cube([snapperWidth/3, materialThickness*1.5, materialThickness/2]);



//translate([snapperWidth/3, 0, linkHeight-materialThickness*3.5]) cube([snapperWidth/3, materialThickness, materialThickness/2]);
}
if(snapHinge1==2){ //
translate([materialThickness/2, linkWidth-materialThickness, linkHeight-materialThickness*3]) cube([snapperWidth-materialThickness, materialThickness, materialThickness*3]);
translate([materialThickness/2, linkWidth-materialThickness*1.5, linkHeight-materialThickness*3]) cube([snapperWidth-materialThickness, materialThickness/2, materialThickness]);
translate([snapperWidth/3, linkWidth-materialThickness*1.5, linkHeight-materialThickness*3.5]) cube([snapperWidth/3, materialThickness*1.5, materialThickness/2]);



//translate([snapperWidth/3, linkWidth, linkHeight-materialThickness*3.5]) cube([snapperWidth/3, materialThickness, materialThickness/2]);
}
}
}
if (selectPart==0||selectPart==2){
//Schließer oben
rotate([0,180,0])translate ([-linkWidth+15,-10,-materialThickness])union(){
    difference() { //untere Platte vom Schließer Schleppkette
        union(){
            translate([0,0, 0]) rotate([0, 0, -90]) cube([snapperWidth, linkWidth, materialThickness]);
            if(snapHinge1==1){ // hinge
            translate([materialThickness, 0, 0]) rotate([90, 0, 0]) cylinder(h=snapperWidth, r=materialThickness);
            }
            if(snapHinge1==1||snapHinge1==2){
            translate([linkWidth,-materialThickness/2-snapperClearance/2, -materialThickness*2]) rotate([90, 0, -90]) cube([snapperWidth-materialThickness-snapperClearance,materialThickness*3, materialThickness]);
            translate([linkWidth-materialThickness,-materialThickness/2-snapperClearance/2, -materialThickness*1.5-snapperClearance]) rotate([0, 90, -90]) cylinder(h=snapperWidth-materialThickness-snapperClearance, r=materialThickness/2-snapperClearance);
 
        }
            if(snapHinge1==2){
            translate([materialThickness,-materialThickness/2-snapperClearance/2, -materialThickness*2]) rotate([90, 0, -90]) cube([snapperWidth-materialThickness-snapperClearance,materialThickness*3, materialThickness]);
            translate([materialThickness,-materialThickness/2-snapperClearance/2, -materialThickness*1.5-snapperClearance]) rotate([0, 90, -90]) cylinder(h=snapperWidth-materialThickness-snapperClearance, r=materialThickness/2-snapperClearance);
 
        }
        }
        if(snapHinge1==1){//hinge
        translate([materialThickness*2+snapperClearance*3, -snapperWidth-0.1, -materialThickness]) rotate([0, 0, 90]) cube([materialThickness+0.1, materialThickness*2.5, materialThickness*3]); // seite wo stab
        translate([materialThickness*2+snapperClearance*3, -materialThickness-0.1, -materialThickness]) rotate([0, 0, 90]) cube([materialThickness+0.1, materialThickness*2.5, materialThickness*3]); // seite wo stab
        }
    if(snapHinge1==1||snapHinge1==2){
    translate([linkWidth-materialThickness*2-snapperClearance/2, -snapperWidth, 0]) rotate([0, 0, 0]) cube([materialThickness+snapperClearance, materialThickness+snapperClearance/2, materialThickness]); // 
    translate([linkWidth-materialThickness*2-snapperClearance/2, -materialThickness-snapperClearance/2, 0]) rotate([0, 0, 0]) cube([materialThickness+snapperClearance, materialThickness+snapperClearance/2, materialThickness]); // 
    translate([linkWidth-materialThickness, -snapperWidth, 0]) rotate([0, 0, 0]) cube([materialThickness+snapperClearance/2, materialThickness/2+snapperClearance/2, materialThickness]); // 
    translate([linkWidth-materialThickness, -materialThickness/2-snapperClearance/2, 0]) rotate([0, 0, 0]) cube([materialThickness+snapperClearance/2, materialThickness/2+snapperClearance/2, materialThickness]); // 
    }
    if(snapHinge1==2){
    translate([materialThickness-snapperClearance/2, -snapperWidth, 0]) rotate([0, 0, 0]) cube([materialThickness+snapperClearance, materialThickness+snapperClearance/2, materialThickness]); // 
    translate([materialThickness-snapperClearance/2, -materialThickness-snapperClearance/2, 0]) rotate([0, 0, 0]) cube([materialThickness+snapperClearance, materialThickness+snapperClearance/2, materialThickness]); // 
    translate([materialThickness-materialThickness, -snapperWidth, 0]) rotate([0, 0, 0]) cube([materialThickness+snapperClearance/2, materialThickness/2+snapperClearance/2, materialThickness]); // 
    translate([materialThickness-materialThickness, -materialThickness/2-snapperClearance/2, 0]) rotate([0, 0, 0]) cube([materialThickness+snapperClearance/2, materialThickness/2+snapperClearance/2, materialThickness]); // 
    }
//Seperator
    if(separatorCount>=1){
        for(i=[materialThickness+(linkWidth-4*materialThickness)/(separatorCount+1)+materialThickness/(separatorCount+1):(linkWidth-4*materialThickness)/(separatorCount+1)+materialThickness/(separatorCount+1):linkWidth-3*materialThickness]){
            echo(i);
                translate([i-snapperClearance/2, -materialThickness-snapperClearance/2, 0]) cube([materialThickness+snapperClearance, materialThickness+snapperClearance/2, materialThickness]);
                translate([i-snapperClearance/2, -snapperWidth, 0]) cube([materialThickness+snapperClearance, materialThickness+snapperClearance/2, materialThickness]);
        }
    }

}
//Stab des Schließers
if(snapHinge1==1){ //hinge
difference() {
translate([materialThickness,0,0]) rotate([90, 0, 0]) cylinder(h=snapperWidth, r=materialThickness/2-0.1);
translate([materialThickness-materialThickness/4,-snapperWidth, -materialThickness/2]) rotate([0, 0, 90]) cube([snapperWidth, materialThickness/4, materialThickness]); // seite wo stab / Abtrennung zum einschieben
translate([materialThickness+materialThickness/2,-snapperWidth, -materialThickness/2]) rotate([0, 0, 90]) cube([snapperWidth, materialThickness/4, materialThickness]); // seite wo stab / Abtrennung zum einschieben
}
}

// Haltesteg des Stabes
//#translate([linkWidth/1.5-linkWidth+linkWidth/18, -snapperWidth+linkWidth/10-linkWidth/10, 0]) rotate([0, 0, 90]) cube([linkWidth/4, linkWidth/80, linkWidth/20]); // seite wo stab


//translate([linkWidth/1.5-linkWidth+linkWidth/18, -snapperWidth+linkWidth/10-linkWidth/10, 0]) rotate([0, 0, 90]) cube([linkWidth/4, linkWidth/80, linkWidth/20]); // seite wo stab
//translate([linkWidth/1.5-linkWidth+linkWidth/18, -snapperWidth+linkWidth/10-linkWidth/10, 0]) rotate([0, 0, 90]) cube([linkWidth/4, linkWidth/80, linkWidth/20]); // seite wo stab

}
}
}

DragChain(SelectPart,LinkWidth,LinkHeight,MaterialThickness,LinkClearance,SnapperWidth,SnapHinge1,SnapperClearance,SeparatorCount,EdgePin,AdditionalBottomStrength,DegreeFreedom,PinOffset);

