use <Carcassonne_core.scad>;

use <Carcassonne_common_shapes.scad>;



// =================================

//   I N N S  &   C A T H E D R A L S

// =================================







module frfr_cloister(seed=0) {
	color([0.3,0.7,0.3]) bottom(0,2,0,2);
	translate([-3,0,0]) rotate([0,0,90]) cloister();
	
	road(seed+312);

 
}

module arch() {
    translate([0,-1,0])
    rotate([-90,0,0])
    {
        linear_extrude(height=2) {
            scale([1,2])
            intersection() {
                translate([-1,0]) circle(r=2);
                translate([1,0]) circle(r=2);
                
            }
            translate([0,3]) square([2,6], center=true);
        }
    }
}
module archr(){
    rotate([0,0,90]) arch();
}
    

module cathedral() {
    difference() 
    {
        union() {
 
            hull() { // longitude
                translate([ 0,5,5]) rotate([0,0,45]) cylinder(r1=7,r2=1,h=3,$fn=4);
                translate([ 0,5,-5])  rotate([0,0,45]) cylinder(r1=7,r2=7,h=10,$fn=4);
                translate([ 0,-16,5]) rotate([0,0,22.5]) cylinder(r1=5,r2=1,h=3,$fn=8);
                translate([ 0,-16,-5]) rotate([0,0,22.5]) cylinder(r1=5,r2=5,h=10,$fn=8);
            }
            hull() { // dwars
                translate([ 7,-8,5]) rotate([0,0,45]) cylinder(r1=7,r2=1,h=3,$fn=4);
                translate([ 7,-8,-5])  rotate([0,0,45]) cylinder(r1=7,r2=7,h=10,$fn=4);
                translate([-7,-8,5]) rotate([0,0,45]) cylinder(r1=7,r2=1,h=3,$fn=4);
                translate([-7,-8,-5])  rotate([0,0,45]) cylinder(r1=7,r2=7,h=10,$fn=4);
            }
            
            //front
            translate([4,9,7]) cube([2,2,6],center=true);
            translate([4,9,10]) rotate([0,0,45]) cylinder(r1=2,r2=0,h=4,$fn=4);
            translate([-4,9,7]) cube([2,2,6],center=true);
            translate([-4,9,10]) rotate([0,0,45]) cylinder(r1=2,r2=0,h=4,$fn=4);            
            translate([1.5,9.5,7]) cube([1,1,3],center=true);
            translate([-1.5,9.5,7]) cube([1,1,3],center=true);
                            
            translate([0,9.5,6]) cube([10,1,2],center=true);
        }

        // windows etc.
        
            
        //front of front
        translate([3,10]) arch();
        translate([-3,10]) arch();
        translate([0,10,-1]) scale([1.5,1,.8]) arch();
        translate([0,10,4]) rotate([-90,0,0]) cylinder(h=2, r=1.5, center=true);
        
        
        // front of side
        translate([7,-3]) arch();
        translate([10,-3]) arch();
        translate([-7,-3]) arch();
        translate([-10,-3]) arch();
        
        // back of side
        translate([7,-13]) arch();
        translate([10,-13]) arch();
        translate([-7,-13]) arch();
        translate([-10,-13]) arch();
        
        //sides of sides
        translate([12,-5]) archr();
        translate([12,-8]) archr();
        translate([12,-11]) archr();
        translate([-12,-5]) archr();
        translate([-12,-8]) archr();
        translate([-12,-11]) archr();

        //side of front
        translate([5,8]) archr();
        translate([5,5]) archr();
        translate([5,2]) archr();
        translate([5,-1]) archr();
        translate([-5,8]) archr();
        translate([-5,5]) archr();
        translate([-5,2]) archr();
        translate([-5,-1]) archr();


        
        //side of back
        translate([5,-16]) archr();
        translate([-5,-16]) archr();    
        
        // back of back
        translate([3.5,-19.5]) rotate([0,0,45]) arch();
        translate([-3.5,-19.5]) rotate([0,0,-45]) arch();
        translate([0,-21]) arch();
    
    }

}





module cccc_cathedral() {
    color([0.3,0.7,0.3]) bottom(1,1,1,1);
    color([0.7,0.7,0.7]) translate([0,0,1]) bottom(1,1,1,1);
    translate([0,5,5]) cathedral();
    
}


module lake(seed=27) {
    
    linear_extrude(height=.8)
    scale([.6,.6])
    for (j = [1:6])
        translate(rands(-7,7,2,seed+j+12))
        hull() 
        for (i = [1:4])
        {
            
            translate((6-rands(1,5,1,seed+i+j*5)[0])/4*rands(-5,5,2,seed+523+i+j*5)) circle(r=rands(1,5,1,seed+i+j*5)[0]);
            
        }
    
}

module inn(){
    difference() 
    {
        union() {
            rotate([90,0,0])
            linear_extrude(height=6)
            polygon([[-4,0],[4,0],[4,2],[0,6],[-4,2]]);
            
            translate([5,0])
            rotate([90,0,0])
            linear_extrude(height=4)
            polygon([[-2,0],[2,0],[2,2],[0,4],[-2,2]]);
        }
        
    cube([1,2,4],center=true);   
    translate([5,0]) cube([1,2,4],center=true); 
    translate([2,0,1.5]) cube([1,2,1],center=true);   
    translate([-2,0,1.5]) cube([1,2,1],center=true);   
    translate([0,0,3.5]) cube([1,2,.5],center=true);   
        
    translate([0,-6,1.5]) cube([1,2,1],center=true);   
    }
    
}    
    
//inn();
//translate([0,7]) lake(27);


module sideCity(seed=0) {
	singleCityWall();

	if (seed%6 == 1) wallTower(15);
	if (seed%6 == 2) wallTower(-10);
	if (seed%6 == 3) wallTower(20, 1);
	if (seed%6 == 4) wallTower( 15);
	if (seed%6 == 5) wallTower(-15);

	offX = rands(-1.5,1.5,7*7,seed+30);
	offY = rands(-1.5,1.5,7*7,seed+31);
	rots = rands(0,360,7*7,seed+32);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((y > -2 && y < 2) && (x == 3))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

module cccc_alt(seed=0) {
    
    color([0.3,0.7,0.3]) bottom(1,1,1,1);
    sideCity(seed+5);
    rotate([0,0,90]) sideCity(seed+55);
    rotate([0,0,180]) sideCity(seed+555);
    rotate([0,0,-90]) sideCity(seed+222);
}

module cccf_alt(seed=0) {
    
    color([0.3,0.7,0.3]) bottom(1,1,1,0);
    sideCity(seed+5);
    rotate([0,0,90]) sideCity(seed+55);
    rotate([0,0,180]) sideCity(seed+555);
}

module cornerCity(seed=0,shield=0) {
	cornerWall(shield);

	if (seed%8 == 1) wallTower(20);
	if (seed%8 == 2) rotate(90) wallTower(-15, 1);
	
	if (seed%8 == 3) rotate(90) wallTower(-20);
	if (seed%8 == 5) wallTower(5);
	if (seed%8 == 6) rotate(90) wallTower(0, 1);

	offX = rands(-1.5,1.5,7*7,seed);
	offY = rands(-1.5,1.5,7*7,seed+1);
	rots = rands(0,360,7*7,seed+2);
	for(x=[-3:3])
		for(y=[-3:3])
			if ((((x > -2 && (x < 2)) || (y > -2 && y < 2)) && (x == 3 || y == 3))
				|| (!shield && x > 1 && y > 1))
				translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
					rotate([0,0,rots[x+3+(y+3)*7]]) house();
}

module cccf_alt2(seed=0) {
    
    color([0.3,0.7,0.3]) bottom(1,1,0,1);
    cornerCity(seed+5, 1);
    rotate([0,0,-90]) sideCity(seed+55);
}






module singleCityWallOnly(seed=0, shield=0) {
    render(convexity=2) intersection() {
            union() {
                    difference() {
                            translate([ 40,0,0]) cylinder(r=30,h=8,$fn=22);
                            translate([ 40,0,0]) cylinder(r=28,h=12,$fn=22);
                            for(i=[0:10])
                                    translate([ 40,0,8]) rotate([0,0,360/22*(0.5+i)]) cube([60,3,2],center=true);
                    }
                    translate([ 20, 20]) cylinder(r=3,h=9);
                    translate([ 20,-20]) cylinder(r=3,h=9);
            }
            cube([40,40,40],center=true);
    }
}

module cornerCityWall_alt(seed=0, shield=0) {
    rotate([0,0,180]) 
    render(convexity=2) intersection() {
        union() {
            translate([-28.5,-28.5])
            rotate([0,0,5])
            difference() {
                cylinder(r=50,h=8,$fn=36);
                cylinder(r=48,h=12,$fn=36);
                for(i=[0:10])
                        translate([ 0,0,8]) rotate([0,0,360/36*(0.5+i)]) cube([100,3,2],center=true);
            }
            translate([-20, 20]) cylinder(r=3,h=9);
            translate([ 20,-20]) cylinder(r=3,h=9);
        }
        cube([40,40,40],center=true);
    }
}

module cfff_alt(shield=0, seed=0) {
    bottom(1,0,0,0);
    rotate([0,0,90]) singleCityWallOnly();
    cornerCityWall_alt();

    difference() {
        render() 
        intersection() {
            translate([0,0,1]) bottom(1,0,0,0);
            rotate([0,0,180]) translate([-28.5,-28.5]) rotate([0,0,5]) cylinder(r=50,h=8,$fn=36);

        }
        rotate([0,0,90]) translate([ 40,0,0]) cylinder(r=30,h=10,$fn=22);
    }
    
    pos = [0,0];

    nhouses=18;

    rots = rands(0,360,nhouses, seed);
    posX = rands(-16,16,nhouses,seed+nhouses*1);
    posY = rands(-16,16,nhouses,seed+nhouses*2);
    for (i=[0:nhouses-1])
    {
        if (norm([posX[i]-28.5,posY[i]-28.5]) < 48 && norm([posX[i]-0,posY[i]-40])>32)
            translate([posX[i],posY[i],1.5])  rotate([0,0,rots[i]]) house();
    
        
    }

}

//cfff_alt();



//translate([28.5,28.5,-20]) cylinder(r=50,h=2,center=true);
//translate([0,40,-20]) cylinder(r=30,h=8,center=true);








module cfrf(seed=41) {
    color([0.3,0.7,0.3]) bottom(1,0,2,0);
    difference() {
        singleCityWall();
        translate([11.5,0,6]) cube([3,10,10],center=true);
    }
    
    translate([11.5,0,0]) gate();
    
    rotate([0,0,-90]) road(seed+15);

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






module roadSideToCorner(seed=0, length = 20) {
    
    noise = rands(-4,4,6,seed);
    
    x = [[0,0],
        [length/5, noise[0]], 
        [length/5*2,0+noise[1]],
        [length*.7, 10+noise[2]], 
        [length,21]];
    y = [[0,-21],
        [length/5, -10+noise[3]], 
        [length/5*2,0+noise[4]],
        [length*.7, 10+noise[5]], 
        [length,21]];
    

    noiseX = rands(-.5,.5,length+1,seed+62);
    noiseY = rands(-.5,.5,length+1,seed+7584);
 
    linear_extrude(height=0.8) intersection() {
        for(i=[0:length-1]) hull() {
            translate([lookup(i,x)*.4+.3*lookup(i-1,x)+.3*lookup(i+1,x),lookup(i,y)*.4+.3*lookup(i-1,y)+.3*lookup(i+1,y)] + [noiseX[i], noiseY[i]]) circle(r=1);
            translate([lookup(i+1,x)*.4+.3*lookup(i,x)+.3*lookup(i+2,x),lookup(i+1,y)*.4+.3*lookup(i,y)+.3*lookup(i+2,y)] + [noiseX[i+1], noiseY[i+1]]) circle(r=1);
        }
        square([40,40],center=true);
    }
}




module ccrf(shield=0, seed=48) {
    color([0.3,0.7,0.3]) bottom(1,1,0,2);
    
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
                    
                        
    roadSideToCorner(seed+26);
}


 
module crcr(seed=1,shield=1) {
    color([0.3,0.7,0.3]) bottom(2,1,2,1);

    difference() {
        union() {
            rotate([0,0,  0]) roundCityWall();
            rotate([0,0,180]) roundCityWall();
        }
       translate([11.5,0,6]) cube([3,10,10],center=true);
       translate([-11.5,0,6]) cube([3,10,10],center=true);
    }
    translate([11.5,0,0]) gate();
    translate([-11.5,0,0]) gate();
    
    
 
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

    
    rotate([0,0,90]) road(3);
}






module crcr_alt(seed=0) {
    color([0.3,0.7,0.3]) bottom(1,2,1,2);

    difference() {
       union() {
            singleCityWall();
            rotate([0,0,180]) singleCityWall();
       }
       translate([11.5,0,6]) cube([3,10,10],center=true);
       translate([-11.5,0,6]) cube([3,10,10],center=true);
    }
    translate([11.5,0,0]) gate();
    translate([-11.5,0,0]) gate();


    road(seed+213);
    rotate([0,0,90]) road(seed+21);

    rotate(180) wallTower(25);
    wallTower(25, 1);

    offX = rands(-1.5,1.5,7*7,seed+11);
    offY = rands(-1.5,1.5,7*7,seed+31);
    rots = rands(0,360,7*7,seed+12);
    for(x=[-3:3])
        for(y=[-3:3])
            if ((y > -2 && y < 2) && (x == 3 || x == -3))
                translate([x*5+offX[x+3+(y+3)*7],y*5+offY[x+3+(y+3)*7],1.5])
                        rotate([0,0,rots[x+3+(y+3)*7]]) house();
}
module ccfr_inn(shield=0, seed=48) {
    difference() {
        ccfr(shield,seed);
        translate ([0,-10]) lake(seed);
    }
    
    translate ([-10,-10]) rotate([0,0,-90]) inn(); 
    
}

module ccfr(shield=0, seed=48) {
    color([0.3,0.7,0.3]) bottom(1,1,2,0);

    
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

}


module cfrr_inn() {
    difference() {
        cfrr();
        translate ([0,-10]) lake(23);
    }
    
    translate ([-10,-10]) rotate([0,0,-90]) inn(); 
    
}



module ccrr_inn(seed=0) {
    difference() {
        ccrr(123,1);
        translate ([-3,3]) lake(12);
    }
    
    translate ([-10,5]) rotate([0,0,-90]) inn(); 
    
}



module frrr_inn(seed=0) {
    difference() {
        frrr(123,1);
        translate ([10,-6]) lake(16);
    }
    
    translate ([12,5]) rotate([0,0,180]) inn(); 
    
}





module frfr_inn(seed=0) {
    difference() {
        frfr(123,1);
        translate ([10,7]) lake(36);
    }
    
    translate ([10,-5]) inn(); 
    
}





module ffrr_inn(seed=0) {
    difference() {
        ffrr(123,1);
        translate ([10,7]) lake(38);
    }
    
    translate ([10,-5]) inn(); 
    
}



module rrrr_alt(seed=0) {
	color([0.3,0.7,0.3]) bottom(2,2,2,2);
	roadCorner(seed+300);
    	rotate([0,0,180]) roadCorner(seed+600);
    
}


module plate1_inns_and_cathedrals() {
	translate([  0,  0]) cccc_cathedral();
	translate([ 50,  0]) cccc_cathedral();
	translate([100,  0]) frfr_cloister();
	translate([150,  0]) cccc_alt();

	translate([  0, 50]) cccf_alt();
	translate([ 50, 50]) crcr_alt();
	translate([100, 50]) cccf_alt();
	translate([150, 50]) cccf_alt2();

	translate([  0,100]) cfff_alt();
	translate([ 50,100]) cfrf();
	translate([100,100]) ccrf();
	translate([150,100]) crcr();

	translate([  0,150]) ccfr_inn();
	translate([ 50,150]) cfrr_inn();
	translate([100,150]) ccrr_inn();
	translate([150,150]) frrr_inn();
}
module plate2_inns_and_cathedrals() {
	translate([  0,  0]) frfr_inn();
	translate([ 50,  0]) ffrr_inn();
//	translate([100,  0]) ????;
//	translate([150,  0]) ????;
//
	translate([  0, 50]) rrrr_alt();
//	translate([ 50, 50]) ????;
//	translate([100, 50]) ????;
//	translate([150, 50]) ????;
//
//	translate([  0,100]) ????;
//	translate([ 50,100]) ????;
//	translate([100,100]) ????;
//	translate([150,100]) ????;
//
//	translate([  0,150]) ????;
//	translate([ 50,150]) ????;
//	translate([100,150]) ????;
//	translate([150,150]) ????;
}

plate1_inns_and_cathedrals();
//plate2_inns_and_cathedrals();













