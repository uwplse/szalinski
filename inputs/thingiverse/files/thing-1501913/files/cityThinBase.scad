allParts();
//block();
//translate([10,0,0]) block();

//width and depth in mm
base = 500; //mm
//maximum height of blocks
blockMaxH = 20;
//number of blocks
nBlocks = 10;
//spacing between blocks
sBlocks = 20;
//size of block
szBlock = 10;

module allParts(){
    union(){
        base();
        blocks();
    }
}

module block() {
    r = rands(0,3,1)[0];
    hC= rands(6,blockMaxH,1)[0];
    sz=szBlock;
    //hC = 5;
    if(r<1){
        translate([0,0,hC/2]) cube([sz,sz,hC], center=true);
    } 
    else if(r<2) {
        translate([0,0,hC/2]) cylinder(h=hC, d=sz, center=true, $fn=10);
    }
    else {
        translate([0,0,hC/2]) cylinder(d1=sz, h=hC, d2 = 0 , center=true, $fn=4);
    }
}

module base(){
    cube([base,base,0.5], center=true);
}

module blocks(){
    for(i = [-nBlocks:nBlocks]){
        for(j = [-nBlocks:nBlocks]){
            translate([sBlocks*i,sBlocks*j,0]) block();
        }
    }
}