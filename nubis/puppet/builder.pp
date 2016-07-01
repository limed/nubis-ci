#XXX: Needs released version

package { "awscli":
  ensure => latest,
}

package { "rsync":
  ensure => present
}

# XXX: We require jq 1.5, not in repos yet
exec { "wget-jq":
  creates => "/usr/local/bin/jq",
  command => "/usr/bin/curl -Lfqs -o /usr/local/bin/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64"
} ->
file { "/usr/local/bin/jq":
  owner => 0,
  group => 0,
  mode  => 755,
}

vcsrepo { "/opt/nubis-builder":
  ensure   => present,
  provider => git,
  source   => 'https://github.com/Nubisproject/nubis-builder.git',
  revision => "v1.2.0"
}

# XXX: need to move to puppet-packer
staging::file { 'packer.zip':
  source => "https://releases.hashicorp.com/packer/0.10.0/packer_0.10.0_linux_amd64.zip"
} ->
staging::extract { 'packer.zip':
  target  => "/usr/local/bin",
  creates => "/usr/local/bin/packer",
}

# XXX: need to move to puppet-terraform	
staging::file { 'terraform.zip':
  source => "https://releases.hashicorp.com/terraform/0.6.14/terraform_0.6.14_linux_amd64.zip"
} ->
staging::extract { 'terraform.zip':
  target  => "/usr/local/bin",
  creates => "/usr/local/bin/terraform",
}


