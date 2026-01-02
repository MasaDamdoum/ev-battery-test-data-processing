function [folderPath, csvList] = getPFiles(dataRoot, batterySet, batteryNumber)

% - Finds the battery folder by searching _data 
% - Finds P1 and P2 CSVs in the subfolders
% - Returns csvList in correct order: P1 then P2

    % Defining 1 and 2 for either of the two datasets
    if batterySet == 1
        setCode = "150919";
    elseif batterySet == 2
        setCode = "151007";
    else
        error("batterySet must be 1 or 2");
    end

    % finds the battery folder by pattern and trailing number
    patt = "MAP" + setCode + "19*";
    d = dir(fullfile(dataRoot, patt));
    d = d([d.isdir]);

    if isempty(d)
        error("No folders found matching %s in %s", patt, dataRoot);
    end

    bn_plain = string(batteryNumber);                 % "5"
    bn_2     = sprintf("%02d", batteryNumber);        % "05"
    bn_8     = sprintf("%08d", batteryNumber);        % "00000005"

    match = false(size(d));
    for k = 1:numel(d)
        nm = string(d(k).name);
        match(k) = endsWith(nm, bn_plain) || endsWith(nm, bn_2) || endsWith(nm, bn_8);
    end

    if ~any(match)
        error("Couldn't find battery folder ending with %s / %s / %s", bn_plain, bn_2, bn_8);
    end

    % If multiple matches exist, take the first
    folderPath = fullfile(dataRoot, d(find(match,1,'first')).name);

    % finds P1 and P2 CSVs
    files = dir(fullfile(folderPath, "**", "*.csv"));
    if isempty(files)
        error("No CSV files found inside: %s", folderPath);
    end

    fulls = string(fullfile({files.folder}, {files.name}));

    % pick P1 and P2 
    isP1 = contains(lower(fulls), "p1");
    isP2 = contains(lower(fulls), "p2");

    p1 = fulls(find(isP1,1,'first'));
    p2 = fulls(find(isP2,1,'first'));

    if strlength(p1)==0 || strlength(p2)==0
        error("Could not find both P1 and P2 CSV files inside: %s", folderPath);
    end

    csvList = [p1; p2];  % enforces order: P1 then P2
end
