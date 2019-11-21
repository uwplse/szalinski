
//rope diameter
rd=10;//[5:20]

//pulley diameter
pd=80;//[40:200]

//Bearings outer diameter
bo=15;//[10:50]


/*[hidden]*/


wall_w=3;

rd2=rd+4;
bo2=bo+0.2;

minpd=(rd+bo+25);
pd2= minpd>pd?minpd:pd;
echo(pd2);

rad=1.5;

polygon=100;

module polley() {
    rotate_extrude(convexity = 10,$fn=polygon)
    translate([0,0,0])    
    union(){
        //Fillet 1
        translate([bo2/2+5-rad,wall_w+rd2/2+1-rad])
        circle(r=rad, $fn=polygon);
        
        //Fillet 2
        difference(){
            translate([bo2/2+5,5])
            square(size = [rad,rad]);
            
            translate([bo2/2+5+rad,5+rad])
            circle(r=rad, $fn=polygon);
        }
                
        intersection(){
            difference(){        
                union(){                
                    translate([bo2/2,0])
                    square(size = [(pd2-wall_w-bo2)/2,wall_w+rd2/2]);

                    translate([pd2/2-wall_w/2,rd2/2+wall_w/2])
                    circle(d=wall_w, $fn=polygon);
                }
                translate([pd2/2-wall_w/2,0])
                circle(d=rd2, $fn=polygon);
            }
            
            translate([pd2/2-wall_w/2,0])
            circle(d=rd2+10, $fn=polygon);
        }
        
        
        rr=(rd2+10)/2+rad;
        xx=pow((pow(rr,2)-pow((5+rad),2)),(1/2));   
        //Fillet 2     
        difference(){                        
            polygon(points=[[pd2/2-wall_w/2-xx,0],
                        [pd2/2-wall_w/2-xx,5+rad],
                        [pd2/2-wall_w/2,0]
                        ]);
        
            translate([pd2/2-wall_w/2-xx,5+rad])
            circle(r=rad,, $fn=polygon);
            
            translate([pd2/2-wall_w/2,0])
            circle(d=rd2+10, $fn=polygon);
        }
        
        polygon(points=[[bo2/2,0],
                        [bo2/2,wall_w+rd2/2+1],
                        [bo2/2+5-rad,wall_w+rd2/2+1],
                        [bo2/2+5,wall_w+rd2/2+1-rad],
                        [bo2/2+5,5],
                        [pd2/2-wall_w/2-xx,5],
                        [pd2/2-wall_w/2-xx,0]
                        ]);
    }
}


color("OrangeRed")
difference(){ 
    union(){
        polley();
        mirror([0,0,1])
        polley();
    }
    translate([0, (pd2)/2-pow(pow(rd2/2+10,2)-pow(rd2/2+wall_w,2),1/2)/2+wall_w/2,rd2/2+wall_w-0.2]) {
        linear_extrude(height = 1)
        text(str("D",pd2,":",rd,":",bo),size = 2.5,halign ="center",valign ="center");
    }

}



