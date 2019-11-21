scritta="GAGHY";

module nome(){

difference(){
    translate([0,2,1]) //scritta vuota
    cube([50,6,6],false);

    linear_extrude(8)
    text(scritta,size=10);
}


difference(){
    translate([0,0,2])
    linear_extrude(4) //scritta piena
    text(scritta,size=10);
    
    translate([0,3,0])
    cube([50,4,8],false);

}
}

cube([25,25,3],true); //base inferiore

difference(){
translate([0,0,50])
cube([12,12,2],true); //base superiore

translate([0,0,50])
cylinder(2,3,3,false,$fn=10); //foro porta calamita
}

translate([4,-5,0])
rotate([0,-90,0])
nome();     //gambo