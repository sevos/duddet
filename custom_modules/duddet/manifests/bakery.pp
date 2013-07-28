class duddet::bakery {
	include duddet	

	$docker_repository_host = $::hostname
	$docker_repository_port = 5000

	docker::image { 'base':
		require => Package["lxc-docker"]
	}

	file { "/usr/bin/duddet":
		content => template("duddet/duddet.erb"),
		mode => "0755"
	}
}