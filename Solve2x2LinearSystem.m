%% Calculating Solve2x2LinearSystem:
% uses the below formula and returns deltau
function [deltau]=Solve2x2LinearSystem(Z,err)
    det=Z(1,1)*Z(2,2)-Z(1,2)*Z(2,1);
    deltau(1)=(Z(2,2)*err(1) - Z(1,2)*err(2))/det; 
    deltau(2)=(Z(1,1)*err(2) - Z(1,2)*err(1))/det;
end

