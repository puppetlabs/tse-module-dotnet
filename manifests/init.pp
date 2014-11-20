class dotnet {

  require profile::staging

  if $kernelmajversion == '6.1' {
    reboot { 'before dotnet install':
      when => pending,
    }

    staging::file { 'dotNetFx40_Full_x86_x64.exe':
      source => "http://${::servername}/dotnetcms/dotNetFx40_Full_x86_x64.exe",
      before => Package['Microsoft .NET Framework 4 Client Profile'],
    }

    package { 'Microsoft .NET Framework 4 Client Profile':
      ensure          => installed,
      source          => 'C:\staging\dotnet\dotNetFx40_Full_x86_x64.exe',
      install_options => ['/q', '/norestart'],
    }

    reboot { 'successful dotnet install':
      subscribe => Package['Microsoft .NET Framework 4 Client Profile'],
    }
  }

}
