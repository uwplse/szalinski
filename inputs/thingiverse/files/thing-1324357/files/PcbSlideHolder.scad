// <Sopak's Pcb Slide Holder> (c) by <Kamil Sopko>
// 
// <Sopak's Pcb Slide Holder> is licensed under a
// Creative Commons Attribution-ShareAlike 4.0 Unported License.
// 
// You should have received a copy of the license along with this
// work.  If not, see <http://creativecommons.org/licenses/by-sa/4.0/>.

/* [Main Dimensions] */

//pcb width
pcbWidth=15.4;
//pcb lenght
pcbLenght=20;
//pcb height
pcbHeight=1.65;
//overhang on sides
pcbOverhang=1.5;

holderLenght=40;
holderHeight=10;
bottomHeight=3;
sideWidth=5;

/* [Other Dimensions] */

holesDiameterBottom=3;
holesDiameterTop=6.5;
holesHeadHeight=2.5;

holesX=5;
holeXStep=8;
holesAngle=45;
holesInAngle=20;
/* [OtherValues] */

//just  for cleaner boolean  operations
tolerance=0.2;

//quality
fn=30;



pcbHolder(

    tolerance=tolerance,
    $fn=fn
);

module pcbHolder(){
    
    sideHolderLenght=pcbLenght+pcbHeight;
    
    difference(){
        union(){
            translate([-sideHolderLenght/2,-pcbWidth/2-sideWidth+pcbOverhang,0])cube([sideHolderLenght,sideWidth,holderHeight]);
            translate([-sideHolderLenght/2,pcbWidth/2-pcbOverhang,0])cube([sideHolderLenght,sideWidth,holderHeight]);
            difference(){
                translate([-holderLenght/2,-(pcbWidth+2*sideWidth-2*pcbOverhang)/2,0])cube([holderLenght,pcbWidth+2*sideWidth-2*pcbOverhang,bottomHeight]);
                angleStep=holesAngle/(holesInAngle-1);
                for(angle=[-holesAngle/2:angleStep:holesAngle/2]){
                    
                    for(xOffset=[-(holeXStep*(holesX-1))/2:holeXStep:(holeXStep*(holesX-1))/2]){
                        rotate([0,0,angle])translate([xOffset,0,bottomHeight+tolerance-holesHeadHeight])cylinder(d2=holesDiameterTop,d1=holesDiameterBottom,h=holesHeadHeight);
                        rotate([0,0,angle])translate([xOffset,0,-tolerance])cylinder(d=holesDiameterBottom,h=bottomHeight+2*tolerance);
                    }
                }
            }
        }
        translate([-tolerance-sideHolderLenght/2,-pcbWidth/2-tolerance,bottomHeight*2])hull(){
            cube([pcbLenght,pcbWidth+2*tolerance,pcbHeight]);    
            translate([0,pcbOverhang,pcbHeight])cube([pcbLenght,pcbWidth-pcbOverhang*2+2*tolerance,pcbHeight]);
        }
    }
}