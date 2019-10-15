 square=32;
length=square+2*(sin(45)*square);
tunneldepth=15;
tunnelside=12;
difference(){
hull()
{
cube(center=true,size=[square,square,length]);
cube(center=true,size=[square,length,square]);
cube(center=true,size=[length,square,square]);
}//hull
cube(center=true,size=[tunnelside,tunnelside,length+.01]);
for(i=[-1,1]){
rotate([i*45,0,0]) cube(size=[tunnelside,tunnelside,length+.01],center=true);
rotate([0,i*45,0]) cube(size=[tunnelside,tunnelside,length+.01],center=true);
rotate([90,0,i*45]) cube(size=[tunnelside,tunnelside,length+.01],center=true);
rotate([90,0,45+i*45]) cube(size=[tunnelside,tunnelside,length+.01],center=true);
}//for
}//difference

backfill = length-2*tunneldepth;
cube(center=true,size=[tunnelside,tunnelside,backfill]);
for(i=[-1,1]){
rotate([i*45,0,0]) cube(size=[tunnelside,tunnelside,backfill],center=true);
rotate([0,i*45,0]) cube(size=[tunnelside,tunnelside,backfill],center=true);
rotate([90,0,i*45]) cube(size=[tunnelside,tunnelside,backfill],center=true);
rotate([90,0,45+i*45]) cube(size=[tunnelside,tunnelside,backfill],center=true);
}//for