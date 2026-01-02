% build_dataTest.m 
% This script selects a battery dataset and generates the corresponding current–voltage figures

clc; clear; close all;

% Input: Battery set and number 
batterySet    = 2;   % 1 = 150919, 2 = 151007
batteryNumber = 12;   % example: 5 -> MAP1509191900000005

% Paths
codesFolder   = fileparts(mfilename("fullpath"));   % .../BattReuseData/_codes
projectFolder = fileparts(codesFolder);             % .../BattReuseData

dataRoot = fullfile(projectFolder, "_data");
figRoot  = fullfile(projectFolder, "_figures");

% Get CSV files automatically 
[battFolderPath, csvList] = getPFiles(dataRoot, batterySet, batteryNumber);

% Load + append all CSV parts 
t_all = []; i_all = []; v_all = []; step_all = [];
boundaries = [];

for k = 1:numel(csvList)
    [t,i,v,step] = loadTIV(csvList(k));

    t = t - t(1);

    if isempty(t_all)
        t_cont = t;
    else
        dt = median(diff(t_all), "omitnan");
        if isnan(dt), dt = 0; end
        t_cont = t + t_all(end) + max(dt,0);
        boundaries(end+1) = t_all(end); %#ok<AGROW>
    end

    t_all = [t_all; t_cont]; %#ok<AGROW>
    i_all = [i_all; i];      %#ok<AGROW>
    v_all = [v_all; v];      %#ok<AGROW>

    if ~isempty(step)
        step_all = [step_all; double(step)]; %#ok<AGROW>
    end
end

% Plot
fig = figure("Color","w");
tiledlayout(2,1,"TileSpacing","compact","Padding","compact");

nexttile; grid on; hold on;
plot(t_all, i_all, "LineWidth", 1);
for b = 1:numel(boundaries)
    xline(boundaries(b), "--", "P1 ends / P2 starts");
end
ylabel("Current (A)");
title("Current vs Time");

nexttile; grid on; hold on;
plot(t_all, v_all, "LineWidth", 1);
for b = 1:numel(boundaries)
    xline(boundaries(b), "--", "P1 ends / P2 starts");
end
xlabel("Time (s)");
ylabel("Voltage (V)");
title("Voltage vs Time");

figName = sprintf("Set%d_Batt%02d_IV.png", batterySet, batteryNumber);
exportgraphics(fig, fullfile(figRoot, figName), "Resolution", 300);

% Save as a MAT file
dataTest = struct();
dataTest(batterySet, batteryNumber).t = t_all;
dataTest(batterySet, batteryNumber).i = i_all;
dataTest(batterySet, batteryNumber).v = v_all;
dataTest(batterySet, batteryNumber).step = step_all;      % may be empty
dataTest(batterySet, batteryNumber).folder = battFolderPath;

save(fullfile(projectFolder,"dataTest.mat"), "dataTest", "-v7.3");

disp("Done.");
