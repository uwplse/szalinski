//+-----------------------------+
//|  OPENSCAD Cerceuil - coffin |
//|    2017 gaziel@gmail.com    |
//+-----------------------------+   

//humain boby standart ( cm:175x55x41 175x60x45 185x55x41 185x60x45 195x55x41 195x60x45)
// barbie, ken  mm : 280*75*45
//classic Gi-joe  mm: 300*75*55
model="lid";//[coffin,lid]
//Coffin or lid type
type="lyonnais";//[parisien,lyonnais,tombeau]
// preview[view:south, tilt:top]
//internal Lenght 
L=290;
// internal lenght
l=95;
// internal height
H=45;
//thinkness
Ep=3;
// ratio 
pouet=0.22;//[0.10:0.01:0.40]
//decoration
croix ="simple";//[none,simple]
//
//text 
//txt="test";

i=l*pouet;
j=L*(1-pouet);

module baseplate(ep){
    if (type=="tombeau"){
        square([L+2*ep,l+2*ep]);
    }
   if (type=="parisien"){ 
       polygon(points=[[0,i],[0,l-i+2*ep],[j+ep,l+2*ep],[L+2*ep,l-i+2*ep],[L+2*ep,i],[j+ep,0]], paths=[[0,1,2,3,4,5,,6]]);
   }
   
      if (type=="lyonnais"){ 
          polygon(points=[[0,i],[0,l-i+2*ep],[L++2*ep,l+2*ep],[L+2*ep,0]], paths=[[0,1,2,3]]);
   }
    
}
module base(Ep){
    linear_extrude(height = Ep, center = false, convexity = 10)baseplate(Ep);
}
module tourplate(){
    difference(){
        baseplate(Ep);
        translate([Ep,Ep,0])baseplate(0);
    }
    
}
module tour(H){
    linear_extrude(height = H, center = false, convexity = 10)tourplate();
}
module coffre(){
    base(Ep);
    translate([0,0,Ep])tour(H);
}
module couvercle(){
    
    if (type=="tombeau"){
        hull(){
            base(2*Ep);
            color("pink")translate([Ep,Ep,7*Ep])base(Ep);
        }
        translate([(L/2)+Ep,(l/2)+2*Ep,7*Ep])croix();
    }   
    else{
        difference(){
            base(2*Ep);
            translate([Ep,Ep,Ep])tour(Ep);
       
        }
        translate([L/2+L/8,l/2+l/16,Ep])croix();
    }   

}
module croix(){
    if (croix =="simple"){
            translate([0,0,Ep*1.5])cube([L/4,l/4,Ep],center=true);
            translate([L/10-L/16,0,Ep*1.5])cube([L/16,l/1.5,Ep],center=true);
           }
       }

//coffre();//test
//baseplate(Ep);//test
//baseextru();//test
//tour();//test
if (model=="coffin"){
coffre();
}
else{
couvercle();
}