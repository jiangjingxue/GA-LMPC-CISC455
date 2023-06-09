function cofm = calculate_coeffs(xi,vxi,xf,vxf,xm,tPoints)

tv1 = tPoints(2);
tv2 = tPoints(3);
tv3 = tPoints(4);
tv4 = tPoints(5);
tv5 = tPoints(6);
tv6 = tPoints(7);
tf =  tPoints(end);

B = [xi; vxi; 
     xm(1); xm(1); 0; 0;
     xm(2); xm(2); 0; 0;
     xm(3); xm(3); 0; 0;
     xm(4); xm(4); 0; 0;
     xm(5); xm(5); 0; 0;
     xm(6); xm(6); 0; 0;
     xf; vxf;     
    ];

A = [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     1,tv1,tv1^2,tv1^3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,1,2*tv1,3*tv1^2,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,2,6*tv1,0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,1,(tv2-tv1),(tv2-tv1)^2,(tv2-tv1)^3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,1,2*(tv2-tv1),3*(tv2-tv1)^2,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,2,6*(tv2-tv1),0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,1,(tv3-tv2),(tv3-tv2)^2,(tv3-tv2)^3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,1,2*(tv3-tv2),3*(tv3-tv2)^2,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,2,6*(tv3-tv2),0,0,-2,0,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,1,(tv4-tv3),(tv4-tv3)^2,(tv4-tv3)^3,0,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,1,2*(tv4-tv3),3*(tv4-tv3)^2,0,-1,0,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,6*(tv4-tv3),0,0,-2,0,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,(tv5-tv4),(tv5-tv4)^2,(tv5-tv4)^3,0,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2*(tv5-tv4),3*(tv5-tv4)^2,0,-1,0,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,6*(tv5-tv4),0,0,-2,0,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,(tv6-tv5),(tv6-tv5)^2,(tv6-tv5)^3,0,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2*(tv6-tv5),3*(tv6-tv5)^2,0,-1,0,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,6*(tv6-tv5),0,0,-2,0;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,(tf-tv6),(tf-tv6)^2,(tf-tv6)^3;
     0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2*(tf-tv6),3*(tf-tv6)^2;
    ];

allcoefs = transpose(A\B);

for i = 1:7
    cofm(:,i) = allcoefs(4*(i-1)+1:4*i);   
end 

end