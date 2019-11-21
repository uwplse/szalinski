union() {
    hh=10;
    ll=65;
    dd=1.6;
    leng=80;

    for( len=[0:10:leng] ) {
        translate( [0,0,len] ) {
            linear_extrude( height=dd )
                polygon (
                        points=[
                        [0, hh],[dd,hh],
                        [dd+5,dd], [ll-5-dd,dd],
                        [ll-dd,hh],[ll, hh],
                        [ll-5, 0],[0, -hh]
                        ]
                        );
        }
    }
    translate( [0,hh-20,0] )
        cube([dd,20,leng+dd]);
    translate( [ll-dd,hh,0] )
        cube([dd,dd,leng+dd]);
    translate( [0,hh,0] )
        cube([dd,dd,leng+dd]);
}
