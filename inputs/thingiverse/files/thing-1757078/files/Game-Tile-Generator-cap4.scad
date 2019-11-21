tilesize = 24;
wallthickness = 3;

//base
difference() {
translate([0,0,wallthickness/2])
cube([((tilesize+2)+(wallthickness*2)),((tilesize+2)+(wallthickness*2)),wallthickness],true);
translate([0,0,wallthickness/2])    
cube([tilesize-4,tilesize-4,wallthickness*4],true);
}

difference(){
translate([(tilesize+1)/-2,(tilesize+1)/-2,0])
cube([tilesize+1,tilesize+1,wallthickness+3]);

translate([0,0,wallthickness/2])    
cube([tilesize-4,tilesize-4,wallthickness*4],true);
}




