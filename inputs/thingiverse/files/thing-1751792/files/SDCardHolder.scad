//universal customizable SDcard holder
//By RevisionNr3, 03/09/2016

/* [Basic settings] */
// SD card format
FormatCard="Standard";//[Micro,Mini,Standard]
// thickness of the wall
wallThickness=1;//[0.8:0.2:3]
// number of cards in the width direction
numberOfCardsDirection1=1; //[1:1:10]
//number of cards in the length direction
numberOfCardsDirection2=3; //[1:1:10]
//space between SD card and walls (more space = easier fit)
space=0.2; //[0:0.1:0.5]
        
/*[Label]*/
// add a label (optional)
label="SD card holder";
// enter the size of the text
textSize=5; //[2:1:15]

/*[Advanced options]*/
//enter the length of a micro SD card
dimensionsMicroLength=11;
//enter the width of a micro SD card
dimensionsMicroWidth=1;
//enter the height of a micro SD card
dimensionsMicroHeight=15;

//enter the length of a mini SD card
dimensionsMiniLength=20;
//enter the width of a mini SD card
dimensionsMiniWidth=1.4;
//enter the height of a mini SD card
dimensionsMiniHeight=21.5;

//enter the length of a standard SD card
dimensionsStandardLength=24;
//enter the width of a standard SD card
dimensionsStandardWidth=2.1;
//enter the height of a standard SD card
dimensionsStandardHeight=32;

/*[Hidden]*/

lengthSDcard = FormatCard=="Micro"? dimensionsMicroLength : FormatCard=="Mini" ? dimensionsMiniLength : dimensionsStandardLength;
widthSDcard = FormatCard=="Micro"? dimensionsMicroWidth : FormatCard=="Mini" ? dimensionsMiniWidth : dimensionsStandardWidth;
heightSDcard = FormatCard=="Micro"? dimensionsMicroHeight : FormatCard=="Mini" ? dimensionsMiniHeight : dimensionsStandardHeight;

innerLengthBox =lengthSDcard+space;
innerWidthBox = widthSDcard*numberOfCardsDirection1+2*space; //I give more space in the width direction
innerHeightBox = heightSDcard;

radiusCircleCut = FormatCard=="Micro"? (11-2)/2 : FormatCard=="Mini" ? (20-2)/2 : (24-2)/2; // used the length dimensions of the different card sizes as found on the internet

//the program starts here
difference(){

    difference(){
        
        for (i=[1:1:numberOfCardsDirection2])
            translate ([(innerLengthBox+wallThickness)*(i-1),0,0])
            SDcardHolderBox();

        AddLabel();
        }

    AddRounds();
    }
module SDcardHolderBox(){

    difference() {  

        union(){
            // wall 1    
            translate([0,wallThickness/2 + innerWidthBox/2, innerHeightBox/2+wallThickness])
            cube([innerLengthBox,wallThickness,innerHeightBox],center=true);

            // wall 2     
            mirror ([0,1,0]) 
            translate([0,wallThickness/2 + innerWidthBox/2, innerHeightBox/2+wallThickness])
            cube([innerLengthBox,wallThickness,innerHeightBox],center=true);
             
            // small wall 1     
            translate([wallThickness/2+innerLengthBox/2,0, innerHeightBox/2+wallThickness])
            cube([wallThickness,2*wallThickness + innerWidthBox, innerHeightBox],center=true);

            // small wall 2 
            mirror ([1,0,0])
            translate([wallThickness/2 + innerLengthBox/2,0, innerHeightBox/2+wallThickness])
            cube([wallThickness,2*wallThickness + innerWidthBox, innerHeightBox],center=true);
                
            // floor
            difference(){
                translate([0,0,wallThickness/2])
                cube([2*wallThickness+innerLengthBox,2*wallThickness+innerWidthBox,wallThickness],center=true);
                translate([0,0,wallThickness])
                cube([innerLengthBox/2,innerWidthBox,2*wallThickness],center=true);
            }
        }
        
   

    translate([0,0,innerHeightBox+wallThickness])  
    rotate(90,[1,0,0])
    cylinder(h=2*wallThickness+innerWidthBox+1, r=radiusCircleCut ,$fn=50,center=true);    
        
    }

}
module AddLabel(){
    
    textHeight=0.5;
        
    translate([((innerLengthBox+wallThickness)*numberOfCardsDirection2+wallThickness)/2-(innerLengthBox/2+wallThickness),-wallThickness-innerWidthBox/2,innerHeightBox/2-textSize/2])
    rotate([90,0,0])
    translate([0,0,-textHeight])
        linear_extrude(height = 2*textHeight) {
          text(label, font="Liberation Sans", size=textSize, halign="center", valign="center");
        }
}

module AddRounds(){
    // the 0.05 added in the code below is to make sure that the round is rendered without strange artifacts
    
    //round1
    translate([innerLengthBox/2+(numberOfCardsDirection2-1)*(innerLengthBox+wallThickness)+0.05,0,innerHeightBox+0.05])
    GenerateRound(innerWidthBox);
    
    //round2
    translate([innerLengthBox/2+(numberOfCardsDirection2-1)*(innerLengthBox+wallThickness)+0.05,0,wallThickness-0.05])
    rotate([0,90,0])
    GenerateRound(innerWidthBox);
    
    //round3
    translate([-innerLengthBox/2-0.05,0,innerHeightBox+0.05])
    rotate([0,-90,0])
    GenerateRound(innerWidthBox);
    
    //round4
    translate([-innerLengthBox/2-0.05,0,wallThickness-0.05])
    rotate([0,180,0])
    GenerateRound(innerWidthBox);
}

module GenerateRound(){
    
    difference(){
        
        translate([wallThickness/2,0,wallThickness/2])
        cube([wallThickness,2*wallThickness+innerWidthBox+1,wallThickness],center=true);
            
        rotate([90,0,0])
        cylinder(2*wallThickness+innerWidthBox+1,r=wallThickness,$fn=50,center=true);
    }
    
}
