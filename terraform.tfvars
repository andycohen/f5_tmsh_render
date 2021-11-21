hostname           = "test-service-nft"
partition_name     = "test"
partition_desc     = "Test - 123456"
environment        = "nft"
cert_creation_date = "20211118"

site = {
    mg = {
        vip_ip    = "172.10.10.1"
        pool_port = "8033"
        pool_members = {
            devecp12345 = {
                ip   = "10.10.10.10"
                port = "8833"
            }
            devecp12346 = {
                ip   = "10.10.10.11"
                port = "8834"
            }
        }
    }
    mm = {
        vip_ip    = "172.10.10.1"
        pool_port = "8033"
        pool_members = {
            devecp987765 = {
                ip   = "10.10.20.10"
                port = "8843"
            }
            devecp9871111 = {
                ip   = "10.10.20.11"
                port = "8844"
            }
        }
    }
}