/*NON self centering chuck Feb 2016 Glyn Cowles */
// diameter of grip
hd=20;
// grip height
ht=20; 
//outside diameter of chuck
cdo=60;
// inside diameter of chuck
cdi=50;
// chuck height
ch=50; 
// diam of screw holes
hold=7; 
// number of screw holes
nsh=4; 

$fn=50;
assemble();



//-------------------------------------------------
module assemble() {
    grip();     
    translate([0,0,-ch]) chuck();     
}
 
//-------------------------------------------------
module grip() { 
     cylinder(d=hd,h=ht);
}
//-------------------------------------------------
module chuck() {
    n=cdo-cdi;
    difference() {
     cylinder(d=cdo,h=ch);
     cylinder(d=cdi,h=ch-n);
     #translate([0,0,cdi/2]) holes();
    }    
}
//-------------------------------------------------
module holes() {
    p=360/nsh;
    for (i=[0:nsh-1]) {
        rotate([i*p,90,0]) cylinder(h=cdo/2,d=hold);   
    }
}
//-------------------------------------------------
