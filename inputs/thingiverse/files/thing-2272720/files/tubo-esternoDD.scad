   tuboesterno(5,28,4.5,5,30);
   
   module tuboesterno(l2,l3,rag1,rag2,resolution){
       
 
   union(){
        translate([0,0,21])
         cylinder(h=l3,r=rag1,$fn=resolution,center=true);
          translate([0,0,5])
         cylinder(h=l2,r1=rag1,r2=rag2,$fn=resolution,center=true);
        translate([0,0,0])
         cylinder(h=l2,r1=rag1,r2=rag2,$fn=resolution,center=true);
    }
    
   
 }
