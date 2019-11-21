d_leaf = 5; // [4:1:20]
n_leaf = 40; // [10:10:100]
height = 15; // [10,15,20]
wall = 2; // [1.4:0.5:3.5]
rim = 5; //  [3:1:7]

$fn=20;

all();
//leaf();

module all()
{
    flower(d_leaf, n_leaf, height, wall, rim);
    /*
    flower(d_leaf, 20, height, wall, rim);
    translate([100,0,0]) flower(10, 20, height, wall, rim);
    translate([100,0,0]) flower(10, 10, height, wall, rim);
    */
}

module flower(m_d_leaf, m_n_leaf, m_height, m_wall, m_rim)
{
    d_flower = m_d_leaf * m_n_leaf / 3.14;
    a_1 = 360 / m_n_leaf;
    difference()
    {
        for(a=[0:a_1:360]) 
            rotate([0,0,a]) translate([d_flower/2,0,0]) leaf(m_d_leaf, m_n_leaf, m_height, m_wall, m_rim);
        for(a=[0:a_1:360]) 
            rotate([0,0,a]) translate([d_flower/2,0,0]) cylinder(d=m_d_leaf, h=m_height);
        cylinder(d=d_flower, h=m_height);
    }
}

module leaf(m_d_leaf, m_n_leaf, m_height, m_wall, m_rim)
{
    //echo(m_d_leaf);
    cylinder(d=m_d_leaf+2*m_rim-0.1, h=m_wall);
    cylinder(d=m_d_leaf+2*m_wall-0.1, h=m_height-m_rim);
    translate([0,0,m_height-m_rim]) cylinder(d1=m_d_leaf+2*m_wall-0.1, d2=m_d_leaf, h=m_rim);
}