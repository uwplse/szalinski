//點字字符產生器 v1.0  2017.12.30  By Leo Chen


BaseLength = 15.4; //底座長度
BaseWidth = 23.4; //底座寬度
BaseHeight = 0.8; //底座厚度
LineWidth = 1.5; //上方橫條寬度
LineHeight = 1.2; //上方橫條高度
DotRadius = 5; //點字直徑
TB = 2; //上下留白長度
LR = 2; //左右留白長度
P1 = 1; //第一點
P2 = 1; //第二點
P3 = 1; //第三點
P4 = 1; //第四點
P5 = 1; //第五點
P6 = 1; //第六點


module dot1() {
    difference() {
        sphere (d = DotRadius, $fn=30);
        translate ([-DotRadius, -DotRadius, -DotRadius])
            cube ([DotRadius*2, DotRadius*2, DotRadius]);
    }
} //半圓形模組



if (P1 == 1)  {  
translate ([DotRadius/2+LR, BaseWidth-TB-DotRadius/2-LineWidth, BaseHeight]) 
    dot1();//第一點半圓形
 } 
else {  
}

if (P2 == 1)  {  
translate ([DotRadius/2+LR, (BaseWidth-LineWidth)/2, BaseHeight]) 
    dot1();//第二點半圓形
 } 
else {  
}

if (P3 == 1)  {  
translate ([DotRadius/2+LR, DotRadius/2+TB, BaseHeight]) 
    dot1();//第三點半圓形
 } 
else {  
}

if (P4 == 1)  {  
translate ([(BaseLength-DotRadius/2-LR), BaseWidth-TB-DotRadius/2-LineWidth, BaseHeight]) 
    dot1();//第四點半圓形
 } 
else {  
}

if (P5 == 1)  {  
translate ([(BaseLength-DotRadius/2-LR), (BaseWidth-LineWidth)/2, BaseHeight]) 
    dot1();//第五點半圓形
 } 
else {  
}

if (P6 == 1)  {  
translate ([(BaseLength-DotRadius/2-LR), DotRadius/2+TB, BaseHeight]) 
    dot1();//第六點半圓形
 } 
else {  
}

cube ([BaseLength, BaseWidth, BaseHeight]); //畫出底座
translate([0, BaseWidth-LineWidth, BaseHeight]) //畫出橫條標記
cube ([BaseLength, LineWidth, LineHeight]); //將橫條標記上移




