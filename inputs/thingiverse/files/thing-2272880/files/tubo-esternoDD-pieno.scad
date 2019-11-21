   tuboesterno(5,21,4.5,5,30);
   
   module tuboesterno(l2,l3,rag1,rag2,resolution){
       difference(){
 difference(){
   union(){
        translate([0,0,16])
         cylinder(h=l3,r=rag1,$fn=resolution,center=true);
          translate([0,0,5])
         cylinder(h=l2,r1=rag1,r2=rag2,$fn=resolution,center=true);
        translate([0,0,0])
         cylinder(h=l2,r1=rag1,r2=rag2,$fn=resolution,center=true);
    }
    
   }
   
 }
}