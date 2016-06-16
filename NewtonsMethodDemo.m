function NewtonsMethodDemo;
ca

% archy 7/6/16. Trying to figure out how Newton's method works

% 1. Linear approximation of quadratic function

x = 1:100;
y = 2*x.^2+4*x + 30;

figure;plot(y);

figure(1);
% Apply Newton's method iteratively

nStep = 20;
x_newton = zeros(1,nStep);
x_newton(1) = 100*rand;
colormtx = [linspace(0,1,nStep)',zeros(nStep,1),ones(nStep,1)];


for i_step = 1:nStep;
    x_newton(i_step+1) = x_newton(i_step) - ((2*x_newton(i_step).^2+4*x_newton(i_step) + 30) / (4*x_newton(i_step) + 4));
    
    tangent = (4*x_newton(i_step) + 4)*(x-x_newton(i_step)) + (2*x_newton(i_step).^2+4*x_newton(i_step) + 30);
    subplot(1,2,1);
    plot(y,'g');
    hold on;
    plot(x,tangent,'color',colormtx(i_step,:));
    subplot(1,2,2);
    plot(1:i_step+1,2*x_newton(1:i_step+1).^2+4*x_newton(1:i_step+1) + 30); ylabel('Yval');xlabel('step');
end

suptitle('Quadratic, with linear approximation (tangent)');

    
% Okay, that works pretty well. 

% We can just use f'' instead of f' because everything will disappear (we
% don't get a line). But we could use f'' in our tangent formula. What
% happens then?

figure(2);
x_newton = zeros(1,nStep);
x_newton(1) = 100*rand;

for i_step = 1:nStep;
    x_newton(i_step+1) = x_newton(i_step) - ((2*x_newton(i_step).^2+4*x_newton(i_step) + 30) / (4*x_newton(i_step) + 4));
    
    tangent = (4*x_newton(i_step) + 4)*(x-x_newton(i_step)) +(4)*(x-x_newton(i_step))+ (2*x_newton(i_step).^2+4*x_newton(i_step) + 30);
    subplot(1,2,1);
    plot(y,'g');
    hold on;
    plot(x,tangent,'color',colormtx(i_step,:));
    subplot(1,2,2);
    plot(1:i_step+1,2*x_newton(1:i_step+1).^2+4*x_newton(1:i_step+1) + 30); ylabel('Yval');xlabel('step');
end

suptitle('Quadratic, with quadratic approximation?');

% Right, that clearly doesn't make sense, because it's not really a
% simplifcation if we end up with a derivative which is the same order as
% the original 


% Ok, let's try fdoing the same thing, for a cubic.

y = 2*x.^3+ 5*x.^2 + 4*x + 30;

figure(3);
x_newton = zeros(1,nStep);
x_newton(1) = 100*rand;

for i_step = 1:nStep;
    % this version uses first derivative
%     x_newton(i_step+1) = x_newton(i_step) - ((2*x_newton(i_step).^3+5*x_newton(i_step)^2 + 4*x_newton(i_step) + 30) / (6*x_newton(i_step)^2 + 10*x_newton(i_step) + 4));
    % this version subs in second instead of first. it fucks things up
    x_newton(i_step+1) = x_newton(i_step) - ((2*x_newton(i_step).^3+5*x_newton(i_step)^2 + 4*x_newton(i_step) + 30) / (12*x_newton(i_step) + 10));
    % this version subs in first derivative for original function, and
    % second for first.... it works very well. but this is actually finding
    % the minimum of the derivative function. they just happen to be the
    % same here!
    
    x_newton(i_step+1) = x_newton(i_step) - ((6*x_newton(i_step).^2+10*x_newton(i_step) + 4) / (12*x_newton(i_step) + 10));
    
    
    tangent = ((6*x_newton(i_step)^2 + 10*x_newton(i_step) + 4)*(x-x_newton(i_step))) + (12*x_newton(i_step)+10)*(x.^2-x_newton(i_step))+ (2*x_newton(i_step).^3+5*x_newton(i_step)^2+4*x_newton(i_step) + 30);
    
    subplot(1,2,1);
    plot(y,'g');
    hold on;
    plot(x,tangent,'color',colormtx(i_step,:));
    subplot(1,2,2);
    plot(1:i_step+1,(2*x_newton(1:i_step+1).^3+5*x_newton(i_step+1)^2+4*x_newton(i_step+1) + 30)); 
    ylabel('Yval');xlabel('step');
end

%% Repeat the above, but using symbolic math toolbox for a really complex function

nStep =25;
colormtx = [linspace(0,1,nStep)',zeros(nStep,1),ones(nStep,1)];

syms y(x);
y(x) = 2*x.^3-20*x.^2-4*x+exp(x)+42;

yDiff = diff(y);
yDiff2 = diff(yDiff);
yDiff3 = diff(yDiff2);

% Now x and y are both symbolic things

x               = -3:0.01:3;

figure(3);
x_newton = zeros(1,nStep);
x_newton(1) = rand;

for i_step = 1:nStep;
    % this version uses first derivative
%     x_newton(i_step+1) = x_newton(i_step) - ((2*x_newton(i_step).^3+5*x_newton(i_step)^2 + 4*x_newton(i_step) + 30) / (6*x_newton(i_step)^2 + 10*x_newton(i_step) + 4));
    % this version subs in second instead of first. it fucks things up
   
    % this is zero finding
%     x_newton(i_step+1) = x_newton(i_step) - y(x_newton(i_step)) / yDiff(x_newton(i_step));
    
    % this is minima finding
    x_newton(i_step+1) = x_newton(i_step) - yDiff(x_newton(i_step)) / yDiff2(x_newton(i_step));
    
    % what about using the second derivative for zero finding? doesn't work
    % well at all
    x_newton(i_step+1) = x_newton(i_step) - y(x_newton(i_step)) / yDiff2(x_newton(i_step));
    
      % does the third derivative give one jump for cubics?
    x_newton(i_step+1) = x_newton(i_step) - yDiff2(x_newton(i_step)) / yDiff3(x_newton(i_step));
    % nope, this finds the point where the second derivative is zero!
    
    tangent = yDiff(x_newton(i_step))*(x-x_newton(i_step)) + yDiff(x_newton(i_step));
    tangent = double(tangent); % convert out of symbolic
    
    subplot(1,3,1);
    plot(x,y(x),'g');
    hold on;
    plot(x,tangent,'color',colormtx(i_step,:));
    
    subplot(1,3,2);
    plot(1:i_step+1,double(y(x_newton(1:i_step+1)))); 
    ylabel('Yval');xlabel('step');
    
    subplot(1,3,3);
    plot(x,y(x),'g');
    hold on;scatter(x_newton(i_step),double(y(x_newton(i_step))),'MarkerEdgeColor',colormtx(i_step,:));
    ylabel('Yval');xlabel('step');

    
end


end






