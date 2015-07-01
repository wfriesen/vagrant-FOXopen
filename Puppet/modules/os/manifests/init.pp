class os {

	package {"openjdk-7-jre":
		ensure => installed
	}
	
	package {"zip":
		ensure => installed
	}

	package {"unzip":
		ensure => installed
	}
	
}
