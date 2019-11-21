thickness=2;
tubeDia=12.5;
tubeRad=tubeDia/2;
space=5;
plateWidth=tubeDia+thickness+space*2;
tubeNum=5;
plateLength=tubeNum*tubeDia+(tubeNum+1)*space;

fn=32;
holderHeight=15;
plateHeight=3;

linear_extrude(holderHeight){
    difference(){
  
        hull(){
            for(i=[0:tubeNum-1]){
            translate([i*(space+tubeDia)+(space+tubeRad),plateWidth/2])
            circle(tubeRad+thickness,$fn=fn);
            }
        }
        
        
        for(i=[0:tubeNum-1]){
        translate([i*(space+tubeDia)+(space+tubeRad),plateWidth/2])
        circle(tubeRad,$fn=fn);
        }
    }
}
linear_extrude(plateHeight){
    square([plateLength,plateWidth]);
    }
