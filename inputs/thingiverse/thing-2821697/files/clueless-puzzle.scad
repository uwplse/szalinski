
side = 10;

module block(shape)
{
    echo(len(shape));
    for(i = [0:len(shape)-1])
    {
        for(j = [0:len(shape[i])-1])
        {
            if(shape[i][j] == 1)
            {
                translate([(j)*side,(len(shape)-1-i)*side,0])
                cube([side,side,side]);
            }
        }
        
    }
}

block([[1],[1],[1]]);

translate([1*(side+1)+1,1,0])
block([[0,1],
       [1,1],
       [1,0]]);

translate([2*(side+1)+1,0,0])
block([[0,1,0,0],
       [1,1,1,1]]);

translate([3*(side+1)+1,1*(side+1),0])
block([[0,1,0],
       [1,1,0],
       [0,1,1]]);

translate([0*(side+1)+1,2*(side+1),0])
block([[1,1],
       [0,1]]);

translate([2*(side+1),3*(side+1)-1,0])
block([[1,1]]);

translate([5*(side+1),2*(side+1),0])
block([[1],[1],[1],[1]]);

translate([0*(side+1),4*(side+1)-1,0])
block([[1,0,0],
       [1,1,1]]);

translate([3*(side+1),4*(side+1)-1,0])
block([[1,1]]);

translate([1*(side+1),5*(side+1)-1,0])
block([[1,1,1,1]]);
