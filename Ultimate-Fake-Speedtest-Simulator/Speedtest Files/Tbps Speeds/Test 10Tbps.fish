function speedtest
    clear
    # --- PHASE 1: Optimal Server Discovery ---
    echo -e "\033[1;36m[SYSTEM]\033[0m Initializing Subsea Terabit Multi-Core Fiber..."
    sleep 1
    
    set ip_rand1 (random 100 254)
    set ip_rand2 (random 10 254)
    set dynamic_ip "192.145.$ip_rand1.$ip_rand2"

    # Discovery Pings (Backbone Grid)
    set lon_pg (random 1 2)    
    set ger_pg (random 1 2)   
    set fra_pg (random 1 2)   
    set dxb_pg (random 4 8)  

    echo -e "\033[1;30m[PING]\033[0m  London-INX (LON-04) ......... "$lon_pg"ms"
    sleep 0.8
    echo -e "\033[1;30m[PING]\033[0m  Germany-DE-CIX (FRA-01) .... "$ger_pg"ms"
    sleep 0.8
    echo -e "\033[1;30m[PING]\033[0m  France-IX (PAR-02) ......... "$fra_pg"ms"
    sleep 0.8
    echo -e "\033[1;30m[PING]\033[0m  Dubai-IX (DXB-01) ........... "$dxb_pg"ms"
    sleep 0.8
    
    # Discovery Winner
    set base_pg (random 0 1)
    echo -ne "\033[1;30m[PING]\033[0m  Hormuud Exchange (MOG-01) ... "$base_pg"ms"
    sleep 1.2
    
    echo -e "\r\033[1;32m[WINNER] Hormuud Exchange (MOG-01) ... "$base_pg"ms (LOWEST LATENCY)\033[0m"
    echo -ne "\033[1;33m[SCAN]\033[0m  Multiplexing 128-Channel DWDM..."
    sleep 3 
    
    echo -e "\r\033[1;32m[FOUND]\033[0m Local Node: Mogadishu-SUBSEA-GATE (Latency: "$base_pg"ms)         "
    echo -ne "\033[1;33m[QoS]\033[0m   Calibrating Coherent Transponders..."
    sleep 1.2
    echo -e "\r\033[1;32m[OK]\033[0m    Line Status: \033[1;32mMAXIMUM\033[0m (C+L Band Verified)"
    sleep 1
    echo ""

    # --- PHASE 2: Permanent Header ---
    echo -e "\033[1;37m━━━━━━━━━━━━━━━━━━━━ HORMUUD TELECOM ━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "ISP:      Hormuud Telecom | IP: $dynamic_ip"
    echo -e "Gaming:   [\033[1;32m LIGHT-SPEED \033[0m] | Bufferbloat: [\033[1;32m    A+     \033[0m]"
    echo -e "Interface:[\033[1;32m DWDM-128CH  \033[0m] | Status:      [\033[1;32m 10TBPS GLOBAL \033[0m]"
    echo -e "\033[1;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""

    set total_data 0
    set graph ""
    set block "█"

    # --- PHASE 3 & 4: Ramp-Up (Climbing to 10,000,000 Mbps) ---
    for i in (seq 1 20)
        # Target is 10,000,000 Mbps
        set dl (math "500000 * $i")
        set ul (math "480000 * $i")
        
        set pg (random 0 1)
        set jt_raw (random 1 2)
        set jt (math -s1 "$jt_raw / 10")

        echo -ne "\r\033[1;35mPing: $pg ms\033[0m | \033[1;33mJitter: $jt ms\033[0m | \033[1;32mDL: $dl Mbps\033[0m | \033[1;34mUL: $ul Mbps\033[0m | \033[1;32mMODE: WAVE-SYNC\033[0m \n\033[1;32mTraffic: [+] \033[1;37mSent: 0GB\033[0m"
        echo -ne "\033[1A"
        sleep 0.1
    end

    # --- PHASE 5: Infinite Live Monitor (10Tbps Zone) ---
    while true
        set pg (random 0 1)
        set jt_raw (random 1 2)
        set jt (math -s1 "$jt_raw / 10")

        # 10Tbps Speeds (9,420,000 to 9,995,000 Mbps)
        set dl (math (random 9420000 9995000) + (random 1 9)/10) 
        set ul (math (random 9150000 9680000) + (random 1 9)/10)
        
        # Data Accumulation: 10Tbps is 1250GB/s. Loop 0.4s = 500GB (512000MB)
        set total_data (math "$total_data + 512000")
        set total_gb (math -s1 "$total_data / 1024")

        set graph "$graph$block"
        if test (string length "$graph") -gt 35
            set graph (string sub -s 2 "$graph")
        end

        echo -ne "\r\033[1;35mPing: $pg ms\033[0m | \033[1;33mJitter: $jt ms\033[0m | \033[1;32mDL: $dl Mbps\033[0m | \033[1;34mUL: $ul Mbps\033[0m | \033[1;32mMODE: OPTICAL-10T\033[0m \n\033[1;32mTraffic: [$graph] \033[1;37mSent: "$total_gb"GB\033[0m"
        echo -ne "\033[1A"
        sleep 0.4
    end
end