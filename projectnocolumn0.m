data = xlsread('ad.data.xlsx');
datanonan = data(~any(isnan(data),2),:);
column =  size(datanonan,2);
eing = 0;
for i=1:column 
    if(datanonan(:,i)==0)
        display(i)
    else 
       if(eing==0)
           datanonan0=datanonan(:,i);
           eing=1;
       else
           datanonan0=[datanonan0,datanonan(:,i)];
       end
    end
end

idx = ( datanonan(:,column)==1 );
dataad = datanonan(idx,:);
idx = ( datanonan(:,column)==0 );
datanoad = datanonan(idx,:);
rowad = size(dataad,1);
rownoad = size(datanoad,1);
k = randperm(rownoad);
datanoad2 = datanoad(k(1:rowad),:);


data = [dataad;datanoad2]; %success data



cp_KNN = classperf(data(:,1559));
cp_SVM = classperf(data(:,1559));
test = crossvalind('holdOut',data(:,1559),0.7);
train = ~test;    

%///////////////////////////////KNN//////////////////////////////////////
nub=0;
class_KNN = knnclassify(data(test,1:1558),data(train,1:1558),data(train,1559),5);
%classperf( cp_KNN,class_KNN,test);  
%cp_KNN.CorrectRate ;
        for n=1:(sum(test(:,1)==1)/2)
             if(class_KNN(n,1)==0)
                 buffer=1;
                 count=0;
                 while(buffer<=n) 
                     if (test(count+1,1)==1)
                         buffer=buffer+1;
                     end
                     count=count+1;
                 end
                 if(nub==0)
                 wrongpoint_KNN=data(count,1:1559);
                 nub=1;
                 else  wrongpoint_KNN=[wrongpoint_KNN;data(count,1:1559)];
                 end
             end   
         end
         
         for n=fix(sum(test(:,1)==1)/2+1):sum(test(:,1)==1)
             if(class_KNN(n,1)==1)
                 buffer=1;
                 count=0;
                 while(buffer<=n) 
                     if (test(count+1,1)==1)
                         buffer=buffer+1;
                     end
                     count=count+1;
                 end
                 if(nub==0)
                 wrongpoint_KNN=data(count,1:1559);
                 nub=1;
                 else  wrongpoint_KNN=[wrongpoint_KNN;data(count,1:1559)];
                 end
             end                 
         end

percent_KNN=[1-size(wrongpoint_KNN,1)/size(class_KNN,1),size(wrongpoint_KNN,1)/size(class_KNN,1)]*100



%//////////////////////////////SVM//////////////////////////////////////  

nub=0;
svmStruct = svmtrain(data(train,1:1558),data(train,1559),'kernel_function',...
    'rbf','boxconstraint',1); 
class_SVM = svmclassify(svmStruct,data(test,1:1558));
%classperf(cp_SVM,class_SVM,test);
%cp_SVM.CorrectRate;
        for n=1:(sum(test(:,1)==1)/2)
            if(class_SVM(n,1)==0)
                buffer=1;
                count=0;
                while(buffer<=n) 
                    if (test(count+1,1)==1)
                        buffer=buffer+1;
                    end
                    count=count+1;
                end
                if(nub==0)
                wrongpoint_SVM=data(count,1:1559);
                nub=1;
                else  wrongpoint_SVM=[wrongpoint_SVM;data(count,1:1559)];
                end
            end         
        end

        for n=fix(sum(test(:,1)==1)/2+1):sum(test(:,1)==1)
            if(class_KNN(n,1)==1)
                buffer=1;
                count=0;
                while(buffer<=n) 
                    if (test(count+1,1)==1)
                        buffer=buffer+1;
                    end
                    count=count+1;
                end
                if(nub==0)
                wrongpoint_SVM=data(count,1:1559);
                nub=1;
                else  wrongpoint_SVM=[wrongpoint_SVM;data(count,1:1559)];
                end
            end         
        end


percent_SVM=[1-size(wrongpoint_SVM,1)/size(class_SVM,1),size(wrongpoint_SVM,1)/size(class_SVM,1)]*100



idx = ( datanonan0(:,1431)==1 );
dataad0 = datanonan0(idx,:);
idx = ( datanonan0(:,1431)==0 );
datanoad0 = datanonan0(idx,:);
datanoad20 = datanoad0(k(1:rowad),:);


data2 = [dataad0;datanoad20]; %success data

%///////////////////////////////KNN//////////////////////////////////////
nub=0;
class_KNN2 = knnclassify(data2(test,1:1430),data2(train,1:1430),data2(train,1431),5);
%classperf( cp_KNN,class_KNN,test);  
%cp_KNN.CorrectRate ;
        for n=1:(sum(test(:,1)==1)/2)
             if(class_KNN2(n,1)==0)
                 buffer=1;
                 count=0;
                 while(buffer<=n) 
                     if (test(count+1,1)==1)
                         buffer=buffer+1;
                     end
                     count=count+1;
                 end
                 if(nub==0)
                 wrongpoint_KNN2=data2(count,1:1431);
                 nub=1;
                 else  wrongpoint_KNN2=[wrongpoint_KNN2;data2(count,1:1431)];
                 end
             end   
         end
         
         for n=fix(sum(test(:,1)==1)/2+1):sum(test(:,1)==1)
             if(class_KNN2(n,1)==1)
                 buffer=1;
                 count=0;
                 while(buffer<=n) 
                     if (test(count+1,1)==1)
                         buffer=buffer+1;
                     end
                     count=count+1;
                 end
                 if(nub==0)
                 wrongpoint_KNN2=data2(count,1:1431);
                 nub=1;
                 else  wrongpoint_KNN2=[wrongpoint_KNN2;data2(count,1:1431)];
                 end
             end                 
         end

percent_KNN2=[1-size(wrongpoint_KNN2,1)/size(class_KNN2,1),size(wrongpoint_KNN2,1)/size(class_KNN2,1)]*100



%//////////////////////////////SVM//////////////////////////////////////  

nub=0;
svmStruct = svmtrain(data2(train,1:1430),data2(train,1431),'kernel_function',...
    'rbf','boxconstraint',1); 
class_SVM2 = svmclassify(svmStruct,data2(test,1:1430));
%classperf(cp_SVM,class_SVM,test);
%cp_SVM.CorrectRate;
        for n=1:(sum(test(:,1)==1)/2)
            if(class_SVM2(n,1)==0)
                buffer=1;
                count=0;
                while(buffer<=n) 
                    if (test(count+1,1)==1)
                        buffer=buffer+1;
                    end
                    count=count+1;
                end
                if(nub==0)
                wrongpoint_SVM2=data2(count,1:1431);
                nub=1;
                else  wrongpoint_SVM2=[wrongpoint_SVM2;data2(count,1:1431)];
                end
            end         
        end

        for n=fix(sum(test(:,1)==1)/2+1):sum(test(:,1)==1)
            if(class_KNN2(n,1)==1)
                buffer=1;
                count=0;
                while(buffer<=n) 
                    if (test(count+1,1)==1)
                        buffer=buffer+1;
                    end
                    count=count+1;
                end
                if(nub==0)
                wrongpoint_SVM2=data2(count,1:1431);
                nub=1;
                else  wrongpoint_SVM2=[wrongpoint_SVM2;data2(count,1:1431)];
                end
            end         
        end


percent_SVM2=[1-size(wrongpoint_SVM2,1)/size(class_SVM2,1),size(wrongpoint_SVM2,1)/size(class_SVM2,1)]*100
