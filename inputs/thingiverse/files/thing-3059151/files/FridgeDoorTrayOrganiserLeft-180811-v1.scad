rd=6;
s=5;

t=136;
b=127;
c=99-s;

tt=t-2*rd;
bb=b-2*rd;
cc=c-2*rd;

ss=(c+s)/c;

//left piece
union()
    {
    linear_extrude(height = 50, twist = 0, scale=[1,ss],$fn=50) 
            {
            difference() 
                {
                offset(r = rd) 
                    {
                    polygon(points=[
                        [-194+rd,-43+rd+s/2],
                        [-64-rd,-99/2+rd+s/2],
                        [-68.5-rd,99/2-rd-s+1],
                        [-201+rd,21-rd-s/2]]);
                    }
                offset(r = rd/2) 
                    {
                    polygon(points=[
                        [-194+rd,-43+rd+s/2],
                        [-64-rd,-99/2+rd+s/2],
                        [-68.5-rd,99/2-rd-s+1],
                        [-201+rd,21-rd-s/2]]);
                    }
                }
             };

    translate([0,0,-2])
    linear_extrude(height = 3, twist = 0, scale=1,$fn=50)
        {
        offset(r = rd) 
            { 
            polygon(points=[
                [-194+rd,-43+rd+s/2],
                [-64-rd,-99/2+rd+s/2],
                [-68.5-rd,99/2-rd-s+1],
                [-201+rd,21-rd-s/2]]);
            }
        };
    };  

