## GitLab configuration settings

## GitLab URL
external_url 'https://{{ gitlab_domain }}'
registry_external_url 'https://{{ gitlab_domain }}:5050'

### GitLab email server settings
###! Docs: https://docs.gitlab.com/omnibus/settings/smtp.html
###! **Use smtp instead of sendmail/postfix.**

gitlab_rails['smtp_enable'] = true
gitlab_rails['smtp_address'] = "smtp.sendgrid.net"
gitlab_rails['smtp_port'] = 465
gitlab_rails['smtp_user_name'] = "{{ smtp_user_name }}"
gitlab_rails['smtp_password'] = "{{ smtp_password }}"
gitlab_rails['smtp_domain'] = "dortlii.dev"
gitlab_rails['smtp_authentication'] = "login"
gitlab_rails['smtp_tls'] = true  # Enable SMTPS (SMTP over SSL)
gitlab_rails['smtp_openssl_verify_mode'] = 'peer'

gitlab_rails['gitlab_email_from'] = 'gitlab@dortlii.dev'
gitlab_rails['gitlab_email_reply_to'] = 'hello@dortlii.dev'

###! **Can be: 'none', 'peer', 'client_once', 'fail_if_no_peer_cert'**
###! Docs: http://api.rubyonrails.org/classes/ActionMailer/Base.html
# gitlab_rails['smtp_openssl_verify_mode'] = 'none'

# gitlab_rails['smtp_ca_path'] = "/etc/ssl/certs"
# gitlab_rails['smtp_ca_file'] = "/etc/ssl/certs/ca-certificates.crt"

### Email Settings

# gitlab_rails['gitlab_email_enabled'] = true

##! If your SMTP server does not like the default 'From: gitlab@gitlab.example.com'
##! can change the 'From' with this setting.
# gitlab_rails['gitlab_email_from'] = 'example@example.com'
# gitlab_rails['gitlab_email_display_name'] = 'Example'
# gitlab_rails['gitlab_email_reply_to'] = 'noreply@example.com'
# gitlab_rails['gitlab_email_subject_suffix'] = ''
# gitlab_rails['gitlab_email_smime_enabled'] = false
# gitlab_rails['gitlab_email_smime_key_file'] = '/etc/gitlab/ssl/gitlab_smime.key'
# gitlab_rails['gitlab_email_smime_cert_file'] = '/etc/gitlab/ssl/gitlab_smime.crt'
# gitlab_rails['gitlab_email_smime_ca_certs_file'] = '/etc/gitlab/ssl/gitlab_smime_cas.crt'

### GitLab user privileges
gitlab_rails['gitlab_default_can_create_group'] = false
gitlab_rails['gitlab_username_changing_enabled'] = false

### Monitoring settings
###! IP whitelist controlling access to monitoring endpoints
# gitlab_rails['monitoring_whitelist'] = ['127.0.0.0/8', '::1/128']
###! Time between sampling of unicorn socket metrics, in seconds
# gitlab_rails['monitoring_unicorn_sampler_interval'] = 10

### Reply by email
###! Allow users to comment on issues and merge requests by replying to
###! notification emails.
###! Docs: https://docs.gitlab.com/ee/administration/reply_by_email.html
# gitlab_rails['incoming_email_enabled'] = true

#### Incoming Email Address
####! The email address including the `%{key}` placeholder that will be replaced
####! to reference the item being replied to.
####! **The placeholder can be omitted but if present, it must appear in the
####!   "user" part of the address (before the `@`).**
# gitlab_rails['incoming_email_address'] = "gitlab-incoming+%{key}@gmail.com"

#### Email account username
####! **With third party providers, this is usually the full email address.**
####! **With self-hosted email servers, this is usually the user part of the
####!   email address.**
# gitlab_rails['incoming_email_email'] = "gitlab-incoming@gmail.com"

#### Email account password
# gitlab_rails['incoming_email_password'] = "[REDACTED]"

#### IMAP Settings
# gitlab_rails['incoming_email_host'] = "imap.gmail.com"
# gitlab_rails['incoming_email_port'] = 993
# gitlab_rails['incoming_email_ssl'] = true
# gitlab_rails['incoming_email_start_tls'] = false

#### Incoming Mailbox Settings (via `mail_room`)
####! The mailbox where incoming mail will end up. Usually "inbox".
# gitlab_rails['incoming_email_mailbox_name'] = "inbox"
####! The IDLE command timeout.
# gitlab_rails['incoming_email_idle_timeout'] = 60
####! The file name for internal `mail_room` JSON logfile
# gitlab_rails['incoming_email_log_file'] = "/var/log/gitlab/mailroom/mail_room_json.log"
####! Permanently remove messages from the mailbox when they are deleted after delivery
# gitlab_rails['incoming_email_expunge_deleted'] = false

####! The format of mail_room crash logs
# mailroom['exit_log_format'] = "plain"

### Git LFS
# gitlab_rails['lfs_enabled'] = true
# gitlab_rails['lfs_storage_path'] = "/var/opt/gitlab/gitlab-rails/shared/lfs-objects"
# gitlab_rails['lfs_object_store_enabled'] = false
# gitlab_rails['lfs_object_store_direct_upload'] = false
# gitlab_rails['lfs_object_store_background_upload'] = true
# gitlab_rails['lfs_object_store_proxy_download'] = false
# gitlab_rails['lfs_object_store_remote_directory'] = "lfs-objects"
# gitlab_rails['lfs_object_store_connection'] = {
#   'provider' => 'AWS',
#   'region' => 'eu-west-1',
#   'aws_access_key_id' => 'AWS_ACCESS_KEY_ID',
#   'aws_secret_access_key' => 'AWS_SECRET_ACCESS_KEY',
#   # # The below options configure an S3 compatible host instead of AWS
#   # 'aws_signature_version' => 4, # For creation of signed URLs. Set to 2 if provider does not support v4.
#   # 'endpoint' => 'https://s3.amazonaws.com', # default: nil - Useful for S3 compliant services such as DigitalOcean Spaces
#   # 'host' => 's3.amazonaws.com',
#   # 'path_style' => false # Use 'host/bucket_name/object' instead of 'bucket_name.host/object'
# }

### Terraform state
###! Docs: https://docs.gitlab.com/ee/administration/terraform_state
# gitlab_rails['terraform_state_enabled'] = true
# gitlab_rails['terraform_state_storage_path'] = "/var/opt/gitlab/gitlab-rails/shared/terraform_state"
# gitlab_rails['terraform_state_object_store_enabled'] = false
# gitlab_rails['terraform_state_object_store_remote_directory'] = "terraform"
# gitlab_rails['terraform_state_object_store_connection'] = {
#   'provider' => 'AWS',
#   'region' => 'eu-west-1',
#   'aws_access_key_id' => 'AWS_ACCESS_KEY_ID',
#   'aws_secret_access_key' => 'AWS_SECRET_ACCESS_KEY',
#   # # The below options configure an S3 compatible host instead of AWS
#   # 'host' => 's3.amazonaws.com',
#   # 'aws_signature_version' => 4, # For creation of signed URLs. Set to 2 if provider does not support v4.
#   # 'endpoint' => 'https://s3.amazonaws.com', # default: nil - Useful for S3 compliant services such as DigitalOcean Spaces
#   # 'path_style' => false # Use 'host/bucket_name/object' instead of 'bucket_name.host/object'
# }

### OmniAuth Settings
###! Docs: https://docs.gitlab.com/ee/integration/omniauth.html
gitlab_rails['omniauth_enabled'] = true
gitlab_rails['omniauth_allow_single_sign_on'] = ['{{ sso_provider }}']
gitlab_rails['omniauth_sync_email_from_provider'] = '{{ sso_provider }}'
gitlab_rails['omniauth_sync_profile_from_provider'] = ['{{ sso_provider }}']
gitlab_rails['omniauth_sync_profile_attributes'] = ['email']
# gitlab_rails['omniauth_auto_sign_in_with_provider'] = '{{ sso_provider }}'
gitlab_rails['omniauth_auto_link_user'] = ['{{ sso_provider }}']
gitlab_rails['omniauth_providers'] = [
  {
    name: "{{ sso_provider }}",
    label: "Azure AD",
    
    args: {
      name: "{{ sso_provider }}",
      scope: ["openid", "profile", "email"],
      response_type: "code",
      issuer:  "https://login.microsoftonline.com/{{ sso_tenant_id }}/v2.0",
      client_auth_method: "query",
      discovery: true,
      uid_field: "preferred_username",
      pkce: true,
      client_options: {
        identifier: "{{ sso_client_id }}",
        secret: "{{ sso_client_secret }}",
        redirect_uri: "https://{{ gitlab_domain }}/users/auth/{{ sso_provider }}/callback"
      }
    }
  }
]

### Let's Encrypt
# disable it
letsencrypt['enable'] = false

### Backup Settings
###! Docs: https://docs.gitlab.com/omnibus/settings/backups.html

# gitlab_rails['manage_backup_path'] = true
# gitlab_rails['backup_path'] = "/var/opt/gitlab/backups"

###! Docs: https://docs.gitlab.com/ee/raketasks/backup_restore.html#backup-archive-permissions
# gitlab_rails['backup_archive_permissions'] = 0644

# gitlab_rails['backup_pg_schema'] = 'public'

###! The duration in seconds to keep backups before they are allowed to be deleted
# gitlab_rails['backup_keep_time'] = 604800

# gitlab_rails['backup_upload_connection'] = {
#   'provider' => 'AWS',
#   'region' => 'eu-west-1',
#   'aws_access_key_id' => 'AKIAKIAKI',
#   'aws_secret_access_key' => 'secret123',
#   # # If IAM profile use is enabled, remove aws_access_key_id and aws_secret_access_key
#   'use_iam_profile' => false
# }
# gitlab_rails['backup_upload_remote_directory'] = 'my.s3.bucket'
# gitlab_rails['backup_multipart_chunk_size'] = 104857600

###! **Turns on AWS Server-Side Encryption with Amazon S3-Managed Keys for
###!   backups**
# gitlab_rails['backup_encryption'] = 'AES256'
###! The encryption key to use with AWS Server-Side Encryption.
###! Setting this value will enable Server-Side Encryption with customer provided keys;
###!   otherwise S3-managed keys are used.
# gitlab_rails['backup_encryption_key'] = '<base64-encoded encryption key>'

###! **Specifies Amazon S3 storage class to use for backups. Valid values
###!   include 'STANDARD', 'STANDARD_IA', and 'REDUCED_REDUNDANCY'**
# gitlab_rails['backup_storage_class'] = 'STANDARD'


### For setting up different data storing directory
###! Docs: https://docs.gitlab.com/omnibus/settings/configuration.html#storing-git-data-in-an-alternative-directory
###! **If you want to use a single non-default directory to store git data use a
###!   path that doesn't contain symlinks.**
# git_data_dirs({
#   "default" => {
#     "path" => "/mnt/nfs-01/git-data"
#    }
# })


### For storing encrypted configuration files
###! Docs: https://docs.gitlab.com/ee/administration/encrypted_configuration.html
# gitlab_rails['encrypted_settings_path'] = '/var/opt/gitlab/gitlab-rails/shared/encrypted_settings'

### Wait for file system to be mounted
###! Docs: https://docs.gitlab.com/omnibus/settings/configuration.html#only-start-omnibus-gitlab-services-after-a-given-filesystem-is-mounted
# high_availability['mountpoint'] = ["/var/opt/gitlab/git-data", "/var/opt/gitlab/gitlab-rails/shared"]

################################################################################
## GitLab NGINX
##! Docs: https://docs.gitlab.com/omnibus/settings/nginx.html
################################################################################

nginx['enable'] = true
# nginx['client_max_body_size'] = '250m'
nginx['redirect_http_to_https'] = true

nginx['ssl_certificate'] = "/home/sslcerti/acmesh/certs/git.server.dortlii.dev.pem"
nginx['ssl_certificate_key'] = "/home/sslcerti/acmesh/private/git.server.dortlii.dev.pem"
nginx['ssl_ciphers'] = "ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256"
nginx['ssl_prefer_server_ciphers'] = "on"

registry_nginx['ssl_certificate'] = "/home/sslcerti/acmesh/certs/git.server.dortlii.dev.pem"
registry_nginx['ssl_certificate_key'] = "/home/sslcerti/acmesh/private/git.server.dortlii.dev.pem"

##! **Recommended by: https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html
##!                   https://cipherli.st/**
nginx['ssl_protocols'] = "TLSv1.2 TLSv1.3"

##! **Recommended in: https://nginx.org/en/docs/http/ngx_http_ssl_module.html**
nginx['ssl_session_cache'] = "builtin:1000  shared:SSL:10m"

##! **Default according to https://nginx.org/en/docs/http/ngx_http_ssl_module.html**
nginx['ssl_session_timeout'] = "5m"

# nginx['ssl_dhparam'] = nil # Path to dhparams.pem, eg. /etc/gitlab/ssl/dhparams.pem
# nginx['listen_addresses'] = ['*', '[::]']

##! **Defaults to forcing web browsers to always communicate using only HTTPS**
##! Docs: https://docs.gitlab.com/omnibus/settings/nginx.html#setting-http-strict-transport-security
# nginx['hsts_max_age'] = 31536000
nginx['hsts_include_subdomains'] = false

