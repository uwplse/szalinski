//number of division
d=5;//[1:1,2:2,3:3,4:4,5:5,6:6,7:7]
//type of box ending 
final=1;//[1:angled,2:vertical]
//type of box front
front=1;//[1:angled,2:vertical]
//Distance between divisions
e=10;
//Space from box and division height
t=0;
//box Height
H=50;
//Card height (hypotenusa)
C=63;
//Box Width
W=70;
//Length of the 1st division
X1=40;
//Length of the 2nd division
X2=35;
//Length of the 3rd division
X3=20;
//Length of the 4th division
X4=25;
//Length of the 5th division
X5=35;
//Length of the 6th division
X6=40;
//Length of the 7th division
X7=25;


B=sqrt(pow(C,2)-pow(H,2));


module division(P1,H1,t1,C1,W1,e1)
{
    Cn=((H1-t1)*C1)/H1;
    Bd=sqrt(pow((Cn),2)-pow((H-t),2));
    Alt_div=(W1-e1)/2;
    posdiv=(W1+e1)/2;
    linear_extrude(height = Alt_div){
    polygon([[P1,1],[P1+1.5,1],[P1+1.5+Bd,H1-t1],[P1+Bd,H1-t1]]);
    }
    translate([0,0,posdiv]){
        linear_extrude(height = Alt_div){
        polygon([[P1,1],[P1+1.5,1],[P1+1.5+Bd,H1-t1],[P1+Bd,H1-t1]]);
        }
    }
}

if (d==1)
{
   L=X1;
   mirror ([0,1,0]){
   rotate ([90,0,0]) {
        difference() {
                linear_extrude(height = W){
                    if (final==1)
                    {
                        if (front==1)
                            {polygon([[0,0],[L,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L,0],[L+B,H],[0,H]]);}
                            }
                    else
                    {
                        if (front==1)
                            {polygon([[0,0],[L+B,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L+B,0],[L+B,H],[0,H]]);}
                            }
                }
               if (final==2) division (X1,H,t,C,W,e);    
            }
        }
    }
}

if (d==2)
{
   L=X1+X2;
    mirror ([0,1,0]){
   rotate ([90,0,0]) {
        difference() {
                linear_extrude(height = W){
                    if (final==1)
                    {
                        if (front==1)
                            {polygon([[0,0],[L,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L,0],[L+B,H],[0,H]]);}
                            }
                    else
                    {
                        if (front==1)
                            {polygon([[0,0],[L+B,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L+B,0],[L+B,H],[0,H]]);}
                            }
                }
                division (X1,H,t,C,W,e);
                if (final==2) division (X1+X2,H,t,C,W,e);               
                }

            }
        }
    }

if (d==3)
{
    L=X1+X2+X3;
   mirror ([0,1,0]){
   rotate ([90,0,0]) {
        difference() {
                linear_extrude(height = W){
                    if (final==1)
                    {
                        if (front==1)
                            {polygon([[0,0],[L,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L,0],[L+B,H],[0,H]]);}
                            }
                    else
                    {
                        if (front==1)
                            {polygon([[0,0],[L+B,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L+B,0],[L+B,H],[0,H]]);}
                            }
                }
                    division (X1,H,t,C,W,e);
                    division (X1+X2,H,t,C,W,e);
                    if (final==2) division (X1+X2+X3,H,t,C,W,e);        
                }
            }
        }    
}

if (d==4)
{
    L=X1+X2+X3+X4;
       mirror ([0,1,0]){
   rotate ([90,0,0]) {
        difference() {
                linear_extrude(height = W){
                    if (final==1)
                    {
                        if (front==1)
                            {polygon([[0,0],[L,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L,0],[L+B,H],[0,H]]);}
                            }
                    else
                    {
                        if (front==1)
                            {polygon([[0,0],[L+B,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L+B,0],[L+B,H],[0,H]]);}
                            }
                }
                    division (X1,H,t,C,W,e);
                    division (X1+X2,H,t,C,W,e);
                    division (X1+X2+X3,H,t,C,W,e);
                    if (final==2) division (X1+X2+X3+X4,H,t,C,W,e);               
                }
            }
        } 
}

if (d==5)
{
    L=X1+X2+X3+X4+X5;
       mirror ([0,1,0]){
   rotate ([90,0,0]) {
        difference() {
                linear_extrude(height = W){
                    if (final==1)
                    {
                        if (front==1)
                            {polygon([[0,0],[L,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L,0],[L+B,H],[0,H]]);}
                            }
                    else
                    {
                        if (front==1)
                            {polygon([[0,0],[L+B,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L+B,0],[L+B,H],[0,H]]);}
                            }
                }
                    division (X1,H,t,C,W,e);
                    division (X1+X2,H,t,C,W,e);
                    division (X1+X2+X3,H,t,C,W,e);
                    division (X1+X2+X3+X4,H,t,C,W,e);                if (final==2) division (X1+X2+X3+X4+X5,H,t,C,W,e);  
                
                }
            }
        }     
}

if (d==6)
{
    L=X1+X2+X3+X4+X5+X6;
       mirror ([0,1,0]){
   rotate ([90,0,0]) {
        difference() {
                linear_extrude(height = W){
                    if (final==1)
                    {
                        if (front==1)
                            {polygon([[0,0],[L,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L,0],[L+B,H],[0,H]]);}
                            }
                    else
                    {
                        if (front==1)
                            {polygon([[0,0],[L+B,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L+B,0],[L+B,H],[0,H]]);}
                            }
                }
                    division (X1,H,t,C,W,e);
                    division (X1+X2,H,t,C,W,e);
                    division (X1+X2+X3,H,t,C,W,e);
                    division (X1+X2+X3+X4,H,t,C,W,e);
                    division (X1+X2+X3+X4+X5,H,t,C,W,e);                if (final==2) division (X1+X2+X3+X4+X5+X6,H,t,C,W,e);                
                }
            }
        }     
}

if (d==7)
{
    L=X1+X2+X3+X4+X5+X6+X7;
       mirror ([0,1,0]){
   rotate ([90,0,0]) {
        difference() {
                linear_extrude(height = W){
                    if (final==1)
                    {
                        if (front==1)
                            {polygon([[0,0],[L,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L,0],[L+B,H],[0,H]]);}
                            }
                    else
                    {
                        if (front==1)
                            {polygon([[0,0],[L+B,0],[L+B,H],[B,H]]);}
                        else
                            {polygon([[0,0],[L+B,0],[L+B,H],[0,H]]);}
                            }
                }
                    division (X1,H,t,C,W,e);
                    division (X1+X2,H,t,C,W,e);
                    division (X1+X2+X3,H,t,C,W,e);
                    division (X1+X2+X3+X4,H,t,C,W,e);
                    division (X1+X2+X3+X4+X5,H,t,C,W,e);
                    division (X1+X2+X3+X4+X5+X6,H,t,C,W,e);                if (final==2) division (X1+X2+X3+X4+X5+X6+X7,H,t,C,W,e);                
                }
            }
        }     
}
