function d_wall()=0.8;
function d_szuflada()=30;
function l_szuflada()=60;

module szuflada() 
{
    difference() {
        cube([d_szuflada(),l_szuflada(),d_szuflada()/2]);
        translate( [d_wall(),d_wall(), d_wall()] )
            cube([d_szuflada()-2*d_wall(),
                    l_szuflada()-2*d_wall(),
                    d_szuflada()-d_wall()+0.01]);
    }

    difference() {
    hull() {
        translate( [d_szuflada()/2-5,0,0] )
            cylinder(r=5,h=d_wall());
        translate( [d_szuflada()/2+5,0,0] )
            cylinder(r=5,h=d_wall());
    }
    translate( [0,0,-0.1] )
    hull() {
        translate( [d_szuflada()/2-5,0,0] )
            cylinder(r=2.5,h=d_wall()+0.2);
        translate( [d_szuflada()/2+5,0,0] )
            cylinder(r=2.5,h=d_wall()+0.2);
    }
    }
}

szuflada();
