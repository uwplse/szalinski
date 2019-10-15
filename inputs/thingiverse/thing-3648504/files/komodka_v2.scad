use <szuflada.scad>

function d_s_wall()=5;
function offset()=0.4;
function offset_tail()=0.4;
function get_D()=d_s_wall()*2+d_szuflada();

module komoda_prot() {
    difference() {
        cube([get_D(),l_szuflada()+1*d_s_wall(),get_D()]);
        translate( [d_s_wall()+offset(),d_s_wall()+offset(),d_s_wall()+offset()-2.5] )
            cube([d_szuflada()+2*offset(),l_szuflada()+offset(),d_szuflada()+2*offset()]);
    }
}

module tail_woman()
{
    translate( [0,0,-0.1] )
    cylinder(r=3,h=(d_s_wall() + l_szuflada())+0.2,$fn=100);
}

module tail_man()
{
    translate( [0,offset()/2,0] )
    cylinder(r=2.6,h=(d_s_wall() + l_szuflada()),$fn=100);
}

module tail_n(l,type)
{
    for( i=[10:20:l-10] )
    {
        translate( [i,0,-1.5] )
            rotate( [-90,0,0] )
            if( type ) {
                tail_man();
            } else {
                scale( v=[1.001,1.001,1.001] )
                tail_woman();
            }
    }
}

module komoda_male() {
    difference() {
        union() {
            komoda_prot();
            tail_n( l=get_D(),type=1);
            translate( [get_D(),0,get_D()/2] )
                mirror( [1,0,0] ) {
                    rotate( [0,90,0])
                        translate( [-get_D()/2,0,0] )
                        tail_n( l=40, type=1 );
                }
        }
        union() {
            translate( [0,0,get_D()] )
                tail_n( l=get_D(),type=0);
            translate( [0,0,0] )
                rotate( [0,-90,0])
                    tail_n( l=40, type=0 );
        }
    }
}

module komoda_female() {
    komoda_prot();
}

komoda_male();
