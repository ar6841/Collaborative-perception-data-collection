%% View point cloud data

x = pi/180; 
R = [ cos(x) sin(x) 0 0
     -sin(x) cos(x) 0 0
      0         0   1 0
      0         0   0 1];

tform = affine3d(R);

lower = min([ptcloud_target.XLimits ptcloud_target.YLimits]);
upper = max([ptcloud_target.XLimits ptcloud_target.YLimits]);
  
xlimits = [lower upper];
ylimits = [lower upper];
zlimits = ptcloud_target.ZLimits;

player = pcplayer(xlimits,ylimits,zlimits);

xlabel(player.Axes,'X (m)');
ylabel(player.Axes,'Y (m)');
zlabel(player.Axes,'Z (m)');
view(player, ptcloud_target)
%for i = 1:360      
 %   ptcloud_target = pctransform(ptcloud_target,tform);     
  %  view(player,ptcloud_target);     
%end