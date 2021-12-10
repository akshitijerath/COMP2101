get-ciminstance win32_networkadapterconfiguration | 
	where IPEnabled -eq "True" | 
		Select-Object Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder  | 
			Ft -auto 
