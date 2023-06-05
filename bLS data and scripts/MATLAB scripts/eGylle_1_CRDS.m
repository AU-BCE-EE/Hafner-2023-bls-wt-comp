    %% Script to import NH3 and CH4 data from Picarro analyzer
% JK August 2021
% Wind tunnel and bLS comparison measurements in Foulum August 2021
%
% 1st measurement

cd 'C:\Users\AU323818\Dropbox\MatLab\Analyser\eGylle 1st 21'

clear

tic

LOAD_SWITCH = 0; % Read in data from dat-files: 0 = NO, 1 = YES
PLOT_SWITCH = 0; % Plot: 0 = NO, 1 = YES
SAVE_FIG = 0;

PATH = 'C:\Users\AU323818\Dropbox\Uni\eGylle\1st trial Aug21\bLS data';
foldout = 'C:\Users\AU323818\Dropbox\Uni\eGylle\1st trial Aug21\Figures';

if LOAD_SWITCH == 1
    
    %% Load CRDS Field - CRDS # G2508
    %========================================================================%
    %========================================================================%
    
    CRDS_field = [];
    datafiles=recursivedir('C:\Users\AU323818\Dropbox\Uni\eGylle\1st trial Aug21\CRDS\CRDS field','*.dat');
    
    opts = delimitedTextImportOptions("NumVariables", 39);
    
    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = "  ";
    
    % Specify column names and types
    opts.VariableNames = ["DATE", "TIME", "FRAC_DAYS_SINCE_JAN1", "FRAC_HRS_SINCE_JAN1", "JULIAN_DAYS", "EPOCH_TIME", "ALARM_STATUS", "INST_STATUS", "CavityPressure", "CavityTemp", "DasTemp", "EtalonTemp", "WarmBoxTemp", "species", "MPVPosition", "OutletValve", "solenoid_valves", "N2O", "N2O_30s", "N2O_1min", "N2O_5min", "N2O_dry", "N2O_dry30s", "N2O_dry1min", "N2O_dry5min", "CO2", "CO2_dry", "CH4", "CH4_dry", "H2O", "NH3", "ChemDetect", "peak_1a", "peak_41", "peak_4", "peak15", "ch4_splinemax", "nh3_conc_ave", "VarName39"];
    opts.VariableTypes = ["datetime", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string"];
    opts = setvaropts(opts, 1, "InputFormat", "yyyy-MM-dd");
    opts = setvaropts(opts, 2, "InputFormat", "HH:mm:ss.SSS");
    opts = setvaropts(opts, 39, "WhitespaceRule", "preserve");
    opts = setvaropts(opts, 39, "EmptyFieldRule", "auto");
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    opts.ConsecutiveDelimitersRule = "join";
    
    for o = 1:length(datafiles)
        %extract date and time from filename
        [versn, ~, ~] = fileparts(datafiles{o});
        filename=datafiles{o};
        
        disp(versn) % Print to check name
        
        fileID = fopen(filename,'r');
        CRDS_field_loop = readtable(filename, opts);
        fclose(fileID);
        fclose('all');
        
        % Remove variables not used
        CRDS_field_loop(:,{'FRAC_DAYS_SINCE_JAN1', 'FRAC_HRS_SINCE_JAN1', 'JULIAN_DAYS', 'EPOCH_TIME', 'INST_STATUS', 'DasTemp', 'EtalonTemp', 'WarmBoxTemp', 'species', 'MPVPosition', 'OutletValve', 'solenoid_valves', 'VarName39'}) = [];
        
        CRDS_field = [CRDS_field; CRDS_field_loop];
        
    end
    
    % Clear temporary variables
    clear opts ext name o versn datafiles CRDS_field_loop
    
    %% Load CRDS Background - CRDS # 2
    %========================================================================%
    %========================================================================%
    CRDS_bg = [];
    datafiles=recursivedir('C:\Users\AU323818\Dropbox\Uni\eGylle\1st trial Aug21\CRDS\CRDS bg','*.dat');
    
    % Setup the Import Options
    opts = delimitedTextImportOptions("NumVariables", 28);
    
    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = "  ";
    
    % Specify column names and types
    opts.VariableNames = ["DATE", "TIME", "FRAC_DAYS_SINCE_JAN1", "FRAC_HRS_SINCE_JAN1", "JULIAN_DAYS", "EPOCH_TIME", "ALARM_STATUS", "INST_STATUS", "CavityPressure", "CavityTemp", "DasTemp", "EtalonTemp", "WarmBoxTemp", "species", "MPVPosition", "InletValve", "OutletValve", "solenoid_valves", "NH3_Raw", "NH3_30s", "NH3_2min", "NH3_5min", "H2O", "NH3_dry", "NH3_uncorrected", "NH3_broadeningCorrected", "peak15", "VarName28"];
    opts.VariableTypes = ["datetime", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string"];
    opts = setvaropts(opts, 1, "InputFormat", "yyyy-MM-dd");
    opts = setvaropts(opts, 2, "InputFormat", "HH:mm:ss.SSS");
    opts = setvaropts(opts, 28, "WhitespaceRule", "preserve");
    opts = setvaropts(opts, 28, "EmptyFieldRule", "auto");
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    opts.ConsecutiveDelimitersRule = "join";
    
    for o = 1:length(datafiles)
        %extract date and time from filename
        [versn, ~, ~] = fileparts(datafiles{o});
        filename=datafiles{o};
        
        disp(versn) % Print to check name
        
        fileID = fopen(filename,'r');
        CRDS_bg_loop = readtable(filename, opts);
        fclose(fileID);
        fclose('all');
        
        % Remove variables not used
        CRDS_bg_loop(:,{'FRAC_DAYS_SINCE_JAN1', 'FRAC_HRS_SINCE_JAN1', 'JULIAN_DAYS', 'EPOCH_TIME', 'INST_STATUS', 'DasTemp', 'EtalonTemp', 'WarmBoxTemp', 'species', 'MPVPosition', 'InletValve', 'OutletValve', 'solenoid_valves', 'VarName28'}) = [];
        
        CRDS_bg = [CRDS_bg; CRDS_bg_loop];
        
        %   Clear temporary variables
        clearvars filename fileID;
        
    end
    
    % Clear temporary variables
    clear opts ext name o versn datafiles CRDS_bg_loop
    
    %% Load G4301 CRDS - CH4 Background

    CRDS_G4301 = [];
    datafiles=recursivedir('C:\Users\AU323818\Dropbox\Uni\eGylle\1st trial Aug21\CRDS\Backpack','*.dat');
    
    % Setup the Import Options
    opts = delimitedTextImportOptions("NumVariables", 23);
    
    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = "  ";
    
    % Specify column names and types
    opts.VariableNames = ["DATE", "TIME", "FRAC_DAYS_SINCE_JAN1", "FRAC_HRS_SINCE_JAN1", "EPOCH_TIME", "ALARM_STATUS", "INST_STATUS", "H2O", "CH4", "CO2", "CavityPressure", "CavityTemp", "Battery_Current", "Battery_Temperature", "Battery_Voltage", "GPS_ABS_LAT", "GPS_ABS_LONG", "GPS_FIT", "GPS_TIME", "GPS_ALTITUDE", "MPVPosition", "CH4_dry", "CO2_dry"];
    opts.VariableTypes = ["datetime", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
    opts = setvaropts(opts, 1, "InputFormat", "yyyy-MM-dd");
    opts = setvaropts(opts, 2, "InputFormat", "HH:mm:ss.SSS");
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    opts.ConsecutiveDelimitersRule = "join";
    
    for o = 1:length(datafiles)
        %extract date and time from filename
        [versn, ~, ~] = fileparts(datafiles{o});
        filename=datafiles{o};
        
        disp(versn) % Print to check name
        
        fileID = fopen(filename,'r');
        CRDS_G4301_loop = readtable(filename, opts);
        fclose(fileID);
        fclose('all');
        
        % Remove variables not used
        CRDS_G4301_loop(:,{'FRAC_DAYS_SINCE_JAN1', 'FRAC_HRS_SINCE_JAN1', 'EPOCH_TIME', 'ALARM_STATUS', 'INST_STATUS', 'Battery_Current', 'Battery_Temperature', 'Battery_Voltage', 'GPS_ABS_LAT', 'GPS_ABS_LONG', 'GPS_FIT', 'GPS_TIME', 'GPS_ALTITUDE', 'MPVPosition'}) = [];
        
        CRDS_G4301 = [CRDS_G4301; CRDS_G4301_loop];
        
        clear filename fileID;
    end

    
    % Clear temporary variables
    clear opts ext name o versn datafiles CRDS_WestCH4_loop ans CRDS_WestNH3_time

    %% Adjust time and apply calibration to concentration - and change all concentrations to ug/m3
    % TIME CORRECTION for background: CRDS #2: 2 hours, 59 min
    % TIME CORRECTION for field: CRDS time G2508: 2 hours
    % TIME CORRECTION for backpack: CRDS time: 2 hours
    
    Time_bg = CRDS_bg.DATE + timeofday(CRDS_bg.TIME) + hours(2) + minutes(59) + seconds(0);
    Time_bg.Format = 'dd.MM.uuuu HH:mm:ss:SSS';
    CRDS_bg.Time = Time_bg;
    
    Time_field = CRDS_field.DATE + timeofday(CRDS_field.TIME) + hours(2) + minutes(0) + seconds(0);
    Time_field.Format = 'dd.MM.uuuu HH:mm:ss:SSS';
    CRDS_field.Time = Time_field;
    
    CRDS_G4301_time = CRDS_G4301.DATE + timeofday(CRDS_G4301.TIME) + hours(2);  
    CRDS_G4301_time.Format = 'dd.MM.uuuu HH:mm:ss:SSS';
    CRDS_G4301.Time = CRDS_G4301_time;
     
    clear Time_bg Time_field CRDS_G4301_time
    
    % CALIBRATION APPLIED and concentration changed to ug/m3
    % CRDS #2 need correction for H2O
    
    CRDS_field.NH3_ug = (CRDS_field.NH3 - 0.0) ./ 1.00 *0.0409*17.031;
    CRDS_field.CH4_ug = (CRDS_field.CH4_dry - 0.0) ./ 1.00 *40.9*16.04;
    
    CRDS_bg.NH3_Raw = CRDS_bg.NH3_Raw-(0.9*CRDS_bg.H2O);
    CRDS_bg.NH3_ug = (CRDS_bg.NH3_Raw - 0.0) ./ 1.00 * 0.0409*17.031;
    CRDS_bg.NH3_dry_ug = (CRDS_bg.NH3_dry - 0.0) ./ 1.00 * 0.0409*17.031;
    
    CRDS_G4301.CH4_ug  = (CRDS_G4301.CH4_dry  - 1.0) ./ 1.00 *40.9*16.04;
    
    save('WTbLS_CRDS_field_1st.mat', 'CRDS_field');
    save('WTbLS_CRDS_bg_1st.mat', 'CRDS_bg');
    
    
    
    TT_temp_CRDS = timetable(CRDS_field.Time, CRDS_field.NH3_ug, CRDS_field.CH4_ug, 'VariableNames',{'NH3', 'CH4'});
    TT_temp_CRDS_bg = timetable(CRDS_bg.Time, CRDS_bg.NH3_ug, 'VariableNames',{'NH3_bg'});
    TT_temp_CRDS_CH4bg = timetable(CRDS_G4301.Time, CRDS_G4301.CH4_ug, 'VariableNames',{'CH4_bg'});
    
    TT_CRDS = synchronize(synchronize(TT_temp_CRDS, TT_temp_CRDS_bg), TT_temp_CRDS_CH4bg);
    
    newTimes = [datetime('2021-08-09 18:00:00'):minutes(30):datetime('2021-08-19 10:00:00')];
    TT_CRDS = retime(TT_CRDS, newTimes, 'mean');
    TT_CRDS = rmmissing(TT_CRDS);
    
    clearvars TT_temp_CRDS TT_temp_CRDS_bg TT_temp_CRDS_CH4bg newTimes CRDS_G4301 CRDS_G4301_loop 
    
    save('WTbLS_TT_CRDS_1st.mat', 'TT_CRDS');
    
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
    rain = readtable("C:\Users\AU323818\Dropbox\Uni\eGylle\2nd trial Aug21\Raingauge.txt", opts);
    
    % Clear temporary variables
    clear opts
    
    rain.mm = rain.Event/2;
    
    TT_rain = table2timetable(rain);
    
    newTimes = [datetime('2021-08-09 13:00:00'):minutes(60):datetime('2021-08-30 10:00:00')];
    TT_rain = retime(TT_rain, newTimes, 'sum');
    
    TT_rain.sum_mm = cumsum(TT_rain.mm);
    TT_rain(:,1:2) = [];
    
    save('WTbLS_TT_rain_1st.mat', 'TT_rain')
    
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
    VejrFoulum = readtable("C:\Users\AU323818\Dropbox\Uni\eGylle\2nd trial Aug21\VejrFoulum.csv", opts);
    
    VejrFoulum.TIME = VejrFoulum.date + timeofday(VejrFoulum.time) + hours(1);
    VejrFoulum.TIME.Format = 'dd-MM-yyyy HH:mm:ss.SSS';
    
    TT_VejrFoulum = table2timetable(VejrFoulum,'RowTimes',VejrFoulum.TIME);
    TT_VejrFoulum(:,[1:3, 19]) = [];
    
    clear opts
    
    TT_Vejr = rmmissing(synchronize(TT_rain, TT_VejrFoulum));
    
    save('WTbLS_Vejr_1st.mat', 'TT_Vejr')
    writetimetable(TT_Vejr, [PATH, '\eGylle_1_Vejr.txt'], 'Delimiter','tab')
    
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
    load('WTbLS_CRDS_field_1st.mat')
    load('WTbLS_CRDS_bg_1st.mat')
    load('WTbLS_TT_CRDS_1st.mat')
    load('WTbLS_Vejr_1st.mat')
end


if LOAD_SWITCH == 1
    %% Load bLS results
    opts = delimitedTextImportOptions("NumVariables", 48);
    
    % Specify range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ";";
    
    % Specify column names and types
    opts.VariableNames = ["rn", "Sensor", "Source", "SensorHeight", "SourceArea", "CE", "CE_se", "CE_lo", "CE_hi", "uCE", "uCE_se", "uCE_lo", "uCE_hi", "vCE", "vCE_se", "vCE_lo", "vCE_hi", "wCE", "wCE_se", "wCE_lo", "wCE_hi", "N_TD", "TD_Time_avg", "TD_Time_max", "Max_Dist", "UCE", "Ustar", "L", "Zo", "sUu", "sVu", "sWu", "z_sWu", "WD", "d", "N0", "MaxFetch", "st", "et", "WS", "airT", "Pair", "N", "kv", "A", "alpha", "bw", "C0"];
    opts.VariableTypes = ["string", "categorical", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "datetime", "datetime", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
    opts = setvaropts(opts, 38, "InputFormat", "yyyy-MM-dd HH:mm:ss");
    opts = setvaropts(opts, 39, "InputFormat", "yyyy-MM-dd HH:mm:ss");
    opts = setvaropts(opts, 1, "WhitespaceRule", "preserve");
    opts = setvaropts(opts, [1, 2, 3], "EmptyFieldRule", "auto");
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % Import the data
    WTbLS_1 = readtable("C:\Users\AU323818\Dropbox\Uni\eGylle\1st trial Aug21\bLS data\bLS_WT_1_1.csv", opts);
    
    clear opts
    
    TT_bLS_1 = table2timetable(WTbLS_1);%, 'RowTimes', WTbLS_1.Time);
    TT_bLS_1.Properties.DimensionNames{1} = 'Time';
    
    Del_col = [1:3, 38, 43:45];
    TT_bLS_1(:,Del_col) = [];
    
    TT_bLS = synchronize(TT_bLS_1, TT_CRDS);
    %% Save and Clear
    %  Correct temperature spikes
    TT_bLS.Zo = TT_EC.z0;
    TT_bLS.L = TT_EC.L;
    TT_bLS.Ustar = TT_EC.UST;
    TT_bLS.airT = TT_EC.airT;
    
    save('WTbLS_TT_bLS_1st.mat', 'TT_bLS')
    
    clearvars WTbLS_1 Del_col TT_bLS_1 CRDS_bg CRDS_field TT_CRDS
    
else
    load('WTbLS_TT_bLS_1st.mat')
end

%% Emission estimates and flags

TT_bLS.emis_NH3 = (TT_bLS.NH3 - TT_bLS.NH3_bg) ./ TT_bLS.CE;
TT_bLS.emis_CH4 = (TT_bLS.CH4 - TT_bLS.CH4_bg) ./ TT_bLS.CE;

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

%% Gap filling, Averages and TAN
Time_Lim7 = [datetime(2021,8,11,16,0,0), datetime(2021,8,18,16,0,0)];


TT_bLS.emis_NH3_soft_gap = fillmissing(TT_bLS.emis_NH3_soft,'linear');
TT_bLS.emis_NH3_hard_gap = fillmissing(TT_bLS.emis_NH3_hard, 'linear');
TT_bLS.emis_NH3_BUH_gap = fillmissing(TT_bLS.emis_NH3_BUH, 'linear');

disp('Average Flag soft and gap filling')
disp([mean(TT_bLS.emis_NH3_soft(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)),"omitnan") mean(TT_bLS.emis_NH3_soft_gap(TT_bLS.Time > Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)),"omitnan")])

disp('Average Flag hard and gap filling')
disp([mean(TT_bLS.emis_NH3_hard(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)),"omitnan") mean(TT_bLS.emis_NH3_hard_gap(TT_bLS.Time > Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)),"omitnan")])

disp('Average Flag Bühler and gap filling - 7 days')
disp([mean(TT_bLS.emis_NH3_BUH(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)),"omitnan") mean(TT_bLS.emis_NH3_BUH_gap(TT_bLS.Time > Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)),"omitnan")])

disp('Cumulated rain fall - 7 days')
disp(sum(rmmissing(TT_Vejr.prec(TT_Vejr.Time >= Time_Lim7(1) & TT_Vejr.Time < Time_Lim7(2)))))

disp('Avg temp - 7 days')
disp(mean(TT_Vejr.TempAir(TT_Vejr.Time >= Time_Lim7(1) & TT_Vejr.Time < Time_Lim7(2)),"omitnan"))

disp('Avg WS - 7 days')
disp(mean(TT_bLS.WS(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)),"omitnan"))

% Loss of TAN - 7 days after application
% kg ammonium-N pr ton (TAN) = 1.90 g/kg
% 35.9 ton/ha slurry.
TAN_slurry = 35.9*1.90E5 * 17.031 / 14.0067; % Basis for TAN er N mens flux er NH3

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

% TT_bLS.TAN = zeros(height(TT_bLS),1);
TT_bLS.TAN = nan(height(TT_bLS),1);
TT_bLS.TAN(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2)) = cumsum(TT_bLS.emis_NH3_BUH_gap(TT_bLS.Time >= Time_Lim7(1) & TT_bLS.Time < Time_Lim7(2))*1800/(TAN_slurry)*100, 'omitnan');

if PLOT_SWITCH == 1
    TimeLim = [datetime('2021-08-09 18:00:00'), datetime('2021-08-19 10:00:00')];
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
        FigFileName = 'NH3_Emis_1st';
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
    ylim([-5 105])
    
    subplot(5,1,3)
    bar(TT_Vejr.Time, TT_Vejr.prec);
    ylabel({'Precipitation', '(mm hr^{-1})'},'FontSize',SizeOfFont, 'color','k')
    legend({'Precipitation'}, 'FontSize',SizeOfFontLgd)
    grid minor
    xlim(TimeLim)
    ylim([0 4.5])
    
    subplot(5,1,4)
    plot(TT_bLS.Time, TT_bLS.WS)
    ylabel({'Wind speed', '(m s^{-1})'},'FontSize',SizeOfFont, 'color','k')
    legend({'Wind speed'}, 'FontSize',SizeOfFontLgd)
    grid minor
    xlim(TimeLim)
    ylim([0 6.9])
    
    subplot(5,1,5)
    plot(TT_Vejr.Time, TT_Vejr.TempAir, TT_Vejr.Time, TT_Vejr.Temp10cm)
    grid minor
    ylabel({'Temperature', '(^oC)'},'FontSize',SizeOfFont, 'color','k')
    legend({'Air temperature', 'Soil temperature (10 cm)'}, 'FontSize',SizeOfFontLgd)
    xlim(TimeLim)
    ylim([10 26.9])
    xlabel('Time')
    xtickformat('MMM dd HH:mm')
    
    samexaxis('abc','xmt','on','ytac','join','yld',1,'YLabelDistance',1.0,'XLim',TimeLim)
    
    ii = ii + 1;
    
    if SAVE_FIG == 1
        FigFileName = 'NH3_Emis_1st_Atmos';
        fullFileName = fullfile(foldout, FigFileName);
        fig51 = gcf;
        fig51.PaperUnits = 'centimeters';
        fig51.PaperPosition = [0 0 19 19];
        print(fullFileName,'-dpng','-r800')
    end
    
end



toc