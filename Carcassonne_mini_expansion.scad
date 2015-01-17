use <Carcassonne_core.scad>;

use <Carcassonne_common_shapes.scad>;

use <Carcassonne_the_river_I.scad>;

use <Carcassonne_inns_and_cathedrals.scad>;


// ============================

//   M I N I   E X P A N S I O N

// ============================



 
module crcf(seed=12,shield=1) {
    color([0.3,0.7,0.3]) bottom(2,1,0,1);

    difference() {
        union() {
            rotate([0,0,  0]) roundCityWall();
            rotate([0,0,180]) roundCityWall();
        }
       translate([11.5,0,6]) cube([3,10,10],center=true);
    }
    translate([11.5,0,0]) gate();
  
    
 
    if (seed == 10) wallTower(10);
    //if (seed == 10) 
        rotate(180) wallTower(30);
    //if (seed == 11) 
        wallTower(25, 1);
    //if (seed == 11) 
        wallTower(-25, 1);

    render() difference() {
            if (shield) color([0.7,0.7,0.7]) translate([0,0,1]) bottom(0,1,0,1, 2);
            else color([0.7,0.7,0.7]) translate([0,0,1]) bottom(0,1,0,1, 0);
            rotate([0,0,  0]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
            rotate([0,0,180]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
    }

    offX = rands(-1.5,1.5,7*7,seed);
    offY = rands(-1.5,1.5,7*7,seed+1);
    rots = rands(0,360,7*7,seed+2);
    for(x=[-3:3])
        for(y=[-3:3])
            if (x>-3&&x<3 && ((x>-2&&x<2) || y>2 || y<-2) && (!shield || x<1||y<2))
                translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
                    rotate([0,0,rots[x+3+(y+3)*7]]) house();

    intersection() {
        rotate([0,0,90]) road(3);
        translate([20,0,0]) cube([40,40,40],center=true);
    }
}

module crcr_plain(seed=0) {
	color([0.3,0.7,0.3]) bottom(1,2,1,2);

	singleCityWall();
	rotate([0,0,180]) singleCityWall();

	if (seed == 1) wallTower(15);
	if (seed == 2) wallTower(20, 1);
	if (seed == 2) rotate(180) wallTower(25);

	offX = rands(-1.5,1.5,7*7,seed+20);
	offY = rands(-1.5,1.5,7*7,seed+21);
	rots = rands(0,360,7*7,seed+22);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3 || x == -3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
                        
         road(seed+623);
}

module crrr_alt(seed=217) {
    color([0.3,0.7,0.3]) bottom(1,2,2,2);
    roadCorner(seed+604);
    rotate([0,0,180]) roadCorner(seed+300);
        
    difference() {
        singleCityWall();
        translate([11.5,0,6]) cube([3,10,10],center=true);
    }
    
    translate([11.5,0,0]) gate();
    

    if (seed == 1) wallTower(15);
    if (seed == 2) wallTower(-10, 1);

    offX = rands(-1.5,1.5,7*7,seed+40);
    offY = rands(-1.5,1.5,7*7,seed+41);
    rots = rands(0,360,7*7,seed+42);
    for(x=[-3:3])
            for(y=[-3:3])
                    if ((y > -2 && y < 2) && (x == 3))
                            translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
                                    rotate([0,0,rots[x+3+(y+3)*7]]) house();
    
    
}

module mountains(seed = 1) 
{
    for (i = [0:4])
        translate(rands(-8,8,2,seed+i*6))
        mountain(14+rands(-2,2,1,seed+i*6+3)[0], 5+rands(-2,2,1,seed+i*6+4)[0], .9+rands(-.2,.2,1,seed+i*6+5)[0]);
    
}


module wfrf(seed=777) {
    difference() {
        union() {
            color([0.3,0.7,0.3]) bottom(0,2,0,3);
            intersection() {
                mountains(seed);
                scale([1,1,20]) bottom(0,2,0,3);
            }
        }
            
        linear_extrude(height=20) 
        //translate([0,-10])
        //scale([1,.5])
        riverSplit(seed, pos=[0,-20] , angle=0, size=5, length=5, depth=0, maxdepth=2);
    
    }
    intersection() {
        translate([0,0,-.4]) 
        mountains(seed);
        scale([1,1,20]) bottom(0,0,0,3);
    }

    // road
    intersection() 
    {
        union() {
            translate([0,0,.8]) 
            mountains(seed);
            scale([1,1,1.8]) bottom(0,2,0,3);
        }
        
        translate([0,10])
        scale([1,.5,20])
        road(seed);

    }
}



module ccrr_double_entrance(shield=0, seed=0) {
    color([0.3,0.7,0.3]) bottom(1,1,2,0);

    
    difference() {
        cornerWall(shield);
        translate([11,-2,6]) rotate([0,0,10]) cube([3,10,10],center=true);
        translate([-2,11,6]) rotate([0,0,80]) cube([3,10,10],center=true);
    }
    translate([11,-2,0]) rotate([0,0,10]) gate();
    translate([-2,11,0]) rotate([0,0,80]) gate();
    


    offX = rands(-1.5,1.5,7*7,seed+20);
    offY = rands(-1.5,1.5,7*7,seed+21);
    rots = rands(0,360,7*7,seed+22);
    for(x=[-3:3])
            for(y=[-3:3])
                    if ((((x > -2 && (x < 2)) || (y > -2 && y < 2)) && (x == 3 || y == 3))
                            || (!shield && x > 1 && y > 1))
                            translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
                                    rotate([0,0,rots[x+3+(y+3)*7]]) house();
                    
                        
    rotate([0,0,-90]) roadCorner(seed+33);
    rotate([0,0,90]) roadCorner(seed+33);

}


module ffff_farm(seed=3) {
    color([0.3,0.7,0.3]) bottom(0,0,0,0);
    
    translate(rands(-10,10,2,seed))
    rotate([0,0,rands(0,360,1,seed)[0]])
    farm();
}

module cccr_hook(shield = 0, seed=0) {
    color([0.3,0.7,0.3]) bottom(1,1,2,1);

    
    difference() {
        cornerWall(shield);
        translate([7.5,7.5,6]) rotate([0,0,45]) cube([3,10,10],center=true);
    }
    translate([7.5,7.5,0]) rotate([0,0,45]) gate();
    

    if (seed == 1) wallTower(10);
    if (seed == 2) rotate(90) wallTower(-10, 1);

    if (seed == 11) wallTower(10);
    if (seed == 11) rotate(90) wallTower(-10);

    offX = rands(-1.5,1.5,7*7,seed+20);
    offY = rands(-1.5,1.5,7*7,seed+21);
    rots = rands(0,360,7*7,seed+22);
    for(x=[-3:3])
            for(y=[-3:3])
                    if ((((x > -2 && (x < 2)) || (y > -2 && y < 2)) && (x == 3 || y == 3))
                            || (!shield && x > 1 && y > 1))
                            translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
                                    rotate([0,0,rots[x+3+(y+3)*7]]) house();
                    
                        
    rotate([0,0,-90]) scale([-1,1,1]) roadSideToCorner(seed+26);

    rotate([0,0,-90])
    cooo(seed);

}

module ccff_disconnected_grass(seed=57, shield = 0) {
    color([0.3,0.7,0.3]) bottom(0,1,1,0);
    render() difference() {
        color([0.7,0.7,0.7]) translate([0,0,1]) bottom(1,1,1,0, shield);
        rotate([0,0,-90]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
        rotate([0,0,0]) translate([40,0,0]) cylinder(r=29,h=10,$fn=22);
    }
    offX = rands(-1.5,1.5,7*7,seed);
    offY = rands(-1.5,1.5,7*7,seed+1);
    rots = rands(0,360,7*7,seed+2);
    rotate([0,0,-90]) roundCityWall();
    rotate([0,0,0]) roundCityWall();
    
    rotate([0,0,-90]) wallTower(10,1);
    rotate([0,0,0]) wallTower(-15,1);
    rotate([0,0,0]) wallTower(37,0);
    
    for(x=[-3:2])
        for(y=[-2:3])
            if (((x < 2 || y < 2) || !shield) && (y > -2 || abs(x) == 3) && (x < 2 || abs(y) == 3))
                translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
                    rotate([0,0,rots[x+3+(y+3)*7]]) house();

}

module rrrr_cloister(seed=654) {
    rrrr(seed);
    rotate([0,0,rands(0,360,1,seed)[0]])
    cloister();
}


module plate1_mini_expansion() {
	translate([  0,  0]) crcf(1,0);
	translate([ 50,  0]) crcr_plain();
	translate([100,  0]) crrr_alt();
	translate([150,  0]) wfrf();

	translate([  0, 50]) ccfr(); // existing
	translate([ 50, 50]) ccrr_double_entrance();
	translate([100, 50]) ffff_farm();
	translate([150, 50]) crcr(5, 0); // existing

	translate([  0,100]) cccr_hook();
	translate([ 50,100]) ccff_disconnected_grass();
	translate([100,100]) rrrr_cloister();
	translate([150,100]) cwcw(57); // existing

}


plate1_mini_expansion();










