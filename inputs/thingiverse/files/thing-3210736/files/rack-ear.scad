l=140;
x1=9;
x2=25+9;
y=9;


//******* fixed
h=43.5; 
spessore=2;
x=x2+x1;

staffaFronte(h,l);
 translate ([0,l/2-spessore/2,x/2-spessore/2]) {
staffaLato();
 }
polyhedron(points=[[0,-l/2+15,0],[h/2-y-4,l/2,0],[-h/2+y+4,l/2,0],[0,l/2,x-x1]], faces=[[0,1,2],[1,0,3],[0,2,3],[2,1,3]]);
 
module staffaLato(){
difference() {
    
cube([h,spessore ,x],true);
    foro(h/2-y,-x/2+x1);
    foro(-h/2+y,-x/2+x1);
    foro(h/2-y,-x/2+x2);
    foro(-h/2+y,-x/2+x2);
}
}

    module staffaFronte(h,l){
difference() {
cube([h,l ,spessore],true);

    foroRack(-h/2+3.5+2.5,-l/2+3+3.5+1.5);
    foroRack(+h/2-3.5-2.5,-l/2+3+3.5+1.5);
}
}

module foroRack(x,y){
    translate ([x,y,0]) {
     cube([7,3,spessore*2],true);
    translate ([0,1.5,-spessore]) {
cylinder(spessore*2, 3.5,3.5);
    }
        translate ([0,-1.5,-spessore]) {
cylinder(spessore*2, 3.5,3.5);
    }
    }
    }
    
    
module foro(x,y){
    translate ([x,spessore*1.5/2,y]) {
        rotate([90,0,0]){
cylinder(spessore*1.5, 2,3);
        }
    }
}