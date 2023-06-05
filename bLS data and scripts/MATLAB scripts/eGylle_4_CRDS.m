%% Script to import NH3 from Picarro analyzer
% JK January 2022
% Wind tunnel and bLS comparison measurements in Foulum January 2022
%
% 4th measurement

cd 'C:\Users\AU323818\Dropbox\MatLab\Analyser\eGylle 1st 21'

% CRDS #1: Background (G2103)
% CRDS #2: Plot (G2103)


clear

tic

LOAD_SWITCH = 0; % Read in data from dat-files: 0 = NO, 1 = YES
PLOT_SWITCH_basic = 0; % Plot: 0 = NO, 1 = YES
EMIS_CAL = 1;
PLOT_SWITCH = 0; % Plot: 0 = NO, 1 = YES
PLOT_SWITH_COMP = 1;
SAVE_FIG = 0;

PATH = 'C:\Users\AU323818\Dropbox\Uni\eGylle\4th trial Jan22\bLS data';
foldout = 'C:\Users\AU323818\Dropbox\Uni\eGylle\4th trial Jan22\Figures';


if LOAD_SWITCH == 1

    %% Load CRDS 2 Field
    %========================================================================%
    %========================================================================%

    CRDS_field = [];
    datafiles=recursivedir('C:\Users\AU323818\Dropbox\Uni\eGylle\4th trial Jan22\CRDS2_plot','*.dat');

    opts = delimitedTextImportOptions("NumVariables", 27);

    opts.DataLines = [2, Inf];
    opts.Delimiter = " ";

    opts.VariableNames = ["DATE", "TIME", "FRAC_DAYS_SINCE_JAN1", "FRAC_HRS_SINCE_JAN1", "JULIAN_DAYS", "EPOCH_TIME", "ALARM_STATUS", "INST_STATUS", "CavityPressure", "CavityTemp", "DasTemp", "EtalonTemp", "WarmBoxTemp", "species", "MPVPosition", "InletValve", "OutletValve", "solenoid_valves", "NH3_Raw", "NH3_30s", "NH3_2min", "NH3_5min", "H2O", "NH3_dry", "NH3_uncorrected", "NH3_broadeningCorrected", "peak15"];
    opts.VariableTypes = ["datetime", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    opts.ConsecutiveDelimitersRule = "join";
    opts.LeadingDelimitersRule = "ignore";

    opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
    opts = setvaropts(opts, "TIME", "InputFormat", "HH:mm:ss.SSS");

    for o = 1:length(datafiles)
        %extract date and time from filename
        [versn, name, ext] = fileparts(datafiles{o});
        filename=datafiles{o};

        disp(versn) % Print to check name

        fileID = fopen(filename,'r');
        CRDS_field_loop = readtable(filename, opts);
        fclose(fileID);
        fclose('all');

        % Remove variables not used
        CRDS_field_loop(:,{'FRAC_DAYS_SINCE_JAN1', 'FRAC_HRS_SINCE_JAN1', 'JULIAN_DAYS', 'EPOCH_TIME', 'INST_STATUS', 'DasTemp', 'EtalonTemp', 'WarmBoxTemp', 'species', 'MPVPosition', 'OutletValve', 'solenoid_valves', 'peak15', 'InletValve', 'NH3_30s', 'NH3_2min'}) = [];

        CRDS_field = [CRDS_field; CRDS_field_loop];

    end

    % Clear temporary variables
    clear opts ext name o versn datafiles CRDS_field_loop ans fileID filename

    %% Load CRDS 1 Background

    %========================================================================%
    %========================================================================%
    CRDS_bg = [];
    datafiles=recursivedir('C:\Users\AU323818\Dropbox\Uni\eGylle\4th trial Jan22\CRDS1_bg','*.dat');

    opts = delimitedTextImportOptions("NumVariables", 27);

    opts.DataLines = [2, Inf];
    opts.Delimiter = " ";

    opts.VariableNames = ["DATE", "TIME", "FRAC_DAYS_SINCE_JAN1", "FRAC_HRS_SINCE_JAN1", "JULIAN_DAYS", "EPOCH_TIME", "ALARM_STATUS", "INST_STATUS", "CavityPressure", "CavityTemp", "DasTemp", "EtalonTemp", "WarmBoxTemp", "species", "MPVPosition", "InletValve", "OutletValve", "solenoid_valves", "NH3_Raw", "NH3_30s", "NH3_2min", "NH3_5min", "H2O", "NH3_dry", "NH3_uncorrected", "NH3_broadeningCorrected", "peak15"];
    opts.VariableTypes = ["datetime", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];

    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    opts.ConsecutiveDelimitersRule = "join";
    opts.LeadingDelimitersRule = "ignore";

    opts = setvaropts(opts, "DATE", "InputFormat", "yyyy-MM-dd");
    opts = setvaropts(opts, "TIME", "InputFormat", "HH:mm:ss.SSS");


    for o = 1:length(datafiles)
        %extract date and time from filename
        [versn, name, ext] = fileparts(datafiles{o});
        filename=datafiles{o};

        disp(versn) % Print to check name

        fileID = fopen(filename,'r');
        CRDS_bg_loop = readtable(filename, opts);
        fclose(fileID);
        fclose('all');

        % Remove variables not used
        CRDS_bg_loop(:,{'FRAC_DAYS_SINCE_JAN1', 'FRAC_HRS_SINCE_JAN1', 'JULIAN_DAYS', 'EPOCH_TIME', 'INST_STATUS', 'DasTemp', 'EtalonTemp', 'WarmBoxTemp', 'species', 'MPVPosition', 'OutletValve', 'solenoid_valves', 'peak15', 'InletValve', 'NH3_30s', 'NH3_2min'}) = [];

        CRDS_bg = [CRDS_bg; CRDS_bg_loop];

        %   Clear temporary variables
        clearvars filename fileID;

    end

    % Clear temporary variables
    clear opts ext name o versn datafiles CRDS_bg_loop ans fileID filename

    %% Adjust time and apply calibration to concentration - and change all concentrations to ug/m3
    %% Adjust time
    % TIME CORRECTION for CRDS #1 background: + 0 sec
    % TIME CORRECTION for CRDS #2 field:  + 58 min, 20 sec

    Time_bg = CRDS_bg.DATE + timeofday(CRDS_bg.TIME) + seconds(0);
    Time_bg.Format = 'dd.MM.uuuu HH:mm:ss:SSS';
    CRDS_bg.Time = Time_bg;

    Time_field = CRDS_field.DATE + timeofday(CRDS_field.TIME) + minutes(58) + seconds(20);
    Time_field.Format = 'dd.MM.uuuu HH:mm:ss:SSS';
    CRDS_field.Time = Time_field;

    clear Time_bg Time_field


    % % CHANGE CALIBRATION!!

    % CRDS 1 (background) = Good calibration in lab
    % CRDS 2 (field) = Too high, needs to be corrected by slope = NH3/1.0717

    % CALIBRATION APPLIED and concentration changed to ug/m3
    % CRDS #2 need correction for H2O

    CRDS_field.NH3_ug = (CRDS_field.NH3_Raw - 0.0) ./ 1.1123 *0.0409*17.031;

    CRDS_bg.NH3_ug = (CRDS_bg.NH3_Raw - 0.0) ./ 1.00 * 0.0409*17.031;

    save('WTbLS_CRDS_field_4th.mat', 'CRDS_field');
    save('WTbLS_CRDS_bg_4th.mat', 'CRDS_bg');

    TT_temp_CRDS = timetable(CRDS_field.Time, CRDS_field.NH3_ug, 'VariableNames',{'NH3'});
    TT_temp_CRDS_bg = timetable(CRDS_bg.Time, CRDS_bg.NH3_ug, 'VariableNames',{'NH3_bg'});

    TT_CRDS = synchronize(TT_temp_CRDS, TT_temp_CRDS_bg);

    newTimes = [datetime('2022-01-04 15:00:00'):minutes(30):datetime('2022-01-14 09:00:00')];
    TT_CRDS = retime(TT_CRDS, newTimes, 'mean');
    TT_CRDS = rmmissing(TT_CRDS);

    clearvars TT_temp_CRDS TT_temp_CRDS_bg newTimes TT_temp_CRDS_CH4bg

    save('WTbLS_TT_CRDS_4th.mat', 'TT_CRDS');

    %% Weather
    % Rain
    opts = delimitedTextImportOptions("NumVariables", 3);

    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";

    % Specify column names and types
    opts.VariableNames = ["Raingauge", "Time", "Event"];
    opts.VariableTypes = ["double", "datetime", "double"];
    opts = setvaropts(opts, 2, "InputFormat", "yyyy-MM-dd HH:mm:ss.S");
    opts = setvaropts(opts, [1, 3], "DecimalSeparator", ",");
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    % Import the data
    rain = readtable("C:\Users\AU323818\Dropbox\Uni\eGylle\4th trial Jan22\Raingauge.txt", opts);

    % Clear temporary variables
    clear opts

    rain.mm = rain.Event/2;

    TT_rain = table2timetable(rain);

    newTimes = [datetime('2022-01-04 15:00:00'):minutes(30):datetime('2022-01-14 09:00:00')];
    TT_rain = retime(TT_rain, newTimes, 'sum');

    TT_rain.sum_mm = cumsum(TT_rain.mm);
    TT_rain(:,1:2) = [];

    save('WTbLS_TT_rain_4th.mat', 'TT_rain')
    %% Foulum weather station
    opts = delimitedTextImportOptions("NumVariables", 18);
    
    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";
    
    % Specify column names and types
    opts.VariableNames = ["station", "date", "time", "prec", "surfwet", "glorad", "TempAir", "TempGrass", "Temp10cm", "Temp30cm", "RH", "WD10", "WS10", "wd2", "wv2", "pres", "netrad", "heatflux"];
    opts.VariableTypes = ["double", "datetime", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
    opts = setvaropts(opts, 2, "InputFormat", "dd-MM-yyy");
    opts = setvaropts(opts, 3, "InputFormat", "H");
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % Import the data
    VejrFoulum = readtable("C:\Users\AU323818\Dropbox\Uni\eGylle\4th trial Jan22\VejrFoulum.csv", opts);
    
    VejrFoulum.TIME = VejrFoulum.date + timeofday(VejrFoulum.time) + hours(1);
    VejrFoulum.TIME.Format = 'dd-MM-yyyy HH:mm:ss.SSS';
    
    TT_VejrFoulum = table2timetable(VejrFoulum,'RowTimes',VejrFoulum.TIME);
    TT_VejrFoulum(:,[1:3, 19]) = [];
    
    clear opts
    
    TT_Vejr = rmmissing(synchronize(TT_rain, TT_VejrFoulum));
    
    save('WTbLS_Vejr_4st.mat', 'TT_Vejr')
    writetimetable(TT_Vejr, [PATH, '\eGylle_4_Vejr.txt'], 'Delimiter','tab')
    
    % Nedbør, mm; Precipitation
    % Overfladefugtighed, minutter; Leaf wetness
    % Globalstråling, W/m2; Global radiation
    % Lufttemperatur - timemiddel, °C;  Air temperature - hour mean
    % Græstemperatur - timemiddel, °C; Grass temperature - hour mean
    % Jordtemperatur i 10 cm - timemiddel, °C;  Soil temperature 10cm - hour mean
    % Jordtemperatur i 30 cm - timemiddel, °C; Soil temperature 30cm - hour mean
    % Relativ luftfugtighed - timemiddel; Relative humidity - hour mean
    % Vindretning i 10 m - timemiddel, grader; Wind direction at 10 m - hour mean
    % Vindhastighed i 10 m - timemiddel, m/s; Wind velocity at 10 m - hour mean
    % Lufttryk, hPa; % Air pressure
    % Nettostråling; Net radiation
    % Jordvarmeflux; Soil heat flux
    
    % http://agro-web01t.uni.au.dk/klimadb/

else
    load('WTbLS_CRDS_field_4th.mat')
    load('WTbLS_CRDS_bg_4th.mat')
    load('WTbLS_TT_CRDS_4th.mat')
    load('WTbLS_TT_rain_4th.mat')
    load('WTbLS_Vejr_4st.mat')
end


if LOAD_SWITCH == 1
    %% Load bLS results

    opts = delimitedTextImportOptions("NumVariables", 59);

    opts.DataLines = [2, Inf];
    opts.Delimiter = ";";

    opts.VariableNames = ["rn", "Sensor", "Source", "SensorHeight", "SourceArea", "CE", "CE_se", "CE_lo", "CE_hi", "uCE", "uCE_se", "uCE_lo", "uCE_hi", "vCE", "vCE_se", "vCE_lo", "vCE_hi", "wCE", "wCE_se", "wCE_lo", "wCE_hi", "N_TD", "TD_Time_avg", "TD_Time_max", "Max_Dist", "UCE", "Ustar", "L", "Zo", "sUu", "sVu", "sWu", "z_sWu", "WD", "d", "N0", "MaxFetch", "st", "et", "Sonic", "Time", "SH", "UST", "sigW", "sigU", "sigV", "WS", "airT", "Pair", "kv", "A", "alpha", "bw", "C0", "Flag_Ustar005", "Flag_Ustar01", "Flag_Ustar015", "Flag_L10", "Flag_L2"];
    opts.VariableTypes = ["double", "categorical", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "datetime", "datetime", "categorical", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "categorical", "categorical", "categorical", "categorical", "categorical"];

    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";

    opts = setvaropts(opts, ["Sensor", "Source", "Sonic", "Flag_Ustar005", "Flag_Ustar01", "Flag_Ustar015", "Flag_L10", "Flag_L2"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "st", "InputFormat", "yyyy-MM-dd HH:mm:ss");
    opts = setvaropts(opts, "et", "InputFormat", "yyyy-MM-dd HH:mm:ss");
    opts = setvaropts(opts, "Time", "InputFormat", "dd-MMM-yyyy HH:mm:ss");

    % Import the data
    WTbLS_1 = readtable("C:\Users\AU323818\Dropbox\Uni\eGylle\4th trial Jan22\bLS data\WT_bLS_4th.csv", opts);

    WTbLS_CRDS = WTbLS_1(WTbLS_1.Sensor == "CRDS", :);
    WTbLS_BG = WTbLS_1(WTbLS_1.Sensor == "BG", :);

    clear opts

    TT_bLS_1 = table2timetable(WTbLS_CRDS, 'RowTimes', WTbLS_CRDS.Time);

    Del_col = [1:3, 40:41, 55:59];
    TT_bLS_1(:,Del_col) = [];
    TT_bLS_1.Properties.DimensionNames{1} = 'Time';


    TT_bLS_1_BG = table2timetable(WTbLS_BG, 'RowTimes', WTbLS_CRDS.Time);

    Del_col = [1:3, 40:41, 55:59];
    TT_bLS_1_BG(:,Del_col) = [];
    TT_bLS_1_BG.Properties.DimensionNames{1} = 'Time';

    TT_bLS = synchronize(TT_bLS_1, TT_CRDS);
    TT_bLS_BG = synchronize(TT_bLS_1_BG, TT_CRDS);

    save('WTbLS_TT_bLS_4th.mat', 'TT_bLS')
    save('WTbLS_TT_bLS_BG_4th.mat', 'TT_bLS_BG')

    clearvars WTbLS_1 Del_col TT_bLS_1 CRDS_bg CRDS_field TT_CRDS TT_EC ix_nan
else
    load('WTbLS_TT_bLS_4th.mat')
    load('WTbLS_TT_bLS_BG_4th.mat')
end

if EMIS_CAL == 1 %% Emission estimates and flags

    TT_bLS.emis_NH3 = (TT_bLS.NH3 - TT_bLS.NH3_bg) ./ TT_bLS.CE;

    FLAG_UST005 = TT_bLS.Ustar > 0.05;
    FLAG_UST15 = TT_bLS.Ustar > 0.15;

    FLAG_L2 = abs(TT_bLS.L) > 2;
    FLAG_L10 = abs(TT_bLS.L) > 10;

    FLAG_sigU = TT_bLS.sUu < 4.5;
    FLAG_sigV = TT_bLS.sVu < 4.5;

    FLAG_C0 = TT_bLS.C0 < 10;

    % disp((height(TT_bLS)-[sum(FLAG_UST005) sum(FLAG_UST15) sum(FLAG_L2) sum(FLAG_L10) sum(FLAG_sigU) sum(FLAG_sigV) sum(FLAG_C0)])/height(TT_bLS)*100)

    FLAG_hard = and(FLAG_UST15,FLAG_L10); % L10 and UST > 0.15
    FLAG_soft = and(FLAG_UST005,FLAG_L2); % L2 and UST > 0.05
    FLAG_BUH = and(and(and(and(FLAG_UST005, FLAG_L2),FLAG_sigU), FLAG_sigV),FLAG_C0); % UST > 0.05, L2, sigU < 4.5, sigV < 4.5, C0 < 10 - from Bühler et al., 2021

    % disp((height(TT_bLS)-[sum(FLAG_hard) sum(FLAG_soft) sum(FLAG_BUH)])/height(TT_bLS)*100)

    TT_bLS.emis_NH3_soft = TT_bLS.emis_NH3;
    TT_bLS.emis_NH3_hard = TT_bLS.emis_NH3;
    TT_bLS.emis_NH3_BUH = TT_bLS.emis_NH3;

    TT_bLS.emis_NH3_soft(~FLAG_soft) = NaN;
    TT_bLS.emis_NH3_hard(~FLAG_hard) = NaN;
    TT_bLS.emis_NH3_BUH(~FLAG_BUH) = NaN;

    save('WTbLS_TT_bLS_4th.mat', 'TT_bLS')
else
    load('WTbLS_TT_bLS_4th.mat')
end

    %% Gap filling, Averages and TAN
    Time_Lim7 = [datetime(2022,01,05,14,0,0), datetime(2022,01,12,14,0,0)];


    
    TT_bLS.emis_NH3_soft_gap = fillmissing(TT_bLS.emis_NH3_soft,'linear');
    TT_bLS.emis_NH3_hard_gap = fillmissing(TT_bLS.emis_NH3_hard, 'linear');
    TT_bLS.emis_NH3_BUH_gap = fillmissing(TT_bLS.emis_NH3_BUH, 'linear');

    disp('Average Flag soft and gap filling')
    disp([nanmean(TT_bLS.emis_NH3_soft(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))) nanmean(TT_bLS.emis_NH3_soft_gap(TT_bLS.Time > Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)))])

    disp('Average Flag hard and gap filling')
    disp([nanmean(TT_bLS.emis_NH3_hard(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))) nanmean(TT_bLS.emis_NH3_hard_gap(TT_bLS.Time > Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)))])

    disp('Average Flag Bühler and gap filling - 7 days')
    disp([nanmean(TT_bLS.emis_NH3_BUH(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))) nanmean(TT_bLS.emis_NH3_BUH_gap(TT_bLS.Time > Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)))])

    disp('Cumulated rain fall - 7 days')
    disp(sum(rmmissing(TT_rain.mm(TT_rain.Time >= Time_Lim7(1) & TT_rain.Time < Time_Lim7(2)))))

    disp('Avg temp - 7 days')
    disp(nanmean(TT_bLS.airT(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))))

    disp('Avg WS - 7 days')
    disp(nanmean(TT_bLS.WS(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))))

    % Loss of TAN - 7 days after application
    % kg ammonium-N pr ton (TAN) = 1.72 g/kg
    % 35.9 ton slurry/ha
    % DM = ?? %
    % Total N = ?? g/kg
    TAN_slurry = 35.9 * 1.72E5 * 17.031 / 14.0067; % Basis for TAN er N mens flux er NH3

    TAN_sotf = cumsum(TT_bLS.emis_NH3_soft(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))*1800/(TAN_slurry)*100, 'omitnan');
    TAN_sotf_gap = cumsum(TT_bLS.emis_NH3_soft_gap(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))*1800/(TAN_slurry)*100, 'omitnan');

    TAN_hard = cumsum(TT_bLS.emis_NH3_hard(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))*1800/(TAN_slurry)*100, 'omitnan');
    TAN_hard_gap = cumsum(TT_bLS.emis_NH3_hard_gap(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))*1800/(TAN_slurry)*100, 'omitnan');

    TAN_BUH = cumsum(TT_bLS.emis_NH3_BUH(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))*1800/(TAN_slurry)*100, 'omitnan');
    TAN_BUH_gap = cumsum(TT_bLS.emis_NH3_BUH_gap(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))*1800/(TAN_slurry)*100, 'omitnan');

    % OBS: Limited to 7 days after application for gap
    disp('TAN loss: soft, soft gap')
    disp([TAN_sotf(end) TAN_sotf_gap(end)])

    disp('TAN loss: hard, hard gap')
    disp([TAN_hard(end) TAN_hard_gap(end)])

    disp('TAN loss: BUH,    BUH gap')
    disp([TAN_BUH(end) TAN_BUH_gap(end)])

    disp('Removed data (%)')
    disp(100-size(rmmissing(TT_bLS.emis_NH3_BUH))/size(TT_bLS.emis_NH3_BUH)*100)

    TT_bLS.TAN = nan(height(TT_bLS),1);
%     TT_bLS.TAN = zeros(height(TT_bLS),1);
    TT_bLS.TAN(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)) = cumsum(TT_bLS.emis_NH3_BUH_gap(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))*1800/(TAN_slurry)*100, 'omitnan');


ii = 2;

%%

if PLOT_SWITCH == 1
    TimeLim = [datetime('2022-01-04 15:00:00'), datetime('2022-01-14 09:00:00')];

    ii = 50;

    x_stairs = TT_bLS.Time;
    y_stairs = [TT_bLS.emis_NH3_BUH];

    fig50=figure(ii);
    stairs(x_stairs, y_stairs,'LineWidth',1)
    grid minor
    ylabel('NH_3 flux [\mug m^{-2} s^{-1}]')
    xlabel('Time')
    xlim(TimeLim)
    datetick('x','mmm dd HH:MM','keepticks')
    ii = ii + 1;

    if SAVE_FIG == 1
        FigFileName = 'NH3_Emis_4th';
        fullFileName = fullfile(foldout, FigFileName);
        fig50 = gcf;
        fig50.PaperUnits = 'centimeters';
        fig50.PaperPosition = [0 0 19 11];
        print(fullFileName,'-dpng','-r800')
    end

    %%
    SizeOfFont = 11;
    SizeOfFontLgd = 10;

    fig51=figure(ii);
    subplot(5,1,[1:2])
    stairs(x_stairs, y_stairs,'LineWidth',1)
    grid minor
    yline(0)
    ylabel({'NH_3 emission', '(\mug m^{-2} s^{-1})'}, 'FontSize',SizeOfFont)
    legend( 'NH_3 emission', 'FontSize',SizeOfFontLgd)
    xlim(TimeLim)
    ylim([-0.4 28])

    subplot(5,1,3)
    bar(TT_rain.Time, TT_rain.mm);
    ylabel({'Precipitation', '(mm hr^{-1})'},'FontSize',SizeOfFont, 'color','k')
    legend({'Precipitation'}, 'FontSize',SizeOfFontLgd)
    grid minor
    xlim(TimeLim)
    ylim([0 1.8])

    subplot(5,1,4)
    plot(TT_bLS.Time, TT_bLS.WS)
    ylabel({'Wind speed', '(m s^{-1})'},'FontSize',SizeOfFont, 'color','k')
    legend({'Wind speed'}, 'FontSize',SizeOfFontLgd)
    grid minor
    xlim(TimeLim)
    ylim([0 9.5])

    subplot(5,1,5)
    plot(TT_bLS.Time, TT_bLS.airT)
    grid minor
    ylabel({'Temperature', '(^oC)'},'FontSize',SizeOfFont, 'color','k')
    legend({'Air temperature'}, 'FontSize',SizeOfFontLgd)
    xlim(TimeLim)
    ylim([0 12.5])
    xlabel('Time')
    xtickformat('MMM dd HH:mm')

    samexaxis('abc','xmt','on','ytac','join','yld',1,'YLabelDistance',1.0,'XLim',TimeLim)

    ii = ii + 1;

    if SAVE_FIG == 1
        FigFileName = 'NH3_Emis_4th_Atmos';
        fullFileName = fullfile(foldout, FigFileName);
        fig51 = gcf;
        fig51.PaperUnits = 'centimeters';
        fig51.PaperPosition = [0 0 19 19];
        print(fullFileName,'-dpng','-r800')
    end


end


toc