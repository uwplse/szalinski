$fn = 60;

width = 50;
length = 100;

thickness = 6;

amount = 5;
offset = 4;

kerf = 0.03;

mainProgram();
mirror([0,1,0]) rotate([0,180,0]) translate([0,-length,0]) mainProgram();



//cube([width,length, thickness]); //test lengte

module mainProgram(){
   
    circleSize = (width - (offset * (amount-1))) /amount;
    
        if(circleSize < offset){
            
            newOffset = offset/2;
          //  echo(newOffset);
            circleSize = (width - (newOffset * (amount-1))) /amount;
            
            tpoint = calculateTangentPoint(circleSize, calculateDistance(circleSize, newOffset));
            remain = allignBasePlate(circleSize, tpoint, newOffset);
            projection(cut = false){
            translate([(width/2) + remain,circleSize/2,-thickness/2]){
            
            difference() { drawTopJoint(circleSize, newOffset); translate([-circleSize/2,-circleSize, -2]) cube([-remain + (circleSize/2), 30,thickness+6]);};
            difference() {
           
            drawBasePlate(circleSize, tpoint, newOffset);    
                
            drawBottomJoint(circleSize, newOffset, calculateDistance(circleSize, newOffset));
          
            //echo(tpoint);
                    }        
                }
            }
        }
            else{
                tpoint = calculateTangentPoint(circleSize, calculateDistance(circleSize, offset));
                remain = allignBasePlate(circleSize, tpoint, offset);
                projection(cut = false){
                translate([ -(width/2) +remain,circleSize/2,-thickness/2]){
                
                difference() {  drawTopJoint(circleSize, offset); translate([-circleSize/2,-circleSize, -2]) cube([-remain + (circleSize/2), 30,thickness+6]);};
                difference() {
                
                drawBasePlate(circleSize, tpoint, offset);  
                  
                drawBottomJoint(circleSize,offset, calculateDistance(circleSize, offset));
          
                }     
            }
         }
    }
}
module drawTopJoint(circleSize, dist){
    
    distanceTop = circleSize + dist;
    
    for(i = [0:amount-1]){
        
            translate([(distanceTop *i) + (circleSize/2) ,0,0])cylinder(r = (circleSize/2) + kerf, h = thickness );
            
        }
    }


function  calculateDistance(circleSize, dist) = sqrt(pow(circleSize,2) - pow(circleSize + (dist/2) - circleSize/2,2));
    
function calculateTangentPoint(circleSize, dist) = sin(asin(dist/circleSize)) * (circleSize/2);
 
function allignBasePlate(circleSize, tpoint, dist) =  (width - (circleSize + (dist/2) + (circleSize + dist) *(amount-1) + (circleSize/2))) /2;  
    

module drawBottomJoint(circleSize,dist,distanceDown){
    
        distanceBottom = circleSize + (dist/2);
    
        for(i = [0:amount-1]){
        
            translate([distanceBottom ,distanceDown,-1]) cylinder(r = (circleSize/2) - kerf, h = thickness +2);
            distanceBottom = distanceBottom +(circleSize + dist) *i;
            //echo(distanceBottom);
            
        }  
    }

module drawBasePlate(circleSize, tpoint, dist){

    remain = allignBasePlate(circleSize, tpoint, dist);
    calcLength = length - circleSize - (tpoint*2) ;
  //translate([-remain,tpoint,0])%cube([width, length -(circleSize/2) - tpoint,thickness]);    
    translate([-remain,tpoint,0])cube([width, calcLength/2   ,thickness]); 

 
    }