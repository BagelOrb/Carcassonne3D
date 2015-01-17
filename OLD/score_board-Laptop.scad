
module wallTower(rot=10,type=0) {
	difference() {
		union() {
			cylinder(r=3,h=10,$fn=8);
			if (type == 0) {
				translate([0,0,10]) cylinder(r1=3,r2=4,h=2,$fn=8);
				translate([0,0,12]) cylinder(r=4,h=2,$fn=8);
			}
			if (type == 1) {
				translate([0,0,10]) cylinder(r1=3.5,r2=1,h=5,$fn=8);
			}
                        if (type == 2) {
                            //rotate([0,0,180/16]) 
                            cylinder(r=4,h=14,$fn=16);
                        }
		}
		if (type == 0 || type == 2) {
			translate([0,0,12]) cylinder(r=2.7,h=4,$fn=8);
			for(i=[0:3]) translate([0,0,14]) rotate(360/16+i*360/8) cube([20,0.8,2],center=true);
		}
                if (type == 2) {
                    translate([0,4,8]) cube ([2,2,2],center=true);
                    translate([0,-4,8]) cube ([2,2,2],center=true);
                }
	}
}  



numX = [
    [0,800],
    [8.5,100],
    [13.5,100],
    [24.5, 800],
    [26.5, 800],
    [36.5, 200],
    [38.5, 200],
    [47.5, 800],
    [49, 800],
    ];

numY = [
    [0,100],
    [8,100],
    [13.5,500],
    [24.5,500],
    [26.5,400],
    [36.5,400],
    [38.5, 250],
    [47.5, 250],
    [49, 150],
    ];

IboundX = [
    [0,750],
    [7.5,150],
    [12.5,150],
    [13.5,150],
    [23.5, 775],
    [24.5, 775],
    [26.5, 775],
    [27.5, 750],
    [28.5, 650],
    [34.5, 300],
    [35.5, 250],
    [36, 165],
    [38, 165],
    [39.5, 300],
    [46.5, 775],
    [49, 750],
    ];

IboundY = [
    [0,150],
    [7.5,150],
    [8.5,190],
    [9.5,220],
    [12.5,450],
    [13.5,475],
    [23.5,475],
    [24,475],
    [25.5,475],
    [26.5,370],
    [27.5,450],
    [36,450],
    [37.5,350],
    [38, 200],
    [39, 180],
    [47, 200],
    [48.5, 175],
    [49, 150],
    ];

OboundX = [
    [0,780],
    [7.5,150],
    [8.5,10],
    [13.5,10],
    [14.5,200],
    [23.5, 800],
    [24, 890],
    [26.5, 890],
    [27.5, 700],
    [28.5, 650],
    [28.5, 750],
    [35.5, 250],
    [36.5, 250],
    [38, 250],
    [39.5, 300],
    [46.5, 750],
    [47.5, 890],
    [49, 890],
    ];

OboundY = [
    [0,10],
    [7.5,10],
    [8.5,100],
    [9.5,250],
    [13.5,600],
    [14.5,600],
    [23.5,600],
    [24,600],
    [25.5,400],
    [26.5,250],
    [27,325],
    [28.5,325],
    [36.5,325],
    [38, 300],
    [47.5, 300],
    [48.5, 100],
    [49, 130],
    ];
seed = 124;//3798; //124

function randomizedTextPos(seed, i) = 
    [ lookup(i-1, numX)*.2 + .5*lookup(i, numX) + .3*lookup(i+1, numX)
    , lookup(i-1, numY)*.2 + .5*lookup(i, numY) + .3*lookup(i+1, numY)] + rands(-7,7,2,seed+i);
    
    
function randomizedIboundPos(seed, i) = 
    [ lookup(i-1, IboundX)*.2 + .5*lookup(i, IboundX) + .3*lookup(i+1, IboundX)
    , lookup(i-1, IboundY)*.2 + .5*lookup(i, IboundY) + .3*lookup(i+1, IboundY)] + rands(-7,7,2,seed+i);
    
    
function randomizedOboundPos(seed, i) = 
    [ lookup(i-1, OboundX)*.1 + .7*lookup(i, OboundX) + .2*lookup(i+1, OboundX)
    , lookup(i-1, OboundY)*.1 + .7*lookup(i, OboundY) + .2*lookup(i+1, OboundY)] + rands(-7,7,2,seed+i);










module drawSep(p1,p2,length = 10, r = 5,seed=0) 
{
    
    tableX = [
        [ 0,0],
        [ .25, rands(-r, r,2,seed+5412)[0]],
        [ 0.5, rands(-r,r,2,seed+532)[0]],
        [ .75, rands(-r, r,2,seed+15)[0]],
        [ 1,0],
        ];
    tableY = [
        [ 0,0],
        [ .25, rands(-r,r,2,seed+5412)[1]],
        [ 0.5, rands(-r,r,2,seed+532)[1]],
        [ .75, rands(-r,r,2,seed+15)[1]],
        [ 1,0],
        ];
    step = 1/length;
    for (i = [step : step : 1-2*step]) hull() {
        translate((1-i)*p1 + i*p2 + [lookup(i,tableX), lookup(i,tableY)]) 
        circle(r=15*i*(1-i));  
        translate((1-(i+step))*p1 + (i+step)*p2 + [lookup((i+step),tableX), lookup((i+step),tableY)]) 
        circle(r=15*i*(1-i));  
    }
    //polygon([p1,p2,p2+[5,5],p1+[-5,5]]);
}





module txt() {
    color([.3,.1,.1]) 
        linear_extrude(height = 4)
        {
            for (i = [0 : 49]) 
                translate(randomizedTextPos(seed, i)) 
                text(str(i), size=15, font = "Liberation Serif:style=Bold");

        }
    
    
}










module seps() {
    color([.3,.1,.1]) 
    linear_extrude(height = 4)
        for (i = [0 : 49]) 
            drawSep(randomizedOboundPos(seed, i),randomizedIboundPos(seed, i), 10, 5, seed+i);
        
   
}












module innerBounds() {
    color([.3,.1,.1]) 
    linear_extrude(height = 4)
        for (i = [26 : 49]) 
            drawSep(randomizedIboundPos(seed, i),randomizedIboundPos(seed, i+1), 10, 2, seed+i+49); 

}

// bottom
//color([0,1,0]) cube([1000,600,1]);
module outerBounds() {
    color([.3,.1,.1]) 
    linear_extrude(height = 4)
    {


        for (i = [0 : 25])
            drawSep(randomizedOboundPos(seed, i),randomizedOboundPos(seed, i+1), 10, 3, seed+i+49*2);
        for (i = [36 : 49]) 
            drawSep(randomizedOboundPos(seed, i),randomizedOboundPos(seed, i+1), 10, 3, seed+i+49*2);


    }
}













module drawWallBorder(p1,p2, d=4, seed=0)
{
    p = p2-p1;
    dx = p[1]/norm(p)*d;
    dy = p[0]/norm(p)*d;
    polygon([
        p1+[-dx,dy],
        p1+[dx,-dy],
        p2+[dx,-dy],
        p2+[-dx,dy],
        ]);
    

    //translate(p1) circle(r=d);
    //translate(p2) circle(r=d);
    
}

module wallTop(p1,p2,seed=0)
{
    d = p2-p1;
    ds = d / norm(d);
    a = atan2(d[1],d[0]);
    if (rands(0,1,1,seed)[0]<0.6) 
    {
        for (i = [4 : 16 : norm(d)-4]) 
        {
            translate(p1+i*ds) translate([0,0,32]) rotate([0,0,a]) cube([8,8,8],center=true);
        
        }
    }
    else
    {
        hull() {
            translate([0,0,32]) translate(p1) cylinder(h=4,r1=6, r2=0,$fn=4);
            translate([0,0,32]) translate(p2) cylinder(h=4,r1=6, r2=0,$fn=4);
        }
    }
    
}

module walls() {
    color([.3,.1,.1]) 
    //translate([0,0,8]) 
    {
        linear_extrude(height = 32) {
            for (i = [0 : 23]) 
                drawWallBorder(randomizedIboundPos(seed, i),randomizedIboundPos(seed, i+1));

            for (i = [26 : 34]) 
                drawWallBorder(randomizedOboundPos(seed, i),randomizedOboundPos(seed, i+1));
        }
        for (i = [0 : 23]) 
            wallTop(randomizedIboundPos(seed, i),randomizedIboundPos(seed, i+1),seed+i);

        for (i = [26 : 34]) 
            wallTop(randomizedOboundPos(seed, i),randomizedOboundPos(seed, i+1),seed+i);
        
    }
}












module basicBoard() {
    txt();
    seps();
    innerBounds();
    outerBounds();
    walls();
    
}
sf = .25;








module bigBuilding1() {
    difference() {
        union() {
            translate([-3,-3,0]) cube([6,6,10]);
            translate([0,0,10]) rotate([0,0,45]) cylinder(h=3, r1=4.4,r2=1,$fn=4);

        }
        translate([-1,-3,7]) cube([1,2,2],center = true);
        translate([1,-3,7]) cube([1,2,2],center = true);
        
        translate([-1,3,7]) cube([1,2,2],center = true);
        translate([1,3,7]) cube([1,2,2],center = true);
        
        translate([-3,-1,7]) cube([2,1,2],center = true);
        translate([-3,1,7]) cube([2,1,2],center = true);
        
        translate([3,-1,7]) cube([2,1,2],center = true);
        translate([3,1,7]) cube([2,1,2],center = true);
        
    }

}

module bigBuilding2() {
    difference() {
        union() {
            translate([-6,-3,0]) cube([12,6,10]);
            hull() 
            {
                translate([-3,0,10]) rotate([0,0,45]) cylinder(h=2, r1=4.4,r2=1,$fn=4);
                translate([3,0,10]) rotate([0,0,45]) cylinder(h=2, r1=4.4,r2=1,$fn=4);
            }
        }
        translate([-4,-3,7]) cube([1,2,2],center = true);
        translate([-2,-3,7]) cube([1,2,2],center = true);
        translate([0,-3,7]) cube([1,2,2],center = true);
        translate([2,-3,7]) cube([1,2,2],center = true);
        translate([4,-3,7]) cube([1,2,2],center = true); 
        
        translate([-4,3,7]) cube([1,2,2],center = true);
        translate([-2,3,7]) cube([1,2,2],center = true);
        translate([0,3,7]) cube([1,2,2],center = true);
        translate([2,3,7]) cube([1,2,2],center = true);
        translate([4,3,7]) cube([1,2,2],center = true);
        
        
        translate([-4,-3,2]) cube([1,2,3],center = true);
    }

}


module randomWallTower(p0,p1,p2, seed=0) {
    rs = rands(0,1,5);
    r = rs[0];
    
    d1 = p1-p0;
    d2 = p2-p1;
    a1 = atan2(d1[1],d1[0]);
    a2 = atan2(d2[1],d2[0]);
    
    a = (a1+a2)/2;
    if (rs[4] * (norm(d1)+norm(d2)) > 10) 
    {
        rotate([0,0,a]) {
            if (r<.3) {
            wallTower(rands(0,180,1,seed)[0], 0); }
            else {if (r<.5) {
            wallTower(rands(0,180,1,seed)[0], 1); } 
            else {if (r<.7) {
            wallTower(0, 2); } 
            else {if (r<.9) {
            bigBuilding1(); } 
            else {if (r<1) {
            bigBuilding2(); } 
            
            }      
            }      
            }    
            }
        }

        
        if (rs[1] < .2) 
        {
            rotate([0,0,a+rands(-30,30,1)[0] + ((rs[3]<.4)? 180 : 0)]) translate([0,4,0]) scale([.5,.5,.7]) 
            if (rs[2] < .5) 
            {
                wallTower(rands(0,180,1,seed)[0], 1);
            }
            else
            {
                bigBuilding1(); 
            }
        }
    }
}


module towers() {
    for (i = [0 : 24]) 
        translate(randomizedIboundPos(seed, i)*sf)
        randomWallTower(randomizedIboundPos(seed, i-1)*sf, randomizedIboundPos(seed, i)*sf, randomizedIboundPos(seed, i+1)*sf, i*4);

    for (i = [26 : 35]) 
        translate(randomizedOboundPos(seed, i)*sf)
        randomWallTower(randomizedIboundPos(seed, i-1)*sf, randomizedIboundPos(seed, i)*sf, randomizedIboundPos(seed, i+1)*sf, i*5+714);
}



























//translate([0,0,-10])
//

//import("basicBoard.stl");


//scale([sf,sf,sf]) walls();
//towers();

//import("basicBoard4.stl"); 
cube([230,160,1]);

import("towers.stl");

//scale([sf,sf,sf]) basicBoard();
//towers();
