provider "linode" {
    token = var.token
}

resource "linode_sshkey" "my_wordpress_linode_ssh_key" {
    label = "my_ssh_key"
    ssh_key = chomp(file("~/.ssh/id_rsa.pub"))
}

resource "random_string" "my_wordpress_linode_root_password" {
    length  = 32
    special = true
}

resource "linode_instance" "my_wordpress_linode" {
    image = var.image
    label = var.label
    region = var.region
    type = var.type
    authorized_keys = [ linode_sshkey.my_wordpress_linode_ssh_key.ssh_key ]
    root_pass = random_string.my_wordpress_linode_root_password.result
    stackscript_id = var.stackscript_id
    stackscript_data = {
       "ssuser" = var.stackscript_data["ssuser"]
       "hostname" = var.stackscript_data["hostname"]
       "website" = var.stackscript_data["website"]
       "dbuser" = var.stackscript_data["dbuser"]
       "db_password" = var.stackscript_data["db_password"]
       "sspassword" = var.stackscript_data["sspassword"]
       "dbuser_password" = var.stackscript_data["dbuser_password"]
    }
}

resource "linode_domain" "my_wordpress_domain" {
    domain = var.domain
    soa_email = var.soa_email
    type = "master"
 }

resource "linode_domain_record" "my_wordpress_domain_www_record" {
    domain_id = linode_domain.my_wordpress_domain.id
    name = "www"
    record_type = var.a_record
    target = "linode_instance.my_wordpress_linode.ipv4"
}

resource "linode_domain_record" "my_wordpress_domain_apex_record" {
    domain_id = linode_domain.my_wordpress_domain.id
    name = ""
    record_type = var.a_record
    target = "linode_instance.my_wordpress_linode.ipv4"
}
