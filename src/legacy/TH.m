folder_path = "./";
files = dir(fullfile(folder_path, '*.mat'));

file_east_t = fopen('enve_t_data_east.csv', 'a');
file_east_f = fopen('enve_f_data_east.csv', 'a');
file_north_t = fopen('enve_t_data_north.csv', 'a');
file_north_f = fopen('enve_f_data_north.csv', 'a');
file_vert_t = fopen('enve_t_data_vert.csv', 'a');
file_vert_f = fopen('enve_f_data_vert.csv', 'a');

for i = 1:length(files)

    file_name = files(i).name;
    disp(file_name)
    load(file_name);
folder_path = "./";

% List all .mat files in the folder
mat_files = dir(fullfile(folder_path, '*.mat'));

% Loop through each .mat file
for i = 1:numel(mat_files)
    file_name = mat_files(i).name;
    file_path = fullfile(folder_path, file_name);
    
    try
        % Load the .mat file
        loaded_data = load(file_path);
        
        % Check if the 'data' field is present
        if isfield(loaded_data, 'data')
            data = loaded_data.data; % Extract the 'data' field
            
            % Check if the 'ZA' field is present within 'data'
            if isfield(data, 'ZA')
                % Process the file since it contains 'ZA' field within 'data'
                fprintf('Processing file %s...\n', file_name);
                % Your processing code here
            else
                % Skip the file since it doesn't contain 'ZA' field within 'data'
                fprintf('Skipping file %s because it doesn''t contain ZA field within data.\n', file_name);
                continue; % Skip to the next file
            end
        else
            % Skip the file since it doesn't contain 'data' field
            fprintf('Skipping file %s because it doesn''t contain data field.\n', file_name);
            continue; % Skip to the next file
        end
    catch ME
        fprintf('Error loading file %s. Skipping...\n', file_name);
        continue; % Skip to the next file
    end
end


    east = data.EA;
    north = data.NA;
    vertical = data.ZA;
    
    data_epsd_east = EPSDParam(east, data.dt);
    data_epsd_north = EPSDParam(north, data.dt);
    data_epsd_vertical = EPSDParam(vertical, data.dt);


    % ----------------------EAST--------------------------------%
    
    enve_t = zeros(length(data_epsd_east.Ts), 1); 
    F_t = [repmat('%d', 1, length(data_epsd_east.Ts)),'\n'];
    enve_freq = zeros(length(data_epsd_east.Ws), 1); 
    F_f = [repmat('%d', 1, length(data_epsd_east.Ts)),'\n'];
    
    for j = 1:length(data_epsd_east.Ts)
        enve_t(j) = trapz(data_epsd_east.Ws, data_epsd_east.GTW(:,j));
    end
    
    for j = 1:length(data_epsd_east.Ws)
        enve_freq(j) = trapz(data_epsd_east.Ts, data_epsd_east.GTW(j,:));
    end

    fprintf(file_east_t,'%s,',file_name); 
    fprintf(file_east_t,F_t,enve_t); 
    fprintf(file_east_t,'\n');

    fprintf(file_east_f,'%s,',file_name); 
    fprintf(file_east_f,F_f,enve_freq); 
    fprintf(file_east_f,'\n');
    
    % -----------------------NORTH-------------------------------%

    enve_t = zeros(length(data_epsd_north.Ts), 1); 
    F_t = [repmat('%d', 1, length(data_epsd_north.Ts)),'\n'];
    enve_freq = zeros(length(data_epsd_north.Ws), 1); 
    F_f = [repmat('%d', 1, length(data_epsd_north.Ts)),'\n'];

    for j = 1:length(data_epsd_north.Ts)
        enve_t(j) = trapz(data_epsd_north.Ws, data_epsd_north.GTW(:,j));
    end
    
    for j = 1:length(data_epsd_north.Ws)
        enve_freq(j) = trapz(data_epsd_north.Ts, data_epsd_north.GTW(j,:));
    end


    fprintf(file_north_t,'%s,',file_name); 
    fprintf(file_north_t,F_t,enve_t); 
    fprintf(file_north_t,'\n');

    fprintf(file_north_f,'%s,',file_name); 
    fprintf(file_north_f,F_f,enve_freq); 
    fprintf(file_north_f,'\n');

    % -----------------------VERTICAL------------------------------%

    enve_t = zeros(length(data_epsd_vertical.Ts), 1); 
    F_t = [repmat('%d', 1, length(data_epsd_vertical.Ts)),'\n'];
    enve_freq = zeros(length(data_epsd_vertical.Ws), 1); 
    F_f = [repmat('%d', 1, length(data_epsd_vertical.Ts)),'\n'];

    for j = 1:length(data_epsd_vertical.Ts)
        enve_t(j) = trapz(data_epsd_vertical.Ws, data_epsd_vertical.GTW(:,j));
    end
    
    for j = 1:length(data_epsd_vertical.Ws)
        enve_freq(j) = trapz(data_epsd_vertical.Ts, data_epsd_vertical.GTW(j,:));
    end
folder_path = "./";


    
    fprintf(file_vert_t,'%s,',file_name); 
    fprintf(file_vert_t,F_t,enve_t); 
    fprintf(file_vert_t,'\n');

    fprintf(file_vert_f,'%s,',file_name); 
    fprintf(file_vert_f,F_f,enve_freq); 
    fprintf(file_vert_f,'\n');
end