function [t,i,v,step] = loadTIV(csvPath)
% Loads one CSV and returns time/current/voltage

    T = readtable(csvPath, "VariableNamingRule","preserve");
    names = lower(string(T.Properties.VariableNames));

    colV = find(contains(names,"voltage"), 1, "first");
    colI = find(contains(names,"current"), 1, "first");

    colT = find(contains(names,"total time"), 1, "first");
    if isempty(colT), colT = find(contains(names,"test time"), 1, "first"); end
    if isempty(colT), colT = find(strcmp(names,"time"), 1, "first"); end

    if isempty(colV) || isempty(colI) || isempty(colT)
        error("Missing Voltage/Current/Time column in %s", csvPath);
    end

    v = T{:,colV};
    i = T{:,colI};

    rawT = T{:,colT};
    t = toSeconds(rawT);

    % Step column
    step = [];
    colStep = find(contains(names,"step") & ~contains(names,"time"), 1, "first");
    if ~isempty(colStep)
        step = T{:,colStep};
    end
end

function tsec = toSeconds(x)
    if isnumeric(x)
        tsec = double(x);
        return;
    end
    if isduration(x)
        tsec = seconds(x);
        return;
    end
    tsec = seconds(duration(string(x)));
end
