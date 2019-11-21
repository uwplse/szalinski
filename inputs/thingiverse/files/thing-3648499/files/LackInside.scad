aa=3;
module mnt() {
translate( [22.5,-22.5,20] )
# rotate( [-90,0,0] )
    cylinder( r=1.5,h=100,$fn=100 );
}
difference() {
    cube( [45,45,30] );
    translate( [aa,aa,aa] )
        cube( [45-2*aa,45-2*aa,40] );
    mnt( );
    translate( [0,45,0] )
    rotate( [0,0,-90] )
    mnt( );
    translate( [32.5,22.5,-5] )
    cylinder( r=1.5, h=20,$fn=100);
    translate( [12.5,22.5,-5] )
    cylinder( r=1.5, h=20,$fn=100);


}
