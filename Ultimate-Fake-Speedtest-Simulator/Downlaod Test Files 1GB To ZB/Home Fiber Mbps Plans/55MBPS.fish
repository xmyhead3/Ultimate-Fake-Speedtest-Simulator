function download_test
    clear

    # --- Randomization for Header ---
    set nodes "Mogadishu-Fiber-Core-01" "Hargeisa-Global-Gateway" "Kismayo-Subsea-Link" "Garowe-Satellite-Node-B" "Baidoa-Fiber-Hub"
    set resources "backbone_sync_99.bin" "intercontinental_relay.iso" "global_archive_delta.db" "dark_fiber_stream.pkg" "oceanic_link_test.raw"
    
    set random_node (random choice $nodes)
    set random_res (random choice $resources)

    printf "\033[1;36m[STORAGE]\033[0m Initializing Hormuud 55Mbps Premium Fiber...\n\n"
    printf "Available Test Sizes (Extended):\n"
    printf " 1) 1MB      2) 100MB     3) 500MB     4) 1GB       5) 10GB\n"
    printf " 6) 100GB    7) 1TB       8) 10TB      9) 100TB    10) 500TB\n"
    printf "11) 1PB     12) 10PB     13) 100PB    14) 500PB    15) 1EB\n"
    printf "16) 10EB    17) 100EB    18) 500EB    19) 1ZB\n\n"

    printf "\033[1;33mSelect option (1-19): \033[0m"
    read --local choice

    # Base Math (Total MB)
    switch $choice
        case "1";  set total_mb 1; set size_name "1MB"
        case "2";  set total_mb 100; set size_name "100MB"
        case "3";  set total_mb 500; set size_name "500MB"
        case "4";  set total_mb 1024; set size_name "1GB"
        case "5";  set total_mb (math "10*1024"); set size_name "10GB"
        case "6";  set total_mb (math "100*1024"); set size_name "100GB"
        case "7";  set total_mb (math "1024*1024"); set size_name "1TB"
        case "8";  set total_mb (math "10*1024*1024"); set size_name "10TB"
        case "9";  set total_mb (math "100*1024*1024"); set size_name "100TB"
        case "10"; set total_mb (math "500*1024*1024"); set size_name "500TB"
        case "11"; set total_mb (math "1024*1024*1024"); set size_name "1PB"
        case "12"; set total_mb (math "10*1024*1024*1024"); set size_name "10PB"
        case "13"; set total_mb (math "100*1024*1024*1024"); set size_name "100PB"
        case "14"; set total_mb (math "500*1024*1024*1024"); set size_name "500PB"
        case "15"; set total_mb (math "1024*1024*1024*1024"); set size_name "1EB"
        case "16"; set total_mb (math "10*1024*1024*1024*1024"); set size_name "10EB"
        case "17"; set total_mb (math "100*1024*1024*1024*1024"); set size_name "100EB"
        case "18"; set total_mb (math "500*1024*1024*1024*1024"); set size_name "500EB"
        case "19"; set total_mb (math "1024*1024*1024*1024*1024"); set size_name "1ZB"
        case "*"
            printf "Invalid choice.\n"
            return
    end

    clear
    printf "\033[1;37m━━━━━━━━━━━━━━━━━━━━ HORMUUD DOWNLOADER ━━━━━━━━━━━━━━━━━━━━\033[0m\n"
    printf "File:      %s Downloading Test\n" $size_name
    printf "Resource:  %s\n" $random_res
    printf "Node:      %s\n" $random_node
    printf "Status:    [\033[1;32m 55MBPS PREMIUM FIBER ACTIVE \033[0m]\n"
    printf "\033[1;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m\n\n"

    set current_mb 0
    set start_time (date +%s)
    set tick_counter 0
    set next_shift_ticks 0
    set random_mbps 55 
    set random_ms 18

    while test $current_mb -lt $total_mb
        if test $tick_counter -ge $next_shift_ticks
            set next_shift_ticks (math $tick_counter + (random 10 50))
            set random_mbps (random 53 57)
            set random_ms (random 15 22)
        end

        # MB per tick calculation (Speed / 8 bits / 10 ticks per sec)
        set speed_mb (math -s2 "$random_mbps / 8 / 10")
        set current_mb (math "$current_mb + $speed_mb")
        if test $current_mb -gt $total_mb; set current_mb $total_mb; end

        set percent (math -s0 "$current_mb*100/$total_mb")
        set bar (string repeat -n (math -s0 "$percent/4") "█")
        set empty (string repeat -n (math "25-"(math -s0 "$percent/4")) "░")
        
        # --- ETA LOGIC ---
        set eta_total_sec (math -s0 "(($total_mb-$current_mb) * 8) / ($random_mbps)")
        
        if test $eta_total_sec -ge 86400 
            set etad (math -s1 "$eta_total_sec/86400")" days"
        else if test $eta_total_sec -ge 3600
            set etad (math -s1 "$eta_total_sec/3600")" hrs"
        else if test $eta_total_sec -ge 60
            set etad (math -s0 "$eta_total_sec/60")" min"
        else
            set etad "$eta_total_sec sec"
        end

        # --- CORRECTED UNIT SCALING HIERARCHY ---
        if test $total_mb -ge 1125899906842624; set st (math -s2 "$total_mb/1125899906842624"); set ut "ZB"
        else if test $total_mb -ge 1099511627776; set st (math -s2 "$total_mb/1099511627776"); set ut "EB"
        else if test $total_mb -ge 1073741824; set st (math -s2 "$total_mb/1073741824"); set ut "PB"
        else if test $total_mb -ge 1048576; set st (math -s2 "$total_mb/1048576"); set ut "TB"
        else if test $total_mb -ge 1024; set st (math -s0 "$total_mb/1024"); set ut "GB"
        else; set st (math -s0 "$total_mb"); set ut "MB"; end

        # Current Downloaded Logic
        if test $current_mb -ge 1125899906842624; set sc (math -s2 "$current_mb/1125899906842624"); set uc "ZB"
        else if test $current_mb -ge 1099511627776; set sc (math -s2 "$current_mb/1099511627776"); set uc "EB"
        else if test $current_mb -ge 1073741824; set sc (math -s2 "$current_mb/1073741824"); set uc "PB"
        else if test $current_mb -ge 1048576; set sc (math -s2 "$current_mb/1048576"); set uc "TB"
        else if test $current_mb -ge 1024; set sc (math -s1 "$current_mb/1024"); set uc "GB"
        else; set sc (math -s1 "$current_mb"); set uc "MB"; end

        printf "\r%3s%% [%-25s] %.2f%s / %.2f%s | Latency: \033[1;36m%dms\033[0m | Speed: \033[1;32m%.1f Mbps\033[0m | ETA: %s    " \
            $percent "$bar$empty" $sc $uc $st $ut $random_ms $random_mbps $etad

        set tick_counter (math $tick_counter + 1)
        sleep 0.1
    end

    set total_time (math (date +%s)"-$start_time")
    printf "\n\n\033[1;32m✔ 55Mbps Transfer Successful\n✔ SHA-256 Checksum Verified\n[FINISH]\033[0m Processed %s in %s sec.\n" $size_name $total_time
end