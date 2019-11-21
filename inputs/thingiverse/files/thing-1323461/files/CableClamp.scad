// <Sopak's Cable Clamp> (c) by <Kamil Sopko>
// 
// <Sopak's Cable Clamp> is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 Unported License.
// 
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.

/* [Dimensions] */

//diameter of cable
cableDiameter=5.5; // [2:0.5:30]

//offset towards wall, controll how much presure will be on  cable
cablePressingOffset=0.1;// [0:0.5:10]

//how many cables
cableWideMultiplier=1;// [1:20]

//use cable separators?
cableSeparator="yes";      // [yes,no]

//min width of cable holder
width=3; // [3:30]

//height of clamp should  be at least size of 2*screwHoleDiameter
height=8; // [5:30]

//diameter of screw
screwHoleDiameter=3;    // [1:0.5:10]

//diameter of  scre head for countersung
screwHeadDiameter=6;    // [1:0.5:15]

//countersung screw height?
screwHeadHeight=2.5;    // [0:0.1:15]

//width of  part where is  screw,  it should be anything acording size of your screw and  material where it goes
widthOfScrewPart=8; // [3:30]

//one or double sided clamp
doubleSided="no";      // [yes,no]


/* [OtherValues] */

//number of leafes in cols
printCols=5;   // [1:5]
//number of leafes in rows
printRows=3;   // [1:5]
//spacing in print setup
printSpacing=3;   // [1:10]

//just  for cleaner boolean  operations
tolerance=0.2;

//quality
fn=50;

    
print();

module print(){
    
    //offset to create wide holder(more or flat cables)
    cableWideOffset=cableDiameter*(cableWideMultiplier-1);
    

    colSpace=cableDiameter+width;
    if(doubleSided=="yes"){
        rowSpace=(cableDiameter+6*width+2*tolerance+screwHoleDiameter*2)+cableWideOffset;
        printInternal(colSpace=colSpace,rowSpace=rowSpace);
        
        
    }else{
        rowSpace=(cableDiameter+4*width+2*tolerance+screwHoleDiameter)+cableWideOffset;
        printInternal(colSpace=colSpace,rowSpace=rowSpace);
    }
}

module printInternal(colSpace=30,rowSpace=30){

    for(row=[0:printRows-1]){
        for(col=[0:printCols-1]){

             translate([col*(colSpace+printSpacing),row*(rowSpace+printSpacing),0])cableClamp(
                cableDiameter=cableDiameter,
                cablePressingOffset=cablePressingOffset,
                cableWideMultiplier=cableWideMultiplier,
                cableSeparator=cableSeparator,
                width=width,
                height=height,
                screwHoleDiameter=screwHoleDiameter,
                screwHeadDiameter=screwHeadDiameter,
                screwHeadHeight=screwHeadHeight,
                widthOfScrewPart=widthOfScrewPart,
                doubleSided=doubleSided,
                tolerance=tolerance,
                $fn=fn
            );
        }
    }
}
module cableClamp(){
    
    //offset to create wide holder(more or flat cables)
    cableWideOffset=cableDiameter*(cableWideMultiplier-1);    

    
    difference(){
        union(){
            hull(){        
                translate([-cablePressingOffset,0,0])cylinder(d=cableDiameter+2*width,h=height);
                translate([cableDiameter/2-cablePressingOffset,0,0])cylinder(d=cableDiameter+2*width,h=height);            
                               
                //wide
                translate([-cablePressingOffset,cableWideOffset,0])cylinder(d=cableDiameter+2*width,h=height);
                translate([cableDiameter/2-cablePressingOffset,cableWideOffset,0])cylinder(d=cableDiameter+2*width,h=height);            
                
                //side joins
                translate([0,(cableDiameter+2*width)/2-1+cableWideOffset,0])cube([widthOfScrewPart,1,height]);
                if(doubleSided=="yes"){
                    translate([0,-(cableDiameter+2*width)/2,0])cube([widthOfScrewPart,1,height]);
                }
            }
            //sides
            translate([0,(cableDiameter+2*width)/2+cableWideOffset,0])cube([widthOfScrewPart,screwHoleDiameter+2*width,height]);
            if(doubleSided=="yes"){
                translate([0,-screwHoleDiameter-2*width-(cableDiameter+2*width)/2,0])cube([widthOfScrewPart,screwHoleDiameter+2*width,height]);
            }
            
        }
        //remove cable space
        
        if(cableSeparator=="yes"){
            for(i=[0:cableDiameter:cableWideOffset]){
            
                hull(){
                    translate([-cablePressingOffset,i,-tolerance])cylinder(d=cableDiameter-tolerance,h=height+2*tolerance);
                    translate([cableDiameter/2-cablePressingOffset,i,-tolerance])cylinder(d=cableDiameter+tolerance,h=height+2*tolerance);
                }
            }
            hull(){
                translate([-cablePressingOffset,0,-tolerance])cylinder(d=cableDiameter-tolerance,h=height+2*tolerance);            
                //wide
                translate([-cablePressingOffset,+cableWideOffset,-tolerance])cylinder(d=cableDiameter-tolerance,h=height+2*tolerance);
            }
        }else{
            hull(){
                translate([-cablePressingOffset,0,-tolerance])cylinder(d=cableDiameter-tolerance,h=height+2*tolerance);
                translate([cableDiameter/2-cablePressingOffset,0,-tolerance])cylinder(d=cableDiameter+tolerance,h=height+2*tolerance);
                
                //wide
                translate([-cablePressingOffset,+cableWideOffset,-tolerance])cylinder(d=cableDiameter-tolerance,h=height+2*tolerance);
                translate([cableDiameter/2-cablePressingOffset,+cableWideOffset,-tolerance])cylinder(d=cableDiameter+tolerance,h=height+2*tolerance);
            }
        }
        
        //remove screw holes
        translate([-tolerance,+screwHoleDiameter/2+width+(cableDiameter+2*width)/2+cableWideOffset,height/2])rotate([0,90,0])cylinder(d=screwHoleDiameter+tolerance,h=widthOfScrewPart+2*tolerance);        
        if(doubleSided=="yes"){
            translate([-tolerance,-screwHoleDiameter/2-width-(cableDiameter+2*width)/2,height/2])rotate([0,90,0])cylinder(d=screwHoleDiameter+tolerance,h=widthOfScrewPart+2*tolerance);
        }
        
        //remove countersung
        
        translate([widthOfScrewPart-screwHeadHeight,+screwHoleDiameter/2+width+(cableDiameter+2*width)/2+cableWideOffset,height/2])rotate([0,90,0])cylinder(d2=screwHeadDiameter+tolerance,d1=screwHoleDiameter+tolerance,h=screwHeadHeight+tolerance);        
        if(doubleSided=="yes"){
            translate([widthOfScrewPart-screwHeadHeight,-screwHoleDiameter/2-width-(cableDiameter+2*width)/2,height/2])rotate([0,90,0])cylinder(d2=screwHeadDiameter+tolerance,d1=screwHoleDiameter+tolerance,h=screwHeadHeight+tolerance);        
        }
        
        //remove all material under axe -X
        translate([-(cableDiameter+2*width),-(cableDiameter+2*width)/2-tolerance-screwHoleDiameter/2,-tolerance])cube([cableDiameter+2*width,(cableDiameter+2*width+2*tolerance+screwHoleDiameter/2)+cableWideOffset,height+2*tolerance]);   
    }
}