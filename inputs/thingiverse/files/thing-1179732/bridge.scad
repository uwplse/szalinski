// Width of bridge
width = 25; // [10:180]

// Length of bridge
length = 80; // [10:180]

module bridge(
    width = 25,
    length = 80
    ){
    
    //Do not modified these constants
    height = 10;
    base = 8;
    bridge_thick = 1;
    length_score = 5;
    width_score = 1.5;
    magic = 0.75; 
        
    cube([base,width,height],center=true);
    translate([length+base,0,0])cube([base,width,height],center=true);
    color("red") translate([length/2+base/2,0,height/2+bridge_thick/2])cube([length+2*base,width,bridge_thick],center=true);
       
    finalScore = (width * width_score) + (length * length_score);
    echo(str("Congratulation you received " , finalScore , " points"));
        
    mySize = (width > length) ? length : width;
    translate([0,-width/2*magic,height/2+bridge_thick])    resize([length*magic,width*magic,1]) linear_extrude(height = magic)text(str(finalScore), size=mySize/2);
}


bridge(width,length);