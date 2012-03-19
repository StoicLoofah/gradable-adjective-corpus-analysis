function []=findBestSplit2way(data, theory)

best = 0;

for i=-1:.001: 1
    cur_best = 0;
    for j=1:size(data,1)
        for k=1:size(data, 2)
            if theory(j,k) > 0
                if data(j,k) >= i
                    cur_best = cur_best + 1;
                end
            elseif theory(j,k) == 0
                if data(j,k) <= i
                    cur_best = cur_best + 1;
                end
            else
                display('ERROR');
            end
        end
    end
    if cur_best > best
        best = cur_best;
        display(['best is ' num2str(i) ' with ' num2str(best) ' correct.']);
    end
end