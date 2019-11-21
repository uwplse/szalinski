diameter = 70; // [20:2:100]
height = 15; // [10,15,20]
wall = 2; // [1.4:0.5:3.5]
rim = 5; //  [3:1:7]

//u=d*pi --> d*3*2 --> ca 0.5 mm pro sektor
$fn=diameter*3*2;

all();

module all()
{
    cookie(diameter, height, wall, rim);
    /*
    cookie(90, height, wall, rim);
    cookie(50, height, wall, rim);
    cookie(30, height, wall, rim);
    */
}

module cookie(m_diameter, m_height, m_wall, m_rim)
{
    difference()
    {
        union()
        {
            cylinder(d=m_diameter+2*m_rim-0.1, h=m_wall);
            cylinder(d=m_diameter+2*m_wall-0.1, h=m_height-m_rim);
            translate([0,0,m_height-m_rim]) cylinder(d1=m_diameter+2*m_wall-0.1, d2=m_diameter, h=m_rim);
        }
        cylinder(d=m_diameter, h=m_height+0.1);
    }
}