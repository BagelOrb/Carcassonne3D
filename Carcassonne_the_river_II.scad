use <Carcassonne_core.scad>;

use <Carcassonne_common_shapes.scad>;

use <Carcassonne_the_river_I.scad>;






// ======================================================

//   R I V E R   E X P A N S I O N   II

// ======================================================






function rr3(seed, i, length) = rands(-3,-1,1, seed)[0]*i/length*(length-i)/length*2 + 2;

module river_isle(seed=315, length=40) {
	d = [[0,0],[10, 1],[length-10, 1],[length, 0]];

	off1 = rands(-1,10,3, seed)[0];
	off2 = rands(-1,10,3, seed)[1];
	off3 = rands(-2,10,3, seed)[2];
	scale3 = rands(1,8,1, seed+1)[0];

//	translate([0,0,-0.4])
	linear_extrude(height=0.8) 
        intersection() {
            union() {
                translate([0,-20]) 
                for(i=[0:length-1]) 
                    hull() {
                            translate([sin(i*off1)*2*sign(off3)*lookup(i,d)+sin(i*off2)*2*sign(off3)*lookup(i,d)+sin(i*off3)*scale3*lookup(i,d),i]) 
                        circle(r=rr3(seed+i, i, length));
                            translate([sin((i+1)*off1)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off2)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off3)*scale3*lookup((i+1),d),(i+1)]) 
                        circle(r=rr3(seed+i, i+1, length));
                    }
                translate([0,-20]) 
                for(i=[0:length-1]) 
                    hull() {
                            translate([-(sin(i*off1)*2*sign(off3)*lookup(i,d)+sin(i*off2)*2*sign(off3)*lookup(i,d)+sin(i*off3)*scale3*lookup(i,d)),length-i]) 
                        circle(r=rr3(seed+i+100, i, length));
                            translate([-(sin((i+1)*off1)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off2)*2*sign(off3)*lookup((i+1),d)+sin((i+1)*off3)*scale3*lookup((i+1),d)),length-(i+1)]) 
                        circle(r=rr3(seed+i+100, i+1, length));
                    }
                }
		square([41,41],center=true);
	}
}





// override the old version!
module singleCityWall() {
    render() intersection() {
        translate([0,0,.5])
        scale([1,1,2]) 
        bottom(1,0,0,0);
        translate([ 40,0,-1]) cylinder(r=30,h=10,$fn=22);
    }
    roundCityWall();
}


module vulcano(radius = 18, height = 10, peekedness =.8, seed = 0) {
    rots = rands(0,360,4, seed);

    difference() {
        union() {
            mountain(radius, height, peekedness);
            
            rotate([0,0,rots[3]])
            intersection() 
            {
                mountain(radius, height+1, peekedness);
                linear_extrude(20)
                union() {
                    rotate([0,rots[0]]) 
                    polygon(points = [[0,1],[0,0],[20,20],[10,25]] );
                    rotate([0,rots[1]]) 
                    polygon(points = [[1,-1],[1,0],[20,-20],[10,-25]] );
                    rotate([0,rots[2]]) 
                    polygon(points = [[0,2],[-1,-1],[-20,-5],[-20,5]] );
                    
                }
            }
        }
        translate([0,0,height-2]) cylinder(h=3,r1=2, r2= 3, $fn=12);
    }
}


module fffw_vulcano(seed=13) {
    difference() {
        union() {
            color([0.3,0.7,0.3]) bottom(0,0,0,3);
            vulcano();
        }
            
        linear_extrude(height=20) 
        //translate([0,-10])
        //scale([1,.5])
        riverSplit(seed, pos=[0,-20] , angle=0, size=5, length=5, depth=0, maxdepth=2);
    
    }
    translate([0,0,-.4]) 
    difference() {
        mountain(18, 10, .8);
        translate([0,0,10-2]) cylinder(h=3,r1=2, r2= 3, $fn=12);
    }
}





module ffww_farm(seed=632) {
    ffww(seed);
    translate([10,10]) 
    rotate([0,0,-45])
    farm();
}





module fwww(seed=1) {
    difference() 
    {
        color([0.3,0.7,0.3]) bottom(0,3,3,3);
	riverCorner(seed+300);
	river(seed);
    }
}


module cfwf(seed=54) {
    difference() {
        color([0.3,0.7,0.3]) bottom(1,0,3,0);
        translate([10,0])
        scale([.5,.5,1]) lake(seed);
        rotate([0,0,-90])
        river_half(seed+32, 40);
    }
    singleCityWall();

    wallTower(20, 1);
    wallTower(-20);
    
    offX = rands(-1.5,1.5,7*7,seed+30);
    offY = rands(-1.5,1.5,7*7,seed+31);
    rots = rands(0,360,7*7,seed+32);
    for(x=[-3:3])
        for(y=[-3:3])
            if ((y > -2 && y < 2) && (x == 3))
                translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
                    rotate([0,0,rots[x+3+(y+3)*7]]) house();
    
}









module gaussian_bridge(length = 15, height=10, width = 10, peekedness = .1) 
{
    translate([0,width/2])
    rotate([90,0])
    linear_extrude(height = width, $fn = 12)
    polygon(points = [for (i = [-4:.2:4])
       (i<-3)? [-length,0] : 
       (i>3)? [length,0] : 
        [i/3*length,
        height * pow(exp(-i*i),peekedness)]     ]); 
    
}

module city_bridge(length = 30, width=20) {
    wallthickness = 1.5;
    wallh=4;
    squeeze=6;
    
    intersection() {
    
    translate([0,0,-4])
    difference() {
        union() {
            gaussian_bridge(length/2,10,width);
            intersection() {
                union() {
                    
                    translate([0,width/2-wallthickness,6])
                    rotate([90,0])
                        gaussian_bridge(length/2,squeeze,20);
                    translate([-length/2,width/2-wallthickness,0])
                        cube([length,wallthickness,20]);
                    translate([0,-width/2+wallthickness,6])
                    rotate([-90,0])
                        gaussian_bridge(length/2,squeeze,20); 
                    translate([-length/2,-width/2,0])
                        cube([length,wallthickness,20]);        
                }
                translate([0,0,wallh])
                gaussian_bridge(length/2,10,width);
            }
        }
        translate([0,width/2,5])
        rotate([90,0])
            gaussian_bridge(length/2,squeeze,30);
        translate([0,-width/2,5])
        rotate([-90,0])
            gaussian_bridge(length/2,squeeze,30);
        
        translate([-5,0,3])
        rotate([90,0])
            cylinder(h=20,r=4.5,center=true);
        translate([5,0,3])
        rotate([90,0])
            cylinder(h=20,r=4.5,center=true);
    }
    
    translate([0,0,10])
    cube([length-2,length-2,20],center=true);
    }
}

module cwcw_connected(seed = 16) {
    difference() {
        union() {
            color([0.3,0.7,0.3]) bottom(1,3,1,3);
            difference() 
            {
                singleCityWall();
                translate([10,0,5.5])
                cube([8,8,8],center=true);
            }
            wallTower(12);
            wallTower(-12);
            rotate([0,0,180]) {
                difference() 
                {
                    singleCityWall();
                    translate([10,0,5.5])
                    cube([8,8,8],center=true);
                }
                wallTower(12);
                wallTower(-12);
            }
            city_bridge();
            translate([17,2,1.5])
            rotate([0,0,29])
            house();
            translate([18,-10,1.5])
            rotate([0,0,-7])
            house();
            translate([-18,10,1.5])
            rotate([0,0,10])
            house();
            translate([-17,3,1.5])
            rotate([0,0,78])
            house();
        }
        
        
        river_isle();
    }

}




module fwfw_cloister() {
    fwfw(386);//386
    translate([10,0]) 
    rotate([0,0,-18])
    cloister();
}



module rwrw_alt(seed=171) {
    union() {
        difference() {
                
            union(){
                color([0.3,0.7,0.3]) bottom(2,3,2,3);
                    rotate([0,0,90])
                    road_mid(seed+477,40);
            }
            river(seed+41);
        }
        translate([-2,1])	
        rotate([0,0,-7])
        bridge();
    }
}

module rwrw_inn(seed=253) {
    rwrw_alt(seed);
}
//rrr= round(rands(0,1000,1)[0]);
//echo(rrr);
//rwrw_inn();

module river_II() {
     	translate([  0,  0]) fffw_vulcano();
	translate([ 50,  0]) ffww_farm();
	translate([100,  0]) fwww();
	translate([150,  0]) cfwf();

	translate([  0, 50]) cwcw_connected();
	translate([ 50, 50]) fwfw_cloister();
	translate([100, 50]) cwrw(84); // old exp
	translate([150, 50]) rrww(15); // old exp

	translate([  0,100]) fffw(51); // old exp
	translate([ 50,100]) ffww(14); // old exp
	translate([100,100]) rwrw_inn();
	translate([150,100]) ccww(92, 1); // old exp
}


river_II();































