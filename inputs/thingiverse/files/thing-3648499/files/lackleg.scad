legd=50.5;
uph=70;
walld=2;

module mnthole() {
    translate( [legd/2+15,10,0] )
        rotate([90,0,0] )
        cylinder( r=1.6, h=20, $fn=100 );
    translate( [legd/2-15,10,0] )
        rotate([90,0,0] )
        cylinder( r=1.6, h=20, $fn=100 );
}

difference() {
    hull() {
        translate( [-walld,-walld,0] )
            cube( [legd+2*walld,legd+walld*2,uph] );
        translate( [-walld*2,-walld*2,-20] )
            cube( [legd+3*walld,legd+walld*3,20.1] );
    }
    union() {
        translate( [walld,walld,-0.1])
            cube( [legd-walld*2,legd-walld*2,uph+0.2] );
        translate( [0,0,uph-20-0.1])
            cube( [legd,legd,0.2+20] );
        translate( [-walld,-walld,-20.1] )
            cube( [legd+2*walld+0.1,legd+walld*2+0.1,20.2-walld] );
    }
    translate( [0,0,uph-10] )
        mnthole();
    translate( [0,0,-10] )
        mnthole();
    rotate( [0,0,90] ) {
        translate( [0,0,uph-10] )
            mnthole();
        translate( [0,0,-10] )
            mnthole();
    }
}
