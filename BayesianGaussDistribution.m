


Dim_1() % for one dimension

function Dim_1()
    [X,y] = generate_data(20,1);
    [mu,covar] = fit(X,y);
 
    w = (covar)*(mu(1)-mu(2));
    b = 0.5*(mu(2)'*(covar)*mu(2) - mu(1)'*(covar)*mu(1));
    f = @(x) w(1)*x + b(1);
    hold on
    scatter(-10:9,X(y==1))
    scatter(-10:9,X(y==2))
    plot(-10:9,f(-10:9))
    hold off
end

function [mu,covaryans]=fit_2(X,y)
    mu = [mean(X(y==1,:,:)) mean(X(y==2,:,:))];
    covaryans =cov(X);
end

function [mu,cov] = fit(X,y)
    
n_classes = max(y);
mu = zeros(size(X,2),n_classes);
cov = zeros(size(X,2),size(X,2));%1,n_classes);

for i = 1:n_classes
    Xc = X(y==i);
    mu_c = mean(Xc,1);
    mu(i) = mu_c;
   
    cov_c = zeros(size(X,2),size(X,2));
    for j = 1:size(Xc,1)
        a = Xc(j)';
        b = Xc(j);
        cov_ci = a*b;
        cov_c = cov_c + cov_ci;       
    end
    cov_c = cov_c/size(X,1);
    cov(i) = cov_c;
end
end


function [X,y] = generate_data(data_number,feature_number)
     X = zeros(data_number*12,feature_number);
        y = zeros(data_number*2,1);
        mean_ = [-10 10];
        count = 1;
        for k = 1:feature_number           
            for i= 1:2
                vector = normrnd(mean_(i),1,data_number,feature_number);
                nor = norm(vector);
                unit_vector = vector / nor;
                for j = 1:20
                    X(count,k) = unit_vector(j);
                    y(count) = i; 
                    count = count + 1;
                end
            end
            count=1;
        end    
end
