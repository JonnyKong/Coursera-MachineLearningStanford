function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
m = length(yval);


for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions

    true_pos = 0;
    false_neg = 0;
    false_pos = 0;
    
    for i = 1 : m
        if(pval(i) < epsilon)
            if(yval(i) == 1)
                true_pos = true_pos + 1;
            else
                false_pos = false_pos + 1;
            end
        elseif(yval(i) == 1)
            false_neg = false_neg + 1;
        end
    end
    
    p = true_pos / (true_pos + false_pos);
    r = true_pos / (true_pos + false_pos);
    F1 = (2 * p * r) / (p + r);

    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
