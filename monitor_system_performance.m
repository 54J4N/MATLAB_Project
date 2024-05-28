function monitor_system_performance()
    % Set up the figure for plotting system performance
    figure;
    hold on;
    grid on;
    xlabel('Time (seconds)');
    ylabel('Usage (%)');
    title('Real-Time System Performance Monitoring');
    xlim([0, 300]); % Set x-axis limits to 5 minutes
    ylim([0, 100]); % Set y-axis limits from 0% to 100%

    % Initialize plot data
    cpuPlot = plot(nan, nan, 'r-', 'DisplayName', 'CPU Usage (%)');
    ramPlot = plot(nan, nan, 'b-', 'DisplayName', 'RAM Usage (%)');
    legend show;
    
    startTime = datetime('now');
    cpuData = [];
    ramData = [];
    timeData = [];

    % Update the plot every second
    while ishandle(cpuPlot) % Run as long as the figure is open
        % Execute system commands
        [~, cpuOut] = system('top -bn2 | grep "Cpu(s)" | tail -n1');
        [~, memOut] = system('free | grep Mem');
        
        % Parse CPU usage from top command
        cpuUsage = sscanf(cpuOut, '%*s %*s %f %*s %*s %*s %*s %*s %*s %*s %*s %*s %*s');

        % Parse memory usage from free command
        memTotal = sscanf(memOut, '%*s %f');
        memUsed = sscanf(memOut, '%*s %*f %f');
        ramUsage = (memUsed / memTotal) * 100;

        % Update data for plotting
        cpuData = [cpuData, cpuUsage];
        ramData = [ramData, ramUsage];
        elapsed = seconds(datetime('now') - startTime);
        timeData = [timeData, elapsed];

        % Update the plots
        set(cpuPlot, 'XData', timeData, 'YData', cpuData);
        set(ramPlot, 'XData', timeData, 'YData', ramData);
        drawnow;

        % Pause for 1 second before updating again
        pause(1);
    end
end
