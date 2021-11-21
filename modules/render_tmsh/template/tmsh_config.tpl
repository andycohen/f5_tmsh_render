################ MG CONFIG ################


auth partition ${partition_name}
    description "${partition_desc}"
}


################ MG CONFIG ################

cd /${partition_name}

ltm monitor ${monitor_type} mon_${service_url}_${pool_port}_${monitor_type} {
    adaptive disabled
    defaults-from /Common/{$monitor_type}
	destination *:${pool_port}
    interval 15
    ip-dscp 0
    partition ${partition_name}
    recv "${monitor_receive_string}"
    recv-disable none
    send "${monitor_send_string} HTTP/1.1\r\nHost: ${service_url}\r\nConnection: Close\r\n\r\n"
    time-until-up 0
    timeout 46
}

ltm profile client-ssl clientssl_${service_url} {
    app-service none
    cert-key-chain {
        ${service_url}_${cert_creation_date} {
            cert ${service_url}_${cert_creation_date}
            key ${service_url}_${cert_creation_date}
        }
    }
    chain none
    defaults-from /Common/${parent_profile_prefix}_clientssl
    inherit-ca-certkeychain true
    inherit-certkeychain false
}

ltm profile server-ssl serverssl_${service_url} {
    app-service none
    defaults-from /Common/${parent_profile_prefix}_serverssl
}

ltm profile http profile_${partition_name}_http {
    app-service none
    defaults-from ${parent_profile_prefix}_http
}

ltm profile tcp profile_${partition_name}_clienttcp {
    app-service none
    defaults-from ${parent_profile_prefix}_tcp_lan_optimised
}

ltm profile tcp profile_${partition_name}_servertcp {
    app-service none
    defaults-from ${parent_profile_prefix}_tcp_lan_optimised
}

ltm persistence cookie profile_${partition_name}_cookie_persist {
    app-service none
    defaults-from /Common/${parent_profile_prefix}_cookie_persist
}

ltm persistence source-addr profile_${partition_name}_source_addr_persist {
    app-service none
    defaults-from /Common/${parent_profile_prefix}_source_addr_persist
    timeout 1800
}

ltm pool pool_${site}_mon_${service_url}_${pool_port} {
    members {
${pool_members}
    }
    monitor mon_${service_url}_${pool_port}_${monitor_type}
    partition ${partition_name}
}


ltm virtual vs_${site}_${service_url}_${vip_port} {
    destination ${vip_ip}:${vip_port}
    fallback-persistence profile_${partition_name}_source_addr_persist
    ip-protocol tcp
    mask 255.255.255.255
    partition ${partition_name}
    persist {
        profile_${partition_name}_cookie_persist {
            default yes
        }
    }
    pool pool_${site}_${service_url}_${pool_port}
    profiles {
        clientssl_${service_url} {
            context clientside
        }
        profile_${partition_name}_clienttcp {
            context clientside
        }
        profile_${partition_name}_http { }
        profile_${partition_name}_servertcp {
            context serverside
        }
        serverssl_${service_url} {
            context serverside
        }
    }
    source 0.0.0.0/0
    source-address-translation {
        pool /Common/snat-${site}-shared
        type snat
    }
    translate-address enabled
    translate-port enabled
}
