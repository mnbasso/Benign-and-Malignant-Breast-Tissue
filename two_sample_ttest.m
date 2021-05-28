function [T] = two_sample_ttest(Features,featnames,Label1,Label2,k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

disp('...Two-sample t-test');

if isstruct(Features) == 1
    Features = cell2mat((struct2cell(Features)))';
end
    

FSGS_Stats = (Features(Label1,:,k));
MN_Stats = (Features(Label2,:,k));
ttest = zeros(size(Features,2),2);

for i = 1:size(Features,2)
    
    [h,p] = ttest2(FSGS_Stats(:,i,k),MN_Stats(:,i,k),'Vartype','unequal');
    ttest(i,:,k) = cat(2, h, p);
    
end

featnames = cellstr(featnames);

%Ttest table
T = array2table(ttest(:,:,k),'VariableNames',{'Hypothesis Test Result','p-value'},'RowNames',featnames);

% Display table
disp(T);

end

