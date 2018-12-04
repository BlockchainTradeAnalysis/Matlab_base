
file_name = 'tejdb_20181115175848.csv';
m = readtable(file_name,'Format','%s%f');
x = table2array(m(:,'time'));		% 在 0 到 2*pi 間，等分取 100 個點 
y = table2array(m(:,'close'));			% 計算 x 的正弦函數值

%MAValue：簡單移動平均值
disp(x);
disp(y);
Price = y;

Length = 5; %5 10 20 60日 
MAValue5=zeros(length(Price),1);
for i=Length:length(Price)
    MAValue5(i)=sum(Price(i-Length+1:i))/Length;
end
MAValue5(1:Length-1)=Price(1:Length-1);

Length = 10; %5 10 20 60日
MAValue10=zeros(length(Price),1);
for i=Length:length(Price)
    MAValue10(i)=sum(Price(i-Length+1:i))/Length;
end
MAValue10(1:Length-1)=Price(1:Length-1);

Length = 20; %5 10 20 60日
MAValue20=zeros(length(Price),1);
for i=Length:length(Price)
    MAValue20(i)=sum(Price(i-Length+1:i))/Length;
end
MAValue20(1:Length-1)=Price(1:Length-1);

Length = 60; %5 10 20 60日
MAValue60=zeros(length(Price),1);
for i=Length:length(Price)
    MAValue60(i)=sum(Price(i-Length+1:i))/Length;
end
MAValue60(1:Length-1)=Price(1:Length-1);

%plot(x,MAValue); % 進行二維平面描點作圖
%{
plot(1:2474,Price,'--sk',1:2474, MAValue5, '--or', 1:2474, MAValue10, '--xg' ,1:2474, MAValue20, '--+b',1:2474, MAValue60, '--*y'); 
set(gca,'xticklabel',[x(1),x(495),x(989),x(1483),x(1977),x(2474)])
%}
plot(1:2474,Price,'--sk',5:2474, MAValue5(5:2474), '--or', 10:2474, MAValue10(10:2474), '--xg' ,20:2474, MAValue20(20:2474), '--+b',60:2474, MAValue60(60:2474), '--*y'); 
set(gca,'xticklabel',[x(1),x(495),x(989),x(1483),x(1977),x(2474)]);
for i = 22 :length(Price)
    vertical_line = i; %第i天是買入或賣出訊號
    if MAValue5(i)>MAValue5(i-1) && MAValue5(i)>MAValue20(i) && MAValue5(i-1) > MAValue20(i-1) && MAValue5(i-2) <= MAValue20(i-2)
        pl_buy=line([vertical_line vertical_line], [0 6000]); %買入訊號
        pl_buy.Color = 'm';
        pl_buy.LineStyle = '-';
    elseif MAValue5(i)<MAValue5(i-1) && MAValue5(i)<MAValue20(i) && MAValue5(i-1) < MAValue20(i-1) && MAValue5(i-2) >= MAValue20(i-2)
        pl_sell=line([vertical_line vertical_line], [0 6000]); %賣出訊號
        pl_sell.Color = 'c';
        pl_sell.LineStyle = '-';
    end
end
%X1  X2       Y1 Y2
%{
            某天的五天均線會比前一天的五天均線高 &&  某天的五天均線會比某天的20天均線高  &&
            前一天的五天均線會比前一天的20天均線高 && 前前一天的五天均線會比前前一天的20天均線低 至少20+2天
SignalBuy = MA5(t)>MA5(t-1)&&MA5(t)>MA20(t) && MA5(t-1)>MA20(t-1)&&MA5(t-2)<=MA20(t-2)
SignalSell = MA5(t)<MA(t-1)&&MA5(t)<MA20(t) &&MA5(t-1)<MA20(t-1)&&MA5(t-2)>=MA20(t-2)
%}
